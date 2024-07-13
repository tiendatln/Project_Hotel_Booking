/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.hotelDAOs;
import DAOs.roomDAOs;
import DAOs.serviceDAOs;
import Model.account;
import Model.hotel;
import Model.room;
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
        String[] RoomId = request.getParameterValues("roomID");
        // Check if quantityAndRoomId is not null and contains a comma
        int hotelID = Integer.valueOf(request.getParameter("HotelID"));
        Date CheckInDate = Date.valueOf(request.getParameter("checkInDate"));
        Date CheckOutDate = Date.valueOf(request.getParameter("checkOutDate"));
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
                List<Integer> roomID = new ArrayList<>();
                for (int i = 0; i < RoomId.length; i++) {
                    roomID.add(Integer.valueOf(RoomId[i]));
                }
                accountDAOs aDAO = new accountDAOs();
                hotelDAOs hDAO = new hotelDAOs();
                serviceDAOs sDAO = new serviceDAOs();
                account ac = aDAO.getAccount(value);
                 
                hotel ht = hDAO.getHotelDetailById(hotelID);
                request.setAttribute("roomID", roomID);
                request.setAttribute("nameUser", ac);
                request.setAttribute("hotel", ht);
                // Forward the request to hotelDetail.jsp
                request.getRequestDispatcher("/customer/reserve.jsp").forward(request, response);
            } catch (NumberFormatException | ArrayIndexOutOfBoundsException e) {
                // Handle parsing or array index out of bounds errors
                e.printStackTrace(); // Log the exception for debugging
                // Handle the error or redirect to an error page
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantityAndRoomId format");
            }
        } else {
            roomDAOs rDAO = new roomDAOs();
            List<room> room = rDAO.getAllRoomImgByHotelId(hotelID);
            request.setAttribute("loginToReserve", "You must be login to reserve!");
            request.getSession().setAttribute("hotelID", hotelID);
            request.setAttribute("roomImg", room);
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
