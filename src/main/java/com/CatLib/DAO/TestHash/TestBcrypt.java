/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.DAO.TestHash;
import org.mindrot.jbcrypt.BCrypt;

public class  TestBcrypt {
    public static void main(String[] args) {
        String plain = "123";
        String hashed = BCrypt.hashpw(plain, BCrypt.gensalt(10));
        System.out.println("Hashed password = " + hashed);
        System.out.println("Check: " + BCrypt.checkpw("123", hashed));
    }
}
