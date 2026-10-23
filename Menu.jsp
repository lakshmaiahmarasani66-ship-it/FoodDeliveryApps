<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.tab.model.Menu" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Menu | KJL Restaurant</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/menu.css">
</head>
<body>

    <jsp:include page="/common/navbar.jsp"/>

    <main class="page">
        <div class="container">

            <div class="section-heading">
                <div>
                    <span class="eyebrow">Freshly prepared</span>
                    <h1>Explore the Menu</h1>
                    <p class="muted">
                        Choose your favorites and add them to your cart.
                    </p>
                </div>

                <a class="btn btn-ghost"
                   href="<%= request.getContextPath() %>/restaurant">
                    ← Restaurants
                </a>
            </div>

            <div class="grid grid-3">
                <%
                    List<Menu> menus =
                        (List<Menu>) request.getAttribute("menus");

                    if (menus != null && !menus.isEmpty()) {
                        for (Menu item : menus) {
                %>

                <article class="card">
                    <img
                        class="card-image"
                        src="<%= (item.getImagePath() == null
                                || item.getImagePath().isBlank())
                                ? request.getContextPath()
                                    + "/images/food-placeholder.jpg"
                                : item.getImagePath() %>"
                        alt="<%= item.getItemName() %>"
                        loading="lazy">

                    <div class="card-body">
                        <h3 class="card-title">
                            <%= item.getItemName() %>
                        </h3>

                        <p class="muted">
                            <%= item.getDescription() == null
                                    ? "Freshly prepared and delicious."
                                    : item.getDescription() %>
                        </p>

                        <div class="card-actions">
                            <span class="price">
                                ₹<%= item.getPrice() %>
                            </span>

                            <form method="post"
                                  action="<%= request.getContextPath() %>/addToCart">

                                <input type="hidden"
                                       name="menuId"
                                       value="<%= item.getMenuId() %>">

                                <input type="hidden"
                                       name="restaurantId"
                                       value="<%= item.getRestaurantId() %>">

                                <button class="btn btn-small" type="submit">
                                    Add to Cart +
                                </button>
                            </form>
                        </div>
                    </div>
                </article>

                <%
                        }
                    } else {
                %>

                <div class="empty-state" style="grid-column: 1 / -1;">
                    <h3>No menu items found</h3>
                    <p class="muted">
                        Please check that your MenuController loads
                        the menu items into the "menus" request attribute.
                    </p>
                </div>

                <%
                    }
                %>
            </div>
        </div>
    </main>

    <jsp:include page="/common/footer.jsp"/>

</body>
</html>