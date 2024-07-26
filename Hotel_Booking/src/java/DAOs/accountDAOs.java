/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import Model.account;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tiend
 */
public class accountDAOs {

    Connection conn;

    /**
     *
     */
    public accountDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param input
     * @return
     */
    public static String getMd5(String input) {
        try {

            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     *
     * @param username
     * @param password
     * @return
     */
    public ResultSet getAccount(String username, String password) {
        ResultSet rs = null;
        try {
            String pw = getMd5(username);
            PreparedStatement ps = conn.prepareStatement("select * from Account where username = ? and password = ?");
            ps.setString(0, username);
            ps.setString(1, pw);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param username
     * @return
     */
    public boolean checkUser(String username) {
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Account where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    /**
     *
     * @param username
     * @param password
     * @return
     */
    public boolean checkPassword(String username, String password) {
        try {
            String pass = getMd5(password);
            PreparedStatement ps = conn.prepareStatement("select * from Account where username = ? and password = ?");
            ps.setString(1, username);
            ps.setString(2, pass.toLowerCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }
 public List<account> getAllAccountNotAdmin() {
        String sql = "select * from [dbo].[Account]\n"
                + "where   is_admin != 1";
        List<account> list = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new account(rs.getString(1), rs.getString(2), rs.getByte(3), rs.getByte(4), rs.getByte(5),
                        rs.getByte(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getInt(10), rs.getString(11), rs.getString(12)));
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    /**
     *
     * @param username
     * @return
     */
    public account getAccount(String username) {
        account ac = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Account where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ac = new account(rs.getString("username"), rs.getString("password"), rs.getByte("is_owner"), rs.getByte("is_manager"), rs.getByte("is_admin"), rs.getByte("ban_status"), rs.getInt("report_count"), rs.getString("email"), rs.getString("name"), rs.getInt("age"), rs.getString("phone"), rs.getString("id_number"));
            }
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return ac;
    }

    /**
     *
     * @param newAccount
     * @return
     */
    public account addNewCusAccount(account newAccount) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Insert into Account values (?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, newAccount.getUsername());
            ps.setString(2, newAccount.getPassword());
            ps.setByte(3, (byte) 0);
            ps.setByte(4, (byte) 0);
            ps.setByte(5, (byte) 0);
            ps.setByte(6, (byte) 0);
            ps.setInt(7, 0);
            ps.setString(8, newAccount.getEmail());
            ps.setString(9, newAccount.getName());
            ps.setInt(10, newAccount.getAge());
            ps.setString(11, newAccount.getPhone());
            ps.setString(12, newAccount.getId_number());
            count = ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return (count == 0) ? null : newAccount;
    }

    /**
     *
     * @param updateAcc
     * @return
     */
    public account updateAccount(account updateAcc) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update Account Set [name] = ?, email = ?, age = ?, phone = ?, id_number = ? where username = ?");
            ps.setString(1, updateAcc.getName());
            ps.setString(2, updateAcc.getEmail());
            ps.setInt(3, updateAcc.getAge());
            ps.setString(4, updateAcc.getPhone());
            ps.setString(5, updateAcc.getId_number());
            ps.setString(6, updateAcc.getUsername());
            count = ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return (count == 0) ? null : updateAcc;
    }

    /**
     *
     * @param newPass
     * @return
     */
    public account changePassword(account newPass) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update Account Set password = ? where username = ?");
            ps.setString(1, newPass.getPassword());
            ps.setString(2, newPass.getUsername());
            ps.setString(2, newPass.getUsername());
            count = ps.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return (count == 0) ? null : newPass;
    }

    /**
     *
     * @param username
     * @return
     */
    public String checkAccount(String username){
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Account where username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            if(rs.next()){
                if(rs.getBoolean("is_owner")){
                    return "owner";
                }else if (rs.getBoolean("is_admin")){
                    return "admin";
                }
            }
        } catch (Exception e) {
        }
        return "customer";
    }
    public boolean checkEmailUser(String email){
        
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Account where email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
        } catch (Exception e) {
        }
        return  false;
    }
    public List<account> getAllAccount() {
        String sql = "select * from account";
        List<account> list = new ArrayList<>();
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new account(rs.getString(1), rs.getString(2), rs.getByte(3), rs.getByte(4), rs.getByte(5),
                        rs.getByte(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getInt(10), rs.getString(11), rs.getString(12)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public void setOwner(String user_id, String owner) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [is_owner] = ? ,[is_manager] = 0, [is_admin] = 0  \n"
                + " WHERE  [username] = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, owner);
            st.setString(2, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
 public void setBan_status(String user_id, String ban) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [ban_status] = ?    \n"
                + " WHERE  [username] = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, ban);
            st.setString(2, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }
    public void setBan_status(String user_id, boolean ban) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [ban_status] = ?    \n"
                + " WHERE  [id_number] = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setBoolean(1, ban);
            st.setString(2, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void setBan_Status(String user_id, String ban) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [ban_status] = ?    \n"
                + " WHERE  [id_number] = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, ban);
            st.setString(2, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void deleteAccount(String id_number) {
        String sql = "DELETE FROM [dbo].[Account]\n"
                + "WHERE id_number = ?";

        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, id_number);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public boolean updatePasswordForget(String newPassword, String email){
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("Update Account Set password = ? where email = ?");
            ps.setString(1, newPassword);
            ps.setString(2, email);
            count = ps.executeUpdate();
            if(count > 0){
                return  true;
            }
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }
     public void setOwner(String user) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "   SET [is_owner] = 1 \n"
                + " WHERE  [username] = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, user);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
     public void setStatusUpdateRole(String user, int status) {
        String sql = "UPDATE [dbo].[UpdateRole]\n"
                + "   SET [status] = ? \n"
                + " WHERE  [username] = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, status);
            st.setString(2, user);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
     public boolean getStatusBanByUsername(String username){
         try {
             PreparedStatement ps = conn.prepareStatement("select ban_status from Account where username = ?");
             ps.setString(1, username);
             ResultSet rs = ps.executeQuery();
             if(rs.next()){
                 if(rs.getInt(1) == 1){
                     return true;
                 }
             }
         } catch (Exception e) {
         }
         return false;
     }
}
