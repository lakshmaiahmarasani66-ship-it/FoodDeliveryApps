
package com.tap.Controllers;

import java.io.IOException;
import java.util.List;

import com.tab.model.User;
import com.tab.model.Restaurant;
import com.tap.DAOImpl.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin-dashboard")
public class AdminDashboardController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user.getRole() == null ||
            !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Admin access required"
            );
            return;
        }

        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();

        request.setAttribute(
            "restaurantCount",
            restaurants == null ? 0 : restaurants.size()
        );

        request.getRequestDispatcher("/AdminDashboard.jsp")
               .forward(request, response);
    }
}
