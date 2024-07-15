/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.hotelDAOs;
import DAOs.reservationDAOs;
import DAOs.roomDAOs;
import DAOs.serviceDAOs;
import Model.account;
import Model.hotel;
import Model.reservation;
import Model.room;
import Model.service;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tiend
 */
public class reservationController extends HttpServlet {

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
            out.println("<title>Servlet reservationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet reservationController at " + request.getContextPath() + "</h1>");
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
        
        if (path.endsWith("/YourReservation")) {
            if (flagCustomer) {
                reservationDAOs rsDAO = new reservationDAOs();
                roomDAOs rDAO = new roomDAOs();
                accountDAOs aDAO = new accountDAOs();
                serviceDAOs sDAO = new serviceDAOs();
                hotelDAOs hDAO = new hotelDAOs();
                List<reservation> rs = rsDAO.getReservationByUsername(value);
                int i = 0;
                while (i < rs.size()) {                    
                    room r = rDAO.getRoomByRoomID(rs.get(i).getRoom().getRoom_id());
                    account ac = aDAO.getAccount(value);
                    service s = sDAO.getServiceByServiceID(rs.get(i).getService().getService_id());
                    hotel h = hDAO.getHotelDetailById(s.getHotel().getHotel_id());
                    rs.get(i).setRoom(r);
                    rs.get(i).setUsername(ac);
                    rs.get(i).setService(s);
                    rs.get(i).getService().setHotel(h);
                    i++;
                }
                request.setAttribute("reservation", rs);
                request.getRequestDispatcher("/customer/reservation.jsp").forward(request, response);
            } else {
                response.sendRedirect("/homeController/HomeCustomer");
            }
        } else if (path.endsWith("/InfoReserve")) {
            request.getRequestDispatcher("/customer/infoForReserve.jsp").forward(request, response);
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
