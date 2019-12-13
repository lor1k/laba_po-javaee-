package classes;

import javax.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int user_id;

    @Column(name = "login")
    public String login;

    @Column(name = "password")
    private String password;

    @Column(name = "isAdmin")
    public int isAdmin;


    public String getPassword() {
        return password;
    }

    User(String login, String password) {
        this.login = login;
        this.password = password;
    }

    User(int user_id, String login, String password, int isAdmin) {
        this.user_id = user_id;
        this.login = login;
        this.password = password;
        this.isAdmin = isAdmin;
    }

    public User(int user_id, String login) {
        this.user_id = user_id;
        this.login = login;
    }

    @Override
    public String toString() {
        return login;
    }
}
