
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tab.model.Restaurant" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KJL Restaurant - Manage Restaurants</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f5f8;
    color: #222;
}

header {
    background: #8b0000;
    color: white;
    padding: 22px 5%;
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
    padding: 10px 15px;
    background: #650000;
    border-radius: 6px;
}

header a:hover {
    background: #4b0000;
}

.container {
    width: 94%;
    max-width: 1200px;
    margin: 28px auto;
}

.panel {
    background: white;
    padding: 22px;
    border-radius: 10px;
    margin-bottom: 25px;
    box-shadow: 0 3px 12px #0000000d;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 15px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 7px;
}

input {
    width: 100%;
    padding: 11px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

button {
    display: inline-block;
    border: 0;
    padding: 10px 15px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    margin-top: 10px;
}

.primary {
    background: #8b0000;
    color: white;
}

.primary:hover {
    background: #650000;
}

.danger {
    background: #b42318;
    color: white;
}

.restaurant {
    border: 1px solid #e6e6e6;
    border-radius: 9px;
    padding: 18px;
    margin: 15px 0;
    background: #fff;
}

.restaurant h3 {
    margin: 0 0 12px;
    color: #8b0000;
}

.details-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 12px;
    line-height: 1.5;
}

.details-grid strong {
    color: #555;
}

.restaurant-image {
    display: block;
    width: 180px;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
    margin: 12px 0;
}

.notice {
    background: #e6f5e9;
    color: #176b35;
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 15px;
}

.error {
    background: #ffe8e8;
    color: #9b111e;
}

.edit-section {
    margin-top: 18px;
    padding-top: 12px;
    border-top: 1px solid #eee;
}

summary {
    cursor: pointer;
    font-weight: bold;
    color: #8b0000;
    padding: 8px 0;
}

.inline-form {
    display: inline-block;
}

small {
    color: #666;
}

@media (max-width: 600px) {
    .container {
        width: 94%;
    }

    .panel {
        padding: 16px;
    }

    .restaurant {
        padding: 14px;
    }
}
</style>
</head>

<body>

<header>
    <h1>KJL Restaurant - Admin</h1>
    <a href="<%= request.getContextPath() %>/admin-orders">
        Manage Orders
    </a>
</header>

<div class="container">

    <h2>Restaurant Management</h2>

    <%
        String message = request.getParameter("message");

        if ("added".equals(message)) {
    %>
        <div class="notice">Restaurant added successfully.</div>
    <%
        } else if ("updated".equals(message)) {
    %>
        <div class="notice">Restaurant updated successfully.</div>
    <%
        } else if ("deactivated".equals(message)) {
    %>
        <div class="notice">Restaurant deactivated successfully.</div>
    <%
        } else if ("error".equals(message)) {
    %>
        <div class="notice error">
            Operation failed. Check the submitted values and server console.
        </div>
    <%
        }
    %>

    <!-- Add Restaurant -->
    <div class="panel">

        <h2>Add Restaurant</h2>

        <form action="<%= request.getContextPath() %>/admin-restaurant-save"
              method="post">

            <input type="hidden" name="restaurantId" value="">

            <div class="form-grid">

                <div>
                    <label for="newName">Restaurant Name</label>
                    <input id="newName" type="text" name="name" required>
                </div>

                <div>
                    <label for="newCuisine">Cuisine Type</label>
                    <input id="newCuisine" type="text"
                           name="cuisineType" required>
                </div>

                <div>
                    <label for="newAddress">Address</label>
                    <input id="newAddress" type="text"
                           name="address" required>
                </div>

                <div>
                    <label for="newDelivery">Delivery Time</label>
                    <input id="newDelivery" type="text"
                           name="deliveryTime"
                           placeholder="30-40 minutes" required>
                </div>

                <div>
                    <label for="newRating">Rating</label>
                    <input id="newRating" type="number"
                           name="rating" min="0" max="5"
                           step="0.1" value="4.0" required>
                </div>

                <div>
                    <label for="newImage">Image URL</label>
                    <input id="newImage" type="url" name="imagePath"
                           placeholder="https://example.com/image.jpg">
                </div>

                <div>
                    <label for="newAdmin">Admin User ID</label>
                    <input id="newAdmin" type="number"
                           name="adminUserId" min="1" required>
                </div>

            </div>

            <button class="primary" type="submit">
                Add Restaurant
            </button>
        </form>
    </div>

    <!-- Existing Restaurants -->
    <div class="panel">

        <h2>Existing Restaurants</h2>

        <%
            List<Restaurant> restaurants =
                (List<Restaurant>) request.getAttribute("restaurants");

            if (restaurants == null || restaurants.isEmpty()) {
        %>

            <p>No restaurants found in the database.</p>

        <%
            } else {
                for (Restaurant r : restaurants) {
        %>

        <div class="restaurant">

            <h3>
                #<%= r.getRestaurantId() %> -
                <%= r.getName() == null ? "" : r.getName() %>
            </h3>

            <% if (r.getImagePath() != null
                    && !r.getImagePath().trim().isEmpty()) { %>

                <img class="restaurant-image"
                     src="<%= r.getImagePath() %>"
                     alt="Restaurant image"
                     onerror="this.style.display='none';">

            <% } %>

            <div class="details-grid">

                <div>
                    <strong>Cuisine:</strong>
                    <%= r.getCuisineType() == null
                        ? "Not set" : r.getCuisineType() %>
                </div>

                <div>
                    <strong>Address:</strong>
                    <%= r.getAddress() == null
                        ? "Not set" : r.getAddress() %>
                </div>

                <div>
                    <strong>Delivery Time:</strong>
                    <%= r.getDeliveryTime() == null
                        ? "Not set" : r.getDeliveryTime() %>
                </div>

                <div>
                    <strong>Rating:</strong>
                    <%= r.getRating() %> / 5
                </div>

                <div>
                    <strong>Admin User ID:</strong>
                    <%= r.getAdminUserId() %>
                </div>

                <div>
                    <strong>Status:</strong>
                    <%= r.isActive() ? "Active" : "Inactive" %>
                </div>

            </div>

            <!-- Edit Restaurant -->
            <div class="edit-section">

                <details>
                    <summary>Edit Restaurant</summary>

                    <form action="<%= request.getContextPath() %>/admin-restaurant-save"
                          method="post">

                        <input type="hidden" name="restaurantId"
                               value="<%= r.getRestaurantId() %>">

                        <div class="form-grid">

                            <div>
                                <label>Name</label>
                                <input type="text" name="name"
                                       value="<%= r.getName() == null ? "" : r.getName() %>"
                                       required>
                            </div>

                            <div>
                                <label>Cuisine Type</label>
                                <input type="text" name="cuisineType"
                                       value="<%= r.getCuisineType() == null ? "" : r.getCuisineType() %>"
                                       required>
                            </div>

                            <div>
                                <label>Address</label>
                                <input type="text" name="address"
                                       value="<%= r.getAddress() == null ? "" : r.getAddress() %>"
                                       required>
                            </div>

                            <div>
                                <label>Delivery Time</label>
                                <input type="text" name="deliveryTime"
                                       value="<%= r.getDeliveryTime() == null ? "" : r.getDeliveryTime() %>"
                                       required>
                            </div>

                            <div>
                                <label>Rating</label>
                                <input type="number" name="rating"
                                       min="0" max="5" step="0.1"
                                       value="<%= r.getRating() %>" required>
                            </div>

                            <div>
                                <label>Image URL</label>
                                <input type="url" name="imagePath"
                                       value="<%= r.getImagePath() == null ? "" : r.getImagePath() %>">
                            </div>

                            <div>
                                <label>Admin User ID</label>
                                <input type="number" name="adminUserId"
                                       min="1"
                                       value="<%= r.getAdminUserId() %>"
                                       required>
                            </div>

                        </div>

                        <button class="primary" type="submit">
                            Save Changes
                        </button>

                    </form>
                </details>

            </div>

            <!-- Deactivate Restaurant -->
            <% if (r.isActive()) { %>

                <form class="inline-form"
                      action="<%= request.getContextPath() %>/admin-restaurant-deactivate"
                      method="post"
                      onsubmit="return confirm('Deactivate this restaurant?');">

                    <input type="hidden" name="restaurantId"
                           value="<%= r.getRestaurantId() %>">

                    <button class="danger" type="submit">
                        Deactivate Restaurant
                    </button>

                </form>

            <% } else { %>

                <p><small>This restaurant is inactive.</small></p>

            <% } %>

        </div>

        <%
                }
            }
        %>

    </div>

</div>

</body>
</html>
