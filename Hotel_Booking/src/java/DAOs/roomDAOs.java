/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.hotel;
import Model.room;
import Model.roomType;
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
public class roomDAOs {

    Connection conn;

    /**
     *
     */
    public roomDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<room> getAllRoomIDByHotelId(int hotel_id) {
        List<room> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room r join Hotel h on r.hotel_id = h.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {

                list.add(new room(rs.getInt("room_id")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public ResultSet getRoomByHotelID(int hotel_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room r join Hotel h on r.hotel_id = h.hotel_id where h.hotel_id = ? ");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public ResultSet showRoomTypeByHotelID(int hotel_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from RoomType rt join Room r on rt.room_type_id = r.room_type_id join Hotel h on h.hotel_id = r.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param room_id
     * @return
     */
    public ResultSet showRoomTypeByRoomID(int room_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from RoomType rt join Room r on rt.room_type_id = r.room_type_id where r.room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public int getLowPrice(int hotel_id) {
        int lowPrice = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select top 1 room_price from Room where hotel_id = ? order by room_price asc");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                lowPrice = rs.getInt("room_price");
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return lowPrice;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public int getHighPrice(int hotel_id) {
        int highPrice = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select top 1 room_price from Room where hotel_id = ? order by room_price desc");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                highPrice = rs.getInt("room_price");
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return highPrice;
    }

    /**
     *
     * @return
     */
    public ResultSet showRoomType() {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from RoomType");
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @return
     */
    public List<roomType> getRoomType() {
        List<roomType> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select room_type_id, name_type, room_capacity\n"
                    + "from RoomType");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new roomType(rs.getInt(1), rs.getString(2), rs.getInt(3)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     *
     * @param list
     * @param start
     * @param end
     * @return
     */
    public List<room> getListByPage(List<room> list, int start, int end) {
        ArrayList<room> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    /**
     *
     * @param username
     * @return
     */
    public List<room> getRoomByUsername(String username) {
        List<room> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select h.hotel_id, r.room_type_id, r.room_id, r.room_name, r.room_price, r.room_img, r.room_status, r.room_description\n"
                    + "from Room r\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "where h.username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt(1), "", "", "", "");
                roomType rt = new roomType(rs.getInt(2), "", "", 0);
                list.add(new room(rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getBoolean(7), rs.getString(8), rt, h));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     *
     * @param room_type_id
     * @return
     */
    public roomType getRoomTypeByID(int room_type_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select rt.room_type_id, name_type, room_capacity\n"
                    + "from RoomType rt \n"
                    + "join Room r on rt.room_type_id = r.room_type_id\n"
                    + "where r.room_type_id = ?");
            ps.setInt(1, room_type_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new roomType(rs.getInt(1), rs.getString(2), rs.getInt(3));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    /**
     *
     * @param room
     */
    public void insertRoom(room room) {

        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO [dbo].[Room]\n"
                    + "([room_name],[room_price],[room_img],[room_status],[room_description],[room_type_id],[hotel_id])\n"
                    + "VALUES(?,?,?,?,?,?,?)");
            ps.setString(1, room.getRoom_name());
            ps.setInt(2, room.getRoom_price());
            ps.setString(3, room.getRoom_img());
            ps.setBoolean(4, room.isRoom_status());
            ps.setString(5, room.getRoom_description());
            ps.setInt(6, room.getRoom_type().getRoom_type_id());
            ps.setInt(7, room.getHotel().getHotel_id());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    /**
     *
     * @param room_id
     */
    public void deleteRoom(int room_id) {

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM [dbo].[Room] WHERE room_id = ?");
            ps.setInt(1, room_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /**
     *
     * @param room
     */
    public void updateRoom(room room) {

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [dbo].[Room]\n"
                    + "SET [room_name] = ?\n"
                    + "      ,[room_price] = ?\n"
                    + "      ,[room_img] = ?\n"
                    + "      ,[room_status] = ?\n"
                    + "      ,[room_description] = ?\n"
                    + "      ,[room_type_id] = ?\n"
                    + "      ,[hotel_id] = ?\n"
                    + " WHERE room_id = ?");
            ps.setString(1, room.getRoom_name());
            ps.setInt(2, room.getRoom_price());
            ps.setString(3, room.getRoom_img());
            ps.setBoolean(4, room.isRoom_status());
            ps.setString(5, room.getRoom_description());
            ps.setInt(6, room.getRoom_type().getRoom_type_id());
            ps.setInt(7, room.getHotel().getHotel_id());
            ps.setInt(8, room.getRoom_id());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public List<room> getAllRoomImgByHotelId(int hotel_id) {
        List<room> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room r join Hotel h on r.hotel_id = h.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {

                list.add(new room(rs.getString("room_img")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    /**
     *
     * @param room_id
     * @return
     */
    public String getRoomImgByRoomID(int room_id) {
        ResultSet rs = null;
        String img = "";
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room where room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                img = rs.getString("room_img");
            }
        } catch (SQLException e) {
        }
        return img;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public int getNumberOfRoom(int hotel_id) {
        int count = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select room_id from Room where hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (Exception e) {
        }
        return count;
    }

    public List<Integer> getRoomIfCheckInAndCheckOutDateNotExistOnReservation(Date CheckInDate, Date CheckOutDate, int hotel_id) {
        List<Integer> list = null;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT r.room_id\n"
                    + "FROM Room r\n"
                    + "JOIN Reservation res ON r.room_id = res.room_id\n"
                    + "    AND (res.check_in_date  BETWEEN ? AND ?\n"
                    + "         or res.check_out_date  BETWEEN ? AND ?)\n"
                    + "		 \n"
                    + "WHERE r.hotel_id = ?;");
            ps.setDate(1, CheckInDate);
            ps.setDate(2, CheckOutDate);
            ps.setDate(3, CheckInDate);
            ps.setDate(4, CheckOutDate);
            ps.setInt(5, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("room_id"));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<room> getAllRoomByHotelID(int hotel_id) {
        List<room> r = null;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room where hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt("hotel_id"), "", "", "", "");
                roomType rt = new roomType(rs.getInt("room_type_id"), "", "", 0);
                r.add(new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"),
                        rs.getBoolean("room_status"), rs.getString("room_description"), rt, h));
            }
        } catch (Exception e) {
        }
        return r;
    }
}
