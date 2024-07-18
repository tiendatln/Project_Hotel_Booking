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
import jakarta.servlet.http.Cookie;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author tiend
 */
public class bookingController extends HttpServlet {

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
            out.println("<title>Servlet bookingController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet bookingController at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/bookingController/remove")) {
            String[] RoomId = request.getParameterValues("roomID");
            String[] s = path.split("/");
            // Check if quantityAndRoomId is not null and contains a comma
            int hotelID = Integer.valueOf(request.getParameter("HotelID"));
            int removeID = Integer.valueOf(s[s.length - 1]);
            String[] quantity = request.getParameterValues("quantity");
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
                    List<service> sv = sDAO.getService(hotelID);
                    List<reservation> re = new ArrayList<>();
                    int ServicePrice = 0;
                    int j = 0;
                    while (j < sv.size()) {
                        ServicePrice += sv.get(j).getService_price();
                        j++;
                    }
                    int Quantity = 1;
                    int _servicePrice = ServicePrice;
                    _servicePrice *= daysBetween;
                    int totalServicePrice = _servicePrice;
                    for (int i = 0; i < RoomId.length; i++) {
                        if (Integer.valueOf(RoomId[i]) != removeID) {
                            Quantity = Integer.valueOf(quantity[i]);
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
                    }
                    if(re != null){
                    totalPrice += totalServicePrice;
                    accountDAOs aDAO = new accountDAOs();
                    hotelDAOs hDAO = new hotelDAOs();
                    account ac = aDAO.getAccount(value);
                    hotel ht = hDAO.getHotelDetailById(hotelID);
                    request.setAttribute("roomID", re);
                    request.setAttribute("nameUser", ac);
                    request.setAttribute("hotel", ht);
                    request.setAttribute("day", daysBetween);
                    request.setAttribute("service", sv);
                    request.setAttribute("servicePrice", _servicePrice);
                    request.setAttribute("totalServicePrice", totalServicePrice);
                    request.setAttribute("TotalPrice", totalPrice);
                    request.setAttribute("checkIndate", CheckInDate);
                    request.setAttribute("checkOutDate", CheckOutDate);
                    // Forward the request to hotelDetail.jsp
                    request.getRequestDispatcher("/customer/reserve.jsp").forward(request, response);
                    }else{
                        
                    }
                } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                    // Handle the error or redirect to an error page
                    response.sendError(jakarta.servlet.http.HttpServletResponse.SC_BAD_REQUEST, "Invalid quantityAndRoomId format");
                }
            } else if (!flagCustomer) {
                List<room> roomImg = rDAO.getAllRoomImgByHotelId(hotelID);
                request.setAttribute("loginToReserve", true);

                List<room> room = rDAO.getAllRoomByHotelID(hotelID);
                
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
        } else if (path.startsWith("/bookingController/Change")) {
            String[] RoomId = request.getParameterValues("roomID");
            String[] s = path.split("/");
            // Check if quantityAndRoomId is not null and contains a comma
            int hotelID = Integer.valueOf(request.getParameter("HotelID"));
            String[] quantity = request.getParameterValues("quantity");
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
                    List<service> sv = sDAO.getService(hotelID);
                    List<reservation> re = new ArrayList<>();
                    int ServicePrice = 0;
                    int j = 0;
                    while (j < sv.size()) {
                        ServicePrice += sv.get(j).getService_price();
                        j++;
                    }
                    int Quantity = 1;
                    int _servicePrice = ServicePrice;
                    _servicePrice *= daysBetween;
                    int totalServicePrice = _servicePrice;
                    for (int i = 0; i < RoomId.length; i++) {
                        Quantity = Integer.valueOf(quantity[i]);
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
                    request.setAttribute("roomID", re);
                    request.setAttribute("nameUser", ac);
                    request.setAttribute("hotel", ht);
                    request.setAttribute("day", daysBetween);
                    request.setAttribute("service", sv);
                    request.setAttribute("servicePrice", _servicePrice);
                    request.setAttribute("totalServicePrice", totalServicePrice);
                    request.setAttribute("TotalPrice", totalPrice);
                    request.setAttribute("checkIndate", CheckInDate);
                    request.setAttribute("checkOutDate", CheckOutDate);
                    // Forward the request to hotelDetail.jsp
                    request.getRequestDispatcher("/customer/reserve.jsp").forward(request, response);
                } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                    // Handle the error or redirect to an error page
                    response.sendError(jakarta.servlet.http.HttpServletResponse.SC_BAD_REQUEST, "Invalid quantityAndRoomId format");
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
                                rs.getBoolean("room_status"), rs.getString("room_description"), rt,rs.getInt("room_capacity"), h));
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
        } else if (path.endsWith("/Booking")) {
            String[] quantity = request.getParameterValues("quantity");
            String[] RoomId = request.getParameterValues("roomID");
            int hotelID = Integer.valueOf(request.getParameter("HotelID"));
            Date CheckInDate = Date.valueOf(request.getParameter("checkInDate"));
            Date CheckOutDate = Date.valueOf(request.getParameter("checkOutDate"));
            LocalDate checkInDate = LocalDate.parse(request.getParameter("checkInDate"));
            LocalDate checkOutDate = LocalDate.parse(request.getParameter("checkOutDate"));
            long daysBetween = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
            roomDAOs rDAO = new roomDAOs();
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
                    serviceDAOs sDAO = new serviceDAOs();
                    List<service> sv = sDAO.getService(hotelID);
                    List<reservation> re = new ArrayList<>();
                    int ServicePrice = 0;
                    int j = 0;
                    while (j < sv.size()) {
                        ServicePrice += sv.get(j).getService_price();
                        j++;
                    }
                    int Quantity = 1;
                    int _servicePrice = ServicePrice;
                    _servicePrice *= daysBetween;
                    int totalServicePrice = _servicePrice;
                    long millis = System.currentTimeMillis();
                    Date re_date = new Date(millis);
                    accountDAOs aDAO = new accountDAOs();
                    reservationDAOs rsDAO = new reservationDAOs();
                    account ac = aDAO.getAccount(value);
                    for (int i = 0; i < RoomId.length; i++) {
                        Quantity = Integer.valueOf(quantity[i]);
                        room r = rDAO.getRoomByRoomID(Integer.valueOf(RoomId[i]));
                        re.add(i, new reservation(Quantity, r));
                        re.get(i).setRoom(r);
                        int totalPrice = (int) (re.get(i).getRoom().getRoom_price() * daysBetween);
                        totalPrice *= Quantity;
                        totalPrice += _servicePrice * Quantity;
                        reservation reserve = new reservation(0, 0, re_date, Quantity, CheckInDate, CheckOutDate, totalPrice, r, sv.get(i), ac);
                        reserve = rsDAO.insertReservation(reserve);
                        if (reserve == null) {
                            response.sendRedirect("/homeController/HomeCustomer");
                        }
                    }
                    request.setAttribute("hotelID", hotelID);
                    // Forward the request to hotelDetail.jsp
                    response.sendRedirect("/bookingController/Success");
                } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                    // Handle the error or redirect to an error page
                    response.sendError(jakarta.servlet.http.HttpServletResponse.SC_BAD_REQUEST, "Invalid quantityAndRoomId format");
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
                                rs.getBoolean("room_status"), rs.getString("room_description"), rt,rs.getInt("room_capacity") , h));
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
        } else if (path.endsWith("/Success")) {
            request.getRequestDispatcher("/customer/bookingSuccess.jsp").forward(request, response);
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
