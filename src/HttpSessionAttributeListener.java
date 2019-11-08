import classes.Dbd;

import javax.servlet.http.HttpSessionBindingEvent;

public class HttpSessionAttributeListener implements javax.servlet.http.HttpSessionAttributeListener {
    private Dbd dbd = new Dbd();
    @Override
    public void attributeAdded(HttpSessionBindingEvent httpSessionBindingEvent) {
        dbd.onMethCall("attributeAdded", "New session attr");
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent httpSessionBindingEvent) {
        dbd.onMethCall("attributeRemoved", "Attr've been deleted)");
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent httpSessionBindingEvent) {
        dbd.onMethCall("attributeReplaced", "Attr've been replaced)");
    }
}
