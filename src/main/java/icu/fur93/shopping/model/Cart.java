package icu.fur93.shopping.model;

public class Cart {
    public int id;
    public int product_id;
    public Product product;
    public int user_id;
    public Cart(int id, int product_id, Product product, int user_id) {
        this.id = id;
        this.product_id = product_id;
        this.product = product;
        this.user_id = user_id;
    }
}
