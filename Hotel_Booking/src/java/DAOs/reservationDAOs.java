/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.account;
import Model.hotel;
import Model.reservation;
import Model.room;
import java.sql.Connection;
import java.sql.Date;
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
public class reservationDAOs {

    Connection conn;

    /**
     *
     */
    public reservationDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param username
     * @return
     */
    public List<reservation> getReservationByUsername(String username) {
        ResultSet rs = null;
        List<reservation> list = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Reservation where username = ? ");
            ps.setString(1, username);
            rs = ps.executeQuery();
            int i =0;
            while (rs.next()) {                
                hotel h = new hotel(rs.getInt("hotel_id"));
                room r = new room(rs.getInt("room_id"));
                account a = new account(rs.getString("username"));
                list.add(i, new reservation(rs.getInt("re_id"), rs.getBoolean("status"), rs.getDate("re_date"), i, check_in_date, check_out_date, i, r, h, a));
                i++;
            }
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    /**
     *
     * @param room_id
     * @return
     */
    public int getHotelIDbyRomID(int room_id){
        int hotel_id = 0;
        ResultSet rs = null; 
        try {
            long millis = System.currentTimeMillis();
            Date re_date = new Date(millis);
            PreparedStatement ps = conn.prepareStatement("select hotel_id from Room where room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if(rs.next()){
               
            }
        } catch (SQLException e) {
            
        }
        return hotel_id;
    }
//    public boolean getBooleanIfHave
}
