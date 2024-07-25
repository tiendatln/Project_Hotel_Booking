/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.hotelDAOs;
import DAOs.roomDAOs;
import Model.hotel;
import Model.room;
import Model.roomType;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tiend
 */
@WebServlet("/Relay")
@MultipartConfig
public class roomManagerController extends HttpServlet {

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
            out.println("<title>Servlet roomManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet roomManagerController at " + request.getContextPath() + "</h1>");
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
            hotel h = new hotel();
            roomType rt = new roomType();
            List<room> roomList = null;
            if (key != null) {
                roomList = rd.SearchRoomByKeyWord(value, key);
            } else {
                roomList = rd.getRoomByUsername(value);
            }

            if (roomList.size() < 1) {
                request.setAttribute("message", true);
            }

            List<roomType> roomType = rd.getRoomType();
            List<hotel> hotel = hd.getHotelByUser(value);
            for (room room : roomList) {
                h = hd.getHotelDetailById(room.getHotel().getHotel_id());
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
            start = (page - 1) * numberpage;
            end = Math.min(page * numberpage, size);
            List<room> room = rd.getListByPage(roomList, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("RoomData", room);
            request.setAttribute("RoomTypeData", roomType);
            request.setAttribute("HotelData", hotel);
            request.getRequestDispatcher("/owner/list-room.jsp").forward(request, response);
        } else {
            if (action.equalsIgnoreCase("deleteroom")) {
                roomDAOs rdb = new roomDAOs();
                String room_id_raw = request.getParameter("id");
                int room_id = Integer.parseInt(room_id_raw);
                rdb.deleteRoom(room_id);
                response.sendRedirect("/roomManagerController");
            }
        }

    }

    public static void main(String[] args) throws IOException {
        File file = new File("/imgs/room");

        System.out.println("Absolute Path: " + file.getAbsoluteFile());
        System.out.println("Canonical Path: " + file.getCanonicalPath());
        System.out.println("Path: " + file.getPath());
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
        String file = request.getSession().getServletContext().getRealPath("/imgs/room");
        String[] s = file.split("\\\\");
        String fileImg = "";
        for (int i = 0; i < s.length; i++) {
            if (!s[i].equals("build")) {
                fileImg += s[i];
                if (i < s.length - 1) {
                    fileImg += "\\";
                }
            }
        }
        fileImg.substring(0, fileImg.length() - 1);
        String action = request.getParameter("action");
        String[] arr = request.getParameterValues("roomID");
        if (action.equalsIgnoreCase("insertroom")) {
            hotelDAOs hdb = new hotelDAOs();
            roomDAOs rdb = new roomDAOs();
            String room_name = request.getParameter("name");
            String roomtype_id_raw = request.getParameter("roomType_id");
            String room_price_raw = request.getParameter("price");
            String hotel_id_raw = request.getParameter("hotel_id");
            String quantity_raw = request.getParameter("quantity");
            String room_description = request.getParameter("description");
            String room_status_raw = request.getParameter("status");
            Part part = request.getPart("room_img");
            Path fileName = Paths.get(part.getSubmittedFileName());
            if (!Files.exists(Paths.get(fileImg))) {
                Files.createDirectories(Paths.get(fileImg));
            }
            String picture = fileName.getFileName().toString();

            int room_type_id = Integer.parseInt(roomtype_id_raw);
            int hotel_id = Integer.parseInt(hotel_id_raw);
            int quantity = Integer.parseInt(quantity_raw);
            int room_price = Integer.parseInt(room_price_raw);
            boolean room_status = (room_status_raw.equals("1")) ? true : false;
            part.write(fileImg + "/" + fileName);
            roomType roomType = rdb.getRoomTypeByID(room_type_id);
            hotel hotel = hdb.getHotelDetailById(hotel_id);
            room room = new room();
            room.setRoom_name(room_name);
            room.setRoom_price(room_price);
            room.setRoom_img(picture);
            room.setRoom_status(room_status);
            room.setRoom_description(room_description);
            room.setRoom_capacity(quantity);
            room.setRoom_type(roomType);
            room.setHotel(hotel);

            rdb.insertRoom(room);
            System.out.println("insert successfull");
            response.sendRedirect("/roomManagerController");
        } else if (action.equalsIgnoreCase("updateroom")) {
            hotelDAOs hdb = new hotelDAOs();
            roomDAOs rdb = new roomDAOs();
            String room_id_raw = request.getParameter("room_id");
            String room_name = request.getParameter("name");
            String roomtype_id_raw = request.getParameter("roomType_id");
            String room_price_raw = request.getParameter("price");
            String hotel_id_raw = request.getParameter("hotel_id");
            String quantity_raw = request.getParameter("quantity");
            String room_description = request.getParameter("description");
            String room_status_raw = request.getParameter("status");
            Part part = request.getPart("room_img");
            Path fileName = Paths.get(part.getSubmittedFileName());
            if (!Files.exists(Paths.get(fileImg))) {
                Files.createDirectories(Paths.get(fileImg));
            }
            String picture = "";
            picture = fileName.getFileName().toString();

            int room_id = Integer.parseInt(room_id_raw);
            int room_type_id = Integer.parseInt(roomtype_id_raw);
            int hotel_id = Integer.parseInt(hotel_id_raw);
            int quantity = Integer.parseInt(quantity_raw);
            int room_price = Integer.parseInt(room_price_raw);
            boolean room_status = (room_status_raw.equals("1")) ? true : false;

            roomType roomType = rdb.getRoomTypeByID(room_type_id);
            hotel hotel = hdb.getHotelDetailById(hotel_id);
            room room = new room();
            room.setRoom_id(room_id);
            room.setRoom_name(room_name);
            room.setRoom_price(room_price);
            room.setRoom_img(picture);
            room.setRoom_status(room_status);
            room.setRoom_description(room_description);
            room.setRoom_capacity(quantity);
            room.setRoom_type(roomType);
            room.setHotel(hotel);

            if (picture.equals("")) {
                rdb.updateRoom(room);
                System.out.println("updated");
                response.sendRedirect("/roomManagerController");
            } else {

                

                File filePic = new File(fileImg + "/" + rdb.getRoomImgByRoomID(room_id));

// Check if the file exists before attempting to delete
                if (filePic.exists()) {
                    if (filePic.delete()) {
                        System.out.println("File deleted successfully: " + fileImg + "/" + rdb.getRoomImgByRoomID(room_id));
                    } else {
                        System.out.println("Failed to delete the file: " + fileImg + "/" + rdb.getRoomImgByRoomID(room_id));
                    }
                } else {
                    System.out.println("File does not exist: " + fileImg + "/" + rdb.getRoomImgByRoomID(room_id));
                }
                rdb.updateRoom(room);
                System.out.println("updated");
                try {
                    part.write(fileImg + "/" + fileName);
                    TimeUnit.SECONDS.sleep(2);
                } catch (InterruptedException ex) {
                    Logger.getLogger(roomManagerController.class.getName()).log(Level.SEVERE, null, ex);
                }
                
                response.sendRedirect("/roomManagerController");
            }

        } else if (action.equalsIgnoreCase("search")) {
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
            hotel h = new hotel();
            roomType rt = new roomType();
            List<room> roomList = rd.SearchRoomByKeyWord(value, key);
            if (roomList.size() < 1) {
                request.setAttribute("message", true);
            }
            List<roomType> roomType = rd.getRoomType();
            List<hotel> hotel = hd.getHotelByUser(value);
            for (room room : roomList) {
                h = hd.getHotelDetailById(room.getHotel().getHotel_id());
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
            start = (page - 1) * numberpage;
            end = Math.min(page * numberpage, size);
            List<room> room = rd.getListByPage(roomList, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("RoomData", room);
            request.setAttribute("RoomTypeData", roomType);
            request.setAttribute("HotelData", hotel);
            request.getRequestDispatcher("/owner/list-room.jsp").forward(request, response);
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
