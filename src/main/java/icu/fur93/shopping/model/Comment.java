package icu.fur93.shopping.model;
import java.util.Date;

public class Comment {
    public int id;
    public String content;
    public int userId;
    public String username;
    public int productId;
    public Date date;

    public Comment(int id, String content, int userId, String username, int productId, Date date) {
        this.id = id;
        this.content = content;
        this.userId = userId;
        this.username = username;
        this.productId = productId;
        this.date = date;
    }
}
