package icu.fur93.shopping;

import icu.fur93.shopping.model.Product;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /**
     * 获取所有产品或特定类别的产品列表
     * @param category 产品类别，如果为null，则返回所有产品
     * @return 产品列表
     */
    public static List<Product> getAllProducts(String category) {
        try {
            Connection conn = DBUtil.getConnection();

            // 根据类别查询产品信息
            PreparedStatement stmt = conn.prepareStatement(category == null ? "SELECT * FROM `products`" : "SELECT * FROM `products` WHERE `category` = ?");
            if (category != null) stmt.setString(1, category);

            ResultSet rs = stmt.executeQuery();
            return convertResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 根据产品ID获取产品信息
     * @param productId 产品ID
     * @return 产品对象
     */
    public static Product getProductById(int productId) {
        try {
            Connection conn = DBUtil.getConnection();

            // 根据产品ID查询产品信息
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `products` WHERE `id` = ?");
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();
            return convertResultSet(rs).get(0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 将ResultSet转换为产品列表
     * @param rs ResultSet对象
     * @return 产品列表
     * @throws SQLException
     */
    static List<Product> convertResultSet(ResultSet rs) throws SQLException {
        List<Product> productList = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("id");
            String category = rs.getString("category");
            String name = rs.getString("name");
            String description = rs.getString("description");
            BigDecimal price = rs.getBigDecimal("price");
            String cover = rs.getString("cover");
            Product product = new Product(id, category, name, description, price, cover);
            productList.add(product);
        }
        return productList;
    }
}
