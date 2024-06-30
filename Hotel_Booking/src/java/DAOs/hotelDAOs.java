/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.account;
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
public class hotelDAOs {

    Connection conn;

    public hotelDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet searchHotelByLocal(String local) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Hotel where hotel_address LIKE ?");
            ps.setString(1, "%" + local + "%");
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    public hotel getHotelDetailById(int hotel_id) {
        ResultSet rs = null;
        hotel htl = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Hotel where hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                htl = new hotel(rs.getInt("hotel_id"), rs.getString("hotel_name"), rs.getString("hotel_address"), rs.getString("hotel_img"), rs.getString("hotel_description"));
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return htl;
    }
    
        public ResultSet getAllHotel() {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Hotel");
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }
        
        public List<hotel> getHotelByUser(String username) {
        List<hotel> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select a.username, hotel_id, hotel_name, hotel_address, hotel_img, hotel_description\n"
                + "from Hotel h\n"
                + "join Account a on h.username = a.username\n"
                + "where h.username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                account a = new account(rs.getString(1));
                list.add(new hotel(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), a));
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return list;
    }
}
