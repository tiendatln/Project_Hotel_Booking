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
import jakarta.servlet.http.Cookie;
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
@WebServlet(name = "RoomManager", urlPatterns = {"/roommanager"})
public class RoomManager extends HttpServlet {

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
            RoomDAO rd = new RoomDAO();
            HotelDAO hd = new HotelDAO();
            Hotel h = new Hotel();
            RoomType rt = new RoomType();
            List<Room> roomList = rd.getRoomByUsername(value);
            List<RoomType> roomType = rd.getRoomType();
            List<Hotel> hotel = hd.getHotelByUser(value);
            for (Room room : roomList) {
                h = hd.getHotelByID(room.getHotel().getHotel_id());
                room.setHotel(h);
                rt = rd.getRoomTypeByID(room.getRoom_type().getRoom_type_id());
                room.setRoom_type(rt);
            }
            int page, numberpage = 5;
            int size = roomList.size();
            int num = (size % 5 == 0 ? (size / 5) : ((size / 5)) + 1); // so trang 
            String xpage = request.getParameter("page");
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numberpage;
            end = Math.min(page * numberpage, size);
            List<Room> room = rd.getListByPage(roomList, start, end);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("RoomData", room);
            request.setAttribute("RoomTypeData", roomType);
            request.setAttribute("HotelData", hotel);
            request.getRequestDispatcher("owner/list-room.jsp").forward(request, response);
        } else {
            if (action.equalsIgnoreCase("insertroom")) {
                HotelDAO hdb = new HotelDAO();
                RoomDAO rdb = new RoomDAO();
                String room_number = request.getParameter("name");
                String roomtype_id_raw = request.getParameter("roomType_id");
                String room_price_raw = request.getParameter("price");
                String hotel_id_raw = request.getParameter("hotel_id");
                String room_description = request.getParameter("description");
                String room_img = "img/room" + request.getParameter("room_img");
                String room_status_raw = request.getParameter("status");

                int room_type_id = Integer.parseInt(roomtype_id_raw);
                int hotel_id = Integer.parseInt(hotel_id_raw);
                int room_price = Integer.parseInt(room_price_raw);
                boolean room_status = (room_status_raw.equals("1")) ? true : false;

                RoomType roomType = rdb.getRoomTypeByID(room_type_id);
                Hotel hotel = hdb.getHotelByID(hotel_id);
                Room room = new Room();
                room.setRoom_name(room_number);
                room.setRoom_price(room_price);
                room.setRoom_img(room_img);
                room.setRoom_status(room_status);
                room.setRoom_type(roomType);
                room.setHotel(hotel);

                rdb.insertRoom(room);
                System.out.println("inster successfull");
                response.sendRedirect("roommanager");
            }
            if (action.equalsIgnoreCase("deleteroom")) {
                RoomDAO rdb = new RoomDAO();
                String room_id_raw = request.getParameter("id");
                int room_id = Integer.parseInt(room_id_raw);
                rdb.deleteRoom(room_id);
                response.sendRedirect("roommanager");
            }
            if (action.equalsIgnoreCase("updateroom")) {
                HotelDAO hdb = new HotelDAO();
                RoomDAO rdb = new RoomDAO();
                String room_id_raw = request.getParameter("room_id");
                String room_number = request.getParameter("name");
                String roomtype_id_raw = request.getParameter("roomType_id");
                String room_price_raw = request.getParameter("price");
                String hotel_id_raw = request.getParameter("hotel_id");
                String room_description = request.getParameter("description");
                String room_img = "img/room" + request.getParameter("room_img");
                String room_status_raw = request.getParameter("status");

                int room_id = Integer.parseInt(room_id_raw);
                int room_type_id = Integer.parseInt(roomtype_id_raw);
                int hotel_id = Integer.parseInt(hotel_id_raw);
                int room_price = Integer.parseInt(room_price_raw);
                boolean room_status = (room_status_raw.equals("1")) ? true : false;

                RoomType roomType = rdb.getRoomTypeByID(room_type_id);
                Hotel hotel = hdb.getHotelByID(hotel_id);
                Room room = new Room();
                room.setRoom_id(room_id);
                room.setRoom_name(room_number);
                room.setRoom_price(room_price);
                room.setRoom_img(room_img);
                room.setRoom_status(room_status);
                room.setRoom_type(roomType);
                room.setHotel(hotel);

                rdb.updateRoom(room);
                System.out.println("updated");
                response.sendRedirect("roommanager");
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
