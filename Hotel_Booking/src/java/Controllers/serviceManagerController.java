/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.hotelDAOs;
import DAOs.roomDAOs;
import DAOs.serviceDAOs;
import Model.hotel;
import Model.service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class serviceManagerController extends HttpServlet {

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
            out.println("<title>Servlet serviceManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet serviceManagerController at " + request.getContextPath() + "</h1>");
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
            hotelDAOs hd = new hotelDAOs();
            serviceDAOs sd = new serviceDAOs();
            List<service> serviceList = null;
            if (key != null) {
                serviceList = sd.SearchServiceByKeyWord(value, key);
            } else {
                serviceList = sd.getAllServiceByOwner(value);
            }

            if (serviceList.size() < 1) {
                request.setAttribute("message", true);
            }

            List<hotel> hotel = hd.getHotelByUser(value);

            int i = 0;
            while (i < serviceList.size()) {
                hotel h = hd.getHotelDetailById(serviceList.get(i).getHotel().getHotel_id());
                serviceList.get(i).setHotel(h);
                i++;
            }
            int page, numberpage = 6;
            int size = serviceList.size();
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
            List<service> service = sd.getListByPage(serviceList, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("HotelData", hotel);
            request.setAttribute("ServiceData", service);
            request.getRequestDispatcher("/owner/list-service.jsp").forward(request, response);
        } else {
            if (action.equalsIgnoreCase("deleteservice")) {
                serviceDAOs sd = new serviceDAOs();
                String id_raw = request.getParameter("id");
                int id = Integer.parseInt(id_raw);
                sd.deleteService(id);
                response.sendRedirect("/serviceManagerController");
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
            response.sendRedirect("/serviceManagerController");
        }

        if (action.equalsIgnoreCase("updateservice")) {
            hotelDAOs hd = new hotelDAOs();
            serviceDAOs sd = new serviceDAOs();
            String service_id_raw = request.getParameter("service_id");
            String service_name = request.getParameter("service_name");
            String service_price_raw = request.getParameter("service_price");
            String hotel_id_raw = request.getParameter("hotel_id");
            int service_id = Integer.parseInt(service_id_raw);
            int service_price = Integer.parseInt(service_price_raw);
            int hotel_id = Integer.parseInt(hotel_id_raw);

            hotel h = hd.getHotelDetailById(hotel_id);
            service service = new service();
            service.setService_id(service_id);
            service.setService_name(service_name);
            service.setService_price(service_price);
            service.setHotel(h);
            sd.updateService(service);
            System.out.println("updated");
            response.sendRedirect("/serviceManagerController");
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
            hotelDAOs hd = new hotelDAOs();
            serviceDAOs sd = new serviceDAOs();
            List<service> serviceList = sd.SearchServiceByKeyWord(value, key);
            if (serviceList.size() < 1) {
                request.setAttribute("message", true);
            }
            List<hotel> hotel = hd.getHotelByUser(value);

            int i = 0;
            while (i < serviceList.size()) {
                hotel h = hd.getHotelDetailById(serviceList.get(i).getHotel().getHotel_id());
                serviceList.get(i).setHotel(h);
                i++;
            }
            int page, numberpage = 6;
            int size = serviceList.size();
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
            List<service> service = sd.getListByPage(serviceList, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("HotelData", hotel);
            request.setAttribute("ServiceData", service);
            request.getRequestDispatcher("/owner/list-service.jsp").forward(request, response);
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
