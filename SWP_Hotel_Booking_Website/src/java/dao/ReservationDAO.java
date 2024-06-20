/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class ReservationDAO extends DBContext{
    PreparedStatement ps = null; 
    ResultSet rs = null; 
    
    public ResultSet getAllInfo(String username) {        
        try {
            ps = connection.prepareStatement("select * from Reservation re join Account ac \n"
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
            Logger.getLogger(ReservationDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }
}
