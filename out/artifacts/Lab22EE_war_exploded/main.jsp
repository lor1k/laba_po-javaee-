<%@ page import="classes.User" %><%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 16.10.2019
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Success!</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/main.css">
</head>
<%
    User current_user = (User)session.getAttribute("current_user");
    if(current_user == null){
        response.sendRedirect("/Lab22EE_war_exploded/welcome");
    }
    System.out.println(current_user.login + " : " + current_user.isAdmin);
%>
<body>
<jsp:include page="header.jsp"/>
<h1><%=(User)session.getAttribute("current_user")%></h1>

<nav>
    <ul>
        <%=current_user.isAdmin == 1 ? "<li><a class='admin_panel' href='/Lab22EE_war_exploded/admin_panel'><p>Admin Panel</p></a></li>": ""%>
        <li><a href="${pageContext.request.contextPath}/my_wallets"><p>My wallets</p></a></li>
        <li><a href="${pageContext.request.contextPath}/search_user"><p>Search user</p></a></li>
        <li><a href="${pageContext.request.contextPath}/search_wallets"><p>Search wallets</p></a></li>
        <li><a href="${pageContext.request.contextPath}/send"><p>Send</p></a></li>
        <li><a href="${pageContext.request.contextPath}/logout"><p>Log out</p></a></li>
    </ul>
</nav>
</body>
</html>
