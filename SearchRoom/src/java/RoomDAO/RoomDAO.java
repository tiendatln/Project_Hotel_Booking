/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package RoomDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Room;

/**
 *
 * @author KHA PHAM
 */
public class RoomDAO {
    String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName= Room_Booking_website";
    String jdbcUsername = "sa";
    String jdbcPassword = "123";

    private static final String txt= "SELECT room_id, room_name, room_price, room_status FROM Room";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e);
        }
        return connection;
    }

    public List<Room> selectAllRooms() {
        List<Room> rooms = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(txt);) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int roomId = rs.getInt("room_id");
                String roomName = rs.getString("room_name");
                double roomPrice = rs.getDouble("room_price");
                boolean roomStatus = rs.getBoolean("room_status");
                rooms.add(new Room(roomId, roomName, roomPrice, roomStatus));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return rooms;
    }

    public class request {

        public request() {
        }
    }
    
    public List<Room> searchRoomsByName(String name) {
    List<Room> rooms = new ArrayList<>();
    String query = "SELECT room_id, room_name, room_price, room_status FROM Room WHERE room_name LIKE ?";
    try (Connection connection = getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);) {
        preparedStatement.setString(1, "%" + name + "%");
        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            int roomId = rs.getInt("room_id");
            String roomName = rs.getString("room_name");
            double roomPrice = rs.getDouble("room_price");
            boolean roomStatus = rs.getBoolean("room_status");
            rooms.add(new Room(roomId, roomName, roomPrice, roomStatus));
        }
    } catch (SQLException e) {
        System.out.println(e);
    }
    return rooms;
    }
      public List<Room> searchRoomsByDate()  {
    List<Room> rooms = new ArrayList<>();
    String query = "SELECT R.room_id, R.room_name, R.room_price, R.room_status\n" +
"FROM Room R\n" +
"WHERE R.room_id NOT IN (\n" +
"    SELECT room_id \n" +
"    FROM Reservation \n" +
"    WHERE (check_in_date <= '2024-07-01' AND check_out_date >= '2024-06-30')\n" +
") AND R.room_status = 1;  ";
    try (Connection connection = getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);) {
 
        ResultSet rs = preparedStatement.executeQuery();

        while (rs.next()) {
            int roomId = rs.getInt("room_id");
            String roomName = rs.getString("room_name");
            double roomPrice = rs.getDouble("room_price");
            boolean roomStatus = rs.getBoolean("room_status");
            rooms.add(new Room(roomId, roomName, roomPrice, roomStatus));
        }
    } catch (SQLException e) {
        System.out.println(e);
    }
    return rooms;
    }
    
}
