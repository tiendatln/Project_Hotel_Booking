/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.account;
import Model.feedback;
import Model.hotel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tiend
 */
public class feedbackDAOs {

    Connection conn;

    /**
     *
     */
    public feedbackDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(feedbackDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<feedback> getFeedbackByHotelID(int hotel_id) {
        List<feedback> feedbackList = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Feedback f join Account a on a.username = f.username WHERE hotel_id = ?");
            ps.setInt(1, hotel_id);
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                account a = new account(rs.getString("username"));
                hotel ht = new hotel(hotel_id);
                feedback feedback = new feedback(rs.getInt("feedback_id"),rs.getString("comment"), a, ht);
                feedbackList.add(i, feedback);
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider proper logging or rethrowing the exception based on your requirement
        }
        return feedbackList;
    }

    public feedback addNewFeedback(feedback newFeedback, account ac, hotel ht) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Feedback (comment, username, hotel_id) VALUES \n"
                    + "(?, ?, ?);");
            ps.setString(1, newFeedback.getComment());
            ps.setString(2, ac.getUsername());
            ps.setInt(3, ht.getHotel_id());
            count = ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(feedbackDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return (count == 0) ? null : newFeedback;
    }

    public int getFeedbackExistByUsername(String username) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Feedback where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (Exception e) {
        }
        return count;
    }

    public boolean deleteFeedbackByUsername(String username) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM Feedback WHERE username = ?");
            ps.setString(1, username);
            count = ps.executeUpdate();
            if (count > 0) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public List<feedback> getFeedbackByOwner(String username) {
        List<feedback> feedbackList = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select f.username, h.hotel_id, feedback_id, comment \n"
                    + "from Feedback f\n"
                    + "join Hotel h on f.hotel_id = h.hotel_id\n"
                    + "where h.username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                account a = new account(rs.getString(1));
                hotel h = new hotel(rs.getInt(2));
                feedback feedback = new feedback(rs.getInt(3), rs.getString(4), a, h);
                feedbackList.add(i, feedback);
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider proper logging or rethrowing the exception based on your requirement
        }
        return feedbackList;
    }
    
    
    public List<feedback> getFeedbackByAdmin() {
        List<feedback> feedbackList = new ArrayList<>();
        try {
              PreparedStatement ps = conn.prepareStatement("select f.username, h.hotel_id, feedback_id, comment \n"
                    + "from Feedback f\n"
                    + "join Hotel h on f.hotel_id = h.hotel_id");
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                account a = new account(rs.getString(1));
                hotel h = new hotel(rs.getInt(2));
                feedback feedback = new feedback(rs.getInt(3), rs.getString(4), a, h);
                feedbackList.add(i, feedback);
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider proper logging or rethrowing the exception based on your requirement
        }
        return feedbackList;
    }

    public List<feedback> getListByPage(List<feedback> list, int start, int end) {
        ArrayList<feedback> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public int CountFeedback() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Feedback" );
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (Exception e) {
        }
        return count;
    }
     public int CountFeedback(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Feedback f\n"
                    + "join Hotel h on f.hotel_id = h.hotel_id\n"
                    + "WHERE h.username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public List<feedback> SearchFeedbackByKeyWord(String text) {
        List<feedback> feedbackList = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select f.username, h.hotel_id, feedback_id, comment\n"
                    + "from Feedback f \n"
                    + "inner join Hotel h on f.hotel_id = h.hotel_id\n"
                    + "where feedback_id LIKE ? OR f.username LIKE ? OR h.hotel_name LIKE ?");
            ps.setString(1, text);
            ps.setString(2, "%" + text + "%");
            ps.setString(3, "%" + text + "%");
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                account a = new account(rs.getString(1));
                hotel h = new hotel(rs.getInt(2));
                feedback feedback = new feedback(rs.getInt(3), rs.getString(4), a, h);
                feedbackList.add(i, feedback);
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider proper logging or rethrowing the exception based on your requirement
        }
        return feedbackList;
    }

    public boolean deleteFeedBack(int feedback_id) {
        boolean delete = false;
        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM Feedback WHERE feedback_id = ?");
            ps.setInt(1, feedback_id);
            delete = ps.execute();
        } catch (SQLException e) {
        }
        return delete;
    }
    public void deleteFeedback(int feedback_id) {

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM [dbo].[Feedback] WHERE feedback_id = ?");
            ps.setInt(1, feedback_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }      

    }
    public List<feedback> getFeedbackByCustomer(String username) {
        List<feedback> feedbackList = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select * \n"
                    + "from Feedback \n"
                    + "where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                account a = new account(rs.getString("username"));
                hotel h = new hotel(rs.getInt("hotel_id"));
                feedback feedback = new feedback(rs.getInt("feedback_id"), rs.getString("comment"), a, h);
                feedbackList.add(i, feedback);
                i++;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider proper logging or rethrowing the exception based on your requirement
        }
        return feedbackList;
    }
}
