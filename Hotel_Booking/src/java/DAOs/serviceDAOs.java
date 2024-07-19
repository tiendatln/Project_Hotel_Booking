/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.hotel;
import Model.service;
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
public class serviceDAOs {

    Connection conn;

    /**
     *
     */
    public serviceDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<service> getAllService() {
        List<service> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select hotel_id, service_id, [service_name], service_price \n"
                    + "from [Service]\n"
                    + "order by hotel_id");
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt(1));
                list.add(new service(rs.getInt(2), rs.getString(3), rs.getInt(4), h));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<service> getAllServiceByOwner(String username) {
        List<service> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select h.hotel_id, service_id, [service_name], service_price \n"
                    + "from [Service] s\n"
                    + "inner join Hotel h on s.hotel_id = h.hotel_id\n"
                    + "where h.username = ?\n"
                    + "order by h.hotel_id, service_id");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt(1));
                list.add(new service(rs.getInt(2), rs.getString(3), rs.getInt(4), h));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public List<service> SearchServiceByKeyWord(String username, String text) {
        List<service> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select h.hotel_id, service_id, [service_name], service_price \n"
                    + "from [Service] s\n"
                    + "inner join Hotel h on s.hotel_id = h.hotel_id\n"
                    + "where h.username = ? AND [service_name] LIKE ? OR h.hotel_name LIKE ?\n"
                    + "order by h.hotel_id");
            ps.setString(1, username);
            ps.setString(2, "%" + text + "%");
            ps.setString(3, "%" + text + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                hotel h = new hotel(rs.getInt(1));
                list.add(new service(rs.getInt(2), rs.getString(3), rs.getInt(4), h));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void insertService(service service) {
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO [dbo].[Service]\n"
                    + "           ([service_name]\n"
                    + "           ,[service_price]\n"
                    + "           ,[hotel_id])\n"
                    + "     VALUES(?,?,?)");
            ps.setString(1, service.getService_name());
            ps.setLong(2, service.getService_price());
            ps.setInt(3, service.getHotel().getHotel_id());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void updateService(service service) {
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [dbo].[Service]\n"
                    + "   SET [service_name] = ?\n"
                    + "      ,[service_price] = ?\n"
                    + "      ,[hotel_id] = ?\n"
                    + " WHERE [service_id] = ?");
            ps.setString(1, service.getService_name());
            ps.setLong(2, service.getService_price());
            ps.setInt(3, service.getHotel().getHotel_id());
            ps.setInt(4, service.getService_id());
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void deleteService(int service_id) {

        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM [dbo].[Service] WHERE service_id = ?");
            ps.setInt(1, service_id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }

    }

    public List<service> getListByPage(List<service> list, int start, int end) {
        ArrayList<service> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    /**
     *
     * @param service_id
     * @return
     */
    public ResultSet getSevice(int service_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Service where service_id = ?");
            ps.setInt(0, service_id);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(serviceDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param hotel_id
     * @return
     */
    public ResultSet getServiceByHotelID(int hotel_id) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Service s join Hotel h on h.hotel_id = s.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(serviceDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    public List<service> getService(int hotel_id) {
        ResultSet rs = null;
        List<service> s = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Service s join Hotel h on h.hotel_id = s.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
            int j = 0;
            while (rs.next()) {
                hotel h = new hotel(hotel_id);
                s.add(j, new service(rs.getInt("service_id"), rs.getString("service_name"), rs.getInt("service_price"), h));
                j++;
            }
        } catch (Exception e) {
        }
        return s;
    }

    public service getServiceByServiceID(int service_id) {
        ResultSet rs = null;
        service s = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Service where service_id = ?");
            ps.setInt(1, service_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                hotel h = new hotel(rs.getInt("hotel_id"));
                s = new service(rs.getInt("service_id"), rs.getString("service_name"), rs.getInt("service_price"), h);
            }
        } catch (SQLException e) {
            Logger.getLogger(serviceDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return s;
    }

}
