package icu.fur93.shopping;

import icu.fur93.shopping.model.Cart;
import icu.fur93.shopping.model.Product;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public static List<Cart> getAllCartItems(int userId) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement("SELECT p.*, c.* FROM carts c JOIN products p ON c.product_id = p.id  WHERE c.user_id = ? ORDER BY c.id DESC;");
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            return covertResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void addCartItem(int userId, int productId) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement("INSERT INTO `carts` (`user_id`, `product_id`) VALUES (?, ?)");
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);

            // 通过影响行数判断执行成功失败
//            int rowsAffected = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteCartItem(int cartId) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement("DELETE FROM carts WHERE id = ?");
            stmt.setInt(1, cartId);

            // 通过影响行数判断执行成功失败
//            int rowsAffected = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    static List<Cart> covertResultSet(ResultSet rs) throws SQLException {
        List<Cart> productList = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("c.id");
            int userId = rs.getInt("c.user_id");
            int productId = rs.getInt("c.product_id");

            int pid = rs.getInt("p.id");
            String category = rs.getString("p.category");
            String name = rs.getString("p.name");
            String description = rs.getString("p.description");
            BigDecimal price = rs.getBigDecimal("p.price");
            String cover = rs.getString("p.cover");
            Product product = new Product(pid, category, name, description, price, cover);

            Cart cart = new Cart(id, productId, product, userId);
            productList.add(cart);
        }
        return productList;
    }

}
