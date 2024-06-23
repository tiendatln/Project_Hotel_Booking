/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class DBConnection {

    public static Connection connect() throws ClassNotFoundException, SQLException {
        //Khai bao driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        //Tao doi tuong Connection
        Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=Room_Booking_website;user=sa;password=1;encrypt=true;trustServerCertificate=true;");
        return conn;
    }
}
