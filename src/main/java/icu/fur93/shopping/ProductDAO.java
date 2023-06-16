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
    public static List<Product> getAllProducts(String category) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement(category == null ? "SELECT * FROM `products`" : "SELECT * FROM `products` WHERE `category` = ?");
            if (category != null) stmt.setString(1, category);

            ResultSet rs = stmt.executeQuery();
            return covertResultSet(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Product getProductById(int productId) {
        try {
            Connection conn = DBUtil.getConnection();

            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `products` WHERE `id` = ?");
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();
            return covertResultSet(rs).get(0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 将 ORM 部分抽象出来
    static List<Product> covertResultSet(ResultSet rs) throws SQLException {
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
