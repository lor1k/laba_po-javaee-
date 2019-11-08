<%@ page import="classes.User" %>
<%@ page import="classes.Dbd" %><%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 25.10.2019
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User current_user = (User)session.getAttribute("current_user");
    if(current_user == null){
        response.sendRedirect("/Lab22EE_war_exploded/welcome");
    }
    if(current_user.isAdmin != 1){
        response.sendRedirect("/Lab22EE_war_exploded/main");
    }

%>

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
<form action="">
    <label for="wallet">Wallet:</label>
    <input type="number" name="wallet" id="wallet">
    <label for="amount">Amount:</label>
    <input type="number" name="amount" id="amount">
    <input type="submit" value="Add">
</form>
<%
    Dbd dbd = new Dbd();

    Integer wallet_id = null;
    Integer amount = null;
    dbd.connect();

    try {
        wallet_id = Integer.parseInt(request.getParameter("wallet"));
        amount = Integer.parseInt(request.getParameter("amount"));
    } catch (Exception e){
        System.out.println(e.getMessage());
    }
    System.out.println(wallet_id + " : " + amount);//
    if(wallet_id != null && amount != null){
        System.out.println("Result add code: " + dbd.addMoney(wallet_id, amount));

    } else {
        System.out.println("NUL BLYA!");
    }
%>

</body>
</html>
