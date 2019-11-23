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

@WebServlet("/MyWalletServlet")
public class MyWalletServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException{
        HttpSession session = request.getSession();
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
        ArrayList<Wallet> wallets = dbd.getWallets(current_user.user_id);
        String s;
        Integer id = null;
        Double balance = null;
        String currency = null;
        ArrayList<String> validWallets = new ArrayList<>(0);
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
                validWallets.add(s);
            }
        }
        session.setAttribute("validWallets", validWallets);

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
            session.setAttribute("del_res", del_res);
        }

        System.out.println("c_id = " + currency_id);
        if(currency_id != null && !currency_id.equals("")){
            cre_res = dbd.createWallet(current_user, currency_id);
            session.setAttribute("cre_res", cre_res);
        }
        dbd.close();
    }

}
