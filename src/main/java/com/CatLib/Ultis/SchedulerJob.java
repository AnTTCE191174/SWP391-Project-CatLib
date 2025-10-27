package com.CatLib.Ultis; // Đặt trong package Ultis

import com.CatLib.Conn.ConnectionUtils;
import com.CatLib.DAO.BookOrdersDAO;
import com.CatLib.Model.BookOrders;
import com.CatLib.Ultis.MailService;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

// Lớp này là một "công việc" (Runnable) có thể được lập lịch
public class SchedulerJob implements Runnable {

    @Override
    public void run() {
        System.out.println("--- [SCHEDULER] Bắt đầu quét độc giả quá hạn lúc 8:00 AM ---");

        Connection conn = null;
        try {
            conn = ConnectionUtils.getConnection();
            List<BookOrders> overdueOrders = BookOrdersDAO.findOverdueOrders(conn);

            if (overdueOrders == null || overdueOrders.isEmpty()) {
                System.out.println("--- [SCHEDULER] Không tìm thấy độc giả nào quá hạn. ---");
                return;
            }

            JavaMailSender mailSender = MailService.getMailSender();
            if (mailSender == null) {
                System.err.println("--- [SCHEDULER] LỖI: Không thể cấu hình Mail Sender! ---");
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            int successCount = 0;
            String emailFrom = "your-real-email@gmail.com"; // <-- SỬA LẠI EMAIL NÀY

            for (BookOrders order : overdueOrders) {
                try {
                    String toEmail = order.getUser().getEmail();
                    String bookTitle = order.getBook().getTitle();
                    String readerName = order.getUser().getFullName();

                    if (readerName == null || readerName.trim().isEmpty()) {
                        readerName = toEmail;
                    }
                    String formattedDate = sdf.format(order.getDueDate());

                    MimeMessage mimeMessage = mailSender.createMimeMessage();
                    MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "UTF-8");

                    String subject = "[Thư viện CatLib] Thông báo trả sách quá hạn";
                    String body = String.format(
                            "Chào %s,\n\n"
                            + "Hệ thống thư viện CatLib ghi nhận bạn đang mượn cuốn sách: \"%s\".\n"
                            + "Sách đã quá hạn trả vào ngày %s.\n\n"
                            + "Vui lòng mang sách đến thư viện trả sớm nhất có thể.\n\n"
                            + "Trân trọng,\n"
                            + "Thư viện CatLib.",
                            readerName,
                            bookTitle,
                            formattedDate
                    );

                    helper.setFrom(emailFrom);
                    helper.setTo(toEmail);
                    helper.setSubject(subject);
                    helper.setText(body);

                    mailSender.send(mimeMessage);
                    successCount++;
                    BookOrdersDAO.updateLastReminderDate(order.getOrderId(), conn);

                } catch (Exception e) {
                    System.err.println("--- [SCHEDULER] Lỗi gửi mail tới " + order.getUser().getEmail() + ": " + e.getMessage());
                }
            }
            System.out.println("--- [SCHEDULER] Đã gửi thành công " + successCount + " / " + overdueOrders.size() + " email. ---");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
