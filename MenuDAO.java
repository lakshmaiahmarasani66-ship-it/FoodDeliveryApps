
package com.tap.DAO;

import com.tab.model.Menu;
import java.util.List;

public interface MenuDAO {

    void addMenu(Menu menu);

    Menu getMenu(int menuId);

    List<Menu> getAllMenus();

    List<Menu> getMenusByRestaurantId(int restaurantId);

    void updateMenu(Menu menu);

    void deleteMenu(int menuId);
}


