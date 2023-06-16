<%@ page import="icu.fur93.shopping.UserDAO" %>
<%@ page import="icu.fur93.shopping.model.User" %><%--
  Created by IntelliJ IDEA.
  User: colour93
  Date: 2023/6/16
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="mdui-appbar mdui-appbar-scroll-hide">
  <div class="mdui-toolbar mdui-color-theme">
    <i class="mdui-icon material-icons">shopping_basket</i>
    <div class="mdui-typo-headline">Shopping</div>
    <div class="mdui-toolbar-spacer"></div>

    <%
      Object userIdObj = session.getAttribute("userId");

      if (userIdObj == null) {
        out.print("<div class=\"mdui-typo-title\">未登录</div>");
        out.print("<a href=\"login.jsp\" class=\"mdui-btn mdui-btn-icon\"><i class=\"mdui-icon material-icons\">account_circle</i></a>");
      } else {
        int userId = Integer.parseInt(userIdObj.toString());
        User user = UserDAO.getUserById(userId);
        out.print("<div class=\"mdui-typo-title\">" + user.username + "</div>");
        out.print("<a href=\"logout.jsp\" class=\"mdui-btn mdui-btn-icon\"><i class=\"mdui-icon material-icons\">exit_to_app</i></a>");
      }

    %>
  </div>
  <div class="mdui-tab mdui-color-theme">
    <a href="index.jsp" class="mdui-ripple mdui-ripple-white">
      <i class="mdui-icon material-icons">home</i>
      <label>主页</label>
    </a>
    <a href="index.jsp?category=book" class="mdui-ripple mdui-ripple-white">
      <i class="mdui-icon material-icons">library_books</i>
      <label>书籍</label>
    </a>
    <a href="index.jsp?category=food" class="mdui-ripple mdui-ripple-white">
      <i class="mdui-icon material-icons">restaurant_menu</i>
      <label>食物</label>
    </a>
  </div>
</div>