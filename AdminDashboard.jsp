
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.tab.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    if (user.getRole() == null ||
        !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN,
                           "Admin access required");
        return;
    }
%>

<%@ page import="jakarta.servlet.http.HttpServletResponse" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KJL Restaurant | Admin Dashboard</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #ffffff;
    color: #000000;
}

/* Navigation */
.navbar {
    background: #000000;
    color: #ffffff;
    padding: 18px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 15px;
}

.logo {
    color: #ff8c00;
    font-size: 25px;
    font-weight: bold;
}

.nav-links {
    display: flex;
    gap: 20px;
    align-items: center;
    flex-wrap: wrap;
}

.nav-links a {
    color: #ffffff;
    text-decoration: none;
    font-size: 14px;
}

.nav-links a:hover {
    color: #ff8c00;
}

/* Hero */
.hero {
    background: #000000;
    color: #ffffff;
    text-align: center;
    padding: 55px 20px;
}

.hero-label {
    color: #ff8c00;
    letter-spacing: 3px;
    font-size: 13px;
    font-weight: bold;
    margin-bottom: 18px;
}

.hero h1 {
    font-size: 36px;
    margin-bottom: 15px;
}

.hero p {
    color: #dddddd;
    line-height: 1.7;
}

/* Dashboard */
.dashboard {
    max-width: 1150px;
    margin: 0 auto;
    padding: 45px 25px 60px;
}

.section-title {
    font-size: 27px;
    margin-bottom: 10px;
}

.section-description {
    color: #666666;
    margin-bottom: 30px;
    line-height: 1.6;
}

.cards {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 24px;
}

.card {
    background: #ffffff;
    border: 1px solid #eeeeee;
    border-top: 5px solid #ff8c00;
    border-radius: 10px;
    padding: 27px 23px;
    box-shadow: 0 5px 18px rgba(0, 0, 0, 0.07);
    transition: transform 0.2s, box-shadow 0.2s;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 9px 23px rgba(0, 0, 0, 0.12);
}

.card-icon {
    font-size: 32px;
    margin-bottom: 18px;
}

.card h2 {
    font-size: 20px;
    margin-bottom: 12px;
}

.card p {
    color: #666666;
    font-size: 14px;
    line-height: 1.7;
    min-height: 48px;
    margin-bottom: 22px;
}

/* All dashboard buttons */
.dashboard-btn {
    display: inline-block;
    background: #ff8c00;
    color: #ffffff;
    padding: 12px 18px;
    border: 2px solid #ff8c00;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
    font-weight: bold;
    transition: 0.2s;
}

.dashboard-btn:hover {
    background: #000000;
    color: #ffffff;
    border-color: #000000;
}

/* Footer */
.footer {
    background: #000000;
    color: #ffffff;
    text-align: center;
    padding: 22px;
    font-size: 13px;
}

.footer span {
    color: #ff8c00;
}

@media (max-width: 850px) {
    .cards {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

@media (max-width: 550px) {
    .cards {
        grid-template-columns: 1fr;
    }

    .hero h1 {
        font-size: 29px;
    }

    .navbar {
        flex-direction: column;
    }
}
</style>
</head>

<body>

<!-- Navigation -->
<header class="navbar">
    <div class="logo">KJL Restaurant</div>

    <nav class="nav-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/restaurant">
            Restaurants
        </a>

        <a href="<%= request.getContextPath() %>/orders">
            Orders
        </a>

        <a href="<%= request.getContextPath() %>/customer-dashboard">
            Customer View
        </a>

        <a href="<%= request.getContextPath() %>/logout">
            Logout
        </a>
    </nav>
</header>

<!-- Hero -->
<section class="hero">
    <div class="hero-label">ADMINISTRATION PANEL</div>

    <h1>Welcome to Admin Dashboard</h1>

    <p>
        Manage your restaurants, menus, orders and users
        from one place.
    </p>
</section>

<!-- Dashboard Cards -->
<main class="dashboard">

    <h2 class="section-title">Dashboard Overview</h2>

    <p class="section-description">
        Select an option below to manage your KJL Restaurant application.
    </p>

    <div class="cards">

        <!-- Restaurants -->
        <section class="card">
            <div class="card-icon">🍽️</div>

            <h2>Restaurant Management</h2>

            <p>
                View and manage restaurants available
                in your food delivery application.
            </p>

            <a class="dashboard-btn"
               href="<%= request.getContextPath() %>/restaurant">
                Manage Restaurants
            </a>
        </section>

        <!-- Menus -->
        <section class="card">
            <div class="card-icon">📋</div>

            <h2>Menu Management</h2>

            <p>
                Open the restaurant section to access
                restaurant menus and menu-related options.
            </p>

            <a class="dashboard-btn"
               href="<%= request.getContextPath() %>/restaurant">
                Manage Menus
            </a>
        </section>

        <!-- Orders -->
        <section class="card">
            <div class="card-icon">📦</div>

            <h2>Order Management</h2>

            <p>
                View orders and check order information
                available in your application.
            </p>

            <a class="dashboard-btn"
               href="<%= request.getContextPath() %>/orders">
                Manage Orders
            </a>
        </section>

        <!-- User Management -->
        <section class="card">
            <div class="card-icon">👥</div>

            <h2>User Management</h2>

            <p>
                Access the user management section to
                manage registered customers and their details.
            </p>

            <a class="dashboard-btn"
               href="<%= request.getContextPath() %>/admin-users">
                Manage Users
            </a>
        </section>

        <!-- Admin Account -->
        <section class="card">
            <div class="card-icon">👤</div>

            <h2>Admin Account</h2>

            <p>
                Securely log out of your administrator
                account when you finish your work.
            </p>

            <a class="dashboard-btn"
               href="<%= request.getContextPath() %>/logout">
                Logout
            </a>
        </section>

        <!-- Customer View -->
        <section class="card">
            <div class="card-icon">🛍️</div>

            <h2>Customer View</h2>

            <p>
                Open the customer dashboard to view
                the customer-facing application.
            </p>

            <a class="dashboard-btn"
               href="<%= request.getContextPath() %>/customer-dashboard">
                View Customer Dashboard
            </a>
        </section>

    </div>
</main>

<footer class="footer">
    © 2026 <span>KJL Restaurant</span>. All rights reserved.
</footer>

</body>
</html>
