
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.tab.model.Order" %>
<%@ page import="com.tab.model.OrderItem" %>
<%@ page import="com.tab.model.Restaurant" %>
<%@ page import="com.tab.model.Menu" %>

<%
    List<Order> orders =
        (List<Order>) request.getAttribute("orders");

    Map<Integer, List<OrderItem>> orderItemsMap =
        (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");

    Map<Integer, Restaurant> restaurantMap =
        (Map<Integer, Restaurant>) request.getAttribute("restaurantMap");

    Map<Integer, Menu> menuMap =
        (Map<Integer, Menu>) request.getAttribute("menuMap");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders - KJL Restaurant</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f6f8;
    color: #292d32;
}

.navbar {
    background: #ffffff;
    padding: 18px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.logo {
    color: #e65325;
    font-size: 25px;
    font-weight: bold;
    text-decoration: none;
}

.nav-links a {
    margin-left: 22px;
    color: #333333;
    text-decoration: none;
    font-weight: 600;
}

.container {
    max-width: 1000px;
    margin: 35px auto;
    padding: 0 18px;
}

.page-title {
    margin-bottom: 8px;
    font-size: 30px;
}

.subtitle {
    color: #777777;
    margin-bottom: 28px;
}

.order-card {
    background: #ffffff;
    border-radius: 14px;
    margin-bottom: 28px;
    overflow: hidden;
    border: 1px solid #e8e8e8;
    box-shadow: 0 4px 15px rgba(0,0,0,0.04);
}

.order-header {
    padding: 22px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    border-bottom: 1px solid #eeeeee;
}

.restaurant-name {
    margin: 0 0 7px;
    font-size: 21px;
}

.order-number {
    color: #777777;
    font-size: 13px;
}

.status {
    display: inline-block;
    padding: 8px 13px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: bold;
    background: #fff0d6;
    color: #986000;
}

.status-cancelled {
    background: #ffe3e3;
    color: #bd2020;
}

.status-delivered {
    background: #dff7e5;
    color: #18743a;
}

.tracking-section {
    padding: 24px 20px;
    border-bottom: 1px solid #eeeeee;
}

.section-title {
    margin: 0 0 22px;
    font-size: 17px;
}

.tracking {
    display: flex;
    width: 100%;
}

.track-step {
    flex: 1;
    text-align: center;
    position: relative;
}

.track-step:not(:last-child)::after {
    content: "";
    position: absolute;
    height: 3px;
    background: #dddddd;
    top: 15px;
    left: 60%;
    width: 80%;
    z-index: 0;
}

.track-step.completed:not(:last-child)::after {
    background: #e65325;
}

.track-circle {
    width: 32px;
    height: 32px;
    margin: 0 auto 10px;
    border-radius: 50%;
    background: #e3e5e8;
    color: #777777;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    position: relative;
    z-index: 1;
}

.track-step.completed .track-circle,
.track-step.current .track-circle {
    background: #e65325;
    color: #ffffff;
}

.track-label {
    font-size: 12px;
    color: #777777;
}

.track-step.completed .track-label,
.track-step.current .track-label {
    color: #292d32;
    font-weight: bold;
}

.cancelled-message {
    padding: 15px;
    background: #fff0f0;
    color: #bd2020;
    border-radius: 8px;
    font-weight: bold;
}

.items-section {
    padding: 22px;
}

.item-row {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
}

.item-image {
    width: 75px;
    height: 75px;
    object-fit: cover;
    border-radius: 10px;
    background: #f1f1f1;
}

.item-info {
    flex: 1;
}

.item-name {
    margin: 0 0 8px;
    font-weight: bold;
}

.item-quantity {
    font-size: 13px;
    color: #777777;
}

.item-price {
    font-weight: bold;
    white-space: nowrap;
}

.order-details {
    padding: 22px;
    background: #fafafa;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 15px;
}

.detail-label {
    color: #777777;
    font-size: 13px;
}

.detail-value {
    text-align: right;
    overflow-wrap: anywhere;
}

.total-row {
    border-top: 1px solid #dddddd;
    padding-top: 17px;
    margin-top: 12px;
    font-size: 19px;
    font-weight: bold;
}

.total-price {
    color: #e65325;
}

.cancel-form {
    padding: 0 22px 22px;
    text-align: right;
}

.cancel-button {
    background: #dc3545;
    color: #ffffff;
    border: none;
    padding: 12px 19px;
    border-radius: 7px;
    cursor: pointer;
    font-weight: bold;
}

.cancel-button:hover {
    background: #b92332;
}

.message {
    background: #e1f7e7;
    color: #176b32;
    padding: 13px;
    margin-bottom: 20px;
    border-radius: 7px;
}

.empty-orders {
    background: #ffffff;
    padding: 50px 20px;
    border-radius: 12px;
    text-align: center;
}

.empty-orders a {
    display: inline-block;
    margin-top: 15px;
    padding: 12px 20px;
    background: #e65325;
    color: #ffffff;
    text-decoration: none;
    border-radius: 7px;
}

@media (max-width: 600px) {
    .navbar {
        padding: 16px;
    }

    .logo {
        font-size: 20px;
    }

    .nav-links a {
        margin-left: 10px;
        font-size: 13px;
    }

    .order-header {
        align-items: flex-start;
    }

    .track-label {
        font-size: 10px;
    }

    .track-step:not(:last-child)::after {
        left: 65%;
        width: 70%;
    }

    .item-image {
        width: 58px;
        height: 58px;
    }

    .item-row {
        gap: 10px;
    }
}
</style>
</head>

<body>

<div class="navbar">
    <a class="logo"
       href="<%= request.getContextPath() %>/restaurant">
        KJL Restaurant
    </a>

    <div class="nav-links">
        <a href="<%= request.getContextPath() %>/restaurant">Home</a>
        <a href="<%= request.getContextPath() %>/Cart.jsp">Cart</a>
        <a href="<%= request.getContextPath() %>/orders">My Orders</a>
    </div>
</div>

<div class="container">

    <h1 class="page-title">My Orders</h1>
    <p class="subtitle">
        Track your orders and view your order details.
    </p>

    <% if ("cancelled".equals(request.getParameter("message"))) { %>
        <div class="message">
            Your order has been cancelled successfully.
        </div>
    <% } %>

    <% if (orders != null && !orders.isEmpty()) { %>

        <% for (Order order : orders) {

            String status = order.getStatus() == null
                ? ""
                : order.getStatus().trim()
                    .toUpperCase(Locale.ROOT)
                    .replace('_', ' ')
                    .replace('-', ' ');

            boolean cancelled = status.equals("CANCELLED")
                || status.equals("CANCELED");

            boolean delivered = status.equals("DELIVERED");

            int currentStep = 0;

            if (status.equals("PREPARING")) {
                currentStep = 1;
            } else if (status.equals("OUT FOR DELIVERY")) {
                currentStep = 2;
            } else if (delivered) {
                currentStep = 3;
            }

            Restaurant restaurant = restaurantMap == null
                ? null
                : restaurantMap.get(order.getRestaurantId());

            List<OrderItem> items = orderItemsMap == null
                ? null
                : orderItemsMap.get(order.getOrderId());
        %>

        <div class="order-card">

            <div class="order-header">
                <div>
                    <h2 class="restaurant-name">
                        <%= restaurant != null
                            ? restaurant.getName()
                            : "Restaurant" %>
                    </h2>

                    <div class="order-number">
                        Order Number: <%= order.getOrderId() %>
                    </div>
                </div>

                <span class="status <%= cancelled
                    ? "status-cancelled"
                    : delivered ? "status-delivered" : "" %>">
                    <%= status.isEmpty() ? "UNKNOWN" : status %>
                </span>
            </div>

            <div class="tracking-section">
                <h3 class="section-title">Order Tracking</h3>

                <% if (cancelled) { %>

                    <div class="cancelled-message">
                        This order has been cancelled.
                    </div>

                <% } else { %>

                    <div class="tracking">

                        <%
                            String[] steps = {
                                "Order Placed",
                                "Preparing",
                                "Out for Delivery",
                                "Delivered"
                            };

                            for (int i = 0; i < steps.length; i++) {
                                String stepClass = "";

                                if (i < currentStep) {
                                    stepClass = "completed";
                                } else if (i == currentStep) {
                                    stepClass = "current";
                                }
                        %>

                        <div class="track-step <%= stepClass %>">
                            <div class="track-circle">
                                <%= i + 1 %>
                            </div>

                            <div class="track-label">
                                <%= steps[i] %>
                            </div>
                        </div>

                        <% } %>

                    </div>

                <% } %>
            </div>

            <div class="items-section">
                <h3 class="section-title">Ordered Items</h3>

                <% if (items != null && !items.isEmpty()) { %>

                    <% for (OrderItem item : items) {

                        Menu menu = menuMap == null
                            ? null
                            : menuMap.get(item.getMenuId());

                        String imagePath = menu == null
                            ? null
                            : menu.getImagePath();
                    %>

                    <div class="item-row">

                        <% if (imagePath != null
                                && !imagePath.trim().isEmpty()) { %>

                            <img class="item-image"
                                 src="<%= imagePath %>"
                                 alt="Food item"
                                 onerror="this.style.display='none';">

                        <% } else { %>

                            <div class="item-image"></div>

                        <% } %>

                        <div class="item-info">
                            <p class="item-name">
                                <%= menu != null
                                    ? menu.getItemName()
                                    : "Menu item" %>
                            </p>

                            <div class="item-quantity">
                                Quantity: <%= item.getQuantity() %>
                            </div>
                        </div>

                        <div class="item-price">
                            Rs. <%= String.format("%.2f",
                                item.getTotalAmount()) %>
                        </div>

                    </div>

                    <% } %>

                <% } else { %>

                    <p>No item details are available for this order.</p>

                <% } %>
            </div>

            <div class="order-details">

                <div class="detail-row">
                    <span class="detail-label">Order Date</span>
                    <span class="detail-value">
                        <%= order.getOrderDate() != null
                            ? order.getOrderDate()
                            : "N/A" %>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Payment Method</span>
                    <span class="detail-value">
                        <%= order.getPaymentMode() != null
                            ? order.getPaymentMode()
                            : "N/A" %>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Delivery Address</span>
                    <span class="detail-value">
                        <%= order.getAddress() != null
                            && !order.getAddress().trim().isEmpty()
                            ? order.getAddress()
                            : "N/A" %>
                    </span>
                </div>

                <div class="detail-row total-row">
                    <span>Total Amount</span>
                    <span class="total-price">
                        Rs. <%= String.format("%.2f",
                            order.getTotalAmount()) %>
                    </span>
                </div>

            </div>

            <% if ("PLACED".equals(status)) { %>

                <form class="cancel-form"
                      action="<%= request.getContextPath() %>/cancel-order"
                      method="post"
                      onsubmit="return confirm('Are you sure you want to cancel this order?');">

                    <input type="hidden"
                           name="orderId"
                           value="<%= order.getOrderId() %>">

                    <button type="submit" class="cancel-button">
                        Cancel Order
                    </button>

                </form>

            <% } %>

        </div>

        <% } %>

    <% } else { %>

        <div class="empty-orders">
            <h2>No orders yet</h2>
            <p>Your orders will appear here after you place an order.</p>

            <a href="<%= request.getContextPath() %>/restaurant">
                Browse Restaurants
            </a>
        </div>

    <% } %>

</div>

</body>
</html>
