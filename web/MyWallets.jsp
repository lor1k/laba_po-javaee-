<%@ page import="classes.Dbd" %>
<%@ page import="classes.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.Wallet" %>
<%@ page import="java.io.PrintWriter" %>
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
    ArrayList<Wallet> wallets = dbd.getWallets(current_user.user_id);
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

    System.out.println("currency = " + currency);
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
            s = w.id + " " + w.balance + " " + w.currency;
           out.println("<p>" + s + "</p>");
        }
    }



%>

</div>

<aside>
    <div class="actions">
        <button class="delete" id="del_but">Delete wallet</button>
        <button class="create" id="create_but">Create new wallet</button>
    </div>
    <%
        Integer wallet_id = null;
        String currency_id = null;
        int del_res = 0;
        int cre_res = 0;
        try{
            wallet_id = Integer.parseInt(request.getParameter("delete_id"));
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        try{
            currency_id = request.getParameter("currency_id").toUpperCase();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }

        if(wallet_id != null){
            del_res = dbd.deleteWallet(current_user, wallet_id);
        }
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
        System.out.println("c_id = " + currency_id);
        if(currency_id != null && !currency_id.equals("")){
            cre_res = dbd.createWallet(current_user, currency_id);
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
        <form action="">
            <input type="number" id="delete_id" name="delete_id" class="input" placeholder="id">
            <input type="submit" class="delete" value="Delete">
        </form>
    </div>
    <div class="create_bar hidden">
        <form action="">
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
<%
    dbd.close();
%>