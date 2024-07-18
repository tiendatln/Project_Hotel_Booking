/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.feedbackDAOs;
import DAOs.reservationDAOs;
import Model.account;
import java.io.IOException;
import java.io.PrintWriter;
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
public class UserManager extends HttpServlet {

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
            out.println("<title>Servlet UserManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserManager at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String id = request.getParameter("id_number");
        try {
            accountDAOs ad = new accountDAOs();
            List<account> a = ad.getAllAccount();
            List<account> c = new ArrayList<>();
            if (action == null) {
                for (int i = 0; i < a.size(); i++) {
                    if (a.get(i).getIs_adnmin() == 0) {
                        c.add(a.get(i));
                        request.setAttribute("user", c);
                    }
                }
                request.getRequestDispatcher("/admin/usermanager.jsp").forward(request, response);
            } else if (action.equals("deleteaccount")) {
                feedbackDAOs fDAO = new feedbackDAOs();
                reservationDAOs rsDAO = new reservationDAOs();
                if (fDAO.deleteFeedbackByUsername(username)) {
                    if (rsDAO.deleteReservationByUsername(username)) {
                        ad.deleteAccount(id);
                    }
                }
                response.sendRedirect("/UserManager");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
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
        String status_raw = request.getParameter("clockaccount");
        accountDAOs acDAO = new accountDAOs();
        if (action.equals("setowner")) {
            String user_id = request.getParameter("user_id");
            String owner = request.getParameter("check");
            acDAO.setOwner(user_id, owner);
            response.sendRedirect("/UserManager");
        } else if (action.equals("ban_status")) {
            String user_id = request.getParameter("user_id");
            boolean ban = Boolean.parseBoolean(status_raw);
            acDAO.setBan_status(user_id, ban);
            response.sendRedirect("/UserManager");
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
