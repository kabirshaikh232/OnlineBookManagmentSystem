<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Checkout.aspx.cs"
    Inherits="WebApplication3.Checkout" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookShelf - Checkout</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html, body { height: 100%; overflow: hidden; }
        body { font-family: 'DM Sans', sans-serif; background: #f8f5f0; color: #1a1a2e; display: flex; flex-direction: column; height: 100vh; }

        .navbar {
            background: #1b4332; padding: 0 32px;
            display: flex; align-items: center; justify-content: space-between;
            height: 56px; flex-shrink: 0; z-index: 100;
            box-shadow: 0 2px 16px rgba(0,0,0,0.18);
        }
        .navbar-brand { font-family: 'Playfair Display', serif; font-size: 1.2rem; color: #fff; }
        .nav-steps { display: flex; align-items: center; }
        .step { display: flex; align-items: center; padding: 0 14px; color: rgba(255,255,255,0.45); font-size: 0.78rem; }
        .step.active { color: #fff; }
        .step.done { color: #52b788; }
        .step-num { width: 22px; height: 22px; border-radius: 50%; background: rgba(255,255,255,0.15); display: flex; align-items: center; justify-content: center; font-size: 0.68rem; font-weight: 600; margin-right: 6px; }
        .step.active .step-num { background: #52b788; color: #1b4332; }
        .step.done .step-num { background: #52b788; color: #1b4332; }
        .step-divider { width: 24px; height: 1px; background: rgba(255,255,255,0.2); }

        /* ── CHECKOUT LAYOUT ── */
        .checkout-body { flex: 1; overflow: hidden; display: flex; flex-direction: column; }
        .checkout-hero { background: linear-gradient(135deg, #1b4332 0%, #2d6a4f 60%, #52b788 100%); padding: 14px 32px; flex-shrink: 0; }
        .hero-eyebrow { font-size: 0.68rem; letter-spacing: 2px; text-transform: uppercase; color: #d8f3dc; margin-bottom: 2px; }
        .checkout-hero h1 { font-family: 'Playfair Display', serif; font-size: 1.5rem; color: #fff; margin-bottom: 2px; }
        .hero-sub { color: rgba(255,255,255,0.7); font-size: 0.82rem; }

        .main { flex: 1; overflow: hidden; display: flex; max-width: 1060px; width: 100%; margin: 0 auto; padding: 16px 32px; gap: 20px; }
        .main-left { flex: 1.4; display: flex; flex-direction: column; overflow: hidden; }
        .main-right { flex: 1; overflow-y: auto; display: flex; flex-direction: column; gap: 14px; }
        .main-right::-webkit-scrollbar { width: 4px; }
        .main-right::-webkit-scrollbar-thumb { background: #d8f3dc; border-radius: 4px; }

        /* Delivery card fills entire left height */
        .delivery-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 16px rgba(27,67,50,0.10); border: 1px solid rgba(27,67,50,0.07); padding: 20px 24px; flex: 1; display: flex; flex-direction: column; }
        .delivery-card h3 { font-family: 'Playfair Display', serif; font-size: 1rem; margin-bottom: 16px; color: #1a1a2e; padding-bottom: 10px; border-bottom: 1px solid #f0ede8; flex-shrink: 0; }
        .delivery-fields { flex: 1; display: flex; flex-direction: column; justify-content: space-between; }

        .form-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 16px rgba(27,67,50,0.10); border: 1px solid rgba(27,67,50,0.07); padding: 16px 18px; }
        .form-card h3 { font-family: 'Playfair Display', serif; font-size: 0.95rem; margin-bottom: 12px; color: #1a1a2e; padding-bottom: 8px; border-bottom: 1px solid #f0ede8; }
        .form-row { display: flex; gap: 12px; margin-bottom: 0; }
        .form-col { flex: 1; }
        .form-group { display: flex; flex-direction: column; margin-bottom: 12px; }
        .form-group:last-child { margin-bottom: 0; }
        .form-group label { font-size: 0.72rem; font-weight: 600; color: #6b7280; letter-spacing: 0.8px; text-transform: uppercase; margin-bottom: 4px; }
        .form-group input, .form-group textarea {
            border: 1.5px solid #e5e7eb; border-radius: 7px;
            padding: 10px 12px; font-family: 'DM Sans', sans-serif;
            font-size: 0.88rem; outline: none; width: 100%; background: #fff;
        }
        .form-group input:focus, .form-group textarea:focus { border-color: #52b788; }
        .form-group textarea { resize: none; flex: 1; min-height: 64px; }

        .payment-options { display: flex; flex-direction: column; gap: 8px; }
        .payment-option { border: 1.5px solid #e5e7eb; border-radius: 9px; padding: 11px 14px; display: flex; align-items: center; cursor: pointer; transition: all 0.15s; }
        .payment-option:hover { border-color: #52b788; background: #fafff8; }
        .payment-option.selected { border-color: #52b788; background: #f0faf4; }
        .payment-option input[type="radio"] { width: 15px; height: 15px; margin-right: 12px; flex-shrink: 0; }
        .payment-icon { font-size: 1.2rem; margin-right: 10px; }
        .payment-option-label { font-size: 0.88rem; font-weight: 500; }
        .payment-option-sub { font-size: 0.74rem; color: #6b7280; }

        .summary-card { background: #fff; border-radius: 12px; box-shadow: 0 2px 16px rgba(27,67,50,0.10); border: 1px solid rgba(27,67,50,0.07); padding: 20px; }
        .summary-card h3 { font-family: 'Playfair Display', serif; font-size: 1rem; margin-bottom: 14px; color: #1a1a2e; padding-bottom: 10px; border-bottom: 1px solid #f0ede8; }
        .summary-items { margin-bottom: 12px; }
        .summary-item { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; }
        .summary-item-name { font-size: 0.84rem; color: #1a1a2e; flex: 1; }
        .summary-item-price { font-size: 0.84rem; font-weight: 600; color: #1b4332; }
        .summary-line { display: flex; justify-content: space-between; padding: 7px 0; border-top: 1px solid #f0ede8; font-size: 0.84rem; color: #6b7280; }
        .summary-total { display: flex; justify-content: space-between; padding: 10px 0 0; border-top: 2px solid #d8f3dc; }
        .summary-total span:first-child { font-weight: 600; color: #1a1a2e; }
        .summary-total span:last-child { font-family: 'Playfair Display', serif; font-size: 1.2rem; font-weight: 700; color: #1b4332; }

        input[type="submit"].btn-order { width: 100%; padding: 12px; background: #1b4332; color: #fff; border: none; border-radius: 9px; font-family: 'DM Sans', sans-serif; font-size: 0.95rem; font-weight: 600; cursor: pointer; margin-top: 12px; }
        input[type="submit"].btn-order:hover { background: #2d6a4f; }

        #btnPayOnline { width: 100%; padding: 12px; background: #2d6a4f; color: #fff; border: none; border-radius: 9px; font-family: 'DM Sans', sans-serif; font-size: 0.95rem; font-weight: 600; cursor: pointer; margin-top: 12px; display: none; }
        #btnPayOnline:hover { background: #52b788; }
        #btnPayOnline:disabled { background: #aaa; cursor: not-allowed; }

        .secure-note { display: flex; align-items: center; justify-content: center; font-size: 0.72rem; color: #6b7280; margin-top: 8px; }
        .error-msg { color: #dc2626; font-size: 0.82rem; margin-top: 6px; display: block; }

        /* ── SUCCESS PANEL ── */
        .success-body { flex: 1; overflow: hidden; display: flex; flex-direction: column; }
        .success-inner { flex: 1; overflow-y: auto; display: flex; align-items: flex-start; justify-content: center; padding: 20px 24px; }
        .success-wrapper { width: 100%; max-width: 750px; }

        .success-top { display: flex; align-items: center; gap: 18px; margin-bottom: 18px; padding: 18px 24px; background: #fff; border-radius: 14px; border: 1px solid #e9f5ee; box-shadow: 0 2px 14px rgba(27,67,50,0.08); }
        .burst-ring { width: 56px; height: 56px; border-radius: 50%; background: linear-gradient(135deg, #d8f3dc, #b7e4c7); display: flex; align-items: center; justify-content: center; flex-shrink: 0; font-size: 1.6rem; color: #1b4332; animation: popIn 0.55s cubic-bezier(0.34,1.56,0.64,1) both; }
        @keyframes popIn { 0% { transform:scale(0.3);opacity:0; } 100% { transform:scale(1);opacity:1; } }
        .success-headline h2 { font-family: 'Playfair Display', serif; font-size: 1.5rem; color: #1b4332; margin-bottom: 4px; }
        .success-headline p { color: #6b7280; font-size: 0.84rem; line-height: 1.5; }

        .success-grid { display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 12px; margin-bottom: 14px; }
        .info-tile { background: #fff; border-radius: 11px; border: 1px solid #e9f5ee; padding: 14px 16px; box-shadow: 0 2px 10px rgba(27,67,50,0.06); }
        .info-tile.span2 { grid-column: span 2; }
        .tile-icon { font-size: 1.2rem; margin-bottom: 6px; display: block; }
        .tile-label { font-size: 0.65rem; font-weight: 700; letter-spacing: 1.2px; text-transform: uppercase; color: #52b788; margin-bottom: 3px; }
        .tile-value { font-size: 0.88rem; font-weight: 600; color: #1a1a2e; line-height: 1.4; }
        .tile-value.mono { font-family: 'Courier New', monospace; font-size: 0.82rem; background: #f0faf4; display: inline-block; padding: 3px 10px; border-radius: 5px; color: #1b4332; }
        .tile-sub { font-size: 0.72rem; color: #9ca3af; margin-top: 3px; }

        .address-inline { font-size: 0.84rem; color: #4b5563; line-height: 1.5; }
        .items-compact { font-size: 0.84rem; color: #374151; line-height: 1.7; }

        .success-actions { display: flex; gap: 12px; justify-content: center; margin-top: 16px; }
        input[type="submit"].btn-continue { background: #1b4332; color: #fff; border: none; padding: 12px 32px; border-radius: 10px; font-family: 'DM Sans', sans-serif; font-size: 0.92rem; font-weight: 600; cursor: pointer; }
        input[type="submit"].btn-continue:hover { background: #2d6a4f; }
        .btn-dashboard { background: #fff; color: #1b4332; border: 2px solid #1b4332; padding: 12px 32px; border-radius: 10px; font-family: 'DM Sans', sans-serif; font-size: 0.92rem; font-weight: 600; cursor: pointer; text-decoration: none; display: inline-block; }
        .btn-dashboard:hover { background: #f0faf4; }

        .footer { text-align: center; padding: 10px; font-size: 0.74rem; color: #6b7280; border-top: 1px solid #ede8e0; flex-shrink: 0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <nav class="navbar">
            <div class="navbar-brand">&#128218; BookShelf</div>
            <div class="nav-steps">
                <div class="step done"><div class="step-num">&#10003;</div><span>Cart</span></div>
                <div class="step-divider"></div>
                <div class="step active"><div class="step-num">2</div><span>Checkout</span></div>
                <div class="step-divider"></div>
                <div class="step"><div class="step-num">3</div><span>Confirmation</span></div>
            </div>
        </nav>

        <!-- ════════ CHECKOUT PANEL ════════ -->
        <asp:Panel ID="pnlCheckout" runat="server" CssClass="checkout-body">
            <div class="checkout-hero">
                <div class="hero-eyebrow">Almost there</div>
                <h1>Checkout</h1>
                <p class="hero-sub">Fill in your details and choose a payment method.</p>
            </div>

            <div class="main">
                <!-- LEFT: Delivery Info fills full height -->
                <div class="main-left">
                    <div class="delivery-card">
                        <h3>&#128205; Delivery Information</h3>
                        <div class="delivery-fields">
                            <div class="form-row">
                                <div class="form-col">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-col">
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-col">
                                    <div class="form-group">
                                        <label>Email Address</label>
                                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-col">
                                    <div class="form-group">
                                        <label>Phone Number</label>
                                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" style="flex:1;display:flex;flex-direction:column;">
                                <label>Delivery Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" style="flex:1;min-height:80px;"></asp:TextBox>
                            </div>
                            <div class="form-row" style="margin-top:12px;">
                                <div class="form-col">
                                    <div class="form-group">
                                        <label>City</label>
                                        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-col">
                                    <div class="form-group">
                                        <label>PIN Code</label>
                                        <asp:TextBox ID="txtPin" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: Payment Method on top, Order Summary below -->
                <div class="main-right">

                    <!-- Payment Method FIRST -->
                    <div class="form-card">
                        <h3>&#128179; Payment Method</h3>
                        <div class="payment-options">
                            <label class="payment-option selected" id="optCOD" onclick="selectPayment('cod')">
                                <input type="radio" name="paymentMode" id="rdoCOD" value="cod" checked="checked" />
                                <span class="payment-icon">&#128176;</span>
                                <div>
                                    <div class="payment-option-label">Cash on Delivery</div>
                                    <div class="payment-option-sub">Pay when your books arrive</div>
                                </div>
                            </label>
                            <label class="payment-option" id="optOnline" onclick="selectPayment('online')">
                                <input type="radio" name="paymentMode" id="rdoOnline" value="online" />
                                <span class="payment-icon">&#128241;</span>
                                <div>
                                    <div class="payment-option-label">Pay Online (Razorpay)</div>
                                    <div class="payment-option-sub">UPI, Cards, Netbanking, Wallets</div>
                                </div>
                            </label>
                        </div>
                    </div>

                    <!-- Order Summary BELOW Payment -->
                    <div class="summary-card">
                        <h3>Order Summary</h3>
                        <div class="summary-items">
                            <asp:Repeater ID="rptSummary" runat="server">
                                <ItemTemplate>
                                    <div class="summary-item">
                                        <span class="summary-item-name"><%# Eval("BookName") %></span>
                                        <span class="summary-item-price">Rs.<%# Eval("Price") %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="summary-line"><span>Subtotal</span><asp:Label ID="lblSubtotal" runat="server"></asp:Label></div>
                        <div class="summary-line"><span>Delivery</span><span style="color:#16a34a;font-weight:600;">FREE</span></div>
                        <div class="summary-total"><span>Total</span><asp:Label ID="lblTotal" runat="server"></asp:Label></div>

                        <asp:Button ID="btnPlaceOrder" runat="server"
                            Text="Place Order (COD)"
                            CssClass="btn-order"
                            OnClick="btnPlaceOrder_Click" />

                        <button type="button" id="btnPayOnline" onclick="startRazorpay()">
                            &#128179; Pay Online Now
                        </button>

                        <asp:HiddenField ID="hfRazorpayPaymentId" runat="server" />
                        <asp:HiddenField ID="hfRazorpayOrderId"   runat="server" />
                        <asp:HiddenField ID="hfRazorpaySignature" runat="server" />

                        <asp:Button ID="btnConfirmPayment" runat="server"
                            Text="Confirm"
                            Style="display:none !important;"
                            OnClick="btnConfirmPayment_Click" />

                        <div class="secure-note">&#128274; Secured &amp; encrypted checkout</div>
                    </div>

                </div>
            </div>
        </asp:Panel>

        <!-- ════════ SUCCESS PANEL ════════ -->
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="success-body">
            <div class="success-inner">
                <div class="success-wrapper">

                    <div class="success-top">
                        <div class="burst-ring">&#10003;</div>
                        <div class="success-headline">
                            <h2>Order Placed Successfully! &#127881;</h2>
                            <p>Thank you for shopping with BookShelf. Your books are being prepared and will be on their way very soon!</p>
                        </div>
                    </div>

                    <div class="success-grid">
                        <div class="info-tile">
                            <span class="tile-icon">&#129695;</span>
                            <div class="tile-label">Order ID</div>
                            <div class="tile-value mono"><asp:Label ID="lblOrderId" runat="server"></asp:Label></div>
                            <div class="tile-sub">Keep for tracking</div>
                        </div>
                        <div class="info-tile">
                            <span class="tile-icon">&#128666;</span>
                            <div class="tile-label">Est. Delivery</div>
                            <div class="tile-value"><asp:Label ID="lblDeliveryDate" runat="server"></asp:Label></div>
                            <div class="tile-sub">3–5 business days</div>
                        </div>
                        <div class="info-tile">
                            <span class="tile-icon">&#128179;</span>
                            <div class="tile-label">Payment</div>
                            <div class="tile-value"><asp:Label ID="lblPaymentMethod" runat="server"></asp:Label></div>
                            <asp:Label ID="lblPaymentBadge" runat="server"></asp:Label>
                        </div>
                        <div class="info-tile">
                            <span class="tile-icon">&#128197;</span>
                            <div class="tile-label">Order Date</div>
                            <div class="tile-value"><asp:Label ID="lblOrderDate" runat="server"></asp:Label></div>
                            <div class="tile-sub">Placed successfully</div>
                        </div>
                        <div class="info-tile span2">
                            <span class="tile-icon">&#128218;</span>
                            <div class="tile-label">Books Ordered</div>
                            <div class="items-compact"><asp:Literal ID="litOrderItems" runat="server"></asp:Literal></div>
                        </div>
                        <div class="info-tile span2">
                            <span class="tile-icon">&#128205;</span>
                            <div class="tile-label">Delivering To</div>
                            <div class="address-inline">
                                <strong><asp:Label ID="lblDeliveryName" runat="server"></asp:Label></strong><br />
                                <asp:Label ID="lblDeliveryAddress" runat="server"></asp:Label>,
                                <asp:Label ID="lblDeliveryCity"    runat="server"></asp:Label><br />
                                &#128222;&nbsp;<asp:Label ID="lblDeliveryPhone" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <div class="success-actions">
                        <a href="AdminDashboard.aspx" class="btn-dashboard">&#9776; Back to Dashboard</a>
                        <asp:Button ID="btnContinue" runat="server" Text="&#128722; Continue Shopping" CssClass="btn-continue" PostBackUrl="UserHome.aspx" />
                    </div>

                </div>
            </div>
        </asp:Panel>

        <footer class="footer">&#169; 2026 BookShelf &nbsp;&#183;&nbsp; All rights reserved</footer>

    </form>

    <script>
        function selectPayment(mode) {
            var codBtn    = document.getElementById('<%= btnPlaceOrder.ClientID %>');
            var onlineBtn = document.getElementById('btnPayOnline');
            var optCOD    = document.getElementById('optCOD');
            var optOnline = document.getElementById('optOnline');
            if (mode === 'online') {
                codBtn.style.display    = 'none';
                onlineBtn.style.display = 'block';
                optCOD.classList.remove('selected');
                optOnline.classList.add('selected');
            } else {
                codBtn.style.display    = 'block';
                onlineBtn.style.display = 'none';
                optOnline.classList.remove('selected');
                optCOD.classList.add('selected');
            }
        }

        function getVal(id) {
            var el = document.getElementById(id);
            return el ? el.value.trim() : '';
        }

        function validateForm() {
            var ids = [
                '<%= txtFirstName.ClientID %>',
                '<%= txtLastName.ClientID %>',
                '<%= txtEmail.ClientID %>',
                '<%= txtPhone.ClientID %>',
                '<%= txtAddress.ClientID %>',
                '<%= txtCity.ClientID %>',
                '<%= txtPin.ClientID %>'
            ];
            for (var i = 0; i < ids.length; i++) {
                if (!getVal(ids[i])) {
                    alert('Please fill in all delivery fields before paying.');
                    return false;
                }
            }
            return true;
        }

        function startRazorpay() {
            if (!validateForm()) return;

            var btn = document.getElementById('btnPayOnline');
            btn.disabled    = true;
            btn.textContent = 'Please wait...';

            // Build JSON payload — server reads this via JsonSerializer
            var payload = JSON.stringify({
                firstName : getVal('<%= txtFirstName.ClientID %>'),
                lastName  : getVal('<%= txtLastName.ClientID %>'),
                email     : getVal('<%= txtEmail.ClientID %>'),
                phone     : getVal('<%= txtPhone.ClientID %>'),
                address   : getVal('<%= txtAddress.ClientID %>'),
                city      : getVal('<%= txtCity.ClientID %>'),
                pin       : getVal('<%= txtPin.ClientID %>')
            });

            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'CreateRazorpayOrder.ashx', true);
            xhr.setRequestHeader('Content-Type', 'application/json');   // ← JSON, not form-encoded
            xhr.onreadystatechange = function () {
                if (xhr.readyState !== 4) return;

                btn.disabled    = false;
                btn.textContent = '🏦 Pay Online Now';

                if (xhr.status !== 200) {
                    alert('Could not connect to payment server. Please try again.');
                    return;
                }

                var resp;
                try { resp = JSON.parse(xhr.responseText); }
                catch(e) { alert('Unexpected server response.'); return; }

                if (resp.error) {
                    alert('Payment error: ' + resp.error);
                    return;
                }

                document.getElementById('<%= hfRazorpayOrderId.ClientID %>').value = resp.orderId;

                var options = {
                    key         : resp.key,
                    amount      : resp.amountPaise,
                    currency    : 'INR',
                    name        : 'BookShelf',
                    description : 'Book Purchase',
                    order_id    : resp.orderId,
                    handler: function (response) {
                        document.getElementById('<%= hfRazorpayPaymentId.ClientID %>').value = response.razorpay_payment_id;
                        document.getElementById('<%= hfRazorpayOrderId.ClientID %>').value   = response.razorpay_order_id;
                        document.getElementById('<%= hfRazorpaySignature.ClientID %>').value = response.razorpay_signature;
                        document.getElementById('<%= btnConfirmPayment.ClientID %>').click();
                    },
                    prefill : { name: resp.userName, email: resp.email, contact: resp.phone },
                    theme   : { color: '#1b4332' },
                    modal   : {
                        ondismiss: function () {
                            btn.disabled    = false;
                            btn.textContent = '🏦 Pay Online Now';
                        }
                    }
                };

                var rzp = new Razorpay(options);
                rzp.on('payment.failed', function (r) {
                    alert('Payment failed: ' + r.error.description);
                });
                rzp.open();
            };

            xhr.send(payload);   // ← send JSON string
        }
    </script>
</body>
</html>
