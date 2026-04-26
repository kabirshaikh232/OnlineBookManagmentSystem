<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Cart.aspx.cs"
    Inherits="WebApplication3.Cart" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookShelf - My Cart</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        :root {
            --green-dark:  #1b4332;
            --green-mid:   #2d6a4f;
            --green-light: #52b788;
            --green-pale:  #d8f3dc;
            --cream:       #f8f5f0;
            --text-dark:   #1a1a2e;
            --text-muted:  #6b7280;
            --red:         #dc2626;
            --red-pale:    #fee2e2;
            --shadow:      0 4px 24px rgba(27,67,50,0.13);
            --radius:      14px;
        }
        body { font-family: 'DM Sans', sans-serif; background: var(--cream); color: var(--text-dark); min-height: 100vh; }

        .navbar {
            background: var(--green-dark); padding: 0 40px;
            display: flex; align-items: center; justify-content: space-between;
            height: 68px; position: sticky; top: 0; z-index: 100;
            box-shadow: 0 2px 16px rgba(0,0,0,0.18);
        }
        .navbar-brand { font-family: 'Playfair Display', serif; font-size: 1.35rem; color: #fff; }
        input[type="submit"].btn-back {
            background: transparent; border: 1.5px solid rgba(255,255,255,0.4);
            color: #fff; padding: 7px 20px; border-radius: 50px;
            font-family: 'DM Sans', sans-serif; font-size: 0.85rem; cursor: pointer; transition: background 0.2s;
        }
        input[type="submit"].btn-back:hover { background: rgba(255,255,255,0.12); }

        .hero {
            background: linear-gradient(135deg, var(--green-dark) 0%, var(--green-mid) 60%, var(--green-light) 100%);
            padding: 48px 40px 56px; position: relative; overflow: hidden;
        }
        .hero::before {
            content: ''; position: absolute; inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/svg%3E");
        }
        .hero-inner { position: relative; }
        .hero-eyebrow { font-size: 0.75rem; letter-spacing: 2.5px; text-transform: uppercase; color: var(--green-pale); margin-bottom: 8px; }
        .hero h1 { font-family: 'Playfair Display', serif; font-size: clamp(1.8rem,3.5vw,2.5rem); color: #fff; margin-bottom: 8px; }
        .hero-sub { color: rgba(255,255,255,0.7); font-size: 0.95rem; }

        .main { max-width: 960px; margin: 0 auto; padding: 48px 40px 80px; }
        .section-label { font-size: 0.72rem; font-weight: 600; letter-spacing: 2.8px; text-transform: uppercase; color: var(--green-mid); margin-bottom: 24px; }

        .cart-table-wrap {
            background: #fff; border-radius: var(--radius);
            box-shadow: var(--shadow); border: 1px solid rgba(27,67,50,0.07);
            overflow: hidden; margin-bottom: 28px;
            animation: fadeUp 0.4s ease both;
        }
        .cart-table-wrap table { width: 100%; border-collapse: collapse; }
        .cart-table-wrap table th {
            background: var(--green-dark); color: #fff;
            padding: 14px 20px; text-align: left;
            font-size: 0.78rem; font-weight: 600;
            letter-spacing: 1.5px; text-transform: uppercase;
        }
        .cart-table-wrap table td {
            padding: 16px 20px; border-bottom: 1px solid #f0ede8;
            font-size: 0.92rem; vertical-align: middle;
        }
        .cart-table-wrap table tr:last-child td { border-bottom: none; }
        .cart-table-wrap table tr:hover td { background: #fafaf8; }

        .book-name-cell { font-family: 'Playfair Display', serif; font-size: 1rem; color: var(--text-dark); }
        .author-cell { color: var(--text-muted); font-size: 0.85rem; }
        .category-badge {
            font-size: 0.68rem; font-weight: 600; letter-spacing: 1.2px; text-transform: uppercase;
            color: var(--green-mid); background: var(--green-pale);
            padding: 3px 10px; border-radius: 50px; display: inline-block;
        }
        .price-cell { font-family: 'Playfair Display', serif; font-weight: 700; color: var(--green-dark); font-size: 1rem; }

        input[type="submit"].btn-remove {
            background: var(--red-pale); color: var(--red); border: none;
            padding: 7px 14px; border-radius: 8px;
            font-family: 'DM Sans', sans-serif; font-size: 0.78rem;
            font-weight: 500; cursor: pointer; transition: background 0.2s;
        }
        input[type="submit"].btn-remove:hover { background: var(--red); color: #fff; }

        .summary-card {
            background: #fff; border-radius: var(--radius);
            box-shadow: var(--shadow); border: 1px solid rgba(27,67,50,0.07);
            padding: 28px 32px; display: flex;
            align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 20px;
            animation: fadeUp 0.4s 0.1s ease both;
        }
        .total-label { font-size: 0.8rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 4px; }
        .total-amount { font-family: 'Playfair Display', serif; font-size: 2rem; font-weight: 700; color: var(--green-dark); }

        input[type="submit"].btn-checkout {
            background: var(--green-dark); color: #fff; border: none;
            padding: 14px 36px; border-radius: 10px;
            font-family: 'DM Sans', sans-serif; font-size: 1rem;
            font-weight: 500; cursor: pointer; transition: background 0.2s, transform 0.15s;
        }
        input[type="submit"].btn-checkout:hover { background: var(--green-mid); transform: translateY(-2px); }

        .empty-state {
            background: #fff; border-radius: var(--radius);
            box-shadow: var(--shadow); padding: 70px 40px;
            text-align: center; animation: fadeUp 0.4s ease both;
        }
        .empty-icon { font-size: 4rem; margin-bottom: 16px; }
        .empty-state h3 { font-family: 'Playfair Display', serif; font-size: 1.4rem; margin-bottom: 8px; color: var(--text-dark); }
        .empty-state p { color: var(--text-muted); font-size: 0.92rem; margin-bottom: 24px; }
        input[type="submit"].btn-browse {
            background: var(--green-dark); color: #fff; border: none;
            padding: 12px 30px; border-radius: 10px;
            font-family: 'DM Sans', sans-serif; font-size: 0.92rem;
            font-weight: 500; cursor: pointer; transition: background 0.2s;
        }
        input[type="submit"].btn-browse:hover { background: var(--green-mid); }

        .footer { text-align: center; padding: 24px; font-size: 0.78rem; color: var(--text-muted); border-top: 1px solid #ede8e0; }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <nav class="navbar">
            <div class="navbar-brand">&#128218; BookShelf</div>
            <asp:Button ID="btnBack" runat="server" Text="Back to Books"
                CssClass="btn-back" PostBackUrl="BookList.aspx" />
        </nav>

        <section class="hero">
            <div class="hero-inner">
                <div class="hero-eyebrow">Checkout</div>
                <h1>My Cart</h1>
                <p class="hero-sub">Review your selected books before placing your order.</p>
            </div>
        </section>

        <main class="main">
            <div class="section-label">Selected Items</div>

            <asp:Panel ID="pnlCart" runat="server">
                <div class="cart-table-wrap">
                    <asp:GridView ID="gvCart" runat="server"
                        AutoGenerateColumns="False"
                        OnRowCommand="gvCart_RowCommand"
                        GridLines="None"
                        CssClass="cart-grid">
                        <Columns>
                            <asp:TemplateField HeaderText="Book Name">
                                <ItemTemplate>
                                    <span class="book-name-cell"><%# Eval("BookName") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Author">
                                <ItemTemplate>
                                    <span class="author-cell"><%# Eval("Author") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <span class="category-badge"><%# Eval("Category") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Price">
                                <ItemTemplate>
                                    <span class="price-cell">Rs.<%# Eval("Price") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:Button ID="btnRemove" runat="server"
                                        Text="Remove"
                                        CssClass="btn-remove"
                                        CommandName="RemoveItem"
                                        CommandArgument="<%# Container.DataItemIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="summary-card">
                    <div>
                        <div class="total-label">Total Amount</div>
                        <asp:Label ID="lblTotal" runat="server" CssClass="total-amount"></asp:Label>
                    </div>
                    <asp:Button ID="btnCheckout" runat="server"
                        Text="Proceed to Checkout"
                        CssClass="btn-checkout"
                        OnClick="btnCheckout_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="empty-state">
                    <div class="empty-icon">&#128722;</div>
                    <h3>Your cart is empty</h3>
                    <p>Looks like you have not added any books yet. Start exploring!</p>
                    <asp:Button ID="btnBrowse" runat="server"
                        Text="Browse Books"
                        CssClass="btn-browse"
                        PostBackUrl="BookList.aspx" />
                </div>
            </asp:Panel>
        </main>

        <footer class="footer">&#169; 2026 BookShelf &nbsp;&#183;&nbsp; All rights reserved</footer>

    </form>
</body>
</html>