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
        if (path.startsWith("/reserveController/submit")) {

            String[] RoomId = request.getParameterValues("roomID");

            // Check if quantityAndRoomId is not null and contains a comma
            int hotelID = Integer.valueOf(request.getParameter("HotelID"));
            String[] rQuantity = request.getParameterValues("quantity");
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
                        int roomQuantity = Integer.valueOf(rQuantity[i]);
                        room r = rDAO.getRoomByRoomID(Integer.valueOf(RoomId[i]));
                        r.setRoom_capacity(roomQuantity);
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

                List<room> room = rDAO.getAllRoomByHotelID(hotelID);

                request.setAttribute("roomImg", roomImg);
                request.setAttribute("hotelID", hotelID);
                request.setAttribute("room", room);
                feedbackDAOs fDAO = new feedbackDAOs();
                hotelDAOs hDAO = new hotelDAOs();
                reservationDAOs rsDAO = new reservationDAOs();
                account ac = new account();
                List<feedback> feedback = fDAO.getFeedbackByHotelID(hotelID);
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
                        if (reserve.get(i).getRoom().getHotel().getHotel_id() == hotelID) {
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
                List<reservation> re = rsDAO.getReservationAndRoomByLocalAndDate(CheckInDate, CheckOutDate, hotelID);
                List<hotel> Listht = hDAO.getHotelListByHotelID(hotelID);
                List<room> listRoom = rDAO.getAllRoomByHotelID(hotelID);
                List<room> r = new ArrayList<>();
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
                                    } else {
                                    }
                                } else {
                                    checkRoomID = false;
                                }
                                j++;
                            }
                        }
//                    int roomCount = rDAO.getCountRoomByRoomID(listRoom.get(i).getRoom_id());
                        if (checkQuantity && 1 > countRoom) {
                            r.add(listRoom.get(i));
                        }
                        i++;
                    }
                    i = 0;

                } else {
                    r = listRoom;
                }
                i = 0;
                while (i < r.size()) {
                    roomType rt = rDAO.getRoomTypeByID(r.get(i).getRoom_type().getRoom_type_id());
                    r.get(i).setRoom_type(rt);
                    i++;
                }
                request.setAttribute("re", re);
                request.setAttribute("r", r);
                request.setAttribute("checkInDate", checkInDate);
                request.setAttribute("checkOutDate", checkOutDate);
                request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
            }
        } else if (path.startsWith("/reserveController/Change")) {
            int hotel_id = Integer.valueOf(request.getParameter("HotelID"));
            try {
                Date checkInDate = Date.valueOf(request.getParameter("checkInDate"));
                Date checkOutDate = Date.valueOf(request.getParameter("checkOutDate"));

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
                    while (reserveExist && i < reserve.size()) {
                        if (reserve.get(i).getRoom().getHotel().getHotel_id() == hotel_id) {
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
                List<reservation> re = rsDAO.getReservationAndRoomByLocalAndDate(checkInDate, checkOutDate, hotel_id);
                List<room> listRoom = rDAO.getAllRoomByHotelID(hotel_id);
                List<room> room = new ArrayList<>();
                int i = 0;
                if (!re.isEmpty()) {
                    int j = 0;
                    int countToSetQuantity = 0;
                    while (i < listRoom.size()) { //roomID
                        boolean checkQuantity = true;
                        boolean checkRoomID = true;
                        int countRoom = 0;
                        int quantity = 0;
                        int checkQuantityOfRoom = 0;
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
                                    } else {
                                        checkQuantityOfRoom = quantity;
                                    }
                                } else {

                                    checkRoomID = false;
                                }
                                if (checkRoomID) {
                                    j++;
                                }
                            }
                        }

                        if (checkQuantity && 1 > countRoom) {
                            room.add(listRoom.get(i));
                            int quantityOfRoom = listRoom.get(i).getRoom_capacity();
                            checkQuantityOfRoom = quantityOfRoom - checkQuantityOfRoom;
                            room.get(countToSetQuantity).setRoom_capacity(checkQuantityOfRoom);
                            countToSetQuantity++;
                        }
                        i++;
                    }
                    i = 0;

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
                request.setAttribute("checkInDate", checkInDate);
                request.setAttribute("checkOutDate", checkOutDate);
                request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
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
