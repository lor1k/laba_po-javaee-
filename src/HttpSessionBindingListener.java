import classes.Dbd;

import javax.servlet.http.HttpSessionBindingEvent;

public class HttpSessionBindingListener implements javax.servlet.http.HttpSessionBindingListener {
    private Dbd dbd = new Dbd();
    @Override
    public void valueBound(HttpSessionBindingEvent httpSessionBindingEvent) {
        dbd.onMethCall("valueBound", "New event!");
    }

    @Override
    public void valueUnbound(HttpSessionBindingEvent httpSessionBindingEvent) {
        dbd.onMethCall("valueUnbound", "Another event!");
    }
}
