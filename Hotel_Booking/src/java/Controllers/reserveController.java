/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.feedbackDAOs;
import DAOs.hotelDAOs;
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
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 *
 * @author tiend
 */
public class reserveController extends HttpServlet {

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
            out.println("<title>Servlet reserveController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet reserveController at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/reserveController")) {
            String[] RoomId = request.getParameterValues("roomID");
            // Check if quantityAndRoomId is not null and contains a comma
            int hotelID = Integer.valueOf(request.getParameter("HotelID"));
            roomDAOs rDAO = new roomDAOs();
            long millis = System.currentTimeMillis();
            Date CheckInDate = new Date(millis);
            Date CheckOutDate = new Date(millis);
            CheckInDate = Date.valueOf(request.getParameter("checkInDate"));
            CheckOutDate = Date.valueOf(request.getParameter("checkOutDate"));
            LocalDate checkInDate = LocalDate.parse(request.getParameter("checkInDate"));
            LocalDate checkOutDate = LocalDate.parse(request.getParameter("checkOutDate"));
            long daysBetween = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            boolean flagCustomer = false;
            String value = "";
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    }
                }
            }
            if (flagCustomer) {
                try {
                    int totalPrice = 0;
                    serviceDAOs sDAO = new serviceDAOs();
                    List<reservation> re = new ArrayList<>();
                    List<service> sv = sDAO.getService(hotelID);
                    int ServicePrice = 0;
                    int j = 0;
                    while (j < sv.size()) {
                        ServicePrice += sv.get(j).getService_price();
                        j++;
                    }
                    int _servicePrice = ServicePrice;
                    _servicePrice *= daysBetween;
                    int totalServicePrice = _servicePrice;
                    int Quantity = 1;
                    for (int i = 0; i < RoomId.length; i++) {
                        room r = rDAO.getRoomByRoomID(Integer.valueOf(RoomId[i]));
                        re.add(i, new reservation(Quantity, r));
                        re.get(i).setRoom(r);
                        totalPrice += re.get(i).getRoom().getRoom_price() * daysBetween;
                        totalPrice *= Quantity;
                        totalServicePrice *= Quantity;
                        if (Quantity == 1 && i != 0) {
                            totalServicePrice += _servicePrice;
                        }
                    }
                    totalPrice += totalServicePrice;
                    accountDAOs aDAO = new accountDAOs();
                    hotelDAOs hDAO = new hotelDAOs();
                    account ac = aDAO.getAccount(value);
                    hotel ht = hDAO.getHotelDetailById(hotelID);
                    request.setAttribute("nameUser", ac);
                    request.setAttribute("hotel", ht);
                    request.setAttribute("day", daysBetween);
                    request.setAttribute("service", sv);
                    request.setAttribute("roomID", re);
                    request.setAttribute("servicePrice", _servicePrice);
                    request.setAttribute("totalServicePrice", totalServicePrice);
                    request.setAttribute("TotalPrice", totalPrice);
                    request.setAttribute("checkIndate", CheckInDate);
                    request.setAttribute("checkOutDate", CheckOutDate);
                    // Forward the request to hotelDetail.jsp
                    request.getRequestDispatcher("/customer/reserve.jsp").forward(request, response);
                } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                    // Handle the error or redirect to an error page
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantityAndRoomId format");
                }
            } else if (!flagCustomer) {
                List<room> roomImg = rDAO.getAllRoomImgByHotelId(hotelID);
                request.setAttribute("loginToReserve", true);

                List<room> room = new ArrayList<>();
                try {
                    ResultSet rs = rDAO.getRoomByHotelID(hotelID);
                    while (rs.next()) {
                        hotel h = new hotel(rs.getInt("hotel_id"));
                        roomType rt = new roomType(rs.getInt("room_type_id"));
                        room.add(new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"),
                                rs.getBoolean("room_status"), rs.getString("room_description"), rt, h));
                    }
                } catch (Exception e) {

                }

                request.setAttribute("roomImg", roomImg);
                request.getSession().setAttribute("hotelID", hotelID);
                request.setAttribute("room", room);
                feedbackDAOs fDAO = new feedbackDAOs();

                List<feedback> feedback = fDAO.getFeedbackByHotelID(hotelID);
                accountDAOs aDao = new accountDAOs();
                for (int i = 0; i < feedback.size(); i++) {
                    account ac = aDao.getAccount(feedback.get(i).getAccount().getUsername());
                    feedback.get(i).setAccount(ac);
                }

                request.setAttribute("feedback", feedback);
                request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
            }
        } else if (path.startsWith("/reserveController/Change")) {
            try {
                roomDAOs rDAO = new roomDAOs();
                Date checkInDate = Date.valueOf(request.getParameter("checkInDate"));
                Date checkOutDate = Date.valueOf(request.getParameter("checkOutDate"));
                int hotel_id = Integer.valueOf("HotelID");
                List<Integer> roomOnDate = rDAO.getRoomIfCheckInAndCheckOutDateNotExistOnReservation(checkInDate, checkOutDate, hotel_id);
                List<room> room = new ArrayList<>();
                ResultSet rs = rDAO.getRoomByHotelID(hotel_id);
                int i = 0;
                while (rs.next()) {
                    if (rs.getInt("room_id") == roomOnDate.get(i)) {
                        hotel hotel = new hotel(hotel_id);
                        roomType rt = new roomType(rs.getInt("room_type_id"));
                        room.add(new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"),
                                rs.getString("room_img"), rs.getBoolean("room_status"), rs.getString("room_description"), rt, hotel));
                    }
                    i++;
                }
                List<room> roomImg = rDAO.getAllRoomImgByHotelId(hotel_id);
                request.setAttribute("roomImg", roomImg);
                request.getSession().setAttribute("room", room);
                request.getSession().setAttribute("hotelID", hotel_id);
                request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
            } catch (Exception e) {
            }
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
        processRequest(request, response);
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
