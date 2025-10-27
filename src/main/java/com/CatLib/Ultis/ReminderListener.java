package com.CatLib.Ultis; // Đặt trong package Ultis

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener // Đánh dấu đây là một Listener
public class ReminderListener implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Hàm này chạy KHI SERVER KHỞI ĐỘNG
        scheduler = Executors.newSingleThreadScheduledExecutor();

        // Chạy công việc (SchedulerJob)
        // Bắt đầu sau 10 giây
        // Và lặp lại mỗi 24 GIỜ (86400 giây)
        scheduler.scheduleAtFixedRate(new SchedulerJob(), 10, 86400, TimeUnit.SECONDS);

        System.out.println("--- [ReminderListener] Đã khởi tạo bộ lập lịch gửi mail. ---");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Hàm này chạy KHI SERVER TẮT
        if (scheduler != null) {
            scheduler.shutdown();
        }
        System.out.println("--- [ReminderListener] Đã tắt bộ lập lịch. ---");
    }
}
