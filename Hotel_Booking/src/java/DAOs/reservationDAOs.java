/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.reservation;
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
public class reservationDAOs {

    Connection conn;

    public reservationDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAllInfo(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Reservation re join Account ac \n"
                    + "on re.username = ac.username\n"
                    + "join room r\n"
                    + "on r.room_id = re.room_id\n"
                    + "join [Service] se\n"
                    + "on se.service_id = re.service_id\n"
                    + "join Hotel h\n"
                    + "on h.username = ac.username\n"
                    + "where re.username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }
    public reservation insertRoomIntoReserve(int room_id){
        reservation rs = null;
        try {
            
        } catch (Exception e) {
        }
        return rs;
    }
}
