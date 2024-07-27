/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.account;
import Model.updateRole;
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
            PreparedStatement ps = conn.prepareStatement("INSERT INTO UpdateRole(hotel_name, hotel_address, business_licens_img, status, username) \n"
                    + "VALUES (?,?,?,?,?);");
            ps.setString(1, upRole.getHotel_name());
            ps.setString(2, upRole.getHotel_address());
            ps.setString(3, upRole.getBusiness_licens_img());
            ps.setInt(4, upRole.getStatus());
            ps.setString(5, upRole.getAccount().getUsername());
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
                if(rs.getInt("status") != 1){
                return true;
                }
            }
        } catch (Exception e) {
        }
        return  false;
    }
    
    public  updateRole getUpdateRoleOfUsername(String username){
        updateRole ud = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from UpdateRole where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                account ac = new account(rs.getString("username"));
                ud = new updateRole(rs.getInt("id"), rs.getString("hotel_name"), rs.getString("hotel_address"), 
                        rs.getString("business_licens_img"), rs.getInt("status"), ac);
            }
        } catch (Exception e) {
        }
        return  ud;
    }
    
    public List<updateRole> getAllUpdateRole() {
       
        List<updateRole> list = new ArrayList<>();
        try {
            PreparedStatement st =conn.prepareStatement("select u.username, u.id,u.hotel_name, u.hotel_address, u.business_licens_img, u.status  from UpdateRole u");
            ResultSet rs = st.executeQuery();
       
            while (rs.next()) {
                account a = new account(rs.getString(1));
       
                list.add(new updateRole(rs.getInt(2), rs.getString(3),  rs.getString(4), rs.getString(5), rs.getInt(6), a));
            }
  
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
      public void deleteUpdateRole(int id) {
        String sql = "DELETE FROM [dbo].[UpdateRole]\n"
                + "WHERE id = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
          public List<updateRole> getUpdateRoleById(int id) {
        
        List<updateRole> list = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement("select *\n"
                    + "from [dbo].[UpdateRole] u\n"
                    + " join [dbo].[Account] a on a.username = u.username\n"
                    + " where u.id =?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                list.add(new updateRole(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5), new account(rs.getString(6))));
                
            }
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}
