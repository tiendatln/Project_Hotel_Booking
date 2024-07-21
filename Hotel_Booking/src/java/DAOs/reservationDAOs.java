/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Model.account;
import Model.hotel;
import Model.reservation;
import Model.room;
import Model.roomType;
import Model.service;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tiend
 */
public class reservationDAOs {

    Connection conn;

    /**
     *
     */
    public reservationDAOs() {
        try {
            conn = DBConnection.connect();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param username
     * @return
     */
    public ResultSet getAllInfo(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Reservation where username = ? ");
            ps.setString(1, username);
            rs = ps.executeQuery();
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return rs;
    }

    /**
     *
     * @param local
     * @return
     */
    public List<reservation> getReservationAndHotelByLocalAndDate(String local, Date CheckInDate, Date CheckOutDate) {
        List<reservation> re = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM Hotel h \n"
                    + "join Room r on r.hotel_id = h.hotel_id \n"
                    + "join Reservation rs on rs.room_id = r.room_id \n"
                    + "where hotel_address LIKE ? and (? BETWEEN check_in_date \n"
                    + "AND check_out_date or ? BETWEEN check_in_date and check_out_date)\n"
                    + "or (check_in_date BETWEEN ? AND ? \n"
                    + "or check_out_date BETWEEN ? and ?)\n"
                    + "ORDER BY h.hotel_id, r.room_id  ASC;");
            ps.setString(1, "%" + local + "%");
            ps.setDate(2, CheckInDate);
            ps.setDate(3, CheckOutDate);
            ps.setDate(4, CheckInDate);
            ps.setDate(5, CheckOutDate);
            ps.setDate(6, CheckInDate);
            ps.setDate(7, CheckOutDate);
            rs = ps.executeQuery();
            while (rs.next()) {
                roomDAOs rDAO = new roomDAOs();
                hotelDAOs hDAO = new hotelDAOs();
                room r = rDAO.getRoomByRoomID(rs.getInt("room_id"));
                hotel h = hDAO.getHotelByRoomID(r.getRoom_id());
                r.setHotel(h);
                service sv = new service(rs.getInt("service_id"));
                account ac = new account(rs.getString("username"));
                re.add(new reservation(rs.getInt("re_id"), rs.getInt("status"), rs.getDate("re_date"), rs.getInt("quantity"),
                        rs.getDate("check_in_date"), rs.getDate("check_out_date"),
                        rs.getInt("list_price"), r, sv, ac));
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return re;
    }

    public List<reservation> getReservationAndRoomByLocalAndDate(Date CheckInDate, Date CheckOutDate, int hotel_id) {
        List<reservation> re = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * \n"
                    + "FROM Hotel h \n"
                    + "JOIN Room r ON r.hotel_id = h.hotel_id \n"
                    + "JOIN Reservation rs ON rs.room_id = r.room_id \n"
                    + "WHERE h.hotel_id = ?  \n"
                    + "  AND ((? BETWEEN rs.check_in_date AND rs.check_out_date \n"
                    + "        and ? BETWEEN rs.check_in_date AND rs.check_out_date) \n"
                    + "       OR (rs.check_in_date BETWEEN ? AND ? \n"
                    + "           and rs.check_out_date BETWEEN ? AND ?)) \n"
                    + "  \n"
                    + "ORDER BY h.hotel_id, r.room_id ASC;");
            ps.setInt(1, hotel_id);
            ps.setDate(2, CheckInDate);
            ps.setDate(3, CheckOutDate);
            ps.setDate(4, CheckInDate);
            ps.setDate(5, CheckOutDate);
            ps.setDate(6, CheckInDate);
            ps.setDate(7, CheckOutDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                hotelDAOs hDAO = new hotelDAOs();
                hotel h = hDAO.getHotelByRoomID(rs.getInt("room_id"));
                roomType rt = new roomType(rs.getInt("room_type_id"));
                room r = new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"), 
                        rs.getBoolean("room_status"), rs.getString("room_description"), rt, rs.getInt("room_capacity"), h);
                service sv = new service(rs.getInt("service_id"));
                account ac = new account(rs.getString("username"));
                re.add(new reservation(rs.getInt("re_id"), rs.getInt("status"), rs.getDate("re_date"), rs.getInt("quantity"),
                        rs.getDate("check_in_date"), rs.getDate("check_out_date"),
                        rs.getInt("list_price"), r, sv, ac));
            }
        } catch (SQLException e) {
            Logger.getLogger(roomDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return re;
    }

    public static void main(String[] args) {
        long millis = System.currentTimeMillis();
        long tenDaysInMillis = 10L * 24 * 60 * 60 * 1000;
        long checkoutMillis = millis + tenDaysInMillis;
        Date checkinDate = new Date(millis);
        Date checkoutDate = new Date(checkoutMillis);
        reservationDAOs red = new reservationDAOs();
        List<reservation> re = red.getReservationAndRoomByLocalAndDate(checkinDate, checkoutDate, 1);
        int i = 0;
        while (i < re.size()) {
            System.out.println(re.get(i).getRoom().getRoom_id());
            i++;
        }

    }

    /**
     *
     * @param room_id
     * @return
     */
    public int getHotelIDbyRomID(int room_id) {
        int hotel_id = 0;
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select hotel_id from Room where room_id = ?");
            ps.setInt(1, room_id);
            rs = ps.executeQuery();
            if (rs.next()) {

            }
        } catch (SQLException e) {

        }
        return hotel_id;
    }

    public void setStatusBooking(int re_id, int status) {
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE [dbo].[Reservation]\n"
                    + " SET [status] = ? \n"
                    + " WHERE re_id = ?");
            ps.setInt(1, status);
            ps.setInt(2, re_id);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<reservation> getReservationByUsername(String username) {
        List<reservation> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select * from Reservation where username = ? ORDER BY [status] ASC; ");
            ps.setString(1, username);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                hotelDAOs hDAO = new hotelDAOs();
                hotel h = hDAO.getHotelByRoomID(rs.getInt("room_id"));
                service s = new service(rs.getInt("service_id"));
                room r = new room(rs.getInt("room_id"));
                r.setHotel(h);
                account a = new account(rs.getString("username"));
                list.add(i, new reservation(rs.getInt("re_id"),
                        rs.getInt("status"),
                        rs.getDate("re_date"),
                        rs.getInt("quantity"),
                        rs.getDate("check_in_date"),
                        rs.getDate("check_out_date"),
                        rs.getInt("list_price"), r, s, a));
                i++;
            }
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public reservation insertReservation(reservation newRs) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Reservation "
                    + "(status, re_date, quantity, check_in_date, check_out_date, list_price, room_id, service_id, username) VALUES \n"
                    + "(0, ?, ?, ?, ?, ?, ?, ?, ?);");
            ps.setDate(1, newRs.getRe_date());
            ps.setInt(2, newRs.getQuantity());
            ps.setDate(3, newRs.getCheck_in_date());
            ps.setDate(4, newRs.getCheck_out_date());
            ps.setBigDecimal(5, BigDecimal.valueOf(newRs.getList_price()));
            ps.setInt(6, newRs.getRoom().getRoom_id());
            ps.setInt(7, newRs.getService().getService_id());
            ps.setString(8, newRs.getAccount().getUsername());
            count = ps.executeUpdate();
        } catch (Exception e) {
        }
        return (count == 0) ? null : newRs;
    }

    public List<reservation> getBookingByOwner(String username) {
        List<reservation> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select re.service_id, r.room_id, re.username, re.re_id, [status], re_date, re.quantity, check_in_date, check_out_date, list_price\n"
                    + "from Reservation re\n"
                    + "join Room r on re.room_id = r.room_id\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "where h.username = ? \n"
                    + "Order by [status]");
            ps.setString(1, username);
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                service s = new service(rs.getInt(1));
                room r = new room(rs.getInt(2));
                account a = new account(rs.getString(3));
                list.add(i, new reservation(rs.getInt(4),
                        rs.getInt(5),
                        rs.getDate(6),
                        rs.getInt(7),
                        rs.getDate(8),
                        rs.getDate(9),
                        rs.getInt(10), r, s, a));
                i++;

            }
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    public List<reservation> getListByPage(List<reservation> list, int start, int end) {
        ArrayList<reservation> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public boolean deleteReservationByUsername(String username) {
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM Reservation WHERE username = ?");
            ps.setString(1, username);
            count = ps.executeUpdate();
            if (count > 0) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(accountDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }


    public int CountBooking() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation ");

            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountConfirmBooking() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation "
                    + "WHERE [status] = 1");
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountCancelBooking() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation "
                    + "WHERE [status] = 2");
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountPendingBooking() {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation \n"
                    + "WHERE [status] = 0");

            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }
    
    public int CountBooking(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation re\n"
                    + "join Room r on re.room_id = r.room_id\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "WHERE h.username = ?");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountConfirmBooking(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation re\n"
                    + "join Room r on re.room_id = r.room_id\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "WHERE h.username = ? AND re.[status] = 1");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountCancelBooking(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation re\n"
                    + "join Room r on re.room_id = r.room_id\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "WHERE h.username = ? AND re.[status] = 2");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public int CountPendingBooking(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation re\n"
                    + "join Room r on re.room_id = r.room_id\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "WHERE h.username = ? AND re.[status] = 0");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }

    public List<reservation> SearchBooking(String text) {
        List<reservation> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select re.service_id, r.room_id, re.username, re.re_id, [status], re_date, re.quantity, check_in_date, check_out_date, list_price\n"
                    + "from Reservation re\n"
                    + "inner join Room r on re.room_id = r.room_id\n"
                    + "inner join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "where re_id LIKE ? OR re.username LIKE ? OR h.hotel_name LIKE ?\n"
                    + "Order by [status], re_date desc");
            ps.setString(1, text);
            ps.setString(2, "%" + text + "%");
            ps.setString(3, "%" + text + "%");
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                service s = new service(rs.getInt(1));
                room r = new room(rs.getInt(2));
                account a = new account(rs.getString(3));
                list.add(i, new reservation(rs.getInt(4),
                        rs.getInt(5),
                        rs.getDate(6),
                        rs.getInt(7),
                        rs.getDate(8),
                        rs.getDate(9),
                        rs.getInt(10), r, s, a));
                i++;

            }
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }
    public List<reservation> SearchBooking(String username, String text) {
        List<reservation> list = new ArrayList<>();
        ResultSet rs = null;
        try {
            PreparedStatement ps = conn.prepareStatement("select re.service_id, r.room_id, re.username, re.re_id, [status], re_date, re.quantity, check_in_date, check_out_date, list_price\n"
                    + "from Reservation re\n"
                    + "inner join Room r on re.room_id = r.room_id\n"
                    + "inner join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "where h.username = ? AND re_id LIKE ? OR re.username LIKE ? OR h.hotel_name LIKE ?\n"
                    + "Order by [status], re_date desc");
            ps.setString(1, username);
            ps.setString(2, text);
            ps.setString(3, "%" + text + "%");
            ps.setString(4, "%" + text + "%");
            rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                service s = new service(rs.getInt(1));
                room r = new room(rs.getInt(2));
                account a = new account(rs.getString(3));
                list.add(i, new reservation(rs.getInt(4),
                        rs.getInt(5),
                        rs.getDate(6),
                        rs.getInt(7),
                        rs.getDate(8),
                        rs.getDate(9),
                        rs.getInt(10), r, s, a));
                i++;

            }
        } catch (SQLException e) {
            Logger.getLogger(reservationDAOs.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }
    public int CountRejectBooking(String username) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) as 'count'\n"
                    + "FROM Reservation re\n"
                    + "join Room r on re.room_id = r.room_id\n"
                    + "join Hotel h on r.hotel_id = h.hotel_id\n"
                    + "WHERE h.username = ? AND re.[status] = 2");
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return count;
    }
}
