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
public class hotelDAOs {

    Connection conn;

    /**
     *
     */
    public hotelDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteHotel(int hotel_id) {

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM [dbo].[Hotel] WHERE hotel_id = ?");
            ps.setInt(1, hotel_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM [dbo].[Service] WHERE hotel_id = ?");
            ps.setInt(1, hotel_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public void insertHotel(hotel hotel) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO [dbo].[Hotel]\n"
                    + "           ([hotel_name]\n"
                    + "           ,[hotel_address]\n"
                    + "           ,[hotel_img]\n"
                    + "           ,[hotel_description]\n"
                    + "           ,[username])\n"
                    + "     VALUES(?,?,?,?,?)");
            ps.setString(1, hotel.getHotel_name());
            ps.setString(2, hotel.getHotel_address());
            ps.setString(3, hotel.getHotel_img());
            ps.setString(4, hotel.getHotel_description());
            ps.setString(5, hotel.getUsername().getUsername());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateHotel(hotel hotel) {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [dbo].[Hotel]\n"
                    + "   SET [hotel_name] = ?\n"
                    + "      ,[hotel_address] = ?\n"
                    + "      ,[hotel_img] = ?\n"
                    + "      ,[hotel_description] = ?\n"
                    + "      ,[username] = ?\n"
                    + " WHERE [hotel_id] = ?");
            ps.setString(1, hotel.getHotel_name());
            ps.setString(2, hotel.getHotel_address());
            ps.setString(3, hotel.getHotel_img());
            ps.setString(4, hotel.getHotel_description());
            ps.setString(5, hotel.getUsername().getUsername());
            ps.setInt(6, hotel.getHotel_id());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<hotel> getListByPage(List<hotel> list, int start, int end) {
        ArrayList<hotel> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<hotel> getHotelByLocal(String local) {
        List<hotel> h = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Hotel where hotel_address LIKE ?");
            ps.setString(1, "%" + local + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                account ac = new account(rs.getString("username"));
                h.add(new hotel(rs.getInt("hotel_id"), rs.getString("hotel_name"), rs.getString("hotel_address"),
                        rs.getString("hotel_img"), rs.getString("hotel_description"), ac));
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return h;
    }

    public List<hotel> getHotelListByHotelID(int hotel_id) {
        List<hotel> h = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Hotel where hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                account ac = new account(rs.getString("username"));
                h.add(new hotel(rs.getInt("hotel_id"), rs.getString("hotel_name"), rs.getString("hotel_address"),
                        rs.getString("hotel_img"), rs.getString("hotel_description"), ac));
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return h;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
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

    /**
     *
     * @return
     */
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

    /**
     *
     * @param username
     * @return
     */
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

    public hotel getHotelByRoomID(int room_id) {
        hotel h = null;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select h.username, h.hotel_id, hotel_name, hotel_address, hotel_img, hotel_description\n"
                    + "from Hotel h\n"
                    + "join Room r on h.hotel_id = r.hotel_id\n"
                    + "where r.room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                account a = new account(rs.getString(1));
                h = new hotel(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), a);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return h;
    }

     public int CountHotel() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Hotel ");
            
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }
    
    public int CountHotel(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Hotel \n"
                    + "WHERE username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public List<hotel> SearchHotelByKeyWord(String text) {
        List<hotel> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select distinct a.username, h.hotel_id, hotel_name, hotel_address, hotel_img, hotel_description\n"
                    + "from Hotel h\n"
                    + "inner join Account a on h.username = a.username\n"
                    + "inner join [Service] s on h.hotel_id = s.hotel_id\n"
                    + "where h.hotel_id LIKE ? OR hotel_address LIKE ? OR [service_name] LIKE ?\n"
                    + "order by h.hotel_id");
            ps.setString(1, text);
            ps.setString(2, "%" + text + "%");
            ps.setString(3, "%" + text + "%");
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
     public String getHotelImgByHotelID(int hotel_id) {
        ResultSet rs = null;
        String img = "";
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Hotel where hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                img = rs.getString("hotel_img");
            }
        } catch (SQLException e) {
        }
        return img;
    }
}
