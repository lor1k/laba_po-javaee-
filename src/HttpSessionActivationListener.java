import classes.Dbd;

import javax.servlet.http.HttpSessionEvent;

public class HttpSessionActivationListener implements javax.servlet.http.HttpSessionActivationListener {
    private Dbd dbd = new Dbd();
    @Override
    public void sessionWillPassivate(HttpSessionEvent httpSessionEvent) {
        dbd.onMethCall("sessionWillPassivate", "I don't know what is this)");
    }

    @Override
    public void sessionDidActivate(HttpSessionEvent httpSessionEvent) {
        dbd.onMethCall("sessionDidActivate", "This too...");
    }
}
