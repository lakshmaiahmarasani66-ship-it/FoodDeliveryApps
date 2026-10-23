<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tab.model.Cart" %>
<%@ page import="com.tab.model.CartItem" %>
<%@ page import="com.tab.model.Menu" %>
<%@ page import="com.tap.DAOImpl.MenuDAOImpl" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart | KJL Restaurant</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/cart.css">

    <style>
        /* Cart layout */
        .cart-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 300px;
            align-items: start;
            gap: 25px;
        }

        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 18px;
            min-width: 0;
        }

        /* Medium-sized food images */
        .cart-item-image {
            flex-shrink: 0;
            width: 120px;
            height: 100px;
            object-fit: cover;
            background: #eee4d5;
            border-radius: 15px;
        }

        /* Quantity increment/decrement */
        .quantity-control {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            margin-top: 10px;
            padding: 6px;
            border-radius: 12px;
            background: var(--bg, #f7f2e9);
            box-shadow:
                inset 3px 3px 7px rgba(163, 150, 130, 0.15),
                inset -3px -3px 7px rgba(255, 255, 255, 0.8);
        }

        .quantity-control button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border: none;
            border-radius: 9px;
            background: var(--primary, #e85d3f);
            color: #fff;
            font-size: 21px;
            cursor: pointer;
        }

        .quantity-control button:hover {
            background: var(--primary-dark, #cf4930);
        }

        .quantity-control span {
            min-width: 20px;
            text-align: center;
            font-weight: 700;
            color: var(--text, #302b27);
        }

        /* Compact summary in the right corner */
        .cart-summary {
            position: sticky;
            top: 20px;
            width: 100%;
            max-width: 300px;
            margin-left: auto;
            padding: 18px;
            box-sizing: border-box;
            background: var(--bg, #f7f2e9);
            border-radius: 18px;
            box-shadow:
                6px 6px 15px rgba(163, 150, 130, 0.17),
                -6px -6px 15px rgba(255, 255, 255, 0.85);
        }

        .cart-summary h2 {
            margin: 0 0 15px;
            font-size: 1.15rem;
            color: var(--text, #302b27);
        }

        .cart-summary .summary-row {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin: 10px 0;
            font-size: 0.9rem;
        }

        .cart-summary .summary-total {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin: 15px 0;
            font-size: 1rem;
            font-weight: 800;
        }

        .cart-summary .summary-total span:last-child {
            font-size: 1.15rem;
            color: var(--primary, #e85d3f);
        }

        .cart-summary .btn {
            display: block;
            width: 100%;
            padding: 10px 12px;
            box-sizing: border-box;
            text-align: center;
            font-size: 0.9rem;
        }

        .quantity-control button:focus-visible,
        .cart-summary .btn:focus-visible {
            outline: 3px solid rgba(232, 93, 63, 0.4);
            outline-offset: 3px;
        }

        /* Responsive layout */
        @media (max-width: 800px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }

            .cart-summary {
                position: static;
                max-width: 100%;
                margin-left: 0;
            }
        }

        @media (max-width: 550px) {
            .cart-item-image {
                width: 100px;
                height: 90px;
            }

            .cart-item {
                flex-wrap: wrap;
            }

            .cart-item-details {
                min-width: 0;
            }
        }
    </style>
</head>

<body>

<jsp:include page="/common/navbar.jsp" />

<%
    Cart cart = (Cart) session.getAttribute("cart");
    List<CartItem> items = cart != null ? cart.getItems() : null;

    MenuDAOImpl menuDAO = new MenuDAOImpl();

    double total = 0.0;
    int displayedItems = 0;
%>

<main class="page">
    <div class="container">

        <div class="section-heading">
            <div>
                <span class="eyebrow">Your selections</span>
                <h1>My Cart</h1>
                <p class="muted">
                    Manage your food selections before checkout.
                </p>
            </div>

            <a href="<%= request.getContextPath() %>/restaurant"
               class="btn btn-ghost">
                Continue Shopping
            </a>
        </div>

        <% if (items == null || items.isEmpty()) { %>

            <div class="empty-state">
                <h2>Your cart is empty</h2>
                <p class="muted">
                    Delicious food is waiting for you!
                </p>

                <a href="<%= request.getContextPath() %>/restaurant"
                   class="btn">
                    Explore Restaurants
                </a>
            </div>

        <% } else { %>

            <div class="cart-layout">

                <section class="cart-items">

                    <% for (CartItem cartItem : items) {
                           Menu menu = menuDAO.getMenu(cartItem.getMenuId());

                           if (menu == null) {
                               continue;
                           }

                           double itemTotal =
                               menu.getPrice() * cartItem.getQuantity();

                           total += itemTotal;
                           displayedItems += cartItem.getQuantity();
                    %>

                        <article class="cart-item">

                            <img
                                class="cart-item-image"
                                src="<%= menu.getImagePath() != null
                                    && !menu.getImagePath().trim().isEmpty()
                                    ? menu.getImagePath()
                                    : request.getContextPath()
                                        + "/images/restaurant-placeholder.jpg" %>"
                                alt="<%= menu.getItemName() %>">

                            <div class="cart-item-details">

                                <h3 class="cart-item-title">
                                    <%= menu.getItemName() %>
                                </h3>

                                <p class="cart-item-price">
                                    ₹<%= String.format("%.2f", menu.getPrice()) %>
                                    each
                                </p>

                                <form
                                    action="<%= request.getContextPath() %>/addToCart"
                                    method="post">

                                    <input type="hidden"
                                           name="action"
                                           value="update">

                                    <input type="hidden"
                                           name="menuId"
                                           value="<%= cartItem.getMenuId() %>">

                                    <input type="hidden"
                                           name="quantity"
                                           value="<%= cartItem.getQuantity() %>">

                                    <div class="quantity-control">

                                        <button type="button"
                                                aria-label="Decrease quantity"
                                                onclick="changeQuantity(this, -1)">
                                            −
                                        </button>

                                        <span>
                                            <%= cartItem.getQuantity() %>
                                        </span>

                                        <button type="button"
                                                aria-label="Increase quantity"
                                                onclick="changeQuantity(this, 1)">
                                            +
                                        </button>

                                    </div>
                                </form>

                            </div>

                            <div class="cart-item-actions">
                                <span class="cart-item-total">
                                    ₹<%= String.format("%.2f", itemTotal) %>
                                </span>
                            </div>

                        </article>

                    <% } %>

                </section>

                <% if (displayedItems > 0) { %>

                    <aside class="cart-summary">

                        <h2>Order Summary</h2>

                        <div class="summary-row">
                            <span>Total Items</span>
                            <span><%= displayedItems %></span>
                        </div>

                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>₹<%= String.format("%.2f", total) %></span>
                        </div>

                        <hr class="summary-divider">

                        <div class="summary-total">
                            <span>Total</span>
                            <span>₹<%= String.format("%.2f", total) %></span>
                        </div>

                        <form
                            action="<%= request.getContextPath() %>/checkout"
                            method="get">

                            <button type="submit" class="btn">
                                Proceed to Checkout
                            </button>

                        </form>

                    </aside>

                <% } else { %>

                    <div class="empty-state">
                        <h2>Your cart is empty</h2>
                        <p class="muted">
                            Add some delicious food to continue.
                        </p>

                        <a href="<%= request.getContextPath() %>/restaurant"
                           class="btn">
                            Explore Restaurants
                        </a>
                    </div>

                <% } %>

            </div>

        <% } %>

    </div>
</main>

<jsp:include page="/common/footer.jsp" />

<script>
    function changeQuantity(button, change) {
        const form = button.closest("form");
        const quantityInput =
            form.querySelector('input[name="quantity"]');
        const quantityDisplay =
            form.querySelector(".quantity-control span");

        let quantity = parseInt(quantityInput.value, 10);
        quantity += change;

        if (quantity < 0) {
            quantity = 0;
        }

        quantityInput.value = quantity;
        quantityDisplay.textContent = quantity;

        // Update the session cart immediately.
        // Your CartController removes the item when quantity is zero.
        form.submit();
    }
</script>

</body>
</html>