package com.CatLib.Model;

// Model này dùng để hứng dữ liệu TỪ câu query JOIN
// nên nó sẽ chứa cả username, text, và date
public class Comment {
    
    private String username;
    private String text;
    private String date; // Dùng String để cho đơn giản

    // Constructor
    public Comment(String username, String text, String date) {
        this.username = username;
        this.text = text;
        this.date = date;
    }

    // Getters and Setters
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