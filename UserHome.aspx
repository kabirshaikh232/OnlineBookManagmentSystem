<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="WebApplication3.UserHome" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BookShelf - Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; background: #f8f5f0; color: #1a1a2e; min-height: 100vh; }

        .navbar {
            background: #1b4332; padding: 0 40px;
            display: flex; align-items: center; justify-content: space-between;
            height: 68px; position: sticky; top: 0; z-index: 100;
            box-shadow: 0 2px 16px rgba(0,0,0,0.18);
        }
        .navbar-brand { font-family: 'Playfair Display', serif; font-size: 1.35rem; color: #fff; }
        .nav-right { display: flex; align-items: center; }
        .welcome-chip {
            background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);
            border-radius: 50px; padding: 6px 16px; color: #d8f3dc;
            font-size: 0.88rem; margin-right: 14px;
        }
        .welcome-chip strong { color: #fff; }
        .nav-btn {
            color: #fff; border: none; padding: 7px 18px; border-radius: 50px;
            font-family: 'DM Sans', sans-serif; font-size: 0.85rem; cursor: pointer;
            margin-right: 10px; text-decoration: none; display: inline-block; line-height: 1.8;
        }
        .nav-btn-cart { background: #52b788; }
        .nav-btn-cart:hover { background: #2d6a4f; }
        .nav-btn-orders { background: rgba(255,255,255,0.15); border: 1.5px solid rgba(255,255,255,0.3); }
        .nav-btn-orders:hover { background: rgba(255,255,255,0.25); }
        input[type="submit"].btn-logout {
            background: transparent; border: 1.5px solid rgba(255,255,255,0.4);
            color: #fff; padding: 7px 20px; border-radius: 50px;
            font-family: 'DM Sans', sans-serif; font-size: 0.85rem; cursor: pointer;
        }
        input[type="submit"].btn-logout:hover { background: rgba(255,255,255,0.12); }

        .hero {
            background: linear-gradient(135deg, #1b4332 0%, #2d6a4f 60%, #52b788 100%);
            padding: 48px 40px 100px; position: relative; overflow: hidden;
        }
        .hero-eyebrow { font-size: 0.78rem; letter-spacing: 2.5px; text-transform: uppercase; color: #d8f3dc; margin-bottom: 10px; }
        .hero h1 { font-family: 'Playfair Display', serif; font-size: 2.5rem; color: #fff; margin-bottom: 8px; }
        .hero-sub { color: rgba(255,255,255,0.72); font-size: 1rem; }

        .search-wrap {
            background: #fff; border-radius: 16px; padding: 20px 28px;
            margin: -36px 40px 0; position: relative; z-index: 10;
            box-shadow: 0 4px 24px rgba(27,67,50,0.13);
            display: flex; align-items: center; flex-wrap: wrap;
        }
        .search-wrap label { font-size: 0.78rem; font-weight: 600; color: #6b7280; text-transform: uppercase; letter-spacing: 1px; margin-right: 10px; }
        .search-wrap input[type="text"] {
            border: 1.5px solid #e5e7eb; border-radius: 8px; padding: 9px 14px;
            font-family: 'DM Sans', sans-serif; font-size: 0.92rem; outline: none;
            width: 220px; margin-right: 12px;
        }
        .search-wrap input[type="text"]:focus { border-color: #52b788; }
        .search-wrap select {
            border: 1.5px solid #e5e7eb; border-radius: 8px; padding: 9px 14px;
            font-family: 'DM Sans', sans-serif; font-size: 0.92rem;
            background: #fff; outline: none; margin-right: 12px;
        }
        input[type="submit"].btn-search {
            background: #1b4332; color: #fff; border: none;
            padding: 10px 26px; border-radius: 8px; font-family: 'DM Sans', sans-serif;
            font-size: 0.9rem; font-weight: 500; cursor: pointer;
        }
        input[type="submit"].btn-search:hover { background: #2d6a4f; }

        .tabs-wrap { max-width: 1200px; margin: 0 auto; padding: 32px 40px 0; }
        .tabs { display: flex; border-bottom: 2px solid #e5e7eb; margin-bottom: 32px; }
        .tab-btn {
            padding: 12px 28px; font-family: 'DM Sans', sans-serif; font-size: 0.92rem;
            font-weight: 600; color: #6b7280; background: none; border: none;
            cursor: pointer; border-bottom: 3px solid transparent; margin-bottom: -2px;
        }
        .tab-btn:hover { color: #1b4332; }
        .tab-btn.active { color: #1b4332; border-bottom-color: #1b4332; }

        .main { max-width: 1200px; margin: 0 auto; padding: 0 40px 80px; }
        .section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
        .section-label { font-size: 0.72rem; font-weight: 600; letter-spacing: 2.8px; text-transform: uppercase; color: #2d6a4f; }
        .cart-count-badge { background: #d8f3dc; color: #1b4332; border-radius: 50px; padding: 5px 16px; font-size: 0.82rem; font-weight: 600; }

        .books-wrap { margin: 0 -12px; font-size: 0; }
        .book-card {
            display: inline-block; width: calc(20% - 24px); margin: 0 12px 28px;
            background: #fff; border-radius: 14px;
            box-shadow: 0 4px 24px rgba(27,67,50,0.1);
            border: 1px solid rgba(27,67,50,0.07);
            overflow: hidden; vertical-align: top; font-size: 14px;
        }
        .book-card:hover { box-shadow: 0 10px 36px rgba(27,67,50,0.18); }
        .book-cover { width: 100%; height: 180px; object-fit: cover; display: block; background: #d8f3dc; }
        .book-body { padding: 14px; }
        .book-category { font-size: 0.65rem; font-weight: 600; letter-spacing: 1.2px; text-transform: uppercase; color: #2d6a4f; background: #d8f3dc; padding: 2px 8px; border-radius: 50px; display: inline-block; margin-bottom: 6px; }
        .book-title { font-family: 'Playfair Display', serif; font-size: 0.95rem; color: #1a1a2e; margin-bottom: 4px; line-height: 1.3; }
        .book-author { font-size: 0.78rem; color: #6b7280; margin-bottom: 12px; }
        .book-footer { display: flex; align-items: center; justify-content: space-between; }
        .book-price { font-family: 'Playfair Display', serif; font-size: 1.05rem; font-weight: 700; color: #1b4332; }
        input[type="submit"].btn-cart { background: #1b4332; color: #fff; border: none; padding: 6px 12px; border-radius: 7px; font-family: 'DM Sans', sans-serif; font-size: 0.75rem; font-weight: 500; cursor: pointer; }
        input[type="submit"].btn-cart:hover { background: #2d6a4f; }

        .order-card { background: #fff; border-radius: 14px; box-shadow: 0 4px 24px rgba(27,67,50,0.1); border: 1px solid rgba(27,67,50,0.07); margin-bottom: 20px; overflow: hidden; }
        .order-header { padding: 18px 24px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #f0ede8; background: #fafaf8; }
        .order-id-label { font-size: 0.75rem; color: #6b7280; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 3px; }
        .order-id-value { font-family: 'Playfair Display', serif; font-size: 1rem; color: #1b4332; font-weight: 600; }
        .order-date { font-size: 0.82rem; color: #6b7280; margin-bottom: 4px; }
        .order-amount { font-family: 'Playfair Display', serif; font-size: 1.2rem; font-weight: 700; color: #1b4332; }
        .badge { padding: 5px 14px; border-radius: 50px; font-size: 0.75rem; font-weight: 600; display: inline-block; }
        .badge-pending   { background: #fef3c7; color: #92400e; }
        .badge-paid      { background: #d8f3dc; color: #1b4332; }
        .badge-shipped   { background: #dbeafe; color: #1e40af; }
        .badge-delivered { background: #d8f3dc; color: #1b4332; }
        .badge-cancelled { background: #fee2e2; color: #dc2626; }
        .order-body { padding: 18px 24px; }
        .order-meta { font-size: 0.85rem; color: #6b7280; margin-bottom: 14px; }
        .order-meta span { margin-right: 20px; }
        .order-meta strong { color: #1a1a2e; }
        .order-items-title { font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; color: #6b7280; margin-bottom: 10px; }
        .order-item { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #f8f5f0; font-size: 0.88rem; }
        .order-item:last-child { border-bottom: none; }
        .order-item-name { color: #1a1a2e; }
        .order-item-price { font-weight: 600; color: #1b4332; }
        .order-actions { margin-top: 16px; padding-top: 16px; border-top: 1px solid #f0ede8; display: flex; justify-content: flex-end; }

        .btn-help { background: #1b4332; color: #fff; border: none; padding: 8px 20px; border-radius: 8px; font-family: 'DM Sans', sans-serif; font-size: 0.85rem; font-weight: 600; cursor: pointer; }
        .btn-help:hover { background: #2d6a4f; }
        .btn-reorder { background: #dbeafe; color: #1e40af; border: none; padding: 8px 20px; border-radius: 8px; font-family: 'DM Sans', sans-serif; font-size: 0.85rem; font-weight: 600; cursor: pointer; }
        .btn-reorder:hover { background: #1e40af; color: #fff; }

        .overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; }
        .overlay.open { display: block; }
        .help-drawer {
            position: fixed; top: 0; right: -480px; width: 440px; height: 100%;
            background: #fff; box-shadow: -8px 0 40px rgba(0,0,0,0.2);
            display: flex; flex-direction: column; z-index: 10000;
            transition: right 0.3s ease; overflow-y: auto;
        }
        .help-drawer.open { right: 0; }
        .drawer-header { background: #1b4332; padding: 24px 28px; display: flex; align-items: flex-start; justify-content: space-between; flex-shrink: 0; }
        .drawer-header-text h3 { font-family: 'Playfair Display', serif; color: #fff; font-size: 1.15rem; margin-bottom: 4px; }
        .drawer-header-text p { color: rgba(255,255,255,0.65); font-size: 0.82rem; }
        .drawer-close { background: rgba(255,255,255,0.15); border: none; color: #fff; width: 34px; height: 34px; border-radius: 50%; cursor: pointer; font-size: 1.1rem; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .drawer-close:hover { background: rgba(255,255,255,0.3); }
        .drawer-body { padding: 24px 28px; flex: 1; }
        .drawer-section-title { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1.8px; color: #6b7280; margin-bottom: 12px; margin-top: 24px; }
        .drawer-section-title:first-child { margin-top: 0; }

        .help-option { display: flex; align-items: center; padding: 14px 16px; border: 1.5px solid #e5e7eb; border-radius: 10px; margin-bottom: 10px; cursor: pointer; background: #fff; width: 100%; text-align: left; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .help-option:hover { border-color: #52b788; background: #f8fff9; }
        .help-option.danger:hover { border-color: #dc2626; background: #fff5f5; }
        .help-option.danger .help-option-title { color: #dc2626; }
        .help-icon { font-size: 1.1rem; width: 38px; height: 38px; background: #f8f5f0; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-right: 14px; flex-shrink: 0; }
        .help-option-title { font-size: 0.9rem; font-weight: 600; color: #1a1a2e; }
        .help-option-sub { font-size: 0.78rem; color: #6b7280; margin-top: 2px; }
        .help-arrow { margin-left: auto; color: #9ca3af; font-size: 1.1rem; padding-left: 8px; }

        .sub-panel { display: none; }
        .sub-panel.open { display: block; }
        .btn-back-drawer { background: none; border: none; color: #6b7280; font-family: 'DM Sans', sans-serif; font-size: 0.85rem; cursor: pointer; padding: 0 0 16px 0; display: flex; align-items: center; }
        .btn-back-drawer:hover { color: #1b4332; }

        .reason-option { display: flex; align-items: center; padding: 12px 14px; border: 1.5px solid #e5e7eb; border-radius: 8px; margin-bottom: 8px; cursor: pointer; transition: all 0.15s; }
        .reason-option:hover { border-color: #dc2626; background: #fff5f5; }
        .reason-option input[type="radio"] { margin-right: 10px; width: 16px; height: 16px; flex-shrink: 0; }
        .reason-option label { font-size: 0.88rem; color: #1a1a2e; cursor: pointer; }

        .btn-confirm-cancel { width: 100%; padding: 12px; background: #dc2626; color: #fff; border: none; border-radius: 8px; font-family: 'DM Sans', sans-serif; font-size: 0.92rem; font-weight: 600; cursor: pointer; margin-top: 12px; }
        .btn-confirm-cancel:hover { background: #b91c1c; }

        .contact-card { background: #f8f5f0; border-radius: 10px; padding: 16px 18px; margin-bottom: 12px; display: flex; align-items: center; }
        .contact-icon { font-size: 1.3rem; margin-right: 14px; flex-shrink: 0; }
        .contact-title { font-size: 0.9rem; font-weight: 600; color: #1a1a2e; }
        .contact-sub { font-size: 0.78rem; color: #6b7280; margin-top: 2px; }
        .contact-action { margin-left: auto; }
        .btn-contact-action { background: #1b4332; color: #fff; border: none; padding: 7px 16px; border-radius: 6px; font-family: 'DM Sans', sans-serif; font-size: 0.8rem; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 500; }
        .btn-contact-action:hover { background: #2d6a4f; }

        .drawer-input { width: 100%; border: 1.5px solid #e5e7eb; border-radius: 8px; padding: 11px 14px; font-family: 'DM Sans', sans-serif; font-size: 0.92rem; outline: none; margin-bottom: 12px; }
        .drawer-input:focus { border-color: #52b788; }
        .btn-drawer-submit { width: 100%; padding: 12px; background: #1b4332; color: #fff; border: none; border-radius: 8px; font-family: 'DM Sans', sans-serif; font-size: 0.92rem; font-weight: 600; cursor: pointer; }
        .btn-drawer-submit:hover { background: #2d6a4f; }

        .empty { text-align: center; padding: 60px; color: #6b7280; }
        .empty-icon { font-size: 3rem; margin-bottom: 12px; }
        .no-orders { text-align: center; padding: 60px 40px; background: #fff; border-radius: 14px; box-shadow: 0 4px 24px rgba(27,67,50,0.1); }
        .no-orders-icon { font-size: 3.5rem; margin-bottom: 16px; }
        .no-orders h3 { font-family: 'Playfair Display', serif; font-size: 1.3rem; color: #1b4332; margin-bottom: 8px; }
        .no-orders p { color: #6b7280; font-size: 0.92rem; }

        .add-msg { background: #d8f3dc; color: #1b4332; padding: 12px 20px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; display: block; }
        .cancel-msg { background: #fee2e2; color: #dc2626; padding: 12px 20px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; display: block; }

        .footer { text-align: center; padding: 24px; font-size: 0.78rem; color: #6b7280; border-top: 1px solid #ede8e0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <nav class="navbar">
            <div class="navbar-brand">&#128218; BookShelf</div>
            <div class="nav-right">
                <div class="welcome-chip">Hello, <strong><asp:Literal ID="litUserNav" runat="server" /></strong></div>
                <a href="Cart.aspx" class="nav-btn nav-btn-cart">
                    &#128722; Cart <asp:Label ID="lblCartCount" runat="server" Text="(0)"></asp:Label>
                </a>
                <asp:Button ID="btnShowOrders" runat="server" Text="&#128230; My Orders"
                    CssClass="nav-btn nav-btn-orders" OnClick="btnShowOrders_Click" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout"
                    CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </nav>

        <section class="hero">
            <div class="hero-eyebrow">Your personal library</div>
            <h1>Welcome, <asp:Label ID="lblUser" runat="server"></asp:Label> &#128075;</h1>
            <p class="hero-sub">Browse books, add to cart and checkout in seconds.</p>
        </section>

        <div class="search-wrap">
            <label>Search</label>
            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
            <label>Category</label>
            <asp:DropDownList ID="ddlCategory" runat="server">
                <asp:ListItem Text="All"         Value="All"></asp:ListItem>
                <asp:ListItem Text="Programming" Value="Programming"></asp:ListItem>
                <asp:ListItem Text="Database"    Value="Database"></asp:ListItem>
                <asp:ListItem Text="Design"      Value="Design"></asp:ListItem>
                <asp:ListItem Text="Web"         Value="Web"></asp:ListItem>
                <asp:ListItem Text="Networking"  Value="Networking"></asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Search"
                CssClass="btn-search" OnClick="btnSearch_Click" />
        </div>

        <div class="tabs-wrap">
            <div class="tabs">
                <asp:Button ID="btnTabBooks"  runat="server" Text="&#128218; Browse Books" CssClass="tab-btn active" OnClick="btnTabBooks_Click" />
                <asp:Button ID="btnTabOrders" runat="server" Text="&#128230; My Orders"    CssClass="tab-btn"        OnClick="btnTabOrders_Click" />
            </div>
        </div>

        <div class="main">

            <!-- BOOKS TAB -->
            <asp:Panel ID="pnlBooks" runat="server">
                <div class="section-header">
                    <div class="section-label">Available Books</div>
                    <div class="cart-count-badge">&#128722; <asp:Label ID="lblCartCount2" runat="server" Text="0 items in cart"></asp:Label></div>
                </div>
                <asp:Label ID="lblMsg" runat="server" CssClass="add-msg" Visible="false"></asp:Label>
                <div class="books-wrap">
                    <asp:Repeater ID="rptBooks" runat="server" OnItemCommand="rptBooks_ItemCommand">
                        <ItemTemplate>
                            <div class="book-card">
                                <img class="book-cover" src='<%# Eval("CoverUrl") %>' alt='<%# Eval("BookName") %>' onerror="this.src='https://placehold.co/200x180?text=Book'" />
                                <div class="book-body">
                                    <span class="book-category"><%# Eval("Category") %></span>
                                    <div class="book-title"><%# Eval("BookName") %></div>
                                    <div class="book-author">by <%# Eval("Author") %></div>
                                    <div class="book-footer">
                                        <span class="book-price">Rs.<%# Eval("Price") %></span>
                                        <asp:Button ID="btnAdd" runat="server" Text="+ Cart" CssClass="btn-cart"
                                            CommandName="AddToCart"
                                            CommandArgument='<%# Eval("BookName") + "|" + Eval("Author") + "|" + Eval("Category") + "|" + Eval("Price") %>' />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                    <div class="empty"><div class="empty-icon">&#128229;</div><p>No books found.</p></div>
                </asp:Panel>
            </asp:Panel>

            <!-- ORDERS TAB -->
            <asp:Panel ID="pnlOrders" runat="server" Visible="false">
                <div class="section-header">
                    <div class="section-label">My Orders</div>
                </div>
                <asp:Label ID="lblCancelMsg" runat="server" CssClass="cancel-msg" Visible="false"></asp:Label>
                <asp:Panel ID="pnlNoOrders" runat="server" Visible="false">
                    <div class="no-orders">
                        <div class="no-orders-icon">&#128230;</div>
                        <h3>No Orders Yet</h3>
                        <p>You haven't placed any orders yet. Start shopping!</p>
                    </div>
                </asp:Panel>
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <div class="order-id-label">Order ID</div>
                                    <div class="order-id-value"><%# Eval("OrderId") %></div>
                                </div>
                                <div style="text-align:center;">
                                    <div class="order-date"><%# Convert.ToDateTime(Eval("OrderDate")).ToString("dd MMM yyyy, hh:mm tt") %></div>
                                    <div class="order-amount">Rs.<%# Eval("TotalAmount") %></div>
                                </div>
                                <div style="text-align:right;">
                                    <span class='<%# "badge badge-" + Eval("OrderStatus").ToString().ToLower() %>'><%# Eval("OrderStatus") %></span>
                                    <br />
                                    <small style="color:#6b7280;font-size:0.75rem;margin-top:4px;display:block;"><%# Eval("PaymentMethod").ToString().ToUpper() %></small>
                                </div>
                            </div>
                            <div class="order-body">
                                <div style="margin-bottom:16px;"><%# GetProgressBar(Eval("OrderStatus").ToString()) %></div>
                                <div class="order-meta">
                                    <span>&#128205; <strong><%# Eval("City") %></strong>, <%# Eval("PinCode") %></span>
                                    <span>&#128241; <strong><%# Eval("Phone") %></strong></span>
                                    <span>&#128179; <strong><%# Eval("PaymentMethod").ToString().ToUpper() %></strong></span>
                                </div>
                                <div class="order-items-title">Books Ordered</div>
                                <asp:Repeater ID="rptOrderItems" runat="server"
                                    DataSource='<%# GetOrderItems(Eval("OrderId").ToString()) %>'>
                                    <ItemTemplate>
                                        <div class="order-item">
                                            <span class="order-item-name">&#128218; <%# Eval("BookName") %></span>
                                            <span class="order-item-price">Rs.<%# Eval("Price") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <div class="order-actions">
                                    <%# GetActionButton(Eval("OrderId").ToString(), Eval("OrderStatus").ToString()) %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

        </div>

        <footer class="footer">&#169; 2026 BookShelf &nbsp;&#183;&nbsp; All rights reserved</footer>

        <%-- Hidden fields and buttons --%>
        <asp:HiddenField ID="hfCancelId"     runat="server" />
        <asp:HiddenField ID="hfCancelReason" runat="server" />
        <asp:HiddenField ID="hfReorderId"    runat="server" />
        <asp:HiddenField ID="hfPhoneOrderId" runat="server" />
        <asp:HiddenField ID="hfNewPhone"     runat="server" />
        <asp:Button ID="btnCancelHidden"  runat="server" Style="display:none;" OnClick="btnCancelHidden_Click" />
        <asp:Button ID="btnReorderHidden" runat="server" Style="display:none;" OnClick="btnReorderHidden_Click" />
        <asp:Button ID="btnPhoneHidden"   runat="server" Style="display:none;" OnClick="btnPhoneHidden_Click" />

        <%-- OVERLAY --%>
        <div class="overlay" id="helpOverlay" onclick="closeHelp(event)"></div>

        <%-- HELP DRAWER --%>
        <div class="help-drawer" id="helpDrawer">
            <div class="drawer-header">
                <div class="drawer-header-text">
                    <h3>&#128722; Help &amp; Support</h3>
                    <p id="drawerOrderLabel">Loading...</p>
                </div>
                <button class="drawer-close" onclick="closeHelp()">&#10005;</button>
            </div>
            <div class="drawer-body">

                <%-- MAIN MENU --%>
                <div id="menuPanel" class="sub-panel open">
                    <div class="drawer-section-title">Manage My Order</div>

                    <button class="help-option" onclick="showPanel('phonePanel')">
                        <div class="help-icon">&#128241;</div>
                        <div>
                            <div class="help-option-title">Change Phone Number</div>
                            <div class="help-option-sub">Update delivery contact number</div>
                        </div>
                        <span class="help-arrow">&#8250;</span>
                    </button>

                    <button class="help-option" onclick="showPanel('reschedulePanel')">
                        <div class="help-icon">&#128197;</div>
                        <div>
                            <div class="help-option-title">Reschedule Delivery</div>
                            <div class="help-option-sub">Pick a preferred delivery date</div>
                        </div>
                        <span class="help-arrow">&#8250;</span>
                    </button>

                    <button class="help-option danger" id="cancelOptionBtn" onclick="showPanel('reasonPanel')">
                        <div class="help-icon">&#10060;</div>
                        <div>
                            <div class="help-option-title">Cancel Order</div>
                            <div class="help-option-sub">Select a reason to cancel</div>
                        </div>
                        <span class="help-arrow">&#8250;</span>
                    </button>

                    <div class="drawer-section-title">Get Help</div>

                    <button class="help-option" onclick="showPanel('contactPanel')">
                        <div class="help-icon">&#128222;</div>
                        <div>
                            <div class="help-option-title">Contact Us</div>
                            <div class="help-option-sub">Call, email or WhatsApp us</div>
                        </div>
                        <span class="help-arrow">&#8250;</span>
                    </button>

                    <button class="help-option" onclick="showPanel('chatPanel')">
                        <div class="help-icon">&#128172;</div>
                        <div>
                            <div class="help-option-title">Chat With Us</div>
                            <div class="help-option-sub">WhatsApp live support</div>
                        </div>
                        <span class="help-arrow">&#8250;</span>
                    </button>
                </div>

                <%-- CANCEL REASON --%>
                <div id="reasonPanel" class="sub-panel">
                    <button class="btn-back-drawer" onclick="showPanel('menuPanel')">&#8592; Back</button>
                    <div class="drawer-section-title">Why are you cancelling?</div>
                    <div class="reason-option"><input type="radio" name="cancelReason" id="r1" value="Changed my mind" /><label for="r1">Changed my mind</label></div>
                    <div class="reason-option"><input type="radio" name="cancelReason" id="r2" value="Found a better price" /><label for="r2">Found a better price</label></div>
                    <div class="reason-option"><input type="radio" name="cancelReason" id="r3" value="Ordered by mistake" /><label for="r3">Ordered by mistake</label></div>
                    <div class="reason-option"><input type="radio" name="cancelReason" id="r4" value="Delivery taking too long" /><label for="r4">Delivery taking too long</label></div>
                    <div class="reason-option"><input type="radio" name="cancelReason" id="r5" value="Wrong book ordered" /><label for="r5">Wrong book ordered</label></div>
                    <div class="reason-option"><input type="radio" name="cancelReason" id="r6" value="Other" /><label for="r6">Other reason</label></div>
                    <button class="btn-confirm-cancel" onclick="confirmCancel()">&#10060; Confirm Cancellation</button>
                </div>

                <%-- CONTACT US --%>
                <div id="contactPanel" class="sub-panel">
                    <button class="btn-back-drawer" onclick="showPanel('menuPanel')">&#8592; Back</button>
                    <div class="drawer-section-title">Contact Us</div>

                    <div class="contact-card">
                        <div class="contact-icon">&#128222;</div>
                        <div>
                            <div class="contact-title">Call Us</div>
                            <div class="contact-sub">+91 73878 44086 &nbsp;|&nbsp; Mon–Sat 9am–6pm</div>
                        </div>
                        <div class="contact-action">
                            <a href="tel:+917387844086" class="btn-contact-action">Call Now</a>
                        </div>
                    </div>

                    <div class="contact-card">
                        <div class="contact-icon">&#128140;</div>
                        <div>
                            <div class="contact-title">Email Us</div>
                            <div class="contact-sub">shaikhkabir232@gmail.com</div>
                        </div>
                        <div class="contact-action">
                            <a id="emailLink" href="mailto:shaikhkabir232@gmail.com?subject=Order Support" class="btn-contact-action">Email</a>
                        </div>
                    </div>

                    <div class="contact-card">
                        <div class="contact-icon">&#128241;</div>
                        <div>
                            <div class="contact-title">WhatsApp</div>
                            <div class="contact-sub">+91 73878 44086</div>
                        </div>
                        <div class="contact-action">
                            <a href="https://wa.me/917387844086" target="_blank" class="btn-contact-action">WhatsApp</a>
                        </div>
                    </div>
                </div>

                <%-- CHAT --%>
                <div id="chatPanel" class="sub-panel">
                    <button class="btn-back-drawer" onclick="showPanel('menuPanel')">&#8592; Back</button>
                    <div class="drawer-section-title">Chat With Us</div>
                    <div class="contact-card" style="flex-direction:column;align-items:flex-start;">
                        <div style="font-size:0.9rem;font-weight:600;color:#1a1a2e;margin-bottom:6px;">WhatsApp Live Support</div>
                        <div style="font-size:0.82rem;color:#6b7280;margin-bottom:14px;">Typical reply within 5 minutes</div>
                        <a href="https://wa.me/917387844086" target="_blank"
                           style="display:block;width:100%;text-align:center;background:#25d366;color:#fff;padding:11px;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.9rem;font-weight:600;text-decoration:none;">
                            &#128172; Start WhatsApp Chat
                        </a>
                        <div style="margin-top:14px;padding-top:14px;border-top:1px solid #f0ede8;width:100%;">
                            <div style="font-size:0.82rem;color:#6b7280;margin-bottom:8px;">Or email us directly:</div>
                            <a href="mailto:shaikhkabir232@gmail.com?subject=Order Support"
                               style="display:block;width:100%;text-align:center;background:#1b4332;color:#fff;padding:11px;border-radius:8px;font-family:'DM Sans',sans-serif;font-size:0.9rem;font-weight:600;text-decoration:none;">
                                &#128140; Email Support
                            </a>
                        </div>
                    </div>
                </div>

                <%-- CHANGE PHONE --%>
                <div id="phonePanel" class="sub-panel">
                    <button class="btn-back-drawer" onclick="showPanel('menuPanel')">&#8592; Back</button>
                    <div class="drawer-section-title">Change Phone Number</div>
                    <p style="font-size:0.85rem;color:#6b7280;margin-bottom:16px;line-height:1.5;">Enter your new phone number. This will be used for delivery updates.</p>
                    <input type="text" class="drawer-input" id="newPhoneInput" placeholder="+91 73878 44086" />
                    <button class="btn-drawer-submit" onclick="submitPhone()">&#10003; Update Phone Number</button>
                </div>

                <%-- RESCHEDULE --%>
                <div id="reschedulePanel" class="sub-panel">
                    <button class="btn-back-drawer" onclick="showPanel('menuPanel')">&#8592; Back</button>
                    <div class="drawer-section-title">Reschedule Delivery</div>
                    <p style="font-size:0.85rem;color:#6b7280;margin-bottom:16px;line-height:1.5;">Choose a preferred delivery date. Our team will confirm via WhatsApp.</p>
                    <input type="date" class="drawer-input" id="rescheduleDate" />
                    <button class="btn-drawer-submit" onclick="submitReschedule()">&#128197; Confirm Reschedule</button>
                    <div style="margin-top:12px;font-size:0.78rem;color:#6b7280;text-align:center;">
                        Or call us: <a href="tel:+917387844086" style="color:#1b4332;font-weight:600;">+91 73878 44086</a>
                    </div>
                </div>

            </div>
        </div>

    </form>

    <script>
        var currentOrderId = '';
        var currentStatus  = '';

        function openHelp(orderId, status) {
            currentOrderId = orderId;
            currentStatus  = status;
            document.getElementById('drawerOrderLabel').innerText = 'Order: ' + orderId;

            var cancelBtn = document.getElementById('cancelOptionBtn');
            cancelBtn.style.display = (status === 'pending') ? 'flex' : 'none';

            document.getElementById('helpOverlay').classList.add('open');
            document.getElementById('helpDrawer').classList.add('open');
            showPanel('menuPanel');

            var emailLink = document.getElementById('emailLink');
            if (emailLink)
                emailLink.href = 'mailto:shaikhkabir232@gmail.com?subject=Help with Order ' + orderId;
        }

        function closeHelp(e) {
            if (!e || e.target === document.getElementById('helpOverlay')) {
                document.getElementById('helpOverlay').classList.remove('open');
                document.getElementById('helpDrawer').classList.remove('open');
            }
        }

        function showPanel(panelId) {
            var panels = ['menuPanel','reasonPanel','contactPanel','chatPanel','phonePanel','reschedulePanel'];
            panels.forEach(function(id) {
                var el = document.getElementById(id);
                if (el) el.className = 'sub-panel' + (id === panelId ? ' open' : '');
            });
        }

        function confirmCancel() {
            var selected = document.querySelector('input[name="cancelReason"]:checked');
            if (!selected) { alert('Please select a reason.'); return; }
            if (!confirm('Cancel order ' + currentOrderId + '?\nReason: ' + selected.value)) return;

            document.getElementById('<%= hfCancelId.ClientID %>').value     = currentOrderId;
            document.getElementById('<%= hfCancelReason.ClientID %>').value = selected.value;
            document.getElementById('<%= btnCancelHidden.ClientID %>').click();
            closeHelp();
        }

        function submitPhone() {
            var phone = document.getElementById('newPhoneInput').value.trim();
            if (!phone) { alert('Please enter a phone number.'); return; }

            document.getElementById('<%= hfPhoneOrderId.ClientID %>').value = currentOrderId;
            document.getElementById('<%= hfNewPhone.ClientID %>').value     = phone;
            document.getElementById('<%= btnPhoneHidden.ClientID %>').click();
            closeHelp();
        }

        function submitReschedule() {
            var date = document.getElementById('rescheduleDate').value;
            if (!date) { alert('Please select a date.'); return; }
            var d = new Date(date);
            var formatted = d.toLocaleDateString('en-IN', { day:'numeric', month:'long', year:'numeric' });
            alert('Reschedule request submitted for ' + formatted + '.\nOur team will contact you on WhatsApp to confirm.');
            closeHelp();
        }
    </script>
</body>
</html>