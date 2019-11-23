package servlets;

import classes.Dbd;
import classes.User;
import classes.Wallet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/SearchWalletsServlet")
public class SearchWalletsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException {
        HttpSession session = request.getSession();
        User current_user = (User)session.getAttribute("current_user");
        ArrayList<String> validWallets = new ArrayList<>(0);
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
        ArrayList<Wallet> wallets = dbd.getWallets(0);
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
                System.out.println("w = "+ w.toString());
                System.out.println(dbd.getUser(w.getUser_id()).toString());
                s = w.id + " " + w.currency + " Owner: "
                        + dbd.getUser(w.getUser_id()).toString()
                        + "(id:" + w.getUser_id() + ")";
                validWallets.add(s);
            }
        }
        session.setAttribute("allValidWallets", validWallets);
        dbd.close();
    }
}
