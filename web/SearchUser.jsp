<%@ page import="classes.User" %>
<%@ page import="classes.Dbd" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 17.10.2019
  Time: 19:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search user</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/MyWallets.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="heading">
    <h1>Search user</h1>
    <a href="${pageContext.request.contextPath}/welcome">[back]</a>
</div>
<div class="filters">
    <form action="SearchUserServlet">
        <label for="id">Id:</label>
        <input type="number" name="id" id="id">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name">
        <input type="submit" value="Пошук">
    </form>
</div>
<div class="users">

    <%
        ArrayList<String> vU = (ArrayList)session.getAttribute("validUsers");//Here is only ArrayList possible
        for(String u: vU){
            out.println("<p>" + u + "</p>");
        }


    %>

</div>
</body>
</html>
