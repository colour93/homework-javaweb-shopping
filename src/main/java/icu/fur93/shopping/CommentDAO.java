package icu.fur93.shopping;

import icu.fur93.shopping.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CommentDAO {
    public static List<Comment> getCommentsByProductId(int productId) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement("SELECT u.*, c.* FROM comments c JOIN users u ON c.user_id = u.id  WHERE c.product_id = ? ORDER BY c.date DESC;");
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();
            return covertResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean addComment(int userId, int productId, String content, Date date) {
        try {
            Connection conn = DBUtil.getConnection();

            java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());

            PreparedStatement stmt = conn.prepareStatement("INSERT INTO `comments` (`user_id`, `product_id`, `content`, `date`) VALUES (?, ?, ?, ?)");
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setString(3, content);
            stmt.setTimestamp(4, timestamp);

            // 通过影响行数判断执行成功失败
            int rowsAffected = stmt.executeUpdate();
            return (rowsAffected != 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 将 ORM 部分抽象出来
    static List<Comment> covertResultSet(ResultSet rs) throws SQLException {
        List<Comment> productList = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("c.id");
            String content = rs.getString("c.content");
            int userId = rs.getInt("c.user_id");
            String username = rs.getString("u.username");
            int productId = rs.getInt("c.product_id");
            Date date = rs.getTimestamp("c.date");
            Comment comment = new Comment(id, content, userId, username, productId, date);
            productList.add(comment);
        }
        return productList;
    }
}
