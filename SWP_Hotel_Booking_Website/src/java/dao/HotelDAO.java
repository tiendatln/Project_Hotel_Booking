/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Hotel;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class HotelDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Hotel> getHotel() {
        List<Hotel> list = new ArrayList<>();
        String sql = "select a.username, h.hotel_id, h.hotel_name, h.hotel_address, h.hotel_img, h.hotel_detail\n"
                + "from Hotel h \n"
                + "join Account a on h.username = a.username";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString(1));
                list.add(new Hotel(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), a));
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return list;
    }

    public Hotel getHotelByID(int hotel_id) {
        String sql = "select a.username, h.hotel_id, h.hotel_name, h.hotel_address, h.hotel_img, h.hotel_detail\n"
                + "from Hotel h\n"
                + "join Account a on h.username = a.username\n"
                + "join Room r on h.hotel_id = r.hotel_id\n"
                + "where h.hotel_id = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString(1));
                return new Hotel(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), a);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Hotel> getHotelByUser(String username) {
        List<Hotel> list = new ArrayList<>();
        String sql = "select a.username, hotel_id, hotel_name, hotel_address, hotel_img, hotel_detail\n"
                + "from Hotel h\n"
                + "join Account a on h.username = a.username\n"
                + "where h.username = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                Account a = new Account(rs.getString(1));
                list.add(new Hotel(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), a));
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return list;
    }

}
