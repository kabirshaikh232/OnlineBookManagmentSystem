<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminOrders.aspx.cs" Inherits="WebApplication3.AdminOrders" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Orders - BookShelf Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; background: #f8f5f0; color: #1a1a2e; min-height: 100vh; display: flex; }
        .sidebar { width: 240px; background: #1b4332; min-height: 100vh; display: flex; flex-direction: column; position: fixed; top: 0; left: 0; }
        .sidebar-brand { padding: 28px 24px; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .sidebar-brand h2 { font-family: 'Playfair Display', serif; color: #fff; font-size: 1.2rem; }
        .sidebar-brand p { color: rgba(255,255,255,0.5); font-size: 0.75rem; margin-top: 2px; }
        .nav-menu { padding: 20px 0; flex: 1; }
        .nav-item { display: flex; padding: 12px 24px; color: rgba(255,255,255,0.65); text-decoration: none; font-size: 0.9rem; align-items: center; gap: 10px; }
        .nav-item:hover { background: rgba(255,255,255,0.08); color: #fff; }
        .nav-item.active { background: rgba(82,183,136,0.2); color: #52b788; border-right: 3px solid #52b788; }
        .nav-icon { font-size: 1.1rem; width: 28px; }
        .sidebar-footer { padding: 20px 24px; border-top: 1px solid rgba(255,255,255,0.1); }
        .btn-logout { display: block; text-align: center; background: rgba(220,38,38,0.15); color: #fca5a5; border: none; border-radius: 8px; padding: 10px; font-family: 'DM Sans', sans-serif; font-size: 0.85rem; cursor: pointer; width: 100%; }
        .btn-logout:hover { background: rgba(220,38,38,0.3); }
        .main { margin-left: 240px; flex: 1; padding: 40px; }
        .page-header { margin-bottom: 28px; }
        .page-header h1 { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #1b4332; }
        .card { background: #fff; border-radius: 14px; padding: 28px; box-shadow: 0 4px 24px rgba(27,67,50,0.1); border: 1px solid rgba(27,67,50,0.07); }
        table { width: 100%; border-collapse: collapse; }
        th { font-size: 0.75rem; font-weight: 600; color: #6b7280; text-transform: uppercase; letter-spacing: 1px; padding: 10px 14px; text-align: left; border-bottom: 2px solid #f0ede8; }
        td { padding: 12px 14px; font-size: 0.88rem; border-bottom: 1px solid #f8f5f0; vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        select { border: 1.5px solid #e5e7eb; border-radius: 6px; padding: 5px 10px; font-family: 'DM Sans', sans-serif; font-size: 0.82rem; }
        input[type="submit"].btn-update { background: #1b4332; color: #fff; border: none; padding: 6px 16px; border-radius: 6px; cursor: pointer; font-size: 0.82rem; font-family: 'DM Sans', sans-serif; }
        input[type="submit"].btn-update:hover { background: #2d6a4f; }
        .msg { background: #d8f3dc; color: #1b4332; padding: 12px 20px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; display: block; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sidebar">
            <div class="sidebar-brand">
                <h2>&#128218; BookShelf</h2>
                <p>Admin Panel</p>
            </div>
            <nav class="nav-menu">
                <a href="AdminDashboard.aspx" class="nav-item"><span class="nav-icon">&#128200;</span> Dashboard</a>
                <a href="AdminOrders.aspx"    class="nav-item active"><span class="nav-icon">&#128230;</span> Orders</a>
                <a href="AdminBooks.aspx"     class="nav-item"><span class="nav-icon">&#128218;</span> Books</a>
                <a href="AdminUser.aspx"      class="nav-item"><span class="nav-icon">&#128100;</span> Users</a>
            </nav>
            <div class="sidebar-footer">
                <asp:Button ID="btnLogout" runat="server" Text="&#128274; Logout"
                    CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>
        <div class="main">
            <div class="page-header"><h1>&#128230; Manage Orders</h1></div>
            <asp:Label ID="lblMsg" runat="server" CssClass="msg" Visible="false"></asp:Label>
            <div class="card">
                <asp:GridView ID="gvOrders" runat="server"
                    AutoGenerateColumns="False"
                    OnRowCommand="gvOrders_RowCommand"
                    GridLines="None" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="OrderId"       HeaderText="Order ID" />
                        <asp:BoundField DataField="Username"      HeaderText="User" />
                        <asp:BoundField DataField="FirstName"     HeaderText="Name" />
                        <asp:BoundField DataField="Phone"         HeaderText="Phone" />
                        <asp:BoundField DataField="City"          HeaderText="City" />
                        <asp:BoundField DataField="TotalAmount"   HeaderText="Total" DataFormatString="Rs.{0:N0}" />
                        <asp:BoundField DataField="PaymentMethod" HeaderText="Payment" />
                        <asp:BoundField DataField="OrderDate"     HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem Text="Pending"   Value="Pending"></asp:ListItem>
                                    <asp:ListItem Text="Shipped"   Value="Shipped"></asp:ListItem>
                                    <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                                    <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnUpdate" runat="server"
                                    Text="Update" CssClass="btn-update"
                                    CommandName="UpdateStatus"
                                    CommandArgument='<%# Eval("OrderId") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>