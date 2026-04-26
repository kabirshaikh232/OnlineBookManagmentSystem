# 📚 Online Book Store Management System

A web-based application built using **ASP.NET Web Forms and SQL Server** that allows users to browse, search, and purchase books online, while providing administrators with tools to manage inventory and orders.

---

## 🚀 Features

### 👤 User Features

* User Registration & Login
* Browse and Search Books
* View Book Details
* Place Orders
* Payment Confirmation

### 🛠️ Admin Features

* Admin Login
* Add / Update / Delete Books
* Manage Orders
* View Dashboard

---

## 🏗️ Tech Stack

* **Frontend:** ASP.NET Web Forms (ASPX)
* **Backend:** C# (.NET Framework)
* **Database:** Microsoft SQL Server
* **Data Access:** ADO.NET
* **Architecture:** 3-Tier Architecture

---

## 📂 Project Structure

```
/Admin
  ├── AdminLogin.aspx
  ├── AdminDashboard.aspx
  ├── AdminBooks.aspx
  ├── AdminOrders.aspx

/User
  ├── Signup.aspx
  ├── Login.aspx
  ├── UserHome.aspx
  ├── BookList.aspx
  ├── Cart.aspx
  ├── Checkout.aspx

/Common
  ├── Global.asax
  ├── Web.config
```

---

## 🗄️ Database Design

### Tables Used:

* Users
* Admins
* Books
* Orders
* OrderItems

### Relationship:

* **One Order → Many OrderItems**

---

## 📊 ER Diagram (Text Representation)

```
Users        Admins

Books

Orders (OrderId)
   │
   └────< OrderItems (ItemId, OrderId)
```

---

## 🔄 Data Flow Diagram (DFD)

### Level 0 (Context)

* User interacts with system
* Admin manages system

### Level 1

* Create Account → Users DB
* Login → Users DB
* Browse Books → Books DB
* Place Order → Orders DB + OrderItems DB
* Payment Confirmation → User

---

## 🔐 Security Features

* SQL Injection Prevention (Parameterized Queries)
* Session-Based Authentication
* Role-Based Access Control
* **Custom Error Handling (Avoid Yellow Screen of Death)**

---

## ⚙️ Installation & Setup

1. Clone the repository

```
git clone https://github.com/your-username/online-bookstore.git
```

2. Open in Visual Studio

3. Configure Database

* Import `.sql` file into SQL Server
* Update connection string in `Web.config`

4. Run the project

* Press **F5** in Visual Studio

---

## 📌 Future Enhancements

* Payment Gateway Integration (Razorpay/Stripe)
* Email Notifications
* Reports & Analytics Dashboard
* Mobile Application
* Book Reviews & Ratings

---

## 🎯 Conclusion

This project demonstrates a complete **e-commerce workflow** including authentication, book management, order processing, and admin control using ASP.NET and SQL Server.

---

## 👨‍💻 Authors

* Kabir Shaikh
* Prathamesh Patil

---

## 📄 License

This project is for **academic purposes only**.

---
