/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.updateRole;
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
public class updateRoleDAOs {

    Connection conn;

    /**
     *
     */
    public updateRoleDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(updateRoleDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public updateRole insertUpdateRole(updateRole upRole) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO UpdateRole(hotel_name,hotel_address,business_licens_img,username) \n"
                    + "VALUES (?,?,?,?);");
            ps.setString(1, upRole.getHotel_name());
            ps.setString(2, upRole.getHotel_address());
            ps.setString(3, upRole.getBusiness_licens_img());
            ps.setString(4, upRole.getAccount().getUsername());
            count = ps.executeUpdate();
        } catch (SQLException e) {
        }
        return (count == 0)? null: upRole;
    }
    public  boolean getUpdateExistByUsername(String username){
        try {
            PreparedStatement ps = conn.prepareStatement("select * from UpdateRole where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (Exception e) {
        }
        return  false;
    }
}
