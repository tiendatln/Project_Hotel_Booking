/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.feedbackDAOs;
import DAOs.hotelDAOs;
import DAOs.reservationDAOs;
import DAOs.roomDAOs;
import DAOs.serviceDAOs;
import Model.account;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author tiend
 */
public class Dashboard extends HttpServlet {

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
            out.println("<title>Servlet Dashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Dashboard at " + request.getContextPath() + "</h1>");
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
        feedbackDAOs fdb = new feedbackDAOs();

        try {
            int countHotel = hd.CountHotel();
            int countRoom = rd.CountRoom();
            int countFeedback = fdb.CountFeedback();
            int countTotalBooking = redb.CountBooking();
            int countConfirm = redb.CountConfirmBooking();
            int countCancel = redb.CountCancelBooking();
            int countPending = redb.CountPendingBooking();
            double percent_Confirm = ((double) countConfirm / countTotalBooking) * 100;
            double percent_Cancel = ((double) countCancel / countTotalBooking) * 100;
            double percent_Pending = ((double) countPending / countTotalBooking) * 100;
            request.setAttribute("us", value);
            request.setAttribute("hotel", countHotel);
            request.setAttribute("room", countRoom);
            request.setAttribute("feedback", countFeedback);
            request.setAttribute("total", countTotalBooking);
            request.setAttribute("confirm", countConfirm);
            request.setAttribute("cancel", countCancel);
            request.setAttribute("pending", countPending);
            request.setAttribute("perconfirm", percent_Confirm);
            request.setAttribute("percancel", percent_Cancel);
            request.setAttribute("perpending", percent_Pending);
            List<account> a = ad.getAllAccount();
            int countUser = 0, countOwner = 0;
            for (int i = 0; i < a.size(); i++) {
                if (a.get(i).getIs_owner() == 0 && a.get(i).getIs_adnmin() == 0) {
                    countUser += 1;
                }
                if (a.get(i).getIs_owner() == 1) {
                     countOwner += 1;       
                }        
            }          
            request.setAttribute("countuser", countUser);
            request.setAttribute("countowner", countOwner);
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
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
