
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
    boolean loggedIn = session.getAttribute("user") != null;
%>
<header class="site-navbar">
    <div class="container nav-inner">
        <a class="brand" href="<%= ctx %>/restaurant">
            <span class="brand-mark">🍴</span>
            <span>KJL Restaurant</span>
        </a>

        <nav class="nav-links">
            <a href="<%= ctx %>/restaurant">Restaurants</a>
            <a href="<%= ctx %>/cart">Cart</a>
            <% if (loggedIn) { %>
                <a href="<%= ctx %>/orders">My Orders</a>
            <% } %>
        </nav>

        <div class="nav-actions">
            <a class="icon-btn"
               href="<%= ctx %>/<%= loggedIn ? "Profile.jsp" : "Login.jsp" %>"
               title="<%= loggedIn ? "My Profile" : "Login" %>"
               aria-label="Profile">
                ♙
            </a>

            <% if (loggedIn) { %>
                <a class="btn btn-small btn-ghost" href="<%= ctx %>/logout">Logout</a>
            <% } %>
        </div>
    </div>
</header>
