
package com.tap.DAO;

import com.tab.model.Order;
import java.util.List;

public interface OrderDAO {

    void addOrder(Order order);

    Order getOrder(int orderId);

    List<Order> getAllOrders();
    
    List<Order> getOrdersByUserId(int userId);

    void updateOrder(Order order);

    void deleteOrder(int orderId);
}

