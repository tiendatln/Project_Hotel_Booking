/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;

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
            request.getRequestDispatcher("/listHotel.jsp").forward(request, response);
        }else if(path.startsWith("/searchController/HotelDetail")){
            String[] s = path.split("/");
            request.getSession().setAttribute("hotelID", s[s.length - 1]);
            request.getRequestDispatcher("/hotelDetail.jsp").forward(request, response);
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
            try {
                long millis = System.currentTimeMillis();
                long tenDaysInMillis = 10L * 24 * 60 * 60 * 1000;
                long checkoutMillis = millis + tenDaysInMillis;
                Date checkinDate = new Date(millis);
                Date checkoutDate = new Date(millis);
                String searchLocal = request.getParameter("destination");
                checkinDate = Date.valueOf(request.getParameter("checkin-date"));
                checkoutDate = Date.valueOf(request.getParameter("checkout-date"));
                long checkin = checkinDate.getTime();
                long checkout = checkoutDate.getTime();
                if(checkin == checkout){
                    checkoutDate = new Date(checkoutMillis);
                    checkout = checkoutDate.getTime();
                }
                request.getSession().setAttribute("listRoom", searchLocal);
                request.getSession().setAttribute("checkin", checkin);
                request.getSession().setAttribute("checkout", checkout);
                response.sendRedirect("/searchController/ListHotel");
            } catch (IOException e) {

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
