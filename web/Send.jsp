<%@ page import="classes.User" %>
<%@ page import="classes.Dbd" %>
<%@ page import="classes.Wallet" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: shlap
  Date: 17.10.2019
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Send</title>
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/MyWallets.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="heading">
    <h1>Send</h1>
    <a href="${pageContext.request.contextPath}/welcome">[back]</a>
</div>
<div class="filters">
    <form action="SendServlet">
        <label for="amount">Amount: </label>
        <input type="number" name="amount" id="amount" placeholder="AMOUNT" required>
        <p> from </p>
        <select name="wallet" id="wallet">
            <option value="0" selected disabled>-select wallet-</option>
            <%
                User current_user = (User)session.getAttribute("current_user");
                if(current_user == null){
                    response.sendRedirect("/Lab22EE_war_exploded/welcome");
                }
                Dbd dbd = new Dbd();
                dbd.connect();
                ArrayList<Wallet> wallets = dbd.getWallets(current_user.user_id);
                for (Wallet w :
                        wallets) {
                    out.print("<option value = \"" + w.id + "\"" + "> " + w.id + ". " + w.currency + " (" + w.balance + ") </option>");
                }
            %>
        </select>
        <label for="to"></label>
        <input type="number" name="to" id="to" required>
        <input type="submit" value="Send">
    </form>
    <%
        Integer res_code = (Integer)session.getAttribute("send_code");
        if(res_code != 0){
            if(res_code == -3){
                out.print("<p class = 'error_p'>Currency exchange is not available now</p>");
            }
            if(res_code == -2){
                out.print("<p class = 'error_p'>Not enough balance</p>");
            }
            if(res_code == -1){
                out.print("<p class = 'error_p'>Destination wallet doesn't exists</p>");
            }
            if(res_code == 1){
                out.print("<p class = 'success_p'>Sent!</p>");
            }
        }
    %>

</div>

</body>
</html>
