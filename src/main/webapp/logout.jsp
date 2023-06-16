<%--
  Created by IntelliJ IDEA.
  User: colour93
  Date: 2023/6/16
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="header.jsp"%>

<%

  session.setAttribute("userId", null);

%>

<%@ include file="scripts_import.jsp"%>

<script>

  mdui.snackbar("登出成功", {
    onClosed: () => {
      window.location.href = "index.jsp"
    }
  })

</script>

<%@ include file="footer.jsp"%>
