
package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tab.model.Restaurant;
import com.tap.utility.DBConnection;
import com.tap.DAO.RestaurantDAO;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public void addRestaurant(Restaurant restaurant) {
        String sql = "INSERT INTO restaurant "
                + "(name, deliveryTime, address, adminUserId, rating, "
                + "isActive, imagePath, cuisineType) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, restaurant.getName());
                ps.setString(2, restaurant.getDeliveryTime());
                ps.setString(3, restaurant.getAddress());
                ps.setInt(4, restaurant.getAdminUserId());
                ps.setDouble(5, restaurant.getRating());
                ps.setBoolean(6, restaurant.isActive());
                ps.setString(7, restaurant.getImagePath());
                ps.setString(8, restaurant.getCuisineType());

                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        String sql = "SELECT * FROM restaurant WHERE restaurantId = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, restaurantId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return mapRestaurant(rs);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurant";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    restaurants.add(mapRestaurant(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return restaurants;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {
        String sql = "UPDATE restaurant SET name = ?, deliveryTime = ?, "
                + "address = ?, adminUserId = ?, rating = ?, "
                + "isActive = ?, imagePath = ?, cuisineType = ? "
                + "WHERE restaurantId = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, restaurant.getName());
                ps.setString(2, restaurant.getDeliveryTime());
                ps.setString(3, restaurant.getAddress());
                ps.setInt(4, restaurant.getAdminUserId());
                ps.setDouble(5, restaurant.getRating());
                ps.setBoolean(6, restaurant.isActive());
                ps.setString(7, restaurant.getImagePath());
                ps.setString(8, restaurant.getCuisineType());
                ps.setInt(9, restaurant.getRestaurantId());

                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {
        String sql = "DELETE FROM restaurant WHERE restaurantId = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, restaurantId);
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Restaurant mapRestaurant(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();

        restaurant.setRestaurantId(rs.getInt("restaurantId"));
        restaurant.setName(rs.getString("name"));
        restaurant.setDeliveryTime(rs.getString("deliveryTime"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setAdminUserId(rs.getInt("adminUserId"));
        restaurant.setRating(rs.getDouble("rating"));
        restaurant.setActive(rs.getBoolean("isActive"));
        restaurant.setImagePath(rs.getString("imagePath"));
        restaurant.setCuisineType(rs.getString("cuisineType"));

        return restaurant;
    }
}
