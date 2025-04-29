package com.junasa.background;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.Timer;

public class AppListener implements ServletContextListener {
    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer();
        timer.schedule(new AutoCancelBorrowRequests(), 0, 24 * 60 * 60 * 1000); // Run every 24 hours
        timer.schedule(new OverdueReminderTask(), 0, 24 * 60 * 60 * 1000); // Run every 24 hours
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
        }
    }
}