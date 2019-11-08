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
    Dbd dbd = new Dbd();
    User current_user = null;
    HttpSession s = request.getSession();
    boolean logined = false;
    current_user = (User)s.getAttribute("current_user");
    if(current_user != null) {
        response.sendRedirect("/Lab22EE_war_exploded/main");
    }
    dbd.connect();
    String login = request.getParameter("login");
    String password = request.getParameter("password");
    String reg_log = request.getParameter("reg_log");
    String reg_pass = request.getParameter("reg_pass");
    String rep_password = request.getParameter("rep_password");
    if(login!=null && password!=null && !password.equals("") && !login.equals("")){
        current_user = dbd.login(login, password);
        if(current_user != null){
            if(password.equals(current_user.getPassword())){
                s.setAttribute("current_user", current_user);
                logined = true;
            }
        }
    }
    System.out.println("rl: " + reg_log + " rp: " + reg_pass + " rp: " + rep_password);
    if(reg_log!=null && reg_pass!=null && rep_password != null && !reg_log.equals("") && !reg_pass.equals("") && !rep_password.equals("")){
        int reg_code = dbd.register(reg_log, reg_pass, rep_password);
        System.out.println("Reg_code: " + reg_code);
        if(reg_code == 1){
            current_user = dbd.getUser(login);
            s.setAttribute("current_user", current_user);
            response.sendRedirect("/Lab22EE_war_exploded/main");
        }
        if(reg_code == -1){//pass not match
            out.print("<p>Passwords doesn't match</p>");
        }
        if(reg_code == -2){
            out.print("<p>Login is occupied</p>");
        }
    }
    if(logined){

        response.sendRedirect("/Lab22EE_war_exploded/main");
    }else{
        //response.sendRedirect("/Lab22EE_war_exploded/welcome");
    }

%>
<jsp:include page="header.jsp"/>
<div class="wrapper">
    <div class="form" id="login_form">
        <p>Login</p>
        <form action="">
            <input type="text" placeholder="Login" name="login">
            <input type="password" placeholder="Password" name="password">
            <span id="to_reg">I don't have an account</span>
            <input type="submit" value="Ввійти">
        </form>
    </div>
    <div class="form hidden" id="registration_form">
        <p>Registration</p>
        <form action="">
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
<%
    dbd.close();
%>