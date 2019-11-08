import classes.Dbd;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class ContextListener implements ServletContextListener {
    private Dbd dbd = new Dbd();
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        dbd.onMethCall("contextInitialized", "Context na meste!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        dbd.onMethCall("contextDestroyed","Context ne na meste!");
    }
}
