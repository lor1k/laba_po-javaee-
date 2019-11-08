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
    <form action="">
        <label for="id">Id:</label>
        <input type="number" name="id" id="id">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name">
        <input type="submit" value="Пошук">
    </form>
</div>
<div class="users">

    <%
        User current_user = (User)session.getAttribute("current_user");
        if(current_user == null){
            response.sendRedirect("/Lab22EE_war_exploded/welcome");
        }
        boolean valid;
        Dbd dbd = new Dbd();
        dbd.connect();
        ArrayList<User> users = dbd.getUsers();

        Integer id = null;
        String name = null;
        try{
            id = Integer.parseInt(request.getParameter("id"));
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        try{
            name = request.getParameter("name").toUpperCase();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }


        for (User u :
                users) {
            if(u.user_id == current_user.user_id){
                continue;
            }
            valid = true;
            if(id != null){
                if(id != u.user_id){
                    valid = false;
                }
            }
            if(name != null){
                if(!name.equals(u.toString().toUpperCase())){
                    valid = false;
                }
            }
            if(valid){
                out.write("<p>" + u.user_id + " " + u.toString() + "</p>");
            }
        }


    %>

</div>
</body>
</html>
<%
    dbd.close();
%>