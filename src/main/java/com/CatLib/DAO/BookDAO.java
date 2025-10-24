/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.CatLib.DAO;

import com.CatLib.Model.Book;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class BookDAO {

    public static List<Book> findAllBook(Connection conn) {
        String sql = "select Book.bookid, title, [description], stockQuantity, authorName, imageURL from BOOK\n"
                + "join Book_Author on Book.BookID = Book_Author.BookID\n"
                + "join AUTHOR on AUTHOR.authorId = Book_Author.authorId\n";
        List<Book> list;
        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                int id = Integer.parseInt(rs.getString("bookid"));

                String title = rs.getString("title");
                String description = rs.getString("description");
                String authorName = rs.getString("authorName");
                int stockQuantity = rs.getInt("stockQuantity");
                String url = rs.getString("imageURL");

                Book book = new Book(id, title, description, stockQuantity, authorName, url);
                list.add(book);
            }
            return list;

        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static Book findBookById(Connection conn, String bookId) {
        String sql = "select * from Book\n"
                + "join Book_Author on Book.BookID = Book_Author.BookID\n"
                + "join AUTHOR on AUTHOR.authorId = Book_Author.authorId\n"
                + "join CATEGORY on CATEGORY.categoryId = Book.categoryId \n"
                + "where book.bookId = ?";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, bookId);
            ResultSet rs = pstm.executeQuery();

            if (rs.next()) {
                String title = rs.getString("title");
                String quantity = rs.getString("stockquantity");
                String description = rs.getString("description");
                String authorName = rs.getString("authorName");
                String categoryName = rs.getString("categoryName");
                String publishDate = rs.getString("publishDate");
                String publisher = rs.getString("publisher");

                String url = rs.getString("imageURL");

                Book book = new Book(Integer.parseInt(bookId),
                        title,
                        Date.valueOf(publishDate),
                        description,
                        publisher,
                        Integer.parseInt(quantity),
                        categoryName,
                        authorName,
                        url);

                return book;
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return null;
    }

    public static List<Book> searchBookByInput(Connection conn, String input) {
        String sql = "select Book.bookid, title, [description], stockQuantity, authorName, imageURL from BOOK\n"
                + "join Book_Author on Book.BookID = Book_Author.BookID\n"
                + "join AUTHOR on AUTHOR.authorId = Book_Author.authorId\n"
                + "join CATEGORY on CATEGORY.categoryId = Book.categoryId "
                + "WHERE BOOK.title COLLATE Latin1_General_CI_AI LIKE '%' + ? + '%'\n"
                + "OR authorName COLLATE Latin1_General_CI_AI LIKE '%' + ? + '%'\n"
                + "OR CATEGORY.CategoryID = TRY_CAST(? AS INT)";
        try {
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setString(1, input);
            pstm.setString(2, input);
            pstm.setString(3, input);

            ResultSet rs = pstm.executeQuery();
            List<Book> list = new ArrayList<>();
            while (rs.next()) {
                int id = Integer.parseInt(rs.getString("bookId"));

                String title = rs.getString("title");
                String description = rs.getString("description");
                String authorName = rs.getString("authorName");
                int stockQuantity = rs.getInt("stockQuantity");
                String url = rs.getString("imageURL");

                Book book = new Book(id, title, description, stockQuantity, authorName, url);
                list.add(book);
            }
            if (list.isEmpty()) {
                return null;
            } else {
                return list;
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return null;
    }

    public static boolean createBook(Connection conn, Book book, String categoryName, String authorName) {
        try {
            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Kiểm tra category
            int categoryId = -1;
            String checkCategorySQL = "SELECT CategoryID FROM Category WHERE CategoryName = ?";
            PreparedStatement checkCategoryStmt = conn.prepareStatement(checkCategorySQL);
            checkCategoryStmt.setString(1, categoryName);
            ResultSet categoryRS = checkCategoryStmt.executeQuery();
            if (categoryRS.next()) {
                categoryId = categoryRS.getInt("CategoryID");
            } else {
                String insertCategorySQL = "INSERT INTO Category (CategoryName) VALUES (?)";
                PreparedStatement insertCategoryStmt = conn.prepareStatement(insertCategorySQL, Statement.RETURN_GENERATED_KEYS);
                insertCategoryStmt.setString(1, categoryName);
                insertCategoryStmt.executeUpdate();
                ResultSet generatedKeys = insertCategoryStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    categoryId = generatedKeys.getInt(1);
                }
            }

            // 2. Kiểm tra author
            int authorId = -1;
            String checkAuthorSQL = "SELECT AuthorID FROM Author WHERE AuthorName = ?";
            PreparedStatement checkAuthorStmt = conn.prepareStatement(checkAuthorSQL);
            checkAuthorStmt.setString(1, authorName);
            ResultSet authorRS = checkAuthorStmt.executeQuery();
            if (authorRS.next()) {
                authorId = authorRS.getInt("AuthorID");
            } else {
                String insertAuthorSQL = "INSERT INTO Author (AuthorName) VALUES (?)";
                PreparedStatement insertAuthorStmt = conn.prepareStatement(insertAuthorSQL, Statement.RETURN_GENERATED_KEYS);
                insertAuthorStmt.setString(1, authorName);
                insertAuthorStmt.executeUpdate();
                ResultSet generatedKeys = insertAuthorStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    authorId = generatedKeys.getInt(1);
                }
            }

            // 3. Insert Book (KHÔNG còn AuthorID)
            String insertBookSQL = "INSERT INTO Book (title, publishDate, publisher, stockQuantity, description, imageURL, categoryId) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement insertBookStmt = conn.prepareStatement(insertBookSQL, Statement.RETURN_GENERATED_KEYS);
            insertBookStmt.setString(1, book.getTitle());
            insertBookStmt.setDate(2, book.getPublishDate());
            insertBookStmt.setString(3, book.getPublisher());
            insertBookStmt.setInt(4, book.getStockQuantity());
            insertBookStmt.setString(5, book.getDescription());
            insertBookStmt.setString(6, book.getUrlImage());
            insertBookStmt.setInt(7, categoryId);
            insertBookStmt.executeUpdate();

            ResultSet bookKeys = insertBookStmt.getGeneratedKeys();
            if (bookKeys.next()) {
                int bookId = bookKeys.getInt(1);

                // 4. Insert vào bảng Book_Author
                String insertBookAuthorSQL = "INSERT INTO Book_Author (BookID, AuthorID) VALUES (?, ?)";
                PreparedStatement bookAuthorStmt = conn.prepareStatement(insertBookAuthorSQL);
                bookAuthorStmt.setInt(1, bookId);
                bookAuthorStmt.setInt(2, authorId);
                bookAuthorStmt.executeUpdate();
            }

            conn.commit(); // Commit transaction
            return true;
        } catch (SQLException e) {
            try {
                conn.rollback(); // Rollback nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public static boolean updateBook(Connection conn, Book book, String categoryName, String authorName) {
        try {
            conn.setAutoCommit(false);

            // 1. Kiểm tra category
            int categoryId = -1;
            String checkCategorySQL = "SELECT CategoryID FROM Category WHERE CategoryName = ?";
            PreparedStatement checkCategoryStmt = conn.prepareStatement(checkCategorySQL);
            checkCategoryStmt.setString(1, categoryName);
            ResultSet categoryRS = checkCategoryStmt.executeQuery();
            if (categoryRS.next()) {
                categoryId = categoryRS.getInt("CategoryID");
            } else {
                String insertCategorySQL = "INSERT INTO Category (CategoryName) VALUES (?)";
                PreparedStatement insertCategoryStmt = conn.prepareStatement(insertCategorySQL, Statement.RETURN_GENERATED_KEYS);
                insertCategoryStmt.setString(1, categoryName);
                insertCategoryStmt.executeUpdate();
                ResultSet generatedKeys = insertCategoryStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    categoryId = generatedKeys.getInt(1);
                }
            }

            // 2. Kiểm tra author
            int authorId = -1;
            String checkAuthorSQL = "SELECT AuthorID FROM Author WHERE AuthorName = ?";
            PreparedStatement checkAuthorStmt = conn.prepareStatement(checkAuthorSQL);
            checkAuthorStmt.setString(1, authorName);
            ResultSet authorRS = checkAuthorStmt.executeQuery();
            if (authorRS.next()) {
                authorId = authorRS.getInt("AuthorID");
            } else {
                String insertAuthorSQL = "INSERT INTO Author (AuthorName) VALUES (?)";
                PreparedStatement insertAuthorStmt = conn.prepareStatement(insertAuthorSQL, Statement.RETURN_GENERATED_KEYS);
                insertAuthorStmt.setString(1, authorName);
                insertAuthorStmt.executeUpdate();
                ResultSet generatedKeys = insertAuthorStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    authorId = generatedKeys.getInt(1);
                }
            }
            
            // Cập nhật Book
            String updateBookSQL = "UPDATE Book SET title = ?, publishDate = ?, publisher = ?, stockQuantity = ?, description = ?, imageURL = ?, categoryId = ? WHERE bookId = ?";
            PreparedStatement updateBookStmt = conn.prepareStatement(updateBookSQL);
            updateBookStmt.setString(1, book.getTitle());
            updateBookStmt.setDate(2, book.getPublishDate());
            updateBookStmt.setString(3, book.getPublisher());
            updateBookStmt.setInt(4, book.getStockQuantity());
            updateBookStmt.setString(5, book.getDescription());
            updateBookStmt.setString(6, book.getUrlImage());
            updateBookStmt.setInt(7, categoryId);
            updateBookStmt.setInt(8, book.getBookId());
            int affected = updateBookStmt.executeUpdate();

            if (affected == 0) {
                return false;
            }

            // Xóa author cũ, gán author mới
            String deleteOld = "DELETE FROM Book_Author WHERE BookID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteOld);
            deleteStmt.setInt(1, book.getBookId());
            deleteStmt.executeUpdate();

            String insertNew = "INSERT INTO Book_Author (BookID, AuthorID) VALUES (?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertNew);
            insertStmt.setInt(1, book.getBookId());
            insertStmt.setInt(2, authorId);
            insertStmt.executeUpdate();

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static boolean deleteBook(Connection conn, String bookId) {
        try {
            // Kiểm tra trạng thái đơn hàng
            String checkSQL = "SELECT COUNT(*) FROM BookOrders WHERE BookID = ? AND Status IN ('pending', 'approved', 'overdue')";
            PreparedStatement checkStmt = conn.prepareStatement(checkSQL);
            checkStmt.setString(1, bookId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // đang mượn → không xóa
            }

            conn.setAutoCommit(false);

            // Xóa đơn hàng đã trả hoặc bị từ chối
            String deleteOrdersSQL = "DELETE FROM BookOrders WHERE BookID = ?";
            PreparedStatement deleteOrders = conn.prepareStatement(deleteOrdersSQL);
            deleteOrders.setString(1, bookId);
            deleteOrders.executeUpdate();

            // Xóa liên kết tác giả
            String deleteBookAuthor = "DELETE FROM Book_Author WHERE BookID = ?";
            PreparedStatement deleteBA = conn.prepareStatement(deleteBookAuthor);
            deleteBA.setString(1, bookId);
            deleteBA.executeUpdate();

            // Xóa Book
            String deleteBookSQL = "DELETE FROM Book WHERE BookID = ?";
            PreparedStatement deleteBook = conn.prepareStatement(deleteBookSQL);
            deleteBook.setString(1, bookId);
            int result = deleteBook.executeUpdate();

            conn.commit();

            return result > 0;

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

}
