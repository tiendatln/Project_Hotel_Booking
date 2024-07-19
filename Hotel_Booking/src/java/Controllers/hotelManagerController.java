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
import Model.roomType;
import Model.service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tiend
 */
@MultipartConfig
public class hotelManagerController extends HttpServlet {

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
            out.println("<title>Servlet hotelManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet hotelManagerController at " + request.getContextPath() + "</h1>");
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
            serviceDAOs sd = new serviceDAOs();
            hotel h = new hotel();
            List<hotel> hotelList = null;
            if (key != null) {
                hotelList = hd.SearchHotelByKeyWord(key);
            } else {
                hotelList = hd.getHotelByUser(value);
            }

            if (hotelList.size() < 1) {
                request.setAttribute("message", true);
            }

            List<service> service = sd.getAllService();
            int page, numberpage = 6;
            int size = hotelList.size();
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
            List<hotel> hotel = hd.getListByPage(hotelList, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("HotelData", hotel);
            request.setAttribute("AllHotelData", hotelList);
            request.setAttribute("ServiceData", service);
            request.getRequestDispatcher("/owner/list-hotel.jsp").forward(request, response);
        } else {
            if (action.equalsIgnoreCase("deletehotel")) {
                hotelDAOs hdb = new hotelDAOs();
                roomDAOs rdb = new roomDAOs();
                String hotel_id_raw = request.getParameter("id");
                int hotel_id = Integer.parseInt(hotel_id_raw);
                List<room> list_room = rdb.getAllRoomIDByHotelId(hotel_id);
                for (int i = 0; i < list_room.size(); i++) {
                    room r = list_room.get(i);
                    int count = 0;
                    while (count < 2) {
                        rdb.deleteRoom(r.getRoom_id());
                        count++;
                    }
                }
                int i = 0;
                while (i < 2) {
                    hdb.deleteHotel(hotel_id);
                    i++;
                }

                response.sendRedirect("/hotelManagerController");
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
        String file = request.getSession().getServletContext().getRealPath("/imgs/hotel");
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
        if (action.equalsIgnoreCase("inserthotel")) {

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
            accountDAOs adb = new accountDAOs();
            hotelDAOs hdb = new hotelDAOs();
            roomDAOs rdb = new roomDAOs();
            String hotel_name = request.getParameter("hotel_name");
            String hotel_address = request.getParameter("hotel_address");
            String hotel_description = request.getParameter("hotel_description");
//            String hotel_img = "imgs/room/" + request.getParameter("hotel_img");
            Part part = request.getPart("hotel_img");
            Path fileName = Paths.get(part.getSubmittedFileName());
            if (!Files.exists(Paths.get(fileImg))) {
                Files.createDirectories(Paths.get(fileImg));
            }
            String picture = fileName.getFileName().toString();

            part.write(fileImg + "/" + fileName);

            account user = adb.getAccount(value);
            hotel hotel = new hotel();
            hotel.setHotel_name(hotel_name);
            hotel.setHotel_address(hotel_address);
            hotel.setHotel_description(hotel_description);
            hotel.setHotel_img(picture);
            hotel.setUsername(user);
            hdb.insertHotel(hotel);

            System.out.println("insert successfull");
            response.sendRedirect("/hotelManagerController");
        }
        if (action.equalsIgnoreCase("insertservice")) {
            accountDAOs adb = new accountDAOs();
            hotelDAOs hdb = new hotelDAOs();
            roomDAOs rdb = new roomDAOs();
            serviceDAOs sdb = new serviceDAOs();
            String service_name = request.getParameter("service_name");
            String service_price_raw = request.getParameter("service_price");
            String hotel_id_raw = request.getParameter("hotel_id");

            int service_price = Integer.parseInt(service_price_raw);
            int hotel_id = Integer.parseInt(hotel_id_raw);

            hotel hotel = hdb.getHotelDetailById(hotel_id);
            service service = new service();
            service.setService_name(service_name);
            service.setService_price(service_price);
            service.setHotel(hotel);
            sdb.insertService(service);
            System.out.println("insert successfull");
            response.sendRedirect("/hotelManagerController");
        }
        if (action.equalsIgnoreCase("updatehotel")) {
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
            accountDAOs adb = new accountDAOs();
            hotelDAOs hdb = new hotelDAOs();
            roomDAOs rdb = new roomDAOs();
            String hotel_id_raw = request.getParameter("hotel_id");
            String hotel_name = request.getParameter("hotel_name");
            String hotel_address = request.getParameter("hotel_address");
            String hotel_description = request.getParameter("hotel_description");
//            String hotel_img = "imgs/room/" + request.getParameter("hotel_img");
            Part part = request.getPart("hotel_img");
            Path fileName = Paths.get(part.getSubmittedFileName());
            if (!Files.exists(Paths.get(fileImg))) {
                Files.createDirectories(Paths.get(fileImg));
            }
            String picture = fileName.getFileName().toString();           

            int hotel_id = Integer.parseInt(hotel_id_raw);

            account user = adb.getAccount(value);
            hotel hotel = new hotel();
            hotel.setHotel_id(hotel_id);
            hotel.setHotel_name(hotel_name);
            hotel.setHotel_address(hotel_address);
            hotel.setHotel_description(hotel_description);
            hotel.setHotel_img(picture);
            hotel.setUsername(user);

            if (picture.equals("")) {
                hdb.updateHotel(hotel);
                System.out.println("updated");
                response.sendRedirect("/hotelManagerController");
            } else {

                part.write(fileImg + "/" + fileName);

                File filePic = new File(fileImg + "/" + hdb.getHotelImgByHotelID(hotel_id));

// Check if the file exists before attempting to delete
                if (filePic.exists()) {
                    if (filePic.delete()) {

                    } else {

                    }
                } else {

                }
                hdb.updateHotel(hotel);
                System.out.println("updated");
                try {
                    TimeUnit.SECONDS.sleep(2);
                } catch (InterruptedException ex) {
                    Logger.getLogger(hotelManagerController.class.getName()).log(Level.SEVERE, null, ex);
                }

                response.sendRedirect("/hotelManagerController");
            }
        }

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
            serviceDAOs sd = new serviceDAOs();
            hotel h = new hotel();
            List<hotel> hotelList = hd.SearchHotelByKeyWord(key);
            if (hotelList.size() < 1) {
                request.setAttribute("message", true);
            }
            List<service> service = sd.getAllService();
            int page, numberpage = 6;
            int size = hotelList.size();
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
            List<hotel> hotel = hd.getListByPage(hotelList, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("HotelData", hotel);
            request.setAttribute("ServiceData", service);
            request.getRequestDispatcher("/owner/list-hotel.jsp").forward(request, response);
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
