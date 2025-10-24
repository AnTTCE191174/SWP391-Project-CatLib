/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.Model;


public class Author {

    private int authorId;
    private String name;
    private String story;

    // Constructor
    public Author(int authorId, String name, String story) {
        this.authorId = authorId;
        this.name = name;
        this.story = story;
    }

    public Author(int authorId, String name) {
        this.authorId = authorId;
        this.name = name;
    }
    
    

    // Getters
    public int getAuthorId() {
        return authorId;
    }

    public String getName() {
        return name;
    }

    public String getStory() {
        return story;
    }

    // Setters
    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setStory(String story) {
        this.story = story;
    }

    @Override
    public String toString() {
        return "Author{"
                + "authorId=" + authorId
                + ", name='" + name + '\''
                + ", story='" + story + '\''
                + '}';
    }
}
