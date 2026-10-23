
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.tab.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Restaurants | KJL Restaurant</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/common.css">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/restaurant.css">

    <style>
        .restaurant-search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin: 22px 0;
            align-items: center;
        }

        .restaurant-search-form input,
        .restaurant-search-form select {
            flex: 1;
            min-width: 180px;
            padding: 12px 14px;
            border: 1px solid #dedede;
            border-radius: 9px;
            background: #fff;
            color: #333;
            font-size: 14px;
            outline: none;
        }

        .restaurant-search-form input:focus,
        .restaurant-search-form select:focus {
            border-color: #e65325;
        }

        .restaurant-search-form button,
        .restaurant-search-form .clear-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 9px;
            background: #e65325;
            color: white;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            text-align: center;
        }

        .restaurant-search-form .clear-btn {
            background: #555;
        }

        .restaurant-search-form button:hover {
            background: #c9441d;
        }

        .restaurant-search-form .clear-btn:hover {
            background: #333;
        }

        .search-result-count {
            margin: 0 0 18px;
            color: #777;
            font-size: 14px;
        }

        .no-results {
            grid-column: 1 / -1;
            padding: 35px 20px;
            text-align: center;
            background: #fff;
            border-radius: 12px;
        }

        .no-results h3 {
            margin-bottom: 8px;
        }

        @media (max-width: 600px) {
            .restaurant-search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .restaurant-search-form input,
            .restaurant-search-form select {
                width: 100%;
                min-width: 0;
            }
        }
    </style>
</head>

<body>

    <jsp:include page="/common/navbar.jsp" />

    <main class="page">
        <div class="container">

            <section class="hero">
                <div>
                    <span class="eyebrow">Fresh • Local • Delicious</span>

                    <h1>Good food is just a few clicks away.</h1>

                    <p>
                        Discover restaurants, explore menus, and order
                        your favorite meals with KJL Restaurant.
                    </p>

                    <a class="btn" href="#restaurants">
                        Explore Restaurants →
                    </a>
                </div>

                <div class="hero-art" aria-hidden="true">🍛</div>
            </section>

            <section id="restaurants">

                <div class="section-heading">
                    <div>
                        <span class="eyebrow">Made for your cravings</span>
                        <h2>Popular Restaurants</h2>
                    </div>
                </div>

                <%
                    String search = request.getParameter("search");
                    String cuisine = request.getParameter("cuisine");

                    if (search == null) {
                        search = "";
                    }

                    if (cuisine == null) {
                        cuisine = "";
                    }

                    List<Restaurant> restaurants =
                        (List<Restaurant>) request.getAttribute("restaurants");
                %>

                <form class="restaurant-search-form"
                      action="<%= request.getContextPath() %>/restaurant"
                      method="get">

                    <input type="search"
                           name="search"
                           placeholder="Search restaurant name..."
                           value="<%= search.replace("&", "&amp;")
                                            .replace("\"", "&quot;")
                                            .replace("<", "&lt;")
                                            .replace(">", "&gt;") %>">

                    <select name="cuisine">
                        <option value="">All Cuisines</option>
                        <option value="Indian"
                            <%= "Indian".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            Indian
                        </option>
                        <option value="North Indian"
                            <%= "North Indian".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            North Indian
                        </option>
                        <option value="South Indian"
                            <%= "South Indian".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            South Indian
                        </option>
                        <option value="Chinese"
                            <%= "Chinese".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            Chinese
                        </option>
                        <option value="Italian"
                            <%= "Italian".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            Italian
                        </option>
                        <option value="Mexican"
                            <%= "Mexican".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            Mexican
                        </option>
                        <option value="Biryani"
                            <%= "Biryani".equalsIgnoreCase(cuisine) ? "selected" : "" %>>
                            Biryani
                        </option>
                    </select>

                    <button type="submit">Search</button>

                    <a class="clear-btn"
                       href="<%= request.getContextPath() %>/restaurant">
                        Clear
                    </a>
                </form>

                <p class="search-result-count">
                    <%= restaurants == null ? 0 : restaurants.size() %>
                    restaurant(s) found
                </p>

                <div class="grid grid-3">

                    <%
                        if (restaurants != null && !restaurants.isEmpty()) {
                            for (Restaurant r : restaurants) {
                    %>

                    <article class="card">

                        <img class="card-image"
                             src="<%= (r.getImagePath() == null
                                     || r.getImagePath().isBlank())
                                     ? request.getContextPath()
                                         + "/images/restaurant-placeholder.jpg"
                                     : r.getImagePath() %>"
                             alt="<%= r.getName() %>"
                             loading="lazy">

                        <div class="card-body">

                            <div class="section-heading">
                                <h3 class="card-title">
                                    <%= r.getName() %>
                                </h3>

                                <span class="badge">
                                    ★ <%= r.getRating() %>
                                </span>
                            </div>

                            <p class="muted">
                                <%= r.getCuisineType() == null
                                        ? "Popular cuisine"
                                        : r.getCuisineType() %>
                            </p>

                            <div class="card-meta">
                                <span>
                                    ⏱ <%= r.getDeliveryTime() %> min
                                </span>

                                <span>
                                    📍 <%= r.getAddress() == null
                                            ? "Nearby"
                                            : r.getAddress() %>
                                </span>
                            </div>

                            <div class="card-actions">
                                <a class="btn btn-small"
                                   href="<%= request.getContextPath() %>/menu?restaurantId=<%= r.getRestaurantId() %>">
                                    View Menu →
                                </a>
                            </div>

                        </div>
                    </article>

                    <%
                            }
                        } else {
                    %>

                    <div class="no-results">
                        <h3>No restaurants found</h3>
                        <p class="muted">
                            Try another restaurant name or cuisine.
                        </p>

                        <a class="btn"
                           href="<%= request.getContextPath() %>/restaurant">
                            Show All Restaurants
                        </a>
                    </div>

                    <%
                        }
                    %>

                </div>
            </section>

        </div>
    </main>

    <jsp:include page="/common/footer.jsp" />

</body>
</html>
