/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Ultis;

import java.util.Properties;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

/**
 *
 * @author trant
 */
public class MailService {

    private static JavaMailSender mailSender = null;

    /**
     * Hàm này chỉ nên được gọi một lần khi ứng dụng khởi động, hoặc nó sẽ tự
     * khởi tạo khi được gọi lần đầu tiên.
     */
    public static JavaMailSender getMailSender() {
        // Chỉ khởi tạo 1 lần duy nhất (Singleton pattern)
        if (mailSender == null) {
            JavaMailSenderImpl sender = new JavaMailSenderImpl();
            Properties props = new Properties();

            try {
                // Tải file properties từ 'src/main/resources' (classpath)
                props.load(MailService.class.getClassLoader().getResourceAsStream("application.properties"));

                // Đọc cấu hình từ file
                sender.setHost(props.getProperty("mailconfig.host"));
                sender.setPort(Integer.parseInt(props.getProperty("mailconfig.port")));
                sender.setUsername(props.getProperty("mailconfig.username"));
                sender.setPassword(props.getProperty("mailconfig.password"));

                // Cấu hình thuộc tính JavaMail
                Properties javaMailProps = new Properties();
                javaMailProps.put("mail.smtp.auth", props.getProperty("mailconfig.smtp.auth"));
                javaMailProps.put("mail.smtp.starttls.enable", props.getProperty("mailconfig.smtp.starttls.enable"));

                sender.setJavaMailProperties(javaMailProps);

                mailSender = sender;
                System.out.println("--- Cấu hình MailSender thành công! ---");

            } catch (Exception e) {
                System.err.println("LỖI: Không thể tải file application.properties hoặc cấu hình mail.");
                e.printStackTrace();
            }
        }
        return mailSender;
    }
}
