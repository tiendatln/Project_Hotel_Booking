/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.feedbackDAOs;
import DAOs.hotelDAOs;
import DAOs.reservationDAOs;
import DAOs.roomDAOs;
import DAOs.serviceDAOs;
import Model.account;
import Model.feedback;
import Model.hotel;
import Model.reservation;
import Model.room;
import Model.roomType;
import Model.service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
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
public class searchController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet searchController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet searchController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.endsWith("/ListHotel")) {

            request.getRequestDispatcher("/customer/listHotel.jsp").forward(request, response);
        } else if (path.startsWith("/searchController/HotelDetail")) {
            String[] s = path.split("/");
            Date checkinDate = Date.valueOf(s[s.length - 3]);
            Date checkoutDate = Date.valueOf(s[s.length - 2]);
            int hotel_id = Integer.valueOf(s[s.length - 1]);
            roomDAOs rDAO = new roomDAOs();
            List<room> roomImg = rDAO.getAllRoomImgByHotelId(hotel_id);
            String value = "";
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        break; //thoat khoi vong lap
                    }
                }
            }
            request.setAttribute("roomImg", roomImg);
            request.setAttribute("hotelID", hotel_id);

            feedbackDAOs fDAO = new feedbackDAOs();
            hotelDAOs hDAO = new hotelDAOs();
            reservationDAOs rsDAO = new reservationDAOs();
            account ac = new account();
            List<feedback> feedback = fDAO.getFeedbackByHotelID(hotel_id);
            accountDAOs aDao = new accountDAOs();
            for (int i = 0; i < feedback.size(); i++) {
                ac = aDao.getAccount(feedback.get(i).getAccount().getUsername());
                feedback.get(i).setAccount(ac);
            }
            request.setAttribute("feedback", feedback);
            List<reservation> reserve = rsDAO.getReservationByUsername(value);
            if (!reserve.isEmpty()) {
                int i = 0;
                boolean reserveExist = true;
                boolean status = false;
                int countStatus = 0;
                while (reserveExist) {
                    room r = rDAO.getRoomByRoomID(reserve.get(i).getRoom().getRoom_id());
                    hotel ht = hDAO.getHotelByRoomID(r.getRoom_id());
                    r.setHotel(ht);
                    reserve.get(i).setRoom(r);
                    if (reserve.get(i).getRoom().getHotel().getHotel_id() == hotel_id) {
                        reserveExist = false;
                        if (reserve.get(i).getStatus() == 1) {
                            countStatus++;
                        }
                        if (countStatus == reserve.size() - 1) {
                            status = true;
                        }
                    }
                    i++;
                }
                if (!reserveExist && status) {
                    int count = fDAO.getFeedbackExistByUsername(value);
                    if (count == 0 && count < 1) {
                        request.setAttribute("canFeedback", true);
                    }
                }
            }
            List<reservation> re = rsDAO.getReservationAndRoomByLocalAndDate(checkinDate, checkoutDate, hotel_id);
            List<room> listRoom = rDAO.getAllRoomByHotelID(hotel_id);
            List<room> room = new ArrayList<>();
            int i = 0;
            if (!re.isEmpty()) {
                int j = 0;
                while (i < listRoom.size()) { //roomID
                    boolean checkQuantity = true;
                    boolean checkRoomID = true;
                    int countRoom = 0;
                    int quantity = 0;
                    int room_id = listRoom.get(i).getRoom_id();
                    int k = 0;
                    while (j < re.size() && checkQuantity && checkRoomID) { //RoomID in reservation
                        int roomIdByReservation = re.get(j).getRoom().getRoom_id();
                        {
                            if (room_id == roomIdByReservation) {
                                int roomCapacity = re.get(j).getRoom().getRoom_capacity();
                                int reservationQuantity = re.get(j).getQuantity();
                                if (quantity == 0) {
                                    quantity = reservationQuantity;
                                }
                                if (k != 0 && roomIdByReservation == room_id) {
                                    quantity += re.get(j).getQuantity();
                                }
                                k++;
                                if (quantity >= roomCapacity) {
                                    if (1 > countRoom) {
                                        countRoom++;
                                        quantity = 0;
                                        k = 0;
                                    } else {
                                        checkQuantity = false;
                                    }
                                }
                            } else {
                                checkRoomID = false;
                            }
                            if (checkRoomID) {
                                j++;
                            }
                        }
                    }
//                    int roomCount = rDAO.getCountRoomByRoomID(listRoom.get(i).getRoom_id());
                    if (checkQuantity && 1 > countRoom) {
                        room.add(listRoom.get(i));
                    }
                    i++;
                }
                i = 0;

                while (i < listRoom.size()) {
                    int countRoomID = 0;
                    int y = 0;
                    while (y < re.size()) {
                        if (listRoom.get(i).getRoom_id() == re.get(y).getRoom().getRoom_id()) {
                            countRoomID++;
                        }
                        y++;
                    }
                    if (countRoomID >= re.size()) {
                        room.add(listRoom.get(i));
                    }
                    i++;
                }
            } else {
                room = listRoom;
            }
            i = 0;
            while (i < room.size()) {
                roomType rt = rDAO.getRoomTypeByID(room.get(i).getRoom_type().getRoom_type_id());
                room.get(i).setRoom_type(rt);
                i++;
            }
            request.setAttribute("re", re);
            request.setAttribute("r", room);
            request.setAttribute("checkInDate", checkinDate);
            request.setAttribute("checkOutDate", checkoutDate);
            request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
        } 
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("btnSearchHotel") != null) {
            String destination = request.getParameter("destination");
            if (!destination.equals("")) {
                try {
                    long millis = System.currentTimeMillis();
                    long tenDaysInMillis = 10L * 24 * 60 * 60 * 1000;
                    long checkoutMillis = millis + tenDaysInMillis;
                    Date checkinDate = new Date(millis);
                    Date checkoutDate = new Date(millis);
                    String roomType = request.getParameter("roomType");
                    checkinDate = Date.valueOf(request.getParameter("checkin-date"));
                    checkoutDate = Date.valueOf(request.getParameter("checkout-date"));
                    long checkin = checkinDate.getTime();
                    long checkout = checkoutDate.getTime();
                    if (checkin == checkout) {
                        checkoutDate = new Date(checkoutMillis);
                        checkout = checkoutDate.getTime();
                    }
                    hotelDAOs hDAO = new hotelDAOs();
                    roomDAOs roomDAO = new roomDAOs();
                    reservationDAOs reDAO = new reservationDAOs();
                    List<reservation> re = reDAO.getReservationAndHotelByLocalAndDate(destination, checkinDate, checkoutDate);
                    List<hotel> Listht = hDAO.getHotelByLocal(destination);
                    List<hotel> ht = new ArrayList<>();
                    if (re.isEmpty()) {
                        ht = Listht;
                    } else {
                        int i = 0;

                        while (i < Listht.size() && i < re.size()) {
                            int j = 0;
                            boolean checkQuantity = true;
                            boolean checkHotelID = true;
                            int countRoom = 0;
                            int quantity = 0;
                            int room_id = re.get(0).getRoom().getRoom_id();
                            int k = 0;
                            while (j < re.size() && checkQuantity && checkHotelID) {

                                int hotelIDByRoom = re.get(j).getRoom().getHotel().getHotel_id();
                                int HotelID = Listht.get(i).getHotel_id();
                                if (hotelIDByRoom == HotelID) {
                                    int r = re.get(j).getRoom().getRoom_id();
                                    if (room_id == r) {
                                        int roomCapacity = re.get(j).getRoom().getRoom_capacity();
                                        int reservationQuantity = re.get(j).getQuantity();
                                        int roomCount = roomDAO.getRoomCountByHotelID(Listht.get(i).getHotel_id());
                                        if (quantity == 0) {
                                            quantity = reservationQuantity;
                                        }
                                        if (k != 0) {
                                            quantity += re.get(j).getQuantity();
                                        }
                                        k++;
                                        if (reservationQuantity >= roomCapacity
                                                || quantity >= roomCapacity) {
                                            if (roomCount > countRoom) {
                                                countRoom++;
                                                quantity = 0;
                                                k = 0;
                                            } else {
                                                checkQuantity = false;
                                            }
                                        } else {

                                        }
                                        if (j < re.size() - 1) {
                                            room_id = re.get(j + 1).getRoom().getRoom_id();
                                        }
                                    } else {
                                        countRoom++;
                                        quantity = 0;
                                    }
                                    j++;
                                } else {
                                    checkHotelID = false;
                                }
                            }
                            int roomCount = roomDAO.getRoomCountByHotelID(Listht.get(i).getHotel_id());
                            if (checkQuantity && roomCount > countRoom) {
                                ht.add(Listht.get(i));
                            }

                            i++;
                        }
                        i = 0;
                        while (i < Listht.size()) {
                            int countHotelID = 0;
                            int y = 0;
                            while (y < re.size()) {
                                if (Listht.get(i).getHotel_id() != re.get(y).getRoom().getHotel().getHotel_id()) {
                                    countHotelID++;
                                }
                                y++;
                            }
                            if (countHotelID == re.size()) {
                                ht.add(Listht.get(i));
                            }
                            i++;
                        }
                    }

                    if (!ht.isEmpty()) {

                        serviceDAOs svDAO = new serviceDAOs();
                        List<service> sv = svDAO.getAllService();

                        request.setAttribute("destination", destination);
                        request.setAttribute("checkin", checkin);
                        request.setAttribute("checkout", checkout);
                        request.setAttribute("roomType", roomType);
                        request.setAttribute("hotel", ht);
                        request.setAttribute("service", sv);
                        request.getRequestDispatcher("/customer/listHotel.jsp").forward(request, response);
                    } else {
                        request.setAttribute("searchError", true);
                        request.getRequestDispatcher("/customer/home.jsp").forward(request, response);
                    }
                } catch (IOException e) {

                }
            } else {
                request.setAttribute("search", true);
                request.getRequestDispatcher("/customer/home.jsp").forward(request, response);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
