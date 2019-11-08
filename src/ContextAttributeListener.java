import classes.Dbd;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;

public class ContextAttributeListener implements ServletContextAttributeListener {
    Dbd dbd = new Dbd();
    @Override
    public void attributeAdded(ServletContextAttributeEvent servletContextAttributeEvent) {
        dbd.onMethCall("attributeAdded", "Hey! There's new attribute here!");
    }

    @Override
    public void attributeRemoved(ServletContextAttributeEvent servletContextAttributeEvent) {
        dbd.onMethCall("attributeRemoved","We will miss that one...");
    }

    @Override
    public void attributeReplaced(ServletContextAttributeEvent servletContextAttributeEvent) {
        dbd.onMethCall("attributeReplaced","New value for this one!");
    }
}
