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
import Model.roomType;
import Model.service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import javax.persistence.metamodel.SetAttribute;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class reserveManagerController extends HttpServlet {

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
            out.println("<title>Servlet reserveManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet reserveManagerController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if (action == null) {
            String key = request.getParameter("key");
            Cookie[] cList = null;
            String value = "";
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie           
                    if (cList[i].getName().equals("owner")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        break; //thoat khoi vong lap
                    }
                }
            }
            roomDAOs rd = new roomDAOs();
            hotelDAOs hd = new hotelDAOs();
            reservationDAOs redb = new reservationDAOs();
            serviceDAOs sd = new serviceDAOs();
            accountDAOs ad = new accountDAOs();
            List<reservation> rs = null;
            if (key != null) {
                rs = redb.SearchBooking(value, key);
            } else {
                rs = redb.getBookingByOwner(value);
            }

            if (rs.size() < 1) {
                request.setAttribute("message", true);
            }
            List<roomType> roomType = rd.getRoomType();
            List<hotel> hotel = hd.getHotelByUser(value);
            int i = 0;
            while (i < rs.size()) {
                room r = rd.getRoomByRoomID(rs.get(i).getRoom().getRoom_id());
                account ac = ad.getAccount(rs.get(i).getAccount().getUsername());
                service s = sd.getServiceByServiceID(rs.get(i).getService().getService_id());
                hotel h = hd.getHotelDetailById(s.getHotel().getHotel_id());
                rs.get(i).setRoom(r);
                rs.get(i).setUsername(ac);
                rs.get(i).setService(s);
                rs.get(i).getService().setHotel(h);
                i++;
            }
            int page, numberpage = 6;
            int size = rs.size();
            int num = (size % 6 == 0 ? (size / 6) : ((size / 6)) + 1); // so trang 
            String xpage = request.getParameter("page");
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numberpage;
            end = Math.min(page * numberpage, size);
            List<reservation> reserve = redb.getListByPage(rs, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("ReserveData", reserve);
            request.setAttribute("RoomTypeData", roomType);
            request.setAttribute("HotelData", hotel);
            request.getRequestDispatcher("/owner/list-booking.jsp").forward(request, response);
        } else {
            reservationDAOs redb = new reservationDAOs();
            if (action.equalsIgnoreCase("confirm")) {
                String re_id_raw = request.getParameter("id");
                int re_id = Integer.parseInt(re_id_raw);
                redb.setStatusBooking(re_id, 1);
                response.sendRedirect("/reserveManagerController");
            }
            if (action.equalsIgnoreCase("cancle")) {
                String re_id_raw = request.getParameter("id");
                int re_id = Integer.parseInt(re_id_raw);
                redb.setStatusBooking(re_id, 2);
                response.sendRedirect("/reserveManagerController");
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
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("search")) {
            String key = request.getParameter("key");
            Cookie[] cList = null;
            String value = "";
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie           
                    if (cList[i].getName().equals("owner")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        break; //thoat khoi vong lap
                    }
                }
            }
            roomDAOs rd = new roomDAOs();
            hotelDAOs hd = new hotelDAOs();
            reservationDAOs redb = new reservationDAOs();
            serviceDAOs sd = new serviceDAOs();
            accountDAOs ad = new accountDAOs();
            List<reservation> rs = redb.SearchBooking(value, key);
            if (rs.size() < 1) {
                request.setAttribute("message", true);
            }
            List<roomType> roomType = rd.getRoomType();
            List<hotel> hotel = hd.getHotelByUser(value);
            int i = 0;
            while (i < rs.size()) {
                room r = rd.getRoomByRoomID(rs.get(i).getRoom().getRoom_id());
                account ac = ad.getAccount(rs.get(i).getAccount().getUsername());
                service s = sd.getServiceByServiceID(rs.get(i).getService().getService_id());
                hotel h = hd.getHotelDetailById(s.getHotel().getHotel_id());
                rs.get(i).setRoom(r);
                rs.get(i).setUsername(ac);
                rs.get(i).setService(s);
                rs.get(i).getService().setHotel(h);
                i++;
            }
            int page, numberpage = 6;
            int size = rs.size();
            int num = (size % 6 == 0 ? (size / 6) : ((size / 6)) + 1); // so trang 
            String xpage = request.getParameter("page");
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numberpage;
            end = Math.min(page * numberpage, size);
            List<reservation> reserve = redb.getListByPage(rs, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("ReserveData", reserve);
            request.setAttribute("RoomTypeData", roomType);
            request.setAttribute("HotelData", hotel);
            request.getRequestDispatcher("/owner/list-booking.jsp").forward(request, response);
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
