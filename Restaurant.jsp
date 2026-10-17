```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.tab.model.Restaurant" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KJL Restaurant</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        color: #333;
    }

    header {
        background-color: #fc8019;
        color: white;
        text-align: center;
        padding: 25px 15px;
    }

    header h1 {
        margin: 0;
        font-size: 32px;
    }

    header p {
        margin-bottom: 0;
        font-size: 16px;
    }

    .container {
        width: 92%;
        max-width: 1200px;
        margin: 30px auto;
    }

    .restaurant-grid {
        display: grid;
        grid-template-columns: repeat(
            auto-fit, minmax(270px, 1fr)
        );
        gap: 25px;
    }

    .restaurant-card {
        background-color: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s ease;
    }

    .restaurant-card:hover {
        transform: translateY(-5px);
    }

    .restaurant-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        display: block;
        background-color: #eee;
    }

    .restaurant-details {
        padding: 18px;
    }

    .restaurant-details h2 {
        margin-top: 0;
        margin-bottom: 15px;
        color: #fc8019;
        font-size: 22px;
    }

    .restaurant-details p {
        margin: 10px 0;
        font-size: 14px;
        line-height: 1.5;
        overflow-wrap: anywhere;
    }

    .rating {
        color: #16803c;
        font-weight: bold;
    }

    .active {
        color: green;
        font-weight: bold;
    }

    .inactive {
        color: red;
        font-weight: bold;
    }

    .menu-btn {
        display: inline-block;
        width: 100%;
        margin-top: 12px;
        padding: 12px;
        background-color: #fc8019;
        color: white;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 7px;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
    }

    .menu-btn:hover {
        background-color: #e56f0c;
    }

    .empty-message {
        text-align: center;
        background-color: white;
        padding: 30px;
        border-radius: 10px;
    }

    footer {
        text-align: center;
        padding: 20px;
        color: #666;
    }

    @media (max-width: 600px) {
        .container {
            width: 94%;
        }

        header h1 {
            font-size: 26px;
        }
    }
</style>
</head>

<body>

<header>
    <h1>KJL Restaurant</h1>
    <p>Discover Your Favourite Restaurants</p>
</header>

<div class="container">

<%
    List<Restaurant> restaurants =
        (List<Restaurant>) request.getAttribute("restaurants");

    if (restaurants != null && !restaurants.isEmpty()) {
%>

    <div class="restaurant-grid">

    <%
        for (Restaurant restaurant : restaurants) {
    %>

        <div class="restaurant-card">

            <%
                String imagePath = restaurant.getImagePath();

                if (imagePath != null && !imagePath.trim().isEmpty()) {
            %>

                <img
                    class="restaurant-image"
                    src="<%= imagePath %>"
                    alt="Restaurant image"
                    onerror="this.style.display='none';">

            <%
                }
            %>

            <div class="restaurant-details">

                <h2>
                    <%= restaurant.getName() %>
                </h2>

                <p>
                    <strong>Restaurant ID:</strong>
                    <%= restaurant.getRestaurantId() %>
                </p>

                <p>
                    <strong>Cuisine:</strong>
                    <%= restaurant.getCuisineType() != null
                        ? restaurant.getCuisineType()
                        : "Not available" %>
                </p>

                <p>
                    <strong>Address:</strong>
                    <%= restaurant.getAddress() != null
                        ? restaurant.getAddress()
                        : "Not available" %>
                </p>

                <p>
                    <strong>Delivery Time:</strong>
                    <%= restaurant.getDeliveryTime() != null
                        ? restaurant.getDeliveryTime()
                        : "Not available" %>
                </p>

                <p class="rating">
                    ⭐ Rating:
                    <%= restaurant.getRating() %>
                </p>

                <p>
                    <strong>Admin User ID:</strong>
                    <%= restaurant.getAdminUserId() %>
                </p>

                <p>
                    <strong>Status:</strong>

                    <% if (restaurant.isActive()) { %>
                        <span class="active">Active</span>
                    <% } else { %>
                        <span class="inactive">Inactive</span>
                    <% } %>
                </p>

                <a class="menu-btn"
                   href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>">
                    View Menu
                </a>

            </div>
        </div>

    <%
        }
    %>

    </div>

<%
    } else {
%>

    <div class="empty-message">
        <h2>No Restaurants Found</h2>
        <p>Please check your restaurant records in the database.</p>
    </div>

<%
    }
%>

</div>

<footer>
    <p>&copy; 2026 KJL Restaurant. All rights reserved.</p>
</footer>

</body>
</html>
```