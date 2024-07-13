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
        try   {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Feedback WHERE hotel_id = ?");
            ps.setInt(1, hotel_id);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    feedback feedback = new feedback(rs.getString("comment"));
                    feedbackList.add(feedback);
                }
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
}
