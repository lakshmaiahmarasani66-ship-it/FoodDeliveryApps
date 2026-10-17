package com.tap.DAO;

import com.tab.model.User;
import java.util.List;

public interface UserDAO {

    void addUser(User user);

    User getUser(int userId);

    List<User> getAllUsers();

    void updateUser(User user);

    void deleteUser(int userId);
}

