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
import Model.service;
import java.math.BigDecimal;
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
    public ResultSet getAllInfo(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Reservation where username = ? ");
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param room_id
     * @return
     */
    public int getHotelIDbyRomID(int room_id) {
        int hotel_id = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select hotel_id from Room where room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if (rs.next()) {

            }
        } catch (SQLException e) {

        }
        return hotel_id;
    }

    public List<reservation> getReservationByUsername(String username) {
        List<reservation> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Reservation where username = ? ");
            ps.setString(1, username);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                service s = new service(rs.getInt("service_id"));
                room r = new room(rs.getInt("room_id"));
                account a = new account(rs.getString("username"));
                list.add(i, new reservation(rs.getInt("re_id"),
                        rs.getInt("status"),
                        rs.getDate("re_date"),
                        rs.getInt("quantity"),
                        rs.getDate("check_in_date"),
                        rs.getDate("check_out_date"),
                        rs.getInt("list_price"), r, s, a));
                i++;
            }
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public reservation insertReservation(reservation newRs) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Reservation "
                    + "(status, re_date, quantity, check_in_date, check_out_date, list_price, room_id, service_id, username) VALUES \n"
                    + "(0, ?, ?, ?, ?, ?, ?, ?, ?);");
            ps.setDate(1, newRs.getRe_date());
            ps.setInt(2, newRs.getQuantity());
            ps.setDate(3, newRs.getCheck_in_date());
            ps.setDate(4, newRs.getCheck_out_date());
            ps.setBigDecimal(5, BigDecimal.valueOf(newRs.getList_price()));
            ps.setInt(6, newRs.getRoom().getRoom_id());
            ps.setInt(7, newRs.getService().getService_id());
            ps.setString(8, newRs.getAccount().getUsername());
            count = ps.executeUpdate();
        } catch (Exception e) {
        }
        return (count == 0) ? null : newRs;
    }
//    public boolean getReservationExsitByUsername(String username){
//        int count = 0;
//        try {
//            PreparedStatement ps = conn.prepareStatement("select * from Reservation where username = ?");
//            ps.setString(1, username);
//            ResultSet rs = ps.executeQuery();
//            while(rs.next()){
//                return true;
//            }
//        } catch (Exception e) {
//        }
//        return false;
//    }
}
