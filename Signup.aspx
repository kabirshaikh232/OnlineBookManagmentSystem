<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="WebApplication3.Signup" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>BookShelf – Create Account</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;0,700;1,300;1,400&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet" />
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --green-dark:  #1a4a3a;
  --green-mid:   #2d7a5f;
  --green-light: #4aad8a;
  --green-border: rgba(74, 173, 138, 0.35);
  --green-accent: #5ecfa0;
  --muted: rgba(255,255,255,0.65);
}

html, body {
  height: 100%; width: 100%;
  overflow: hidden;
  font-family: 'Jost', sans-serif;
}

.bg {
  position: fixed; inset: 0;
  background: url('https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=1800&q=90') center/cover no-repeat;
  filter: brightness(0.72) saturate(1.1);
  z-index: 0;
}
.bg::after {
  content: '';
  position: absolute; inset: 0;
  background: linear-gradient(135deg, rgba(20,70,50,0.45) 0%, rgba(0,0,0,0.15) 60%, rgba(15,55,40,0.35) 100%);
}

/* ── NAVBAR ── */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
  height: 60px;
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 44px;
  background: rgba(20, 65, 45, 0.35);
  backdrop-filter: blur(14px);
  border-bottom: 1px solid rgba(74, 173, 138, 0.2);
  z-index: 10;
}
.nav-logo {
  display: flex; align-items: center; gap: 10px;
  text-decoration: none;
  font-family: 'Cormorant Garamond', serif;
  font-size: 22px; font-weight: 600;
  color: #fff; letter-spacing: 1px;
}
.nav-logo .dot {
  width: 8px; height: 8px; border-radius: 50%;
  background: var(--green-accent);
  box-shadow: 0 0 10px var(--green-accent);
}
.nav-pill {
  font-size: 10px; letter-spacing: 2.5px; text-transform: uppercase;
  color: var(--green-accent); padding: 5px 15px;
  border: 1px solid var(--green-border); border-radius: 20px;
  background: rgba(74, 173, 138, 0.1);
}

/* ── PAGE CENTER ── */
.page {
  position: fixed; inset: 0;
  display: flex; align-items: center; justify-content: center;
  z-index: 5;
}

/* ── CARD ── */
.card {
  width: 480px;
  background: rgba(25, 80, 58, 0.28);
  backdrop-filter: blur(28px) saturate(1.6);
  -webkit-backdrop-filter: blur(28px) saturate(1.6);
  border: 1px solid rgba(94, 207, 160, 0.3);
  border-radius: 22px;
  padding: 42px 44px 38px;
  box-shadow:
    0 8px 40px rgba(0,0,0,0.3),
    inset 0 1px 0 rgba(255,255,255,0.1);
  position: relative;
  animation: fadeUp 0.7s cubic-bezier(.22,.68,0,1.2) both;
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(28px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}

.card::before {
  content: '';
  position: absolute; top: 0; left: 12%; right: 12%; height: 1.5px;
  background: linear-gradient(90deg, transparent, var(--green-accent), transparent);
  border-radius: 1px;
}

/* ── HEADER ── */
.card-eyebrow {
  font-size: 10px; letter-spacing: 3.5px; text-transform: uppercase;
  color: var(--green-accent); margin-bottom: 10px;
  display: flex; align-items: center; gap: 8px;
}
.card-eyebrow::before, .card-eyebrow::after {
  content: ''; flex: 1; height: 1px;
  background: linear-gradient(90deg, transparent, var(--green-border));
}
.card-eyebrow::after {
  background: linear-gradient(90deg, var(--green-border), transparent);
}

.card-title {
  font-family: 'Cormorant Garamond', serif;
  font-size: 36px; font-weight: 300;
  color: #fff; line-height: 1.1; margin-bottom: 6px;
}
.card-title em { font-style: italic; color: var(--green-accent); }

.card-sub {
  font-size: 13px; color: var(--muted); font-weight: 300;
  margin-bottom: 28px; line-height: 1.6;
}

/* ── GRID ── */
.fields-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 14px 18px;
}
.field-full { grid-column: 1 / -1; }

.field-label {
  display: block;
  font-size: 10px; letter-spacing: 2px; text-transform: uppercase;
  color: rgba(94, 207, 160, 0.85); font-weight: 500;
  margin-bottom: 7px;
}
.textbox {
  width: 100% !important;
  padding: 12px 14px;
  background: rgba(255,255,255,0.08) !important;
  border: 1px solid rgba(94, 207, 160, 0.25) !important;
  border-radius: 10px;
  color: #fff !important;
  font-family: 'Jost', sans-serif;
  font-size: 14px; font-weight: 300;
  outline: none;
  transition: border-color .25s, background .25s, box-shadow .25s;
  caret-color: var(--green-accent);
}
.textbox::placeholder { color: rgba(255,255,255,0.3) !important; }
.textbox:focus {
  border-color: rgba(94, 207, 160, 0.6) !important;
  background: rgba(255,255,255,0.12) !important;
  box-shadow: 0 0 0 3px rgba(94, 207, 160, 0.12) !important;
}

/* ── BUTTON ── */
.signup-btn {
  width: 100%; padding: 14px; margin-top: 18px;
  background: linear-gradient(135deg, #1a6b4a, #2d9e72, #4aad8a);
  background-size: 200%;
  color: #fff;
  border: none; border-radius: 10px;
  font-family: 'Cormorant Garamond', serif;
  font-size: 18px; font-weight: 600;
  letter-spacing: 2px; text-transform: uppercase;
  cursor: pointer;
  transition: background-position .4s, transform .15s, box-shadow .3s;
  box-shadow: 0 4px 20px rgba(74, 173, 138, 0.35);
}
.signup-btn:hover {
  background-position: 100%;
  box-shadow: 0 6px 28px rgba(74, 173, 138, 0.5);
  transform: translateY(-1px);
}
.signup-btn:active { transform: scale(.98); }

.msg-lbl {
  display: block; margin-top: 10px;
  font-size: 13px; text-align: center;
}

/* ── DIVIDER ── */
.divider {
  display: flex; align-items: center; gap: 12px;
  margin: 20px 0 16px;
}
.divider::before, .divider::after {
  content: ''; flex: 1; height: 1px;
  background: rgba(94, 207, 160, 0.2);
}
.divider span { font-size: 11px; color: rgba(255,255,255,0.4); letter-spacing: 1px; white-space: nowrap; }

/* ── LOGIN LINK ── */
.login-link {
  display: block; width: 100%; padding: 13px;
  text-align: center;
  border: 1px solid rgba(94, 207, 160, 0.25); border-radius: 10px;
  color: rgba(255,255,255,0.7);
  font-family: 'Jost', sans-serif; font-size: 14px;
  text-decoration: none; letter-spacing: 0.5px;
  transition: border-color .25s, color .25s, background .25s;
}
.login-link:hover {
  border-color: rgba(94, 207, 160, 0.5);
  color: var(--green-accent);
  background: rgba(94, 207, 160, 0.08);
}

/* ── BRAND FOOTER ── */
.brand-bottom {
  position: fixed; bottom: 24px; left: 50%; transform: translateX(-50%);
  font-family: 'Cormorant Garamond', serif;
  font-size: 13px; color: rgba(255,255,255,0.3);
  letter-spacing: 1px; z-index: 5; white-space: nowrap;
}
</style>
</head>
<body>
<form id="form1" runat="server">

  <div class="bg"></div>

  <nav class="nav">
    <a href="#" class="nav-logo">
      <span class="dot"></span>
      BookShelf
    </a>
    <span class="nav-pill">New Account</span>
  </nav>

  <div class="page">
    <div class="card">

      <div class="card-eyebrow">Join BookShelf</div>
      <h1 class="card-title">Create Your<br/><em>Account</em></h1>
      <p class="card-sub">Join thousands of readers on BookShelf</p>

      <div class="fields-grid">

        <div>
          <label class="field-label">Full Name</label>
          <asp:TextBox ID="txtName" runat="server" CssClass="textbox" placeholder="Full Name"></asp:TextBox>
        </div>

        <div>
          <label class="field-label">Email</label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox" placeholder="Email"></asp:TextBox>
        </div>

        <div>
          <label class="field-label">Username</label>
          <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox" placeholder="Username"></asp:TextBox>
        </div>

        <div>
          <label class="field-label">Password</label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="Password"></asp:TextBox>
        </div>

        <%-- ❌ Role dropdown REMOVED — all signups are regular Users by default --%>
        <%-- Admins are promoted only by existing admins from the Admin Dashboard --%>

      </div>

      <asp:Button ID="btnSignup" runat="server" Text="Create Account" CssClass="signup-btn" OnClick="btnSignup_Click" />
      <asp:Label ID="lblMsg" runat="server" CssClass="msg-lbl"></asp:Label>

      <div class="divider"><span>Already have an account?</span></div>
      <a href="Login.aspx" class="login-link">Sign In to BookShelf</a>

    </div>
  </div>

  <div class="brand-bottom">BookShelf &nbsp;·&nbsp; Your Personal Library</div>

</form>
</body>
</html>
