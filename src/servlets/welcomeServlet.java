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

@WebServlet("/welcomeServlet")
public class welcomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Dbd dbd = new Dbd();
        User current_user = null;
        boolean logined = false;
        current_user = (User) session.getAttribute("current_user");
        if (current_user != null) {
            response.sendRedirect("/Lab22EE_war_exploded/main");
        }
        dbd.connect();
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        String reg_log = request.getParameter("reg_log");
        String reg_pass = request.getParameter("reg_pass");
        String rep_password = request.getParameter("rep_password");
        if (login != null && password != null && !password.equals("") && !login.equals("")) {
            current_user = dbd.login(login, password);
            if (current_user != null) {
                if (password.equals(current_user.getPassword())) {
                    session.setAttribute("current_user", current_user);
                    logined = true;
                }
            }
        }
        System.out.println("rl: " + reg_log + " rp: " + reg_pass + " rp: " + rep_password);
        if (reg_log != null && reg_pass != null && rep_password != null && !reg_log.equals("") && !reg_pass.equals("") && !rep_password.equals("")) {
            int reg_code = dbd.register(reg_log, reg_pass, rep_password);


            System.out.println("Reg_code: " + reg_code);
            if(reg_code == 1){
                current_user = dbd.getUser(login);
                session.setAttribute("current_user", current_user);
                response.sendRedirect("/Lab22EE_war_exploded/main");
            } else{
                session.setAttribute("reg_code", reg_code);
            }
        }


        if(logined){

            response.sendRedirect("/Lab22EE_war_exploded/main");
        }else{
            //response.sendRedirect("/Lab22EE_war_exploded/welcome");
        }

    }
}