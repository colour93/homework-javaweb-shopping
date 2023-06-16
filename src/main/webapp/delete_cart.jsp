<%@ page import="icu.fur93.shopping.CartDAO" %><%--
  Created by IntelliJ IDEA.
  User: colour93
  Date: 2023/6/16
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>


<%
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    int cartId = Integer.parseInt(request.getParameter("cartId"));

    CartDAO.deleteCartItem(cartId);
  }
%>
