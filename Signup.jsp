<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - KJL Restaurant</title>
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/Signup.css">
</head>
<body>

<div class="signup-container">
    <div class="signup-card">
        <h1>KJL Restaurant</h1>
        <h2>Create Account</h2>
        <p>Sign up to enjoy delicious food.</p>

        <% if ("exists".equals(request.getParameter("error"))) { %>
            <p class="error">Email already registered. Please log in.</p>
        <% } else if ("invalid".equals(request.getParameter("error"))) { %>
            <p class="error">Please check your details and try again.</p>
        <% } %>

        <form action="<%= request.getContextPath() %>/signup"
              method="post">

            <label for="userName">Full Name</label>
            <input type="text" id="userName" name="userName"
                   placeholder="Enter your full name" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email"
                   placeholder="Enter your email" required>

            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone"
                   pattern="[0-9]{10}"
                   placeholder="Enter 10-digit phone number" required>

            <label for="address">Address</label>
            <textarea id="address" name="address"
                      placeholder="Enter your address"
                      rows="3" required></textarea>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   minlength="8" placeholder="Minimum 8 characters"
                   required>

            <button type="submit">Create Account</button>
        </form>

        <p class="login-link">
            Already have an account?
            <a href="<%= request.getContextPath() %>/Login.jsp">Login</a>
        </p>
    </div>
</div>

</body>
</html>