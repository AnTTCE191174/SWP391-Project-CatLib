/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Model;

import java.sql.Date;

public class Book {

    private int bookId;
    private String title;
    private Date publishDate; // Có thể là null, dùng Integer
    private String description;
    private String publisher;
    private int stockQuantity;
    private String categoryName;
    private String authorName; // Có thể là null, dùng Integer
    private String urlImage;
    
    
    // Constructor
    public Book(int bookId, String title, Date publishDate, String description,
            String publisher, int stockQuantity, String categoryName, String authorName, String urlImage) {
        this.bookId = bookId;
        this.title = title;
        this.publishDate = publishDate;
        this.description = description;
        this.publisher = publisher;
        this.stockQuantity = stockQuantity;
        this.categoryName = categoryName;
        this.authorName = authorName;
        this.urlImage = urlImage;
    }

    public Book(int bookId, String title, String description, int stockQuantity, String authorName, String urlImage) {
        this.bookId = bookId;
        this.title = title;
        this.description = description;
        this.stockQuantity = stockQuantity;
        this.authorName = authorName;
        this.urlImage = urlImage;
    }

    public Book(String title, Date publishDate, String publisher, int stockQuantity, String description, String urlImage) {
        this.title = title;
        this.publishDate = publishDate;
        this.description = description;
        this.publisher = publisher;
        this.stockQuantity = stockQuantity;
        this.urlImage = urlImage;
    }
    public Book(){
        
    }
    
  

    public String getUrlImage() {
        return urlImage;
    }

    public void setUrlImage(String urlImage) {
        this.urlImage = urlImage;
    }
    

    // Getters
    public int getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public String getDescription() {
        return description;
    }

    public String getPublisher() {
        return publisher;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getAuthorName() {
        return authorName;
    }

    // Setters
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    @Override
    public String toString() {
        return "Book{"
                + "bookId=" + bookId
                + ", title='" + title + '\''
                + ", publishYear=" + publishDate
                + ", description='" + description + '\''
                + ", publisher='" + publisher + '\''
                + ", stockQuantity=" + stockQuantity
                + ", categoryId=" + categoryName
                + ", authorId=" + authorName
                + '}';
    }
}
