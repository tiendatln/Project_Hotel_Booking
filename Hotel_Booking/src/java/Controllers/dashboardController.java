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
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class dashboardController extends HttpServlet {

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
            out.println("<title>Servlet dashboardController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet dashboardController at " + request.getContextPath() + "</h1>");
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

        int countHotel = hd.CountHotel(value);
        int countRoom = rd.CountRoom(value);
        int countFeedback = fdb.CountFeedback(value);
        int countTotalBooking = redb.CountBooking(value);
        int countConfirm = redb.CountConfirmBooking(value);
        int countReject = redb.CountRejectBooking(value);
        int countCancel = redb.CountCancelBooking(value);
        int countPending = redb.CountPendingBooking(value);
        double percent_Confirm = ((double) countConfirm / countTotalBooking) * 100;
        double percent_Reject = ((double) countReject / countTotalBooking) * 100;
        double percent_Cancel = ((double) countCancel / countTotalBooking) * 100;
        double percent_Pending = ((double) countPending / countTotalBooking) * 100;
        request.setAttribute("hotel", countHotel);
        request.setAttribute("room", countRoom);
        request.setAttribute("feedback", countFeedback);
        request.setAttribute("total", countTotalBooking);
        request.setAttribute("confirm", countConfirm);
        request.setAttribute("reject", countReject);
        request.setAttribute("cancel", countCancel);
        request.setAttribute("pending", countPending);
        request.setAttribute("perconfirm", percent_Confirm);
        request.setAttribute("perreject", percent_Reject);
        request.setAttribute("percancel", percent_Cancel);
        request.setAttribute("perpending", percent_Pending);
        request.getRequestDispatcher("/owner/dashboard.jsp").forward(request, response);
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
