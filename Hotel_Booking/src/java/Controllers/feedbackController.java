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
import Model.account;
import Model.feedback;
import Model.hotel;
import Model.reservation;
import Model.room;
import Model.roomType;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

/**
 *
 * @author tiend
 */
public class feedbackController extends HttpServlet {

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
            out.println("<title>Servlet feedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet feedbackController at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/feedbackController/ViewAll")) {
            String[] s = path.split("/");
            int hotel_id = Integer.valueOf(s[s.length - 1]);
            feedbackDAOs fDAO = new feedbackDAOs();
            accountDAOs aDao = new accountDAOs();
            request.setAttribute("hotel_id", hotel_id);
            List<feedback> fb = fDAO.getFeedbackByHotelID(hotel_id);
            for (int i = 0; i < fb.size(); i++) {
                account ac = aDao.getAccount(fb.get(i).getAccount().getUsername());
                fb.get(i).setAccount(ac);
            }
            request.setAttribute("feedback", fb);
            request.getRequestDispatcher("/customer/feedbackViewAll.jsp").forward(request, response);
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
        if (request.getParameter("btnFeedback") != null) {
            String comment = request.getParameter("txtComment");
            String username = request.getParameter("username");
            int hotel_id = Integer.valueOf(request.getParameter("hotel_id"));
            feedbackDAOs fDAO = new feedbackDAOs();
            hotel Hotel = new hotel(hotel_id);
            account ac = new account(username);
            feedback Feedback = new feedback(comment);
            roomDAOs rDAO = new roomDAOs();
            if (comment == "") {
                request.setAttribute("errorFeedback", true);
            } else {
                Feedback = fDAO.addNewFeedback(Feedback, ac, Hotel);
            }
            if (Feedback == null) {
                request.setAttribute("errorFeedback", true);
            }
            try {
                Date checkInDate = Date.valueOf(request.getParameter("checkInDate"));
                Date checkOutDate = Date.valueOf(request.getParameter("checkOutDate"));
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
                hotelDAOs hDAO = new hotelDAOs();
                reservationDAOs rsDAO = new reservationDAOs();
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

                    while (i < listRoom.size()) {
                        int countRoomID = 0;
                        int y = 0;
                        int quantity = 0;
                        while (y < re.size()) {
                            if (listRoom.get(i).getRoom_id() == re.get(y).getRoom().getRoom_id()) {
                                countRoomID++;
                            } else {
                                if (quantity == 0) {
                                    quantity = re.get(y).getQuantity();
                                } else {
                                    quantity += re.get(y).getQuantity();
                                }
                            }
                            y++;
                        }
                        if (countRoomID >= re.size()) {
                            room.add(listRoom.get(i));
                            room.get(i).setRoom_capacity(quantity);
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
                request.setAttribute("checkInDate", checkInDate);
                request.setAttribute("checkOutDate", checkOutDate);
                request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
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
