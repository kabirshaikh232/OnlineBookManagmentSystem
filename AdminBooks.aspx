<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminBooks.aspx.cs" Inherits="WebApplication3.AdminBooks" %>

<!DOCTYPE html>
<html>
<head runat="server">
<title>Admin - Manage Books</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: #f4f6f9;
}

/* HEADER */
.header {
    background: linear-gradient(135deg, #1b4332, #40916c);
    color: white;
    padding: 20px 40px 30px 40px; /* ✅ extra bottom spacing */
}

/* FLEX */
.header-flex {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* LEFT */
.header-left h2 {
    margin: 0;
}

/* USER NAME */
.admin-info {
    margin-top: 8px;
    font-size: 14px;
    color: #d8f3dc;
    background: rgba(255,255,255,0.15);
    padding: 6px 14px;
    border-radius: 20px;
    display: inline-block;
}

/* RIGHT */
.header-right {
    display: flex;
    align-items: center;
}

/* BUTTON */
.btn {
    background: #1b4332;
    color: white;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    margin-left: 8px;
}

.btn:hover {
    background: #2d6a4f;
}

/* CONTAINER (✅ FIXED - NO NEGATIVE MARGIN) */
.container {
    width: 90%;
    margin: 30px auto; /* ✅ proper spacing */
}

/* CARD */
.card {
    background: white;
    padding: 18px 20px;
    border-radius: 12px;
    margin-bottom: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

/* FORM */
.form-grid {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    align-items: center;
}

/* INPUT */
.input {
    padding: 8px;
    width: 160px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

/* TABLE */
.grid {
    width: 100%;
    border-collapse: collapse;
}

.grid th {
    background: #1b4332;
    color: white;
    padding: 10px;
}

.grid td {
    padding: 10px;
    border-bottom: 1px solid #eee;
}

/* IMAGE */
.grid img {
    width: 50px;
    height: 70px;
    object-fit: cover;
    border-radius: 6px;
}

/* MSG */
.msg { color: green; }
.err { color: red; }

/* PREVIEW */
.preview {
    width: 70px;
    margin-top: 10px;
}
</style>

<script>
function previewImage(input) {
    var img = document.getElementById("imgPreview");
    if (input.files && input.files[0]) {
        img.src = URL.createObjectURL(input.files[0]);
        img.style.display = "block";
    }
}
</script>

</head>

<body>
<form runat="server">

<!-- HEADER -->
<div class="header">
    <div class="header-flex">

        <div class="header-left">
            <h2>📚 Admin - Manage Books</h2>
            <div class="admin-info">
                👤 <asp:Label ID="lblAdmin" runat="server"></asp:Label>
            </div>
        </div>

        <div class="header-right">
            <asp:Button ID="btnDashboard" runat="server"
                Text="Dashboard"
                CssClass="btn"
                OnClick="btnDashboard_Click" />

            <asp:Button ID="btnLogout" runat="server"
                Text="Logout"
                CssClass="btn"
                OnClick="btnLogout_Click" />
        </div>

    </div>
</div>

<div class="container">

<!-- ADD BOOK -->
<div class="card">
<h3>Add New Book</h3>

<asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
<asp:Label ID="lblErr" runat="server" CssClass="err"></asp:Label>

<div class="form-grid">
<asp:TextBox ID="txtBookName" runat="server" CssClass="input" placeholder="Book Name" />
<asp:TextBox ID="txtAuthor" runat="server" CssClass="input" placeholder="Author" />
<asp:TextBox ID="txtCategory" runat="server" CssClass="input" placeholder="Category" />
<asp:TextBox ID="txtPrice" runat="server" CssClass="input" placeholder="Price" />

<asp:FileUpload ID="fileUpload" runat="server" onchange="previewImage(this)" />

<asp:Button ID="btnAdd" runat="server"
Text="Add Book"
CssClass="btn"
OnClick="btnAdd_Click" />
</div>

<img id="imgPreview" class="preview" style="display:none;" />
</div>

<!-- BOOK LIST -->
<div class="card">
<h3>Book List</h3>

<asp:GridView ID="gvBooks" runat="server"
CssClass="grid"
AutoGenerateColumns="False"
OnRowCommand="gvBooks_RowCommand">

<Columns>
<asp:BoundField DataField="BookName" HeaderText="Name" />
<asp:BoundField DataField="Author" HeaderText="Author" />
<asp:BoundField DataField="Category" HeaderText="Category" />
<asp:BoundField DataField="Price" HeaderText="Price" />

<asp:TemplateField HeaderText="Image">
<ItemTemplate>
<img src='<%# ResolveUrl("~/" + Eval("CoverUrl")) %>'
onerror="this.src='images/library.jpg'" />
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Action">
<ItemTemplate>
<asp:Button ID="btnDelete" runat="server"
Text="Delete"
CssClass="btn"
CommandName="DeleteBook"
CommandArgument='<%# Eval("BookId") %>' />
</ItemTemplate>
</asp:TemplateField>

</Columns>
</asp:GridView>

</div>

</div>

</form>
</body>
</html>