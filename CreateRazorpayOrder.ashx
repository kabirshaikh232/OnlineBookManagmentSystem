<%@ WebHandler Language="C#" Class="CreateRazorpayOrder" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

public class CreateRazorpayOrder : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public bool IsReusable { get { return false; } }

    public void ProcessRequest(HttpContext ctx)
    {
        ctx.Response.ContentType = "application/json";
        ctx.Response.Cache.SetNoStore(); // prevent caching

        var js = new JavaScriptSerializer();

        try
        {
            // ── 1. Read JSON body ──────────────────────────────────────────
            string body;
            using (var sr = new StreamReader(ctx.Request.InputStream, Encoding.UTF8))
                body = sr.ReadToEnd();

            if (string.IsNullOrWhiteSpace(body))
            {
                ctx.Response.Write(js.Serialize(new { error = "Empty request body." }));
                return;
            }

            var payload = js.Deserialize<Dictionary<string, string>>(body);

            // ── 2. Validate session ────────────────────────────────────────
            if (ctx.Session == null || ctx.Session["Username"] == null || ctx.Session["Cart"] == null)
            {
                ctx.Response.Write(js.Serialize(new { error = "Session expired. Please log in again." }));
                return;
            }

            // ── 3. Calculate cart total ────────────────────────────────────
            var cart = (DataTable)ctx.Session["Cart"];
            decimal total = 0;
            foreach (DataRow row in cart.Rows)
                total += Convert.ToDecimal(row["Price"]);

            long paise = (long)(total * 100);

            if (paise <= 0)
            {
                ctx.Response.Write(js.Serialize(new { error = "Cart is empty or total is zero." }));
                return;
            }

            // ── 4. Validate delivery fields ────────────────────────────────
            string firstName = Get(payload, "firstName");
            string lastName  = Get(payload, "lastName");
            string email     = Get(payload, "email");
            string phone     = Get(payload, "phone");
            string address   = Get(payload, "address");
            string city      = Get(payload, "city");
            string pin       = Get(payload, "pin");

            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) ||
                string.IsNullOrEmpty(email)      || string.IsNullOrEmpty(phone)    ||
                string.IsNullOrEmpty(address)    || string.IsNullOrEmpty(city)     ||
                string.IsNullOrEmpty(pin))
            {
                ctx.Response.Write(js.Serialize(new { error = "Please fill in all delivery fields." }));
                return;
            }

            // ── 5. Read Razorpay credentials ───────────────────────────────
            string key    = ConfigurationManager.AppSettings["RazorpayKey"];
            string secret = ConfigurationManager.AppSettings["RazorpaySecret"];

            if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(secret))
            {
                ctx.Response.Write(js.Serialize(new { error = "Razorpay keys not configured in Web.config." }));
                return;
            }

            // ── 6. Create Razorpay order via REST API ──────────────────────
            string credentials = Convert.ToBase64String(Encoding.ASCII.GetBytes(key + ":" + secret));
            string receipt     = "rcpt_" + DateTime.Now.Ticks;
            string bodyJson    = "{\"amount\":" + paise +
                                 ",\"currency\":\"INR\"" +
                                 ",\"receipt\":\"" + receipt + "\"}";

            HttpWebRequest req = (HttpWebRequest)WebRequest.Create("https://api.razorpay.com/v1/orders");
            req.Method      = "POST";
            req.ContentType = "application/json";
            req.Headers["Authorization"] = "Basic " + credentials;
            req.Timeout     = 30000; // 30 seconds

            byte[] bodyBytes = Encoding.UTF8.GetBytes(bodyJson);
            req.ContentLength = bodyBytes.Length;
            using (Stream s = req.GetRequestStream())
                s.Write(bodyBytes, 0, bodyBytes.Length);

            string rzpJson;
            using (HttpWebResponse resp   = (HttpWebResponse)req.GetResponse())
            using (StreamReader    reader = new StreamReader(resp.GetResponseStream()))
                rzpJson = reader.ReadToEnd();

            var rzpData = js.Deserialize<Dictionary<string, object>>(rzpJson);

            if (!rzpData.ContainsKey("id"))
            {
                ctx.Response.Write(js.Serialize(new { error = "Razorpay did not return an order id. Response: " + rzpJson }));
                return;
            }

            string rzpOrderId = rzpData["id"].ToString();

            // ── 7. Return data to client ───────────────────────────────────
            ctx.Response.Write(js.Serialize(new
            {
                key         = key,
                orderId     = rzpOrderId,
                amountPaise = paise,
                userName    = (firstName + " " + lastName).Trim(),
                email       = email,
                phone       = phone
            }));
        }
        catch (WebException wex)
        {
            string detail = wex.Message;
            if (wex.Response != null)
            {
                using (StreamReader sr = new StreamReader(wex.Response.GetResponseStream()))
                    detail = sr.ReadToEnd();
            }
            ctx.Response.Write(js.Serialize(new { error = "Razorpay API error: " + detail }));
        }
        catch (Exception ex)
        {
            ctx.Response.Write(js.Serialize(new { error = "Server error: " + ex.Message }));
        }
    }

    private static string Get(Dictionary<string, string> d, string key)
    {
        string v;
        return d != null && d.TryGetValue(key, out v) ? (v ?? "").Trim() : "";
    }
}