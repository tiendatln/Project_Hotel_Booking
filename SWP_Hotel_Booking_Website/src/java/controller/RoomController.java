/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.HotelDAO;
import dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Hotel;
import model.Room;
import model.RoomType;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
@WebServlet(name = "RoomController", urlPatterns = {"/room"})
public class RoomController extends HttpServlet {

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
        String action = request.getParameter("action");
        if (action == null) {
            RoomDAO rd = new RoomDAO(); 
            HotelDAO hd = new HotelDAO(); 
            Hotel h = new Hotel(); 
            RoomType rt = new RoomType(); 
            List<Room> roomList = rd.getRoom(); 
            for (Room room : roomList) {
                h = hd.getHotelByID(room.getHotel().getHotel_id()); 
                room.setHotel(h);
                rt = rd.getRoomTypeByID(room.getRoom_type().getRoom_type_id()); 
                room.setRoom_type(rt);
            }
            int page, numberpage = 6;
            int size = roomList.size(); 
            int num = (size % 6 == 0 ? (size / 6) : ((size / 6)) + 1); // so trang 
            String xpage = request.getParameter("page"); 
            if (xpage == null) {
                page = 1;                 
            } else {
                page = Integer.parseInt(xpage); 
            }
            int start, end; 
            start = (page -1) * numberpage; 
            end = Math.min(page * numberpage, size); 
            List<Room> room = rd.getListByPage(roomList, start, end);             
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("RoomData", room);            
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
             if (action.equalsIgnoreCase("roomdetail")) {
                 String room_id_raw = request.getParameter("room_id"); 
                 RoomDAO rd = new RoomDAO(); 
                 HotelDAO hd = new HotelDAO(); 
                 int room_id = Integer.parseInt(room_id_raw); 
                 Room room = rd.getRoomByID(room_id); 
                 Hotel h = hd.getHotelByID(room.getHotel().getHotel_id());
                 room.setHotel(h);
                 RoomType rt = rd.getRoomTypeByID(room.getRoom_type().getRoom_type_id()); 
                 room.setRoom_type(rt);
                 request.setAttribute("Data", room);
                 request.getRequestDispatcher("room-details.jsp").forward(request, response);
             }
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
        processRequest(request, response);
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
