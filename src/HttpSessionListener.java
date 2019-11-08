import classes.Dbd;

import javax.servlet.http.HttpSessionEvent;

public class HttpSessionListener implements javax.servlet.http.HttpSessionListener {
    private Dbd dbd = new Dbd();
    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        dbd.onMethCall("sessionCreated", "New session!");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        dbd.onMethCall("sessionDestroyed", "Oops...)");
    }
}
