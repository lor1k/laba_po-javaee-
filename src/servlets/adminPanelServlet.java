package servlets;

import classes.Dbd;
import classes.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminPanelServlet")
public class adminPanelServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException {
        HttpSession session = request.getSession();
        User current_user = (User)session.getAttribute("current_user");
        try{
            if(current_user == null){
                response.sendRedirect("/Lab22EE_war_exploded/welcome");
            } else
            if(current_user.isAdmin != 1){
                response.sendRedirect("/Lab22EE_war_exploded/main");
            }
        } catch (IOException e){
            System.out.println(e.getMessage());
        }
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
            System.out.println("NUL!");
        }
        dbd.close();
    }
}

