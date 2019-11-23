<%@ page import="classes.User" %>
<%@ page import="classes.Dbd" %><%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 25.10.2019
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Admin Panel</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/MyWallets.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<h1>Admin panel</h1><a href="${pageContext.request.contextPath}/welcome">[back]</a>
<h1>Add money</h1>
<hr>
<form action="adminPanelServlet">
    <label for="wallet">Wallet:</label>
    <input type="number" name="wallet" id="wallet">
    <label for="amount">Amount:</label>
    <input type="number" name="amount" id="amount">
    <input type="submit" value="Add">
</form>
</body>
</html>
