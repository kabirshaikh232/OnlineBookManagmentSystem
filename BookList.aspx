    <%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="BookList.aspx.cs"
    Inherits="WebApplication3.BookList" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>BookShelf – Browse Books</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,500;0,700;1,500&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet" />
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --green-dark:   #1b4332;
  --green-mid:    #2d6a4f;
  --green-light:  #52b788;
  --green-pale:   #d8f3dc;
  --cream:        #f8f5f0;
  --cream-2:      #f0ede8;
  --text-dark:    #1a1a2e;
  --text-muted:   #6b7280;
  --shadow:       0 8px 32px rgba(27,67,50,0.18);
  --radius:       16px;
}

html, body {
  background: var(--cream);
  color: var(--text-dark);
  font-family: 'DM Sans', sans-serif;
  min-height: 100vh;
}

.navbar {
  background: var(--green-dark);
  height: 68px;
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 40px;
  position: sticky; top: 0; z-index: 100;
  box-shadow: 0 2px 16px rgba(0,0,0,0.18);
}
.brand {
  font-family: 'Playfair Display', serif;
  font-size: 1.35rem; font-weight: 700;
  color: #fff;
}
input[type="submit"].btn-back {
  background: transparent;
  border: 1.5px solid rgba(255,255,255,0.4);
  color: #fff; padding: 8px 22px;
  border-radius: 50px;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.85rem; cursor: pointer;
  transition: background 0.2s;
}
input[type="submit"].btn-back:hover { background: rgba(255,255,255,0.12); }

.toast {
  display: none;
  position: fixed; bottom: 28px; right: 28px;
  background: var(--green-dark); color: #fff;
  padding: 14px 22px; border-radius: 12px;
  font-size: 0.9rem; font-weight: 500;
  box-shadow: 0 8px 32px rgba(27,67,50,0.35);
  z-index: 9999;
  animation: slideUp 0.3s ease;
}
.toast.show { display: block; }
@keyframes slideUp {
  from { opacity: 0; transform: translateY(16px); }
  to   { opacity: 1; transform: translateY(0); }
}

.hero {
  background: linear-gradient(135deg, var(--green-dark) 0%, var(--green-mid) 60%, var(--green-light) 100%);
  padding: 48px 40px 64px;
  position: relative; overflow: hidden;
}
.hero::before {
  content: '';
  position: absolute; inset: 0;
  background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/svg%3E");
}
.hero-inner { position: relative; }
.hero-label {
  font-size: 0.72rem; letter-spacing: 2.5px; text-transform: uppercase;
  color: var(--green-pale); margin-bottom: 10px;
}
.hero h1 {
  font-family: 'Playfair Display', serif;
  font-size: clamp(1.9rem, 3.5vw, 2.6rem);
  color: #fff; margin-bottom: 8px; font-weight: 700;
}
.hero-sub { color: rgba(255,255,255,0.72); font-size: 0.96rem; }

.search-wrap {
  background: #fff; border-radius: 16px;
  padding: 22px 32px; margin: -28px 40px 0;
  position: relative; z-index: 10;
  box-shadow: 0 4px 24px rgba(27,67,50,0.13);
  display: flex; align-items: center; flex-wrap: wrap; gap: 14px;
}
.search-label {
  font-size: 0.75rem; font-weight: 600; letter-spacing: 1.2px;
  text-transform: uppercase; color: var(--text-muted);
}
.search-wrap input[type="text"] {
  border: 1.5px solid #e5e7eb; border-radius: 9px;
  padding: 10px 16px; font-family: 'DM Sans', sans-serif;
  font-size: 0.92rem; outline: none; width: 220px;
  transition: border-color 0.2s; color: var(--text-dark);
}
.search-wrap input[type="text"]:focus { border-color: var(--green-light); }
.search-wrap select {
  border: 1.5px solid #e5e7eb; border-radius: 9px;
  padding: 10px 14px; font-family: 'DM Sans', sans-serif;
  font-size: 0.92rem; background: #fff; outline: none;
  color: var(--text-dark);
}
input[type="submit"].btn-search {
  background: var(--green-dark); color: #fff; border: none;
  padding: 11px 28px; border-radius: 9px;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.9rem; font-weight: 500; cursor: pointer;
  transition: background 0.2s;
}
input[type="submit"].btn-search:hover { background: var(--green-mid); }

.main {
  padding: 52px 40px 80px;
  max-width: 1280px; margin: 0 auto;
}
.section-header {
  display: flex; align-items: center; justify-content: space-between;
  margin-bottom: 28px;
}
.section-label {
  font-size: 0.7rem; font-weight: 600; letter-spacing: 2.8px;
  text-transform: uppercase; color: var(--green-mid);
}
.cart-badge {
  background: var(--green-pale); color: var(--green-dark);
  padding: 6px 16px; border-radius: 50px;
  font-size: 0.82rem; font-weight: 600;
}
.add-msg {
  background: var(--green-pale); color: var(--green-dark);
  padding: 12px 20px; border-radius: 10px;
  font-weight: 500; margin-bottom: 24px; display: block;
}

.book-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
  gap: 24px;
}

.book-card {
  position: relative; height: 320px;
  border-radius: var(--radius); overflow: hidden;
  box-shadow: var(--shadow); cursor: pointer;
  transition: transform 0.25s cubic-bezier(0.34,1.56,0.64,1), box-shadow 0.25s ease;
  animation: fadeUp 0.4s ease both;
}
.book-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: 0 20px 50px rgba(27,67,50,0.28);
}

.book-cover {
  position: absolute; inset: 0;
  width: 100%; height: 100%;
  object-fit: cover; display: block;
  transition: transform 0.4s ease;
}
.book-card:hover .book-cover { transform: scale(1.06); }

.book-overlay {
  position: absolute; inset: 0;
  background: linear-gradient(
    to top,
    rgba(10,30,18,0.95) 0%,
    rgba(10,30,18,0.65) 45%,
    rgba(10,30,18,0.08) 75%,
    transparent 100%
  );
  display: flex; flex-direction: column;
  justify-content: flex-end;
  padding: 18px 16px 16px;
}

.book-category-pill {
  position: absolute; top: 14px; left: 14px;
  background: rgba(255,255,255,0.18);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,255,255,0.25);
  color: #fff; font-size: 0.62rem; font-weight: 600;
  letter-spacing: 1.5px; text-transform: uppercase;
  padding: 4px 10px; border-radius: 50px;
}

.book-author-name {
  font-size: 0.75rem; color: rgba(255,255,255,0.65);
  margin-bottom: 4px; font-weight: 400;
}
.book-title-text {
  font-family: 'Playfair Display', serif;
  font-size: 1.05rem; font-weight: 700;
  color: #fff; line-height: 1.25; margin-bottom: 12px;
  display: -webkit-box;
  -webkit-line-clamp: 2; -webkit-box-orient: vertical;
  overflow: hidden;
}
.book-bottom {
  display: flex; align-items: center; justify-content: space-between;
}
.book-price-text {
  font-family: 'Playfair Display', serif;
  font-size: 1rem; font-weight: 700; color: #fff;
}
input[type="submit"].btn-cart-overlay {
  background: rgba(255,255,255,0.18);
  backdrop-filter: blur(8px);
  border: 1px solid rgba(255,255,255,0.35);
  color: #fff; padding: 6px 14px; border-radius: 8px;
  font-family: 'DM Sans', sans-serif;
  font-size: 0.78rem; font-weight: 500; cursor: pointer;
  transition: background 0.2s, border-color 0.2s, transform 0.15s;
}
input[type="submit"].btn-cart-overlay:hover {
  background: var(--green-light);
  border-color: var(--green-light);
  transform: scale(1.05);
}

.empty-state { text-align: center; padding: 80px 20px; color: var(--text-muted); }
.empty-icon { font-size: 3.5rem; margin-bottom: 14px; }

.footer {
  text-align: center; padding: 28px;
  font-size: 0.78rem; color: var(--text-muted);
  border-top: 1px solid var(--cream-2);
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(20px); }
  to   { opacity: 1; transform: translateY(0); }
}
.book-card:nth-child(1)  { animation-delay: 0.04s; }
.book-card:nth-child(2)  { animation-delay: 0.08s; }
.book-card:nth-child(3)  { animation-delay: 0.12s; }
.book-card:nth-child(4)  { animation-delay: 0.16s; }
.book-card:nth-child(5)  { animation-delay: 0.20s; }
.book-card:nth-child(6)  { animation-delay: 0.24s; }
.book-card:nth-child(7)  { animation-delay: 0.28s; }
.book-card:nth-child(8)  { animation-delay: 0.32s; }
.book-card:nth-child(9)  { animation-delay: 0.36s; }
.book-card:nth-child(10) { animation-delay: 0.40s; }

@media (max-width: 768px) {
  .navbar { padding: 0 16px; }
  .hero { padding: 32px 16px 56px; }
  .search-wrap { margin: -24px 16px 0; padding: 16px; }
  .search-wrap input[type="text"] { width: 100%; }
  .main { padding: 40px 16px 60px; }
  .book-grid { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); gap: 16px; }
  .book-card { height: 260px; }
}
</style>
</head>
<body>
<form id="form1" runat="server">

  <nav class="navbar">
    <div class="brand">&#128218; BookShelf</div>
    <asp:Button ID="btnBack" runat="server" Text="&#8592; Dashboard"
        CssClass="btn-back" PostBackUrl="UserHome.aspx" />
  </nav>

  <section class="hero">
    <div class="hero-inner">
      <div class="hero-label">Our Collection</div>
      <h1>Browse Books</h1>
      <p class="hero-sub">Discover titles across Programming, Database, Design and more.</p>
    </div>
  </section>

  <div class="search-wrap">
    <span class="search-label">Search</span>
    <asp:TextBox ID="txtSearch" runat="server" placeholder="Title, author..."></asp:TextBox>
    <span class="search-label">Category</span>
    <asp:DropDownList ID="ddlCategory" runat="server">
      <asp:ListItem Text="All"         Value="All"></asp:ListItem>
      <asp:ListItem Text="Programming" Value="Programming"></asp:ListItem>
      <asp:ListItem Text="Database"    Value="Database"></asp:ListItem>
      <asp:ListItem Text="Design"      Value="Design"></asp:ListItem>
      <asp:ListItem Text="Web"         Value="Web"></asp:ListItem>
      <asp:ListItem Text="Networking"  Value="Networking"></asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="btnSearch" runat="server" Text="&#128269; Search"
        CssClass="btn-search" OnClick="btnSearch_Click" />
  </div>

  <div style="display:none">
    <asp:GridView ID="gvBooks" runat="server"
        AutoGenerateColumns="False"
        DataKeyNames="BookName,Author,Category,Price"
        OnRowCommand="gvBooks_RowCommand">
      <Columns>
        <asp:BoundField DataField="BookName" />
        <asp:BoundField DataField="Author" />
        <asp:BoundField DataField="Category" />
        <asp:BoundField DataField="Price" />
        <asp:TemplateField>
          <ItemTemplate>
            <asp:Button ID="btnAdd" runat="server" Text="Add to Cart"
                CommandName="AddToCart"
                CommandArgument="<%# Container.DataItemIndex %>" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>

  <main class="main">
    <div class="section-header">
      <div class="section-label">Available Titles</div>
      <div class="cart-badge">&#128722; <asp:Label ID="lblCartCount" runat="server" Text="0 items in cart"></asp:Label></div>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="add-msg" Visible="false"></asp:Label>

    <div class="book-grid">
      <asp:Repeater ID="rptBooks" runat="server" OnItemCommand="rptBooks_ItemCommand">
        <ItemTemplate>
          <div class="book-card">

            <img class="book-cover"
                src='<%# ResolveBookImage(Eval("CoverUrl")) %>'
                alt='<%# Eval("BookName") %>'
                onerror="this.onerror=null;this.src='https://placehold.co/220x320/1b4332/d8f3dc?text=Book'" />

            <span class="book-category-pill"><%# Eval("Category") %></span>

            <div class="book-overlay">
              <div class="book-author-name"><%# Eval("Author") %></div>
              <div class="book-title-text"><%# Eval("BookName") %></div>
              <div class="book-bottom">
                <span class="book-price-text">Rs.<%# Eval("Price") %></span>
                <asp:Button runat="server"
                    Text="+ Cart"
                    CssClass="btn-cart-overlay"
                    CommandName="AddToCart"
                    CommandArgument='<%# Eval("BookName")+"|"+Eval("Author")+"|"+Eval("Category")+"|"+Eval("Price") %>' />
              </div>
            </div>

          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>

    <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
      <div class="empty-state">
        <div class="empty-icon">&#128229;</div>
        <p>No books found. Try a different search.</p>
      </div>
    </asp:Panel>
  </main>

  <footer class="footer">&#169; 2026 BookShelf &nbsp;&#183;&nbsp; Your Personal Library</footer>

  <div class="toast" id="cartToast">&#128722; Added to cart!</div>

</form>
<script>
  window.onload = function () {
    var msg = document.getElementById('<%= lblMsg.ClientID %>');
    if (msg && msg.style.display !== 'none' && msg.innerText.trim() !== '') {
      var toast = document.getElementById('cartToast');
      if (toast) {
        toast.classList.add('show');
        setTimeout(function () { toast.classList.remove('show'); }, 2500);
      }
    }
  };
</script>
</body>
</html>