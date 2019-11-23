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
import java.util.ArrayList;

@WebServlet("/SearchUserServlet")
public class SearchUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException {
        HttpSession session = request.getSession();
        ArrayList<String> validUsers = new ArrayList<>(0);
        User current_user = (User)session.getAttribute("current_user");
        if(current_user == null){
            try {
                response.sendRedirect("/Lab22EE_war_exploded/welcome");
            } catch (IOException e) {
                e.printStackTrace();
            }
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
                validUsers.add(u.user_id + " " + u.toString());
            }
        }
        session.setAttribute("validUsers", validUsers);
        dbd.close();
    }
}
