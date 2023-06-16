package icu.fur93.shopping;

import icu.fur93.shopping.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public static User login(String username, String password) {
        try {

            Connection conn = DBUtil.getConnection();

            // 使用 prepare statement 来避免注入
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `password` = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            List<User> userList = covertResultSet(rs);

            // 如果列表没有数据，那就说明用户名密码不匹配
            if (userList.size() == 0) return null;
            else return userList.get(0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static User register(String username, String password) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement("INSERT INTO `users` (`username`, `password`) VALUES (?, ?)");
            stmt.setString(1, username);
            stmt.setString(2, password);

            // 通过影响行数判断执行成功失败
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) return null;

            PreparedStatement stmt1 = conn.prepareStatement("SELECT * FROM `users` WHERE `username` = ?");
            stmt1.setString(1, username);

            ResultSet rs = stmt1.executeQuery();
            List<User> userList = covertResultSet(rs);

            // 如果列表没有数据，那就说明用户不存在
            if (userList.size() == 0) return null;
            else return userList.get(0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static User getUserById(int userId) {
        try {

            Connection conn = DBUtil.getConnection();

            // 使用 prepare statement 来避免注入
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `users` WHERE `id` = ?");
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            List<User> userList = covertResultSet(rs);

            // 如果列表没有数据，那就说明用户不存在
            if (userList.size() == 0) return null;
            else return userList.get(0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 将 ORM 部分抽象出来
    static List<User> covertResultSet(ResultSet rs) throws SQLException {
        List<User> userList = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String password = rs.getString("password");
            User user = new User(id, username, password);
            userList.add(user);
        }
        return userList;
    }
}
