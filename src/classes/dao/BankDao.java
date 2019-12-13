package classes.dao;

import classes.User;
import classes.Wallet;

import java.util.ArrayList;

public interface BankDao {

    public void findUser(String user_login);
    public User login(String login, String password);
    public ArrayList<Wallet> getWallets(int u_id);
    public ArrayList<User> getUsers();
    public User getUser(int u_id);
    public User getUser(String login);
    public Wallet getWallet(int w_id);
    public int send(int f, int t, double a);
    public int deleteWallet(User c_u, int w_id);
    public int createWallet(User current_user, String currency_id);
    public int register(String login, String pass, String rep_pass);
    public int addMoney(Integer wallet_id, Integer amount);

}
