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

    /**
     * 获取指定商品的评论列表
     * @param productId 商品ID
     * @return 评论列表
     */
    public static List<Comment> getCommentsByProductId(int productId) {
        try {
            Connection conn = DBUtil.getConnection();

            // 查询指定商品的评论信息
            PreparedStatement stmt = conn.prepareStatement("SELECT u.*, c.* FROM comments c JOIN users u ON c.user_id = u.id  WHERE c.product_id = ? ORDER BY c.date DESC;");
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();
            return convertResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 添加评论
     * @param userId 用户ID
     * @param productId 商品ID
     * @param content 评论内容
     * @param date 评论日期
     * @return 添加是否成功
     */
    public static boolean addComment(int userId, int productId, String content, Date date) {
        try {
            Connection conn = DBUtil.getConnection();

            java.sql.Timestamp timestamp = new java.sql.Timestamp(date.getTime());

            // 向评论表中插入评论
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO `comments` (`user_id`, `product_id`, `content`, `date`) VALUES (?, ?, ?, ?)");
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setString(3, content);
            stmt.setTimestamp(4, timestamp);

            // 执行插入操作
            int rowsAffected = stmt.executeUpdate();
            return (rowsAffected != 0);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 将ResultSet转换为评论列表
     * @param rs ResultSet对象
     * @return 评论列表
     * @throws SQLException
     */
    static List<Comment> convertResultSet(ResultSet rs) throws SQLException {
        List<Comment> commentList = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("c.id");
            String content = rs.getString("c.content");
            int userId = rs.getInt("c.user_id");
            String username = rs.getString("u.username");
            int productId = rs.getInt("c.product_id");
            Date date = rs.getTimestamp("c.date");
            Comment comment = new Comment(id, content, userId, username, productId, date);
            commentList.add(comment);
        }
        return commentList;
    }
}
