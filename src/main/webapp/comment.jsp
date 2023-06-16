<%@ page import="icu.fur93.shopping.model.Product" %>
<%@ page import="icu.fur93.shopping.ProductDAO" %>
<%@ page import="icu.fur93.shopping.model.Comment" %>
<%@ page import="java.util.List" %>
<%@ page import="icu.fur93.shopping.CommentDAO" %>
<%@ page import="icu.fur93.shopping.model.User" %>
<%@ page import="icu.fur93.shopping.UserDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: colour93
  Date: 2023/6/15
  Time: 18:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="header.jsp"%>

<div class="mdui-appbar mdui-appbar-scroll-hide">
    <div class="mdui-toolbar mdui-color-theme">
        <a href="index.jsp" class="mdui-btn mdui-btn-icon">
            <i class="mdui-icon material-icons">home</i>
        </a>
        <div class="mdui-typo-headline">Shopping</div>
    </div>
</div>

<div class="mdui-container">

    <%

        // 判断是否登录
        Object userIdObj = session.getAttribute("userId");
        // 从 query 获取 id
        String idStr = request.getParameter("id");

        if (idStr == null || userIdObj == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        User user = UserDAO.getUserById(Integer.parseInt(userIdObj.toString()));
        int id = Integer.parseInt(idStr);

        Product product = ProductDAO.getProductById(id);
        List<Comment> commentList = CommentDAO.getCommentsByProductId(id);

    %>

    <div class="comment-product">

        <img class="comment-product-image" src="<%= product.cover == null ? "https://cdn.w3cbus.com/mdui/docs~1/static/1ca4b7b2b4b2f2352aeb.jpg" : product.cover %>"/>

        <div class="comment-product-info">

            <div class="comment-product-info-title"><%= product.name %></div>

            <div class="comment-product-info-subtitle">￥<%= product.price %> [<%= product.category %>]</div>

            <div class="comment-product-info-desc"><%= product.description == null ? "这里没有简介" : product.description %></div>

        </div>

    </div>

    <form method="post" class="comment-sender">

        <div class="mdui-textfield">
            <textarea class="mdui-textfield-input" rows="3" placeholder="在此处输入评论……" name="content"></textarea>
        </div>

        <div class="comment-sender-bottom">

            <div class="mdui-chip">
                <span class="mdui-chip-title"><%= user.username %></span>
            </div>

            <input type="submit" class="mdui-btn mdui-btn-raised mdui-color-theme-accent" value="发送">


        </div>


    </form>

    <div class="comment-list">

        <%
            if (commentList != null) {
                for (Comment comment : commentList) {
            %>

            <div class="comment-item">

                <div class="comment-item-sender">

                    <div class="comment-item-author mdui-chip"><span class="mdui-chip-title"><%= comment.username %></span></div>

                    <div class="comment-item-timestamp mdui-chip"><span class="mdui-chip-title"><%= comment.date.toString() %></span></div>

                </div>


                <div class="comment-item-content"><%= comment.content %></div>

            </div>

            <%
                }
            }
        %>

    </div>


</div>

<%@ include file="scripts_import.jsp"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int userId = Integer.parseInt(userIdObj.toString());
        String content = request.getParameter("content");
        Date date = new Date();

        if (CommentDAO.addComment(userId, product.id, content, date)) {
            // 这里刷新
            out.print("<script>mdui.snackbar(\"评论成功\", { onClosed: () => { window.location.href = window.location.pathname + window.location.search } })</script>");
        } else {
            out.print("<script>mdui.snackbar(\"评论失败\")</script>");
        }
    }
%>

<%@ include file="footer.jsp"%>