<%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 15.10.2019
  Time: 22:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="classes.Dbd" %>
<%@ page import="classes.User" %>
<%@ page import="java.net.http.HttpClient" %>
<html>
<head>
    <title>Welcome</title>
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>
<%
    Integer reg_code = (Integer)session.getAttribute("reg_code");

//        if(reg_code == -1){//pass not match
//            out.print("<p>Passwords doesn't match</p>");
//        }
//        if(reg_code == -2){
//            out.print("<p>Login is occupied</p>");
//        }

%>
<jsp:include page="header.jsp"/>
<div class="wrapper">
    <div class="form" id="login_form">
        <p>Login</p>
        <form action="welcomeServlet">
            <input type="text" placeholder="Login" name="login">
            <input type="password" placeholder="Password" name="password">
            <span id="to_reg">I don't have an account</span>
            <input type="submit" value="Ввійти">
        </form>
    </div>
    <div class="form hidden" id="registration_form">
        <p>Registration</p>
        <form action="welcomeServlet">
            <input type="text" placeholder="Login" name="reg_log">
            <input type="password" placeholder="Password" name="reg_pass" >
            <input type="password" placeholder="Repeat password" name="rep_password">
            <span id="to_log">I already have an account</span>
            <input type="submit" value="Ввійти">
        </form>
    </div>

</div>
<script>
    var to_reg = document.querySelector("#to_reg");
    var to_log = document.querySelector("#to_log");
    var reg_form = document.querySelector("#registration_form");
    var log_form = document.querySelector("#login_form");

    to_reg.onclick = function (event){
        log_form.classList.add("hidden");
        reg_form.classList.remove("hidden");
    };
    to_log.onclick = function (event){
        reg_form.classList.add("hidden");
        log_form.classList.remove("hidden");
    };
</script>
</body>
</html>