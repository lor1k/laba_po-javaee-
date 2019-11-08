import classes.Dbd;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;

public class RequestListener implements ServletRequestListener {
    private Dbd dbd = new Dbd();
    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {
        dbd.onMethCall("requestDestroyed", "Something happen!");
    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
        dbd.onMethCall("requestInitialized", "Something more happen!");
    }
}
