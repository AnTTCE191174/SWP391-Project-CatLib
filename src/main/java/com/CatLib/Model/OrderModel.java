/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Model;

import java.sql.Date;
import java.time.LocalDate;
import java.util.logging.Logger;


public class OrderModel {

    private int orderId;
    private Integer userId; // Có thể là null nếu không có UserID hợp lệ, dùng Integer
    private Integer bookId; // Có thể là null nếu không có BookID hợp lệ, dùng Integer
    private Date orderDate;
    private Date returnDate;
    private Date actualReturnDate; // Có thể là null
    private long bill; // Sử dụng BigDecimal cho tiền tệ
    private String status;

    private String title;
    private String authorName;
    private String publisher;
    private String publishYear;
    private String imageUrl;

    public OrderModel(int orderId, String title, String authorName, String publisher, String publishYear, Date orderDate, Date returnDate, String imageUrl, String status) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.returnDate = returnDate;
        this.title = title;
        this.authorName = authorName;
        this.publisher = publisher;
        this.publishYear = publishYear;
        this.imageUrl = imageUrl;
        this.status = status;

    }

    // Constructor
    public OrderModel(int orderId, Integer userId, Integer bookId, Date orderDate,
            Date returnDate, Date actualReturnDate, long bill, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.bookId = bookId;
        this.orderDate = orderDate;
        this.returnDate = returnDate;
        this.actualReturnDate = actualReturnDate;
        this.bill = bill;
        this.status = status;
    }

    // Getters
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPublishYear() {
        return publishYear;
    }

    public void setPublishYear(String publishYear) {
        this.publishYear = publishYear;
    }

    public int getOrderId() {
        return orderId;
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getBookId() {
        return bookId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public Date getActualReturnDate() {
        return actualReturnDate;
    }

    public long getBill() {
        return bill;
    }

    public String getStatus() {
        return status;
    }

    // Setters
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public void setActualReturnDate(Date actualReturnDate) {
        this.actualReturnDate = actualReturnDate;
    }

    public void setBill(long bill) {
        this.bill = bill;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderModel{" + "orderId=" + orderId + ", userId=" + userId + ", bookId=" + bookId + ", orderDate=" + orderDate + ", returnDate=" + returnDate + ", actualReturnDate=" + actualReturnDate + ", bill=" + bill + ", status=" + status + ", title=" + title + ", authorName=" + authorName + ", publisher=" + publisher + ", publishYear=" + publishYear + ", imageUrl=" + imageUrl + '}';
    }

}
