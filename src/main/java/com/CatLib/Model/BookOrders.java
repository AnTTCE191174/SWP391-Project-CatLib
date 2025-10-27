package com.CatLib.Model;

import java.util.Date;

public class BookOrders {

    private int orderId;
    private Date dueDate; // Hoặc kiểu dữ liệu nào đó bạn dùng
    private String status;
    
    // Đây là phần quan trọng để chứa thông tin liên kết
    private User user;
    private Book book;

    // Cần một constructor rỗng
    public BookOrders() {
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }
}