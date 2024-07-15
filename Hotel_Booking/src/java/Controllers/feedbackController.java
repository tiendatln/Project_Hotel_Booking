/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.feedbackDAOs;
import DAOs.roomDAOs;
import Model.account;
import Model.feedback;
import Model.hotel;
import Model.room;
import Model.roomType;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author tiend
 */
public class feedbackController extends HttpServlet {

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
            out.println("<title>Servlet feedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet feedbackController at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/feedbackController/ViewAll")) {
            String[] s = path.split("/");
            int hotel_id = Integer.valueOf(s[s.length - 1]);
            feedbackDAOs fDAO = new feedbackDAOs();
            accountDAOs aDao = new accountDAOs();
            request.setAttribute("hotel_id", hotel_id);
            List<feedback> fb = fDAO.getFeedbackByHotelID(hotel_id);
            for (int i = 0; i < fb.size(); i++) {
                account ac = aDao.getAccount(fb.get(i).getAccount().getUsername());
                fb.get(i).setAccount(ac);
            }
            request.setAttribute("feedback", fb);
            request.getRequestDispatcher("/customer/feedbackViewAll.jsp").forward(request, response);
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
        if (request.getParameter("btnFeedback") != null) {
            String comment = request.getParameter("txtComment");
            String username = request.getParameter("username");
            int hotel_id = Integer.valueOf(request.getParameter("hotel_id"));
            feedbackDAOs fDAO = new feedbackDAOs();
            hotel ht = new hotel(hotel_id);
            account ac = new account(username);
            feedback feedback = new feedback(comment);
            roomDAOs rDAO = new roomDAOs();
            if (comment == "") {
                request.setAttribute("errorFeedback", true);
            } else {
                feedback = fDAO.addNewFeedback(feedback, ac, ht);
            }
            if (feedback == null) {
                request.setAttribute("errorFeedback", true);
            }
            List<room> room = new ArrayList<>();
            try {
                ResultSet rs = rDAO.getRoomByHotelID(hotel_id);
                while (rs.next()) {
                    hotel h = new hotel(rs.getInt("hotel_id"));
                    roomType rt = new roomType(rs.getInt("room_type_id"));
                    room.add(new room(rs.getInt("room_id"), rs.getString("room_name"), rs.getInt("room_price"), rs.getString("room_img"),
                            rs.getBoolean("room_status"), rs.getString("room_description"), rt, h));
                }
            } catch (Exception e) {

            }
            List<room> roomImg = rDAO.getAllRoomImgByHotelId(hotel_id);

            request.setAttribute("roomImg", roomImg);
            request.getSession().setAttribute("hotelID", hotel_id);
            request.setAttribute("room", room);
            List<feedback> fb = fDAO.getFeedbackByHotelID(hotel_id);
            request.setAttribute("feedback", fb);
            request.getRequestDispatcher("/customer/hotelDetail.jsp").forward(request, response);
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
