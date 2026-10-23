
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<footer class="site-footer">
    <div class="container footer-inner">
        <div>
            <a class="brand" href="<%= request.getContextPath() %>/restaurant">
                <span class="brand-mark">🍴</span>
                <span>KJL Restaurant</span>
            </a>
            <p class="muted">Good food, delivered with care.</p>
        </div>

        <div class="footer-links">
            <a href="<%= request.getContextPath() %>/restaurant">Restaurants</a>
            <a href="<%= request.getContextPath() %>/cart">Cart</a>
            <a href="<%= request.getContextPath() %>/Login.jsp">Account</a>
        </div>

        <small>© KJL Restaurant</small>
    </div>
</footer>
