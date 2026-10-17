
package com.tap.DAO;

import com.tab.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {

    void addOrderItem(OrderItem orderItem);

    OrderItem getOrderItem(int orderItemId);

    List<OrderItem> getAllOrderItems();
    
    List<OrderItem> getOrderItemsByOrderId(int orderId);

    void updateOrderItem(OrderItem orderItem);

    void deleteOrderItem(int orderItemId);
}

