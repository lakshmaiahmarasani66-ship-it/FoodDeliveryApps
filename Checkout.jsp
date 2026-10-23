
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tab.model.Cart" %>
<%@ page import="com.tab.model.CartItem" %>
<%@ page import="com.tab.model.Menu" %>
<%@ page import="com.tap.DAOImpl.MenuDAOImpl" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/cart");
        return;
    }

    List<CartItem> items = cart.getItems();
    MenuDAOImpl menuDAO = new MenuDAOImpl();

    double subtotal = 0;
    int totalQuantity = 0;

    for (CartItem item : items) {
        Menu menu = menuDAO.getMenu(item.getMenuId());

        if (menu != null) {
            subtotal += menu.getPrice() * item.getQuantity();
            totalQuantity += item.getQuantity();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | KJL Restaurant</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/Checkout.css">
</head>
<body>

<jsp:include page="/common/navbar.jsp" />

<main class="checkout-page">
    <div class="checkout-container">

        <div class="checkout-heading">
            <h1>Checkout</h1>
            <p>Confirm your delivery details and payment method.</p>
        </div>

        <div class="checkout-layout">

            <form class="checkout-form"
                  action="<%= request.getContextPath() %>/checkout"
                  method="post">

                <h2>Delivery Details</h2>

                <div class="form-group">
                    <label for="customerName">Full Name</label>
                    <input type="text"
                           id="customerName"
                           name="customerName"
                           placeholder="Enter your full name"
                           required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <div class="phone-input-wrapper">
                        <span class="phone-country-code">🇮🇳 +91</span>
                        <input type="tel"
                               id="phone"
                               name="phone"
                               placeholder="10-digit mobile number"
                               pattern="[0-9]{10}"
                               maxlength="10"
                               required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="address">Delivery Address</label>
                    <textarea id="address"
                              name="address"
                              rows="4"
                              placeholder="Enter your complete delivery address"
                              required></textarea>
                </div>

                <h2 class="payment-heading">Payment Method</h2>

                <div class="payment-options">
                    <label class="payment-option">
                        <input type="radio"
                               name="paymentMode"
                               value="COD"
                               checked>
                        <span>Cash on Delivery</span>
                    </label>

                    <label class="payment-option">
                        <input type="radio"
                               name="paymentMode"
                               value="UPI">
                        <span>UPI</span>
                    </label>

                    <label class="payment-option">
                        <input type="radio"
                               name="paymentMode"
                               value="CARD">
                        <span>Credit / Debit Card</span>
                    </label>
                </div>

                <button type="submit" class="place-order-btn">
                    Place Order
                </button>

                <a class="back-to-cart"
                   href="<%= request.getContextPath() %>/cart">
                    &larr; Back to Cart
                </a>
            </form>

            <aside class="checkout-summary">
                <h2>Order Summary</h2>

                <div class="summary-row">
                    <span>Total Items</span>
                    <span><%= totalQuantity %></span>
                </div>

                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>₹<%= String.format("%.2f", subtotal) %></span>
                </div>

                <div class="summary-divider"></div>

                <div class="summary-row summary-total">
                    <span>Order Total</span>
                    <span>₹<%= String.format("%.2f", subtotal) %></span>
                </div>

                <p class="delivery-note">
                    Delivery charges, if applicable, will be calculated
                    according to your order-processing logic.
                </p>
            </aside>

        </div>
    </div>
</main>

<jsp:include page="/common/footer.jsp" />

</body>
</html>
