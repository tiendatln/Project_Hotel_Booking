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

    public serviceDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public ResultSet getSevice(int service_id){
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
    public ResultSet getServiceByHotelID(int hotel_id){
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Service s join Hotel h on h.hotel_id = s.hotel_id where h.hotel_id = ?");
            ps.setInt(1, hotel_id);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(serviceDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return  rs;
    }
    public List<service> getAllService() {
        List<service> list = new ArrayList<>(); 
        ResultSet rs = null; 
        try {
            PreparedStatement ps = conn.prepareStatement("select hotel_id, service_id, [service_name], service_price from [Service]"); 
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
}
