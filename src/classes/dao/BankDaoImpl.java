package classes.dao;

import classes.User;
import classes.Wallet;

import java.util.ArrayList;
import java.util.logging.Logger;


//@Repository (Spring)
public class BankDaoImpl implements BankDao{
    //private static final Logger logger = Logger.getLogger("Bac", BankDaoImpl.class)
    @Override
    public void findUser(String user_login) {

    }

    @Override
    public User login(String login, String password) {
        return null;
    }

    @Override
    public ArrayList<Wallet> getWallets(int u_id) {
        return null;
    }

    @Override
    public ArrayList<User> getUsers() {
        return null;
    }

    @Override
    public User getUser(int u_id) {
        return null;
    }

    @Override
    public User getUser(String login) {
        return null;
    }

    @Override
    public Wallet getWallet(int w_id) {
        return null;
    }

    @Override
    public int send(int f, int t, double a) {
        return 0;
    }

    @Override
    public int deleteWallet(User c_u, int w_id) {
        return 0;
    }

    @Override
    public int createWallet(User current_user, String currency_id) {
        return 0;
    }

    @Override
    public int register(String login, String pass, String rep_pass) {
        return 0;
    }

    @Override
    public int addMoney(Integer wallet_id, Integer amount) {
        return 0;
    }
}
