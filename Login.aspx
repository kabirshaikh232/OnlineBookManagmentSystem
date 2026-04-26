<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication3.Login" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>BookShelf – Sign In</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;0,700;1,300;1,400&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet" />
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --green-dark:  #1a4a3a;
  --green-mid:   #2d7a5f;
  --green-light: #4aad8a;
  --green-soft:  rgba(45, 122, 95, 0.18);
  --green-glass: rgba(30, 90, 65, 0.22);
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
  background: url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=1800&q=90') center/cover no-repeat;
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

/* ── CENTER WRAPPER ── */
.page {
  position: fixed; inset: 0;
  display: flex; align-items: center; justify-content: center;
  z-index: 5;
}

/* ── CARD ── */
.card {
  width: 420px;
  background: rgba(25, 80, 58, 0.28);
  backdrop-filter: blur(28px) saturate(1.6);
  -webkit-backdrop-filter: blur(28px) saturate(1.6);
  border: 1px solid rgba(94, 207, 160, 0.3);
  border-radius: 22px;
  padding: 46px 44px 40px;
  box-shadow:
    0 8px 40px rgba(0,0,0,0.3),
    0 2px 0 rgba(94, 207, 160, 0.15) inset,
    inset 0 1px 0 rgba(255,255,255,0.1);
  animation: fadeUp 0.7s cubic-bezier(.22,.68,0,1.2) both;
  position: relative;
  overflow: hidden;
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

/* ── LOGIN PANEL ── */
.login-panel {
  transition: opacity 0.35s ease, transform 0.35s ease;
}
.login-panel.hidden {
  opacity: 0;
  transform: translateY(-18px);
  pointer-events: none;
  position: absolute;
}

/* ── FORGOT PANEL ── */
.forgot-panel {
  opacity: 0;
  transform: translateY(18px);
  pointer-events: none;
  transition: opacity 0.35s ease, transform 0.35s ease;
  position: absolute;
  top: 46px; left: 44px; right: 44px;
}
.forgot-panel.visible {
  opacity: 1;
  transform: translateY(0);
  pointer-events: all;
  position: relative;
  top: auto; left: auto; right: auto;
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
  font-size: 38px; font-weight: 300;
  color: #fff; line-height: 1.1;
  margin-bottom: 6px;
  letter-spacing: 0.5px;
}
.card-title em { font-style: italic; color: var(--green-accent); }

.card-sub {
  font-size: 13px; color: var(--muted); font-weight: 300;
  margin-bottom: 32px; line-height: 1.6;
}

/* ── FIELDS ── */
.field { margin-bottom: 18px; }
.field-label {
  display: block;
  font-size: 10px; letter-spacing: 2px; text-transform: uppercase;
  color: rgba(94, 207, 160, 0.85); font-weight: 500;
  margin-bottom: 8px;
}
.textbox {
  width: 100% !important;
  padding: 13px 16px;
  background: rgba(255,255,255,0.08) !important;
  border: 1px solid rgba(94, 207, 160, 0.25) !important;
  border-radius: 10px;
  color: #fff !important;
  font-family: 'Jost', sans-serif;
  font-size: 15px; font-weight: 300;
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
.val-msg {
  display: block; font-size: 11.5px; color: #e8836a; margin-top: 5px;
}

/* ── BUTTONS ── */
.login-btn, .reset-btn {
  width: 100%; padding: 14px;
  margin-top: 8px;
  background: linear-gradient(135deg, #1a6b4a, #2d9e72, #4aad8a);
  background-size: 200% 200%;
  color: #fff;
  border: none; border-radius: 10px;
  font-family: 'Cormorant Garamond', serif;
  font-size: 18px; font-weight: 600;
  letter-spacing: 2px; text-transform: uppercase;
  cursor: pointer;
  transition: background-position .4s, transform .15s, box-shadow .3s;
  box-shadow: 0 4px 20px rgba(74, 173, 138, 0.35);
}
.login-btn:hover, .reset-btn:hover {
  background-position: 100% 0;
  box-shadow: 0 6px 28px rgba(74, 173, 138, 0.5);
  transform: translateY(-1px);
}
.login-btn:active, .reset-btn:active { transform: scale(.98); }

.msg-lbl {
  display: block; margin-top: 10px;
  font-size: 13px; color: #e8836a; text-align: center;
}
.msg-lbl.success { color: var(--green-accent); }

/* ── FORGOT PASSWORD LINK ── */
.forgot-link {
  display: block; margin-top: 10px; text-align: right;
  font-size: 12px; color: rgba(94, 207, 160, 0.7);
  cursor: pointer; letter-spacing: 0.5px;
  background: none; border: none; font-family: 'Jost', sans-serif;
  transition: color .2s;
}
.forgot-link:hover { color: var(--green-accent); text-decoration: underline; }

/* ── BACK LINK ── */
.back-link {
  display: flex; align-items: center; gap: 6px;
  background: none; border: none;
  font-family: 'Jost', sans-serif;
  font-size: 12px; color: rgba(94, 207, 160, 0.7);
  cursor: pointer; margin-bottom: 24px; padding: 0;
  letter-spacing: 0.5px;
  transition: color .2s;
}
.back-link:hover { color: var(--green-accent); }
.back-link::before { content: '←'; font-size: 14px; }

/* ── DIVIDER ── */
.divider {
  display: flex; align-items: center; gap: 12px;
  margin: 24px 0 18px;
}
.divider::before, .divider::after {
  content: ''; flex: 1; height: 1px;
  background: rgba(94, 207, 160, 0.2);
}
.divider span { font-size: 11px; color: rgba(255,255,255,0.4); white-space: nowrap; letter-spacing: 1px; }

/* ── SIGNUP LINK ── */
.signup-link {
  display: block; width: 100%; padding: 13px;
  text-align: center;
  border: 1px solid rgba(94, 207, 160, 0.25); border-radius: 10px;
  color: rgba(255,255,255,0.7);
  font-family: 'Jost', sans-serif; font-size: 14px; font-weight: 400;
  text-decoration: none; letter-spacing: 0.5px;
  transition: border-color .25s, color .25s, background .25s;
}
.signup-link:hover {
  border-color: rgba(94, 207, 160, 0.5);
  color: var(--green-accent);
  background: rgba(94, 207, 160, 0.08);
}

/* ── BOTTOM BRANDING ── */
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
    <span class="nav-pill">Member Portal</span>
  </nav>

  <div class="page">
    <div class="card" id="mainCard">

      <%-- ══ LOGIN PANEL ══ --%>
      <div class="login-panel" id="loginPanel">

        <div class="card-eyebrow">Welcome Back</div>
        <h1 class="card-title">Sign in to your<br/><em>Library</em></h1>
        <p class="card-sub">Access your personal reading collection</p>

        <div class="field">
          <label class="field-label">Username</label>
          <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox" placeholder="Enter your username"></asp:TextBox>
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername"
            ErrorMessage="Username is required" CssClass="val-msg" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
        </div>

        <div class="field">
          <label class="field-label">Password</label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="Enter your password"></asp:TextBox>
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
            ErrorMessage="Password is required" CssClass="val-msg" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
        </div>

        <button type="button" class="forgot-link" onclick="showForgot()">Forgot password?</button>

        <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="login-btn"
          OnClick="btnLogin_Click" ValidationGroup="LoginGroup" />
        <asp:Label ID="lblMsg" runat="server" CssClass="msg-lbl"></asp:Label>

        <div class="divider"><span>New to BookShelf?</span></div>
        <a href="Signup.aspx" class="signup-link">Create a Free Account</a>

      </div>

      <%-- ══ FORGOT PASSWORD PANEL ══ --%>
      <div class="forgot-panel" id="forgotPanel">

        <button type="button" class="back-link" onclick="showLogin()">Back to Sign In</button>

        <div class="card-eyebrow">Reset Password</div>
        <h1 class="card-title">New <em>Password</em></h1>
        <p class="card-sub">Enter your username and choose a new password</p>

        <div class="field">
          <label class="field-label">Username</label>
          <asp:TextBox ID="txtResetUsername" runat="server" CssClass="textbox" placeholder="Your username"></asp:TextBox>
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtResetUsername"
            ErrorMessage="Username is required" CssClass="val-msg" ValidationGroup="ResetGroup"></asp:RequiredFieldValidator>
        </div>

        <div class="field">
          <label class="field-label">New Password</label>
          <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="New password"></asp:TextBox>
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPassword"
            ErrorMessage="New password is required" CssClass="val-msg" ValidationGroup="ResetGroup"></asp:RequiredFieldValidator>
        </div>

        <div class="field">
          <label class="field-label">Confirm Password</label>
          <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="textbox" placeholder="Confirm new password"></asp:TextBox>
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword"
            ErrorMessage="Please confirm your password" CssClass="val-msg" ValidationGroup="ResetGroup"></asp:RequiredFieldValidator>
          <asp:CompareValidator runat="server"
            ControlToValidate="txtConfirmPassword"
            ControlToCompare="txtNewPassword"
            ErrorMessage="Passwords do not match" CssClass="val-msg" ValidationGroup="ResetGroup"></asp:CompareValidator>
        </div>

        <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="reset-btn"
          OnClick="btnResetPassword_Click" ValidationGroup="ResetGroup" />
        <asp:Label ID="lblResetMsg" runat="server" CssClass="msg-lbl"></asp:Label>

      </div>

    </div>
  </div>

  <%-- Hidden field to persist panel state across postbacks --%>
  <asp:HiddenField ID="hdnPanel" runat="server" Value="login" />

  <div class="brand-bottom">BookShelf &nbsp;·&nbsp; Your Personal Library</div>

</form>

<script type="text/javascript">
  function showForgot() {
    document.getElementById('loginPanel').classList.add('hidden');
    document.getElementById('forgotPanel').classList.add('visible');
    document.getElementById('<%= hdnPanel.ClientID %>').value = 'forgot';
  }

  function showLogin() {
    document.getElementById('forgotPanel').classList.remove('visible');
    document.getElementById('loginPanel').classList.remove('hidden');
    document.getElementById('<%= hdnPanel.ClientID %>').value = 'login';
  }

  // Restore panel state after postback
  window.onload = function () {
    var panel = document.getElementById('<%= hdnPanel.ClientID %>').value;
    if (panel === 'forgot') {
      document.getElementById('loginPanel').classList.add('hidden');
      document.getElementById('forgotPanel').classList.add('visible');
    }
  };
</script>
</body>
</html>
