package icu.fur93.shopping;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
    private static final String CONFIG_FILE = "database.properties";

    /**
     * 获取数据库连接
     * @return 数据库连接对象
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        Properties properties = loadProperties();
        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * 加载数据库配置文件
     * @return 包含数据库配置的Properties对象
     */
    private static Properties loadProperties() {
        Properties properties = new Properties();
        try (InputStream input = DBUtil.class.getClassLoader().getResourceAsStream(CONFIG_FILE)) {
            properties.load(input);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return properties;
    }
}
