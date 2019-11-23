package servlets;

import classes.Dbd;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendServlet")
public class SendServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException {
        HttpSession session = request.getSession();
        Dbd dbd = new Dbd();
        dbd.connect();
        Integer from = null;
        Integer to = null;
        Double amount = null;
        int res_code = 0;
        try {
            from = Integer.parseInt(request.getParameter("wallet"));
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        try {
            to = Integer.parseInt(request.getParameter("to"));
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        try {
            amount = Double.parseDouble(request.getParameter("amount"));
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        if(from != null && to != null && amount != null){
            res_code = dbd.send(from, to, amount);
            session.setAttribute("send_code", res_code);
        }
        dbd.close();
    }
}
