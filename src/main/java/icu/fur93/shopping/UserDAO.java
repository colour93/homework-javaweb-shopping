package icu.fur93.shopping;

import icu.fur93.shopping.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    /**
     * 用户登录验证
     * @param username 用户名
     * @param password 密码
     * @return 验证成功返回用户对象，验证失败返回null
     */
    public static User login(String username, String password) {
        try {
            Connection conn = DBUtil.getConnection();

            // 使用 prepare statement 来避免注入
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `users` WHERE `username` = ? AND `password` = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            List<User> userList = convertResultSet(rs);

            // 如果列表没有数据，那就说明用户名密码不匹配
            if (userList.size() == 0) return null;
            else return userList.get(0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 用户注册
     * @param username 用户名
     * @param password 密码
     * @return 注册成功返回用户对象，注册失败返回null
     */
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
            List<User> userList = convertResultSet(rs);

            // 如果列表没有数据，那就说明用户不存在
            if (userList.size() == 0) return null;
            else return userList.get(0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据用户ID获取用户信息
     * @param userId 用户ID
     * @return 用户对象，如果用户不存在则返回null
     */
    public static User getUserById(int userId) {
        try {
            Connection conn = DBUtil.getConnection();

            // 使用 prepare statement 来避免注入
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `users` WHERE `id` = ?");
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            List<User> userList = convertResultSet(rs);

            // 如果列表没有数据，那就说明用户不存在
            if (userList.size() == 0) return null;
            else return userList.get(0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将ResultSet转换为用户列表
     * @param rs ResultSet对象
     * @return 用户列表
     * @throws SQLException
     */
    static List<User> convertResultSet(ResultSet rs) throws SQLException {
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
