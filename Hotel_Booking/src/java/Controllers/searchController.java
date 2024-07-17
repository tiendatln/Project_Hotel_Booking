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
            request.getSession().setAttribute("hotelID", hotel_id);

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

            List<room> room = rDAO.getAllRoomByHotelID(hotel_id);
            int i = 0;
            while (i < room.size()) {

            }

            request.setAttribute("room", room);
            request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
        } else if (path.startsWith("/searchController/Change")) {
            try {
                roomDAOs rDAO = new roomDAOs();
                Date checkInDate = Date.valueOf(request.getParameter("checkInDate"));
                Date checkOutDate = Date.valueOf(request.getParameter("checkOutDate"));
                int hotel_id = Integer.valueOf("HotelID");
                List<Integer> roomOnDate = rDAO.getRoomIfCheckInAndCheckOutDateNotExistOnReservation(checkInDate, checkOutDate, hotel_id);
                List<room> room = rDAO.getAllRoomByHotelID(hotel_id);
 
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
//                    ResultSet rs = hDAO.searchHotelByLocal(destination, checkinDate, checkoutDate);
//                    int count = 0;
//                    try {
//                        if (rs.next()) {
//                            count++;
//                        }
//                    } catch (SQLException ex) {
//                        Logger.getLogger(searchController.class.getName()).log(Level.SEVERE, null, ex);
//                    }
                    int count = 0;
                    if (count > 0) {
                        request.getSession().setAttribute("destination", destination);
                        request.getSession().setAttribute("checkin", checkin);
                        request.getSession().setAttribute("checkout", checkout);
                        request.getSession().setAttribute("roomType", roomType);
                        response.sendRedirect("/searchController/ListHotel");
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
