<%@ page import="icu.fur93.shopping.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="icu.fur93.shopping.ProductDAO" %>
<%@ page import="icu.fur93.shopping.CartDAO" %>
<%@ page import="icu.fur93.shopping.model.Cart" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="header.jsp" %>

<%@ include file="appbar.jsp" %>

<div class="mdui-container">
    <div class="mdui-row">
        <%
            // 从 query 获取 category
            String category = request.getParameter("category");

            // 获取 category 对应 products
            List<Product> productList = ProductDAO.getAllProducts(category);
            if (productList != null) {
                for (Product product : productList) {
        %>
        <div class="mdui-col-xs-6 mdui-col-sm-4 mdui-col-md-3">
            <div class="mdui-card products-item">
                <div class="mdui-card-media">
                    <img src="<%= product.cover == null ? "https://cdn.w3cbus.com/mdui/docs~1/static/1ca4b7b2b4b2f2352aeb.jpg" : product.cover %>"/>
                    <div class="mdui-card-media-covered">
                        <div class="mdui-card-primary">
                            <div class="mdui-card-primary-title"><%= product.name %>
                            </div>
                            <div class="mdui-card-primary-subtitle">￥<%= String.format("%.2f", product.price) %>
                                [<%= product.category %>]
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mdui-card-content">
                    <%= product.description == null ? "这里没有简介" : product.description %>
                </div>
                <div class="mdui-card-actions">
                    <a href="comment.jsp?id=<%= product.id %>" class="mdui-btn mdui-ripple">查看详情</a>
                    <button class="mdui-btn mdui-btn-icon mdui-color-theme-accent mdui-ripple" onclick="addCart(<%= product.id %>)">
                        <i class="mdui-icon material-icons">add_shopping_cart</i>
                    </button>
                </div>
            </div>
        </div>

        <%
                }
            }
        %>
    </div>

    <div class="mdui-container mdui-color-blue-grey-50 mdui-shadow-12" id="sidebar">

        <%
            if (userIdObj != null) {
                int userId = Integer.parseInt(userIdObj.toString());
                List<Cart> cartList = CartDAO.getAllCartItems(userId);
                if (cartList != null) {
                    for (Cart cart : cartList) {
        %>

        <div class="mdui-color-blue-grey-100 mdui-shadow-1 cart-item">
            <img src="<%= cart.product.cover == null ? "https://cdn.w3cbus.com/mdui/docs~1/static/1ca4b7b2b4b2f2352aeb.jpg" : cart.product.cover %>"
                 alt=""
                 class="cart-item-cover"/>
            <div class="cart-item-content">
                <div class="cart-item-title"><%= cart.product.name %>
                </div>
                <div class="cart-item-subtitle">￥<%= String.format("%.2f", cart.product.price) %>
                </div>
            </div>
            <button class="cart-item-btn mdui-btn mdui-btn-icon" onclick="deleteCart(<%= cart.id %>)">
                <i class="mdui-icon material-icons">remove</i>
            </button>
        </div>

        <%
                    }
                }
            }
        %>

    </div>
    <button class="mdui-fab mdui-color-theme-accent mdui-fab-fixed mdui-ripple"
            onclick="sidebarStatus.value = !sidebarStatus.value">
        <i class="mdui-icon material-icons" id="sidebar-icon">arrow_back</i>
    </button>
</div>
<%@ include file="scripts_import.jsp" %>
<script>

    // sidebar 状态变更
    let sidebarStatusHandler = {
        set: function (target, key, value) {
            if (sidebarStatus.value) {
                document.getElementById("sidebar").style.right = '-300px';
                document.getElementById("sidebar-icon").innerText = 'arrow_back';
            } else {
                document.getElementById("sidebar").style.right = '0';
                document.getElementById("sidebar-icon").innerText = 'arrow_forward';
            }
            target[key] = value;
            return true;
        }
    };

    // 使用 Proxy 对变量进行侦听
    let sidebarStatus = new Proxy({
        value: false
    }, sidebarStatusHandler);

    async function addCart(productId) {

        const params = new URLSearchParams();
        params.append('productId', productId);

        await axios.post('add_cart.jsp', params.toString(), {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })

        window.location.reload();

    }

    async function deleteCart(cartId) {

        const params = new URLSearchParams();
        params.append('cartId', cartId);

        await axios.post('delete_cart.jsp', params.toString(), {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })

        window.location.reload();

    }
</script>
<%@ include file="footer.jsp" %>