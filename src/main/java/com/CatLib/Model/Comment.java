package com.CatLib.Model;

public class Comment {
    
    // 1. THÊM TRƯỜNG NÀY VÀO
    private int id; 
    
    private String username;
    private String text;
    private String date;

    // 2. SỬA CONSTRUCTOR CŨ CỦA BẠN (nếu có)
    // Constructor cũ của bạn có thể trông như thế này:
    public Comment(String username, String text, String date) {
        this.username = username;
        this.text = text;
        this.date = date;
    }
    
    // 3. THÊM CONSTRUCTOR MỚI NÀY
    // (Đây là constructor mà CommentDAO sẽ gọi)
    public Comment(int id, String username, String text, String date) {
        this.id = id;
        this.username = username;
        this.text = text;
        this.date = date;
    }

    // 4. THÊM GETTER NÀY (Rất quan trọng, để JSP có thể dùng ${comment.id})
    public int getId() {
        return id;
    }

    // (Giữ nguyên các getter/setter khác của bạn)
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}