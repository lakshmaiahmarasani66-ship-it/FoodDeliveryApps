
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.tab.model.Order" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KJL Restaurant - Admin Orders</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    color: #222;
}

header {
    background: #8b0000;
    color: white;
    padding: 22px 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
}

header h1 {
    margin: 0;
    font-size: 25px;
}

header a {
    color: white;
    text-decoration: none;
    background: #650000;
    padding: 10px 16px;
    border-radius: 6px;
}

header a:hover {
    background: #4b0000;
}

.container {
    width: 92%;
    max-width: 1150px;
    margin: 30px auto;
}

h2 {
    margin-bottom: 20px;
    color: #333;
}

.message {
    padding: 13px;
    margin-bottom: 18px;
    border-radius: 6px;
    background: #e2f5e8;
    color: #176b35;
}

.error {
    background: #ffe6e6;
    color: #a00000;
}

.order-card {
    background: white;
    border-radius: 12px;
    padding: 22px;
    margin-bottom: 22px;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.08);
}

.order-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
    border-bottom: 1px solid #eee;
    padding-bottom: 15px;
}

.order-heading h3 {
    margin: 0;
    color: #8b0000;
}

.status {
    display: inline-block;
    padding: 7px 12px;
    border-radius: 20px;
    background: #fff0cc;
    color: #795400;
    font-size: 13px;
    font-weight: bold;
}

.details {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 16px;
    padding: 18px 0;
}

.detail {
    overflow-wrap: anywhere;
    line-height: 1.6;
}

.detail strong {
    display: block;
    color: #555;
    font-size: 13px;
    margin-bottom: 4px;
}

.amount {
    color: #087b39;
    font-weight: bold;
    font-size: 18px;
}

.update-form {
    border-top: 1px solid #eee;
    padding-top: 18px;
    display: flex;
    align-items: center;
    gap: 12px;
    flex-wrap: wrap;
}

select {
    padding: 11px;
    border: 1px solid #ccc;
    border-radius: 6px;
    min-width: 190px;
    background: white;
}

button {
    background: #8b0000;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

button:hover {
    background: #650000;
}

.no-orders {
    text-align: center;
    background: white;
    padding: 35px;
    border-radius: 10px;
}

footer {
    text-align: center;
    color: #777;
    padding: 20px;
}

@media (max-width: 600px) {
    .container {
        width: 94%;
    }

    .order-card {
        padding: 16px;
    }

    .update-form {
        align-items: stretch;
        flex-direction: column;
    }

    select, button {
        width: 100%;
    }
}
</style>
</head>

<body>

<header>
    <h1>KJL Restaurant - Admin Panel</h1>

    <a href="<%= request.getContextPath() %>/Restaurant.jsp">
        Restaurant Home
    </a>
</header>

<div class="container">

    <h2>Manage Customer Orders</h2>

    <%
        String message = request.getParameter("message");

        if ("updated".equals(message)) {
    %>
        <div class="message">
            Order status updated successfully.
        </div>
    <%
        } else if ("invalid".equals(message)
                || "error".equals(message)) {
    %>
        <div class="message error">
            Unable to update the order. Please check the order details and try again.
        </div>
    <%
        }

        List<Order> orders =
            (List<Order>) request.getAttribute("orders");

        if (orders == null || orders.isEmpty()) {
    %>

        <div class="no-orders">
            <h3>No orders found</h3>
            <p>Customer orders will appear here.</p>
        </div>

    <%
        } else {

            for (Order order : orders) {

                String currentStatus = order.getStatus();

                if (currentStatus == null) {
                    currentStatus = "UNKNOWN";
                }

                String normalizedStatus =
                    currentStatus.trim()
                        .toUpperCase(Locale.ROOT)
                        .replace('-', '_')
                        .replace(' ', '_');

                String displayStatus =
                    normalizedStatus.replace('_', ' ');

                String nextStatus = null;

                if ("PLACED".equals(normalizedStatus)) {
                    nextStatus = "PREPARING";
                } else if ("PREPARING".equals(normalizedStatus)) {
                    nextStatus = "OUT_FOR_DELIVERY";
                } else if ("OUT_FOR_DELIVERY".equals(normalizedStatus)) {
                    nextStatus = "DELIVERED";
                }
    %>

    <div class="order-card">

        <div class="order-heading">
            <h3>Order #<%= order.getOrderId() %></h3>

            <span class="status">
                <%= displayStatus %>
            </span>
        </div>

        <div class="details">

            <div class="detail">
                <strong>Customer ID</strong>
                <%= order.getUserId() %>
            </div>

            <div class="detail">
                <strong>Restaurant ID</strong>
                <%= order.getRestaurantId() %>
            </div>

            <div class="detail">
                <strong>Order Date</strong>
                <%= order.getOrderDate() == null
                    ? "Not available" : order.getOrderDate() %>
            </div>

            <div class="detail">
                <strong>Total Amount</strong>
                <span class="amount">
                    Rs. <%= String.format(
                        Locale.US, "%.2f", order.getTotalAmount()) %>
                </span>
            </div>

            <div class="detail">
                <strong>Payment Mode</strong>
                <%= order.getPaymentMode() == null
                    ? "Not available" : order.getPaymentMode() %>
            </div>

            <div class="detail">
                <strong>Delivery Address</strong>
                <%= order.getAddress() == null
                    ? "Not available" : order.getAddress() %>
            </div>

        </div>

        <% if (nextStatus != null) { %>

        <form class="update-form"
              action="<%= request.getContextPath() %>/admin-update-order"
              method="post">

            <input type="hidden"
                   name="orderId"
                   value="<%= order.getOrderId() %>">

            <label for="status-<%= order.getOrderId() %>">
                Update delivery status:
            </label>

            <select id="status-<%= order.getOrderId() %>"
                    name="status" required>

                <option value="<%= nextStatus %>">
                    <%= nextStatus.replace('_', ' ') %>
                </option>

            </select>

            <button type="submit">Update Status</button>

        </form>

        <% } else { %>

        <p>
            <% if ("DELIVERED".equals(normalizedStatus)) { %>
                This order has been delivered.
            <% } else if ("CANCELLED".equals(normalizedStatus)
                    || "CANCELED".equals(normalizedStatus)) { %>
                This order has been cancelled.
            <% } else { %>
                No status update is available for this order.
            <% } %>
        </p>

        <% } %>

    </div>

    <%
            }
        }
    %>

</div>

<footer>
    &copy; KJL Restaurant | Admin Order Management
</footer>

</body>
</html>
