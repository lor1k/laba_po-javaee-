<%@ page import="classes.Dbd" %>
<%@ page import="classes.User" %>
<%@ page import="classes.Wallet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/MyWallets.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="heading">
    <h1>Your wallets</h1><a href="${pageContext.request.contextPath}/welcome">[back]</a>
</div>
<div class="filters">
    <form action="MyWalletServlet">
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
    ArrayList<String> vW = (ArrayList<String>)session.getAttribute("validWallets");//Корме как ArrayList<String> нут ничего быть не может
    for (String s: vW){
        out.println("<p>" + s + "</p>");
    }



%>

</div>

<aside>
    <div class="actions">
        <button class="delete" id="del_but">Delete wallet</button>
        <button class="create" id="create_but">Create new wallet</button>
    </div>
    <%
        Integer del_res = (Integer)session.getAttribute("del_res");
        Integer cre_res = (Integer)session.getAttribute("cre_res");
        if(del_res != 0){
            if(del_res == -3){
                out.print("<p class = 'error_p'>Wallet is not empty</p>");
            }
            if(del_res == -2){
                out.print("<p class = 'error_p'>Wallet doesn't belong to you</p>");
            }
            if(del_res == -1){
                out.print("<p class = 'error_p'>Wallet doesn't exist</p>");
            }
            if(del_res == 1){
                out.print("<p class = 'success_p'>Deleted!</p>");
            }
        }
        if(cre_res != 0){
            if(cre_res == -1){
                out.print("<p class = 'error_p'>Undefined currency</p>");
            }
            if(cre_res == 1){
                out.print("<p class = 'success_p'>Created!</p>");
            }
        }
    %>
    <div class="delete_bar hidden">
        <form action="MyWalletServlet">
            <input type="number" id="delete_id" name="delete_id" class="input" placeholder="id">
            <input type="submit" class="delete" value="Delete">
        </form>
    </div>
    <div class="create_bar hidden">
        <form action="MyWalletServlet">
            <input type="text" id="currency_id" name="currency_id" class="input" placeholder="currency">
            <input type="submit" class="create" value="Create">
        </form>
    </div>

</aside>
<script>
    var del_but = document.querySelector("#del_but");
    var create_but = document.querySelector("#create_but");
    var del_bar = document.querySelector(".delete_bar");
    var create_bar = document.querySelector(".create_bar");

    del_but.onclick = function (event){
        if(del_bar.classList.contains("hidden")){
            del_bar.classList.remove("hidden");
        }else{
            del_bar.classList.add("hidden");
        }
    };
    create_but.onclick = function (event){
        if(create_bar.classList.contains("hidden")){
            create_bar.classList.remove("hidden");
        }else{
            create_bar.classList.add("hidden");
        }
    };
</script>

</body>
</html>