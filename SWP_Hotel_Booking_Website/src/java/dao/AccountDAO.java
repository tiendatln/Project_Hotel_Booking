/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class AccountDAO extends DBContext{
    PreparedStatement ps = null; 
    ResultSet rs = null; 
    
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

    public ResultSet getAccount(String username, String password) {
        ResultSet rs = null;
        try {
            String pw = getMd5(username);
            ps = connection.prepareStatement("select * from Account where username = ? and password = ?");
            ps.setString(0, username);
            ps.setString(1, pw);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    public boolean checkUser(String username) {
        try {
            ps = connection.prepareStatement("select * from Account where username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean checkPassword(String username, String password) {
        try {
            String pass = getMd5(password);
            ps = connection.prepareStatement("select * from Account where username = ? and password = ?");
            ps.setString(1, username);
            ps.setString(2, pass.toLowerCase());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public Account getAccount(String username) {
        Account ac = null;
        try {
            ps = connection.prepareStatement("select * from Account where username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                ac = new Account(rs.getString("username"), rs.getString("password"), rs.getBoolean("is_owner"), rs.getBoolean("is_manager"), rs.getBoolean("is_admin"), rs.getBoolean("ban_status"), rs.getInt("report_count"), rs.getString("email"), rs.getString("name"), rs.getInt("age"), rs.getString("phone"), rs.getString("id_number"));
            }
        } catch (SQLException e) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return ac;
    }

    public Account addNewCusAccount(Account newAccount) {
        int count = 0;
        try {
            ps = connection.prepareStatement("Insert into Account values (?,?,?,?,?,?,?,?,?,?,?,?)");
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
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return (count == 0) ? null : newAccount;
    }
}
