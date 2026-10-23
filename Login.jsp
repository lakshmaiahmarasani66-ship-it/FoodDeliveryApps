<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | KJL Restaurant</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/Login.css">
</head>
<body>

<div class="login-page">
    <div class="login-card">

        <h1>KJL Restaurant</h1>
        <p class="subtitle">Good food, delivered with care.</p>

        <h2>Welcome Back!</h2>
        <p class="description">Login to continue your food journey.</p>

        <% if ("invalid".equals(request.getParameter("error"))) { %>
            <div class="error-message">
                Invalid email or password. Please try again.
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login"
              method="post">

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email"
                       id="email"
                       name="email"
                       placeholder="Enter your email"
                       autocomplete="email"
                       required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Enter your password"
                       autocomplete="current-password"
                       required>
            </div>

            <button type="submit" class="login-btn">Login</button>
        </form>

        <p class="signup-text">
            Don't have an account?
            <a href="<%= request.getContextPath() %>/Signup.jsp">
                Sign Up
            </a>
        </p>

        <a class="home-link"
           href="<%= request.getContextPath() %>/restaurant">
            ← Back to Restaurants
        </a>

    </div>
</div>

</body>
</html>