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
    <form action="">
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
    User current_user = (User)session.getAttribute("current_user");
    if(current_user == null){
        response.sendRedirect("/Lab22EE_war_exploded/welcome");
    }
    boolean valid;
    Dbd dbd = new Dbd();
    dbd.connect();
    ArrayList<Wallet> wallets = dbd.getWallets(0);
    String s;
    Integer id = null;
    Double balance = null;
    String currency = null;

    try{
        id = Integer.parseInt(request.getParameter("id"));
    }catch (Exception e){
        System.out.println(e.getMessage());
    }
    try{
        currency = request.getParameter("currency").toUpperCase();
    } catch (Exception e){
        System.out.println(e.getMessage());
    }

    String more = request.getParameter("more");
    try{
        balance = Double.parseDouble(request.getParameter("bal"));
    } catch (Exception e){
        System.out.println(e.getMessage());
    }

    for (Wallet w :
            wallets) {
    valid = true;
    s = "";
        if(id != null) {
            if (id != w.id) {
                valid = false;
            }
        }
        if(currency != null && !currency.equals("")){
            if(!currency.equals(w.currency)){
                valid = false;
                System.out.println(w.toString());
            }
        }
        if(more != null){
            if(balance != null && balance != 0){
                if(more.equals("1")){//less
                    if(!(balance>w.balance)){
                        valid = false;
                    }
                }
                if(more.equals("2")){//more
                    if(!(balance<w.balance)){
                        valid = false;
                    }
                }
            }

        }
        if(valid){
            System.out.println("w = "+ w.toString());
            System.out.println(dbd.getUser(w.getUser_id()).toString());
            s = w.id + " " + w.currency + " Owner: "
            + dbd.getUser(w.getUser_id()).toString()
            + "(id:" + w.getUser_id() + ")";
           out.println("<p>" + s + "</p>");
        }
    }



%>
</body>
</html>
<%
    dbd.close();
%>