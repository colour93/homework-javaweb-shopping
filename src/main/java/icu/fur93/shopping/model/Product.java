package icu.fur93.shopping.model;

import java.math.BigDecimal;

public class Product {
    public int id;
    public String category;
    public String name;
    public String description;
    public BigDecimal price;
    public String cover;

    public Product(int id, String category, String name, String description, BigDecimal price, String cover) {
        this.id = id;
        this.category = category;
        this.name = name;
        this.description = description;
        this.price = price;
        this.cover = cover;
    }
}
