/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}
