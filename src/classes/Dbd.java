package classes;


import java.sql.*;
import java.util.ArrayList;
import java.util.Date;

public class Dbd {
    private Connection connection;
    public void connect(){
        try{
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection(
                    "jdbc:sqlite:J:\\проекты\\Lab22EE\\db\\bank.db"
            );
            System.out.println("Connected!");
        }
        catch (Exception e){
            System.out.println("Exception:");
            System.out.println(e.getMessage());
        }
    }
    public void findUser(String user_login){
        try{
            boolean f = false;
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM users WHERE (login = '" + user_login + "')");
            while(rs.next()){
                f = true;
                System.out.println(rs.getInt("id") + "\t" + rs.getString("login"));
            }
            if(!f){
                System.out.println("User not found");
            }
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
    public User login(String login, String password){
        User u = null;
        try{
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM users WHERE (login = '" + login + "')");
            while(rs.next()){
                u = new User(rs.getInt("id"), rs.getString("login"), rs.getString("password"), rs.getInt("isAdmin"));
            }

        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return u;

    }
    public ArrayList<Wallet> getWallets(int u_id){
        ArrayList<Wallet> wallets= new ArrayList<Wallet>();
        try{

            Statement statement = connection.createStatement();
            ResultSet rs;
            if(u_id == 0){
                rs = statement.executeQuery("SELECT * FROM wallets");
            }else{
                rs = statement.executeQuery("SELECT * FROM wallets WHERE (user_id = '" + u_id + "')");
            }
            while(rs.next()){
                wallets.add(new Wallet(rs.getInt("user_id"), rs.getString("currency"), rs.getDouble("balance"), rs.getInt("id")));
            }

        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        return wallets;
    }
    public ArrayList<User> getUsers(){
        ArrayList<User> users = new ArrayList<User>();
        try{
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM users");
            while(rs.next()){
                users.add(new User(rs.getInt("id"), rs.getString("login")));
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return users;
    }
    public User getUser(int u_id){
        User u = null;
        try{
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM users WHERE(id = "+ u_id +")");
            while(rs.next()){
                u = new User(rs.getInt("id"), rs.getString("login"));
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return u;
    }
    public User getUser(String login){
        User u = null;
        try{
            Statement statement = connection.createStatement();
            System.out.println("SELECT * FROM users WHERE(login = '"+ login + "')");
            ResultSet rs = statement.executeQuery("SELECT * FROM users WHERE(login = "+ login + ")");
            while(rs.next()){
                u = new User(rs.getInt("id"), rs.getString("login"));
            }
        }catch (Exception e){
            System.out.println("(getUser exception): " + e.getMessage());
        }
        return u;
    }
    public Wallet getWallet(int w_id){
        Wallet w = null;
        try{
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM wallets WHERE(id = "+ w_id +")");
            while(rs.next()){
                w = new Wallet(rs.getInt("user_id"), rs.getString("currency"), rs.getDouble("balance"), rs.getInt("id"));
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return w;
    }
    public int send(int f, int t, double a){
        Wallet from = getWallet(f);
        Wallet to = getWallet(t);

        if(to != null){
            if(from.balance >= a){
                if(from.currency.equals(to.currency)){
                    from.balance-=a;
                    to.balance+=a;
                    try{
                        Statement statement = connection.createStatement();
                        statement.execute("UPDATE wallets SET "+
                                "balance = "+from.balance+" WHERE id = " +from.id);
                        statement.execute("UPDATE wallets SET "+
                                "balance = "+to.balance+" WHERE id = " +to.id);
                        return 1;//Success
                    } catch (Exception e){
                        System.out.println(e.getMessage());
                    }

                }else{
                    return -3;//Currency issue
                }
            } else{
                return -2; //Not enough balance
            }
        } else{
            return -1;//Destination wallet doesn't exists
        }
        return 0;//wtf
    }
    public int deleteWallet(User c_u, int w_id){
        Wallet w = null;
        Statement statement = null;
        try{
            statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM wallets WHERE(id = "+ w_id +")");
            while(rs.next()){
                w = new Wallet(rs.getInt("user_id"), rs.getString("currency"), rs.getDouble("balance"), rs.getInt("id"));
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        if(w != null){
            if(w.getUser_id() == c_u.user_id){
                if(w.balance == 0){
                    try{
                        statement.execute("DELETE FROM wallets WHERE  id = '" + w_id + "'");
                        statement.close();
                        return 1;
                    } catch (Exception e){
                        System.out.println(e.getMessage());
                    }

                }else{
                    return -3;//Wallet is not empty
                }
            }else{
                return -2;//Wallet doesn't belong to you
            }
        }else{
            return -1; //Wallet doesn't exist
        }
        return 0;//wtf
    }


    public int createWallet(User current_user, String currency_id) {
        if(currency_id.equals("USD") || currency_id.equals("UAH") || currency_id.equals("EUR")){
            try{
                Statement statement = connection.createStatement();
                statement.execute("INSERT INTO wallets (user_id, currency) VALUES ('" + current_user.user_id + "', '" + currency_id + "')");
                statement.close();
                System.out.println("Created{Dbd.createWallet}");
                return 1;//success
            } catch (Exception e){
                System.out.println(e.getMessage());
            }
        } else {
            return -1;//Undefined currency
        }
        return 0;//wtf
    }
    public int register(String login, String pass, String rep_pass){
        User temp_u = getUser(login);
        System.out.println(temp_u.login);
        if(pass.equals(rep_pass)){
            if(temp_u == null){
                try{
                    Statement statement = connection.createStatement();
                    System.out.println("INSERT INTO users (login, password) VALUES ('" + login + "', '" + pass + "')");
                    statement.execute("INSERT INTO users (login, password) VALUES ('" + login + "', '" + pass + "')");
                    statement.close();
                    System.out.println("Created{Dbd.createUser}");
                    return 1;//success
                } catch (Exception e){
                    System.out.println(e.getMessage());
                }
            }else  {
                return  -2; // Login is occupied
            }
        }else {
            return -1;//Passwords doesn't match
        }
        return 0;
    }
    public void onMethCall(String metType, String message){
        try{
            Statement statement = connection.createStatement();
            statement.execute("INSERT INTO meth_call (event, message, time) VALUES ('" + metType + "', '" + message + "', '" + new Date().toString() +"')");
            statement.close();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
    public void close(){
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public int addMoney(Integer wallet_id, Integer amount) {
        Wallet w = this.getWallet(wallet_id);
        if(amount > 0){
            System.out.println("WALLET: " + w.toString());
            if(w != null){
                w.balance+=amount;
                try{
                    Statement statement = connection.createStatement();
                    statement.execute("UPDATE wallets SET balance = " + w.balance + " WHERE (id = " + wallet_id + ")");
                    return 1;//success
                } catch (Exception e){
                    System.out.print(e.getMessage());
                }
            } else {
                return -2;//wallet is not found
            }
        }else {
            return -1; // amount is not correct
        }
        return 0; //wtf
    }
}
