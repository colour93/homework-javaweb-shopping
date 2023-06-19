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

    /**
     * 获取指定用户的购物车中的所有商品
     * @param userId 用户ID
     * @return 购物车中的商品列表
     */
    public static List<Cart> getAllCartItems(int userId) {
        try {
            Connection conn = DBUtil.getConnection();

            // 查询用户购物车中的商品信息
            PreparedStatement stmt = conn.prepareStatement("SELECT p.*, c.* FROM carts c JOIN products p ON c.product_id = p.id  WHERE c.user_id = ? ORDER BY c.id DESC;");
            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();
            return convertResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 向购物车中添加商品
     * @param userId 用户ID
     * @param productId 商品ID
     */
    public static void addCartItem(int userId, int productId) {
        try {
            Connection conn = DBUtil.getConnection();

            // 向购物车中插入商品
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO `carts` (`user_id`, `product_id`) VALUES (?, ?)");
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);

            // 执行插入操作
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除购物车中的商品
     * @param cartId 购物车项ID
     */
    public static void deleteCartItem(int cartId) {
        try {
            Connection conn = DBUtil.getConnection();

            // 删除购物车中的商品
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM carts WHERE id = ?");
            stmt.setInt(1, cartId);

            // 执行删除操作
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 将ResultSet转换为商品列表
     * @param rs ResultSet对象
     * @return 商品列表
     * @throws SQLException
     */
    static List<Cart> convertResultSet(ResultSet rs) throws SQLException {
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
