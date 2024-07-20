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

    public List<room> getAllRoomByHotelID(int hotel_id) {
        List<room> r = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room r join Hotel h on r.hotel_id = h.hotel_id where h.hotel_id = ? ");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt("hotel_id"));
                roomType rt = new roomType(rs.getInt("room_type_id"));
                r.add(new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"),
                        rs.getBoolean("room_status"), rs.getString("room_description"), rt, rs.getInt("room_capacity"), h));
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return r;
    }

    public int getRoomCountByHotelID(int hotel_id) {
        int count = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(r.room_id) AS room_count\n"
                    + "FROM Room r\n"
                    + "JOIN Hotel h ON r.hotel_id = h.hotel_id\n"
                    + "WHERE h.hotel_id = ?; ");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("room_count");
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
    }

    public int getCountRoomByRoomID(int room_id) {
        int count = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(r.room_id) AS room_count\n"
                    + "FROM Room r\n"
                    + "JOIN Reservation re ON re.room_id = r.room_id\n"
                    + "WHERE r.room_id = ?; ");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("room_count");
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return count;
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
            PreparedStatement ps = conn.prepareStatement("select room_type_id, name_type\n"
                    + "from RoomType");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new roomType(rs.getInt(1), rs.getString(2)));
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
            PreparedStatement ps = conn.prepareStatement("select h.hotel_id, r.room_type_id, r.room_id, r.room_name, r.room_price, r.room_img, r.room_status, r.room_description,r.room_capacity\n"
                    + "from Room r\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "where h.username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt(1), "", "", "", "");
                roomType rt = new roomType(rs.getInt(2), "", "");
                list.add(new room(rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getBoolean(7), rs.getString(8), rt, rs.getInt("room_capacity"), h));
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
            PreparedStatement ps = conn.prepareStatement("select rt.room_type_id, name_type\n"
                    + "from RoomType rt \n"
                    + "join Room r on rt.room_type_id = r.room_type_id\n"
                    + "where r.room_type_id = ?");
            ps.setInt(1, room_type_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new roomType(rs.getInt(1), rs.getString(2));
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

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM [dbo].[Reservation] WHERE room_id = ?");
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

    public List<Integer> getRoomIfCheckInAndCheckOutDateNotExistOnReservation(Date CheckInDate, Date CheckOutDate, int hotel_id) {
        List<Integer> list = new ArrayList<>();
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

    public room getRoomByRoomID(int room_id) {
        room r = null;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room where room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                hotel h = new hotel(rs.getInt("hotel_id"));
                roomType rt = new roomType(rs.getInt("room_type_id"));
                r = new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"),
                        rs.getBoolean("room_status"), rs.getString("room_description"), rt, rs.getInt("room_capacity"), h);
            }
        } catch (Exception e) {
        }
        return r;
    }
//    public static void main(String[] args) {
//        roomDAOs rd = new roomDAOs();
//        room r = rd.getRoomByRoomID(1);
//        System.out.println(r);
//    }

    public room getRoomModelByHotelID(int hotel_id) {
        room r = null;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room where room_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                hotel h = new hotel(rs.getInt("hotel_id"));
                roomType rt = new roomType(rs.getInt("room_type_id"));
                r = new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"),
                        rs.getBoolean("room_status"), rs.getString("room_description"), rt, rs.getInt("room_capacity"), h);
            }
        } catch (Exception e) {
        }
        return r;
    }

    public List<room> getRoom(int hotel_id, List<Integer> roomOnDate) {
        List<room> room = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Room r join Hotel h on r.hotel_id = h.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                if (rs.getInt("room_id") == roomOnDate.get(i)) {
                    hotel hotel = new hotel(hotel_id);
                    roomType rt = new roomType(rs.getInt("room_type_id"));
                    room.add(new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"),
                            rs.getString("room_img"), rs.getBoolean("room_status"), rs.getString("room_description"), rt, rs.getInt("room_capacity"), hotel));
                }
                i++;
            }
        } catch (Exception e) {
        }
        return room;
    }
    
    public int CountRoom() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Room ");
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }
    
    public int CountRoom(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Room r\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
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

     public List<room> SearchRoomByKeyWord(String username, String text) {
        List<room> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select h.hotel_id, r.room_type_id, r.room_id, r.room_name, r.room_price, r.room_img, r.room_status, r.room_description,r.room_capacity\n"
                    + "from Room r\n"
                    + "inner join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "inner join RoomType rt on r.room_type_id = rt.room_type_id\n"
                    + "where h.username = ? AND room_id LIKE ? OR room_name LIKE ? OR rt.name_type LIKE ? OR h.hotel_name LIKE ?");
            ps.setString(1, username);
            ps.setString(2, text);
            ps.setString(3, "%" + text + "%");
            ps.setString(4, "%" + text + "%");
            ps.setString(5, "%" + text + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt(1), "", "", "", "");
                roomType rt = new roomType(rs.getInt(2), "", "");
                list.add(new room(rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getBoolean(7), rs.getString(8), rt, rs.getInt("room_capacity"), h));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

//        public static void main(String[] args) throws SQLException {
//        roomDAOs rd = new roomDAOs();
//        int count = rd.getRoomCountByHotelID(1);
//            System.out.println(count);
//    }
}
