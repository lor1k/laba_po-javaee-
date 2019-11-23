<%@ page import="classes.Wallet" %>
<%@ page import="classes.User" %>
<%@ page import="classes.Dbd" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 17.10.2019
  Time: 20:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search Wallets</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/MyWallets.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="heading">
    <h1>Search wallets</h1>
    <a href="${pageContext.request.contextPath}/welcome">[back]</a>
</div>
<div class="filters">
    <form action="SearchWalletsServlet">
        <input type="number" name="id" id="id" placeholder="ID"><label for="id"></label>
        <p> with balance (0 to disable)</p>
        <div class="radios">
            <span><input type="radio" name="more" id="less" value="1"><label for="less">less</label></span>
            <span><input type="radio" name="more" id="more" value="2"><label for="more">more</label></span>
        </div>
        <p>than</p>
        <input type="number" name="bal" id="bal"><label for="bal"></label><label for="currency">Currency: </label>
        <input type="text" name="currency" id="currency" placeholder="CURRENCY">
        <input type="submit" value="Apply">
    </form>
</div>
<div class="wallets">
<%
   ArrayList<String> vW = (ArrayList)session.getAttribute("allValidWallets");//NE NUJNO WARNINGOV!
    for (String w: vW){
        out.println(w);
    }

%>
</body>
</html>
