
package com.tap.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tap.DAO.MenuDAO;
import com.tab.model.Menu;
import com.tap.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public void addMenu(Menu menu) {
        String sql = "INSERT INTO menu "
                + "(restaurantId, itemName, description, price, "
                + "isAvailable, imagePath) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, menu.getRestaurantId());
                ps.setString(2, menu.getItemName());
                ps.setString(3, menu.getDescription());
                ps.setDouble(4, menu.getPrice());
                ps.setBoolean(5, menu.isAvailable());
                ps.setString(6, menu.getImagePath());

                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {
        String sql = "SELECT * FROM menu WHERE menuId = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, menuId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return mapMenu(rs);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Menu> getAllMenus() {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM menu";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                menus.add(mapMenu(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menus;
    }

    @Override
    public List<Menu> getMenusByRestaurantId(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM menu "
                + "WHERE restaurantId = ? AND isAvailable = TRUE";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, restaurantId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        menus.add(mapMenu(rs));
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return menus;
    }

    @Override
    public void updateMenu(Menu menu) {
        String sql = "UPDATE menu SET restaurantId = ?, itemName = ?, "
                + "description = ?, price = ?, isAvailable = ?, "
                + "imagePath = ? WHERE menuId = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, menu.getRestaurantId());
                ps.setString(2, menu.getItemName());
                ps.setString(3, menu.getDescription());
                ps.setDouble(4, menu.getPrice());
                ps.setBoolean(5, menu.isAvailable());
                ps.setString(6, menu.getImagePath());
                ps.setInt(7, menu.getMenuId());

                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {
        String sql = "DELETE FROM menu WHERE menuId = ?";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, menuId);
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Menu mapMenu(ResultSet rs) throws SQLException {
        Menu menu = new Menu();

        menu.setMenuId(rs.getInt("menuId"));
        menu.setRestaurantId(rs.getInt("restaurantId"));
        menu.setItemName(rs.getString("itemName"));
        menu.setDescription(rs.getString("description"));
        menu.setPrice(rs.getDouble("price"));
        menu.setAvailable(rs.getBoolean("isAvailable"));
        menu.setImagePath(rs.getString("imagePath"));

        return menu;
    }
}

