<%@ page import="icu.fur93.shopping.UserDAO" %>
<%@ page import="icu.fur93.shopping.model.User" %><%--
  Created by IntelliJ IDEA.
  User: colour93
  Date: 2023/6/16
  Time: 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<div class="login-content">

    <div class="mdui-shadow-12 login-box">

        <form method="post">

            <div class="mdui-textfield">
                <i class="mdui-icon material-icons">account_circle</i>
                <label class="mdui-textfield-label">用户名</label>
                <input class="mdui-textfield-input" type="text" name="username" />
            </div>

            <div class="mdui-textfield">
                <i class="mdui-icon material-icons">lock</i>
                <label class="mdui-textfield-label">密码</label>
                <input class="mdui-textfield-input" type="password" name="password" />
            </div>

            <a class="mdui-btn mdui-btn-raised mdui-btn-block" href="login.jsp" style="margin-top: 20px;">登录</a>

            <input class="mdui-btn mdui-btn-raised mdui-btn-block mdui-color-theme-accent" type="submit" value="注册"
                   style="margin-top: 20px;" />

        </form>

    </div>

</div>

<%@ include file="scripts_import.jsp"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = UserDAO.register(username, password);

        if (user != null) {
            session.setAttribute("userId", user.id);
            out.print("<script>mdui.snackbar(\"注册成功\", { onClosed: () => { window.location.href = \"index.jsp\" } })</script>");
        } else {
            out.print("<script>mdui.snackbar(\"注册失败\")</script>");
        }
    }
%>

<%@ include file="footer.jsp" %>