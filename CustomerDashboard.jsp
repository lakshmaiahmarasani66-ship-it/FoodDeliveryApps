
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.tab.model.User" %>

<%
    request.setCharacterEncoding("UTF-8");

    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>KJL Restaurant | Customer Dashboard</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #FFFFFF;
            color: #000000;
        }

        /* Navigation bar */
        .navbar {
            background-color: #000000;
            padding: 18px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 18px;
        }

        .logo {
            color: #FF8C00;
            font-size: 27px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 22px;
        }

        .nav-links a {
            color: #FFFFFF;
            text-decoration: none;
            font-size: 15px;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #FF8C00;
        }

        .nav-links .logout-btn {
            background-color: #FF8C00;
            color: #FFFFFF;
            padding: 10px 17px;
            border-radius: 5px;
        }

        .nav-links .logout-btn:hover {
            background-color: #E57800;
            color: #FFFFFF;
        }

        /* Welcome section */
        .hero {
            background-color: #000000;
            color: #FFFFFF;
            padding: 65px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 30px;
        }

        .hero-content {
            max-width: 700px;
        }

        .hero-label {
            display: inline-block;
            background-color: #FF8C00;
            color: #FFFFFF;
            padding: 9px 15px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            letter-spacing: 1.5px;
            margin-bottom: 22px;
        }

        .hero h1 {
            font-size: 40px;
            line-height: 1.4;
            margin-bottom: 18px;
        }

        .hero h1 span {
            color: #FF8C00;
            overflow-wrap: anywhere;
        }

        .hero p {
            color: #FFFFFF;
            font-size: 16px;
            line-height: 1.8;
            margin-bottom: 25px;
        }

        .explore-btn {
            display: inline-block;
            background-color: #FF8C00;
            color: #FFFFFF;
            padding: 13px 23px;
            border: 2px solid #FF8C00;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .explore-btn:hover {
            background-color: #FFFFFF;
            border-color: #FFFFFF;
            color: #000000;
        }

        .hero-icon {
            font-size: 90px;
            border: 3px solid #FF8C00;
            border-radius: 50%;
            padding: 25px;
            flex-shrink: 0;
        }

        /* Dashboard content */
        .dashboard {
            max-width: 1200px;
            margin: 0 auto;
            padding: 55px 25px;
        }

        .section-heading {
            text-align: center;
            margin-bottom: 38px;
        }

        .section-heading h2 {
            color: #000000;
            font-size: 32px;
            margin-bottom: 14px;
        }

        .section-heading h2 span {
            color: #FF8C00;
        }

        .section-heading p {
            color: #000000;
            font-size: 15px;
            line-height: 1.7;
        }

        /* Dashboard cards */
        .cards {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 25px;
        }

        .card {
            background-color: #FFFFFF;
            border: 1px solid #DDDDDD;
            border-top: 5px solid #FF8C00;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 9px 22px rgba(0, 0, 0, 0.14);
        }

        .card-icon {
            background-color: #000000;
            color: #FF8C00;
            font-size: 43px;
            padding: 24px;
        }

        .card-content {
            padding: 27px 22px;
        }

        .card-content h3 {
            color: #000000;
            font-size: 22px;
            margin-bottom: 14px;
        }

        .card-content p {
            color: #000000;
            font-size: 14px;
            line-height: 1.8;
            min-height: 76px;
            margin-bottom: 22px;
        }

        /* Orange buttons */
        .card-btn {
            display: inline-block;
            width: 100%;
            background-color: #FF8C00;
            color: #FFFFFF;
            padding: 13px 15px;
            border: 2px solid #FF8C00;
            border-radius: 5px;
            text-decoration: none;
            font-size: 15px;
            font-weight: bold;
            transition: 0.3s;
        }

        .card-btn:hover {
            background-color: #000000;
            color: #FFFFFF;
            border-color: #000000;
        }

        /* Quick links */
        .quick-links {
            margin-top: 45px;
            padding: 32px 20px;
            background-color: #FFFFFF;
            border: 2px solid #FF8C00;
            border-radius: 10px;
            text-align: center;
        }

        .quick-links h3 {
            color: #000000;
            font-size: 24px;
            margin-bottom: 13px;
        }

        .quick-links p {
            color: #000000;
            line-height: 1.8;
            margin-bottom: 20px;
        }

        .quick-links-list {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .quick-links-list a {
            display: inline-block;
            background-color: #FFFFFF;
            color: #000000;
            padding: 11px 17px;
            border: 1px solid #000000;
            border-radius: 5px;
            text-decoration: none;
            transition: 0.3s;
        }

        .quick-links-list a:hover {
            background-color: #FF8C00;
            color: #FFFFFF;
            border-color: #FF8C00;
        }

        /* Footer */
        .footer {
            background-color: #000000;
            color: #FFFFFF;
            text-align: center;
            padding: 25px 15px;
            line-height: 1.8;
        }

        .footer span {
            color: #FF8C00;
            font-weight: bold;
        }

        /* Responsive design */
        @media (max-width: 900px) {
            .cards {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .hero h1 {
                font-size: 34px;
            }

            .hero-icon {
                font-size: 65px;
                padding: 20px;
            }
        }

        @media (max-width: 600px) {
            .navbar {
                justify-content: center;
            }

            .nav-links {
                justify-content: center;
                gap: 15px;
            }

            .hero {
                flex-direction: column;
                text-align: center;
                padding: 45px 22px;
            }

            .hero h1 {
                font-size: 30px;
            }

            .hero-icon {
                font-size: 55px;
                padding: 17px;
            }

            .cards {
                grid-template-columns: 1fr;
            }

            .section-heading h2 {
                font-size: 27px;
            }

            .dashboard {
                padding: 40px 18px;
            }
        }
    </style>
</head>

<body>

    <!-- Navigation bar -->
    <header class="navbar">

        <a class="logo"
           href="<%= request.getContextPath() %>/customer-dashboard">
            KJL Restaurant
        </a>

        <nav class="nav-links">

            <a href="<%= request.getContextPath() %>/customer-dashboard">
                Dashboard
            </a>

            <a href="<%= request.getContextPath() %>/restaurant">
                Restaurants
            </a>

            <a href="<%= request.getContextPath() %>/cart">
                My Cart
            </a>

            <a href="<%= request.getContextPath() %>/orders">
                My Orders
            </a>

            <a class="logout-btn"
               href="<%= request.getContextPath() %>/logout">
                Logout
            </a>

        </nav>

    </header>

    <!-- Welcome banner -->
    <section class="hero">

        <div class="hero-content">

            <div class="hero-label">
                CUSTOMER DASHBOARD
            </div>

            <h1>
                Welcome Back,<br>
                <span><%= user.getUserName() %></span>!
            </h1>

            <p>
                Your favourite meals are waiting for you.<br>
                Discover restaurants, choose delicious food,
                and enjoy your next meal with KJL Restaurant.
            </p>

            <a class="explore-btn"
               href="<%= request.getContextPath() %>/restaurant">
                Explore Restaurants &rarr;
            </a>

        </div>

        <div class="hero-icon" aria-hidden="true">🍽️</div>

    </section>

    <!-- Main dashboard -->
    <main class="dashboard">

        <div class="section-heading">

            <h2>
                Manage Your <span>Food Orders</span>
            </h2>

            <p>
                Choose an option below to get started.
            </p>

        </div>

        <div class="cards">

            <!-- Restaurant card -->
            <section class="card">

                <div class="card-icon" aria-hidden="true">🍴</div>

                <div class="card-content">

                    <h3>Explore Restaurants</h3>

                    <p>
                        Discover available restaurants and find
                        your favourite dishes from our menu.
                    </p>

                    <a class="card-btn"
                       href="<%= request.getContextPath() %>/restaurant">
                        Browse Restaurants
                    </a>

                </div>

            </section>

            <!-- Cart card -->
            <section class="card">

                <div class="card-icon" aria-hidden="true">🛒</div>

                <div class="card-content">

                    <h3>My Cart</h3>

                    <p>
                        Review your selected food items before
                        proceeding to checkout.
                    </p>

                    <a class="card-btn"
                       href="<%= request.getContextPath() %>/cart">
                        View My Cart
                    </a>

                </div>

            </section>

            <!-- Orders card -->
            <section class="card">

                <div class="card-icon" aria-hidden="true">📦</div>

                <div class="card-content">

                    <h3>My Orders</h3>

                    <p>
                        View your orders and check their
                        current status and details.
                    </p>

                    <a class="card-btn"
                       href="<%= request.getContextPath() %>/orders">
                        View My Orders
                    </a>

                </div>

            </section>

        </div>

        <!-- Quick links -->
        <section class="quick-links">

            <h3>Ready for Something Delicious?</h3>

            <p>
                Browse our restaurants, check your cart,
                or view your order history.
            </p>

            <div class="quick-links-list">

                <a href="<%= request.getContextPath() %>/restaurant">
                    Browse Restaurants
                </a>

                <a href="<%= request.getContextPath() %>/cart">
                    Open My Cart
                </a>

                <a href="<%= request.getContextPath() %>/orders">
                    Track My Orders
                </a>

            </div>

        </section>

    </main>

    <!-- Footer -->
    <footer class="footer">

        <p>
            Thank you for choosing <span>KJL Restaurant</span>!
        </p>

        <p>
            &copy; 2026 KJL Restaurant. All rights reserved.
        </p>

    </footer>

</body>
</html>
