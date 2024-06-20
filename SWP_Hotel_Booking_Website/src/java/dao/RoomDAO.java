/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Hotel;
import model.Room;
import model.RoomType;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class RoomDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Room> getRoom() {
        List<Room> list = new ArrayList<>();
        String sql = "select h.hotel_id, rt.room_type_id, r.room_id, r.room_name, r.room_price, r.room_img, r.room_status\n"
                + "from Room r \n"
                + "join Hotel h on r.hotel_id = h.hotel_id \n"
                + "join RoomType rt on r.room_type_id = rt.room_type_id";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Hotel h = new Hotel(rs.getInt(1));
                RoomType rt = new RoomType(rs.getInt(2));
                list.add(new Room(rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getBoolean(7), rt, h));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<RoomType> getRoomType() {
        List<RoomType> list = new ArrayList<>();
        String sql = "select rt.room_type_id, name_type, room_description, room_capacity\n"
                + "from RoomType rt \n"
                + "join Room r on rt.room_type_id = r.room_type_id";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {               
                list.add(new RoomType(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4)));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Room> getListByPage(List<Room> list, int start, int end) {
        ArrayList<Room> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }        

    public Room getRoomByID(int room_id) {
        String sql = "select h.hotel_id, rt.room_type_id, r.room_id, r.room_name, r.room_price, r.room_img, r.room_status\n"
                + "from Room r \n"
                + "join Hotel h on r.hotel_id = h.hotel_id\n"
                + "join RoomType rt on r.room_type_id = rt.room_type_id\n"
                + "where r.room_id = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Hotel h = new Hotel(rs.getInt(1));
                RoomType rt = new RoomType(rs.getInt(2));
                Room r = new Room(rs.getInt(3), rs.getString(4), rs.getInt(5), rs.getString(6), rs.getBoolean(7), rt, h);
                return r;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }

    public RoomType getRoomTypeByID(int room_type_id) {
        String sql = "select rt.room_type_id, name_type, room_description, room_capacity\n"
                + "from RoomType rt \n"
                + "join Room r on rt.room_type_id = r.room_type_id\n"
                + "where r.room_type_id = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, room_type_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new RoomType(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return null;
    }
    
    
}
