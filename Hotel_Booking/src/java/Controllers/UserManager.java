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
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
            List<account> a = ad.getAllAccountNotAdmin();
            if (action == null) {
                request.setAttribute("user", a);
                request.getRequestDispatcher("/admin/usermanager.jsp").forward(request, response);
            }
//            else if (action.equals("deleteaccount")) {
//                feedbackDAOs fDAO = new feedbackDAOs();
//                reservationDAOs rsDAO = new reservationDAOs();
//                if (fDAO.deleteFeedbackByUsername(username)) {
//                    if (rsDAO.deleteReservationByUsername(username)) {
//                        ad.deleteAccount(id);
//                    }
//                }
//                response.sendRedirect("/UserManager");
//            }
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

        accountDAOs acDAO = new accountDAOs();
        account a = new account();
        if (action.equals("setowner")) {
            String user_id = request.getParameter("user_id");
            String owner = request.getParameter("check");
            acDAO.setOwner(user_id, owner);
            account account = acDAO.getAccount(user_id);
            acDAO.setStatusUpdateRole(user_id, 2);
            String sendemail = "";
            if (account.getIs_owner() == 1) {
                sendemail = "Dear " + account.getUsername() + " ,\n"
                        + "Your request to register as the owner hotel has been approved. Welcome to our hotel booking system!\n"
                        + "\n"
                        + "Best regards,\n"
                        + "Website Admin\n"
                        + "Hotel Booking System";
            } else {
                sendemail = "Dear " + account.getUsername() + " ,\n"
                        + "We regret to inform you that your account has been found in violation of our policies. As a result, your account privileges have been downgraded to a regular user. Please contact our support team for further information.\n"
                        + "\n"
                        + "Best regards,\n"
                        + "Website Admin\n"
                        + "Hotel Booking System";
            }
             String to = account.getEmail();// change accordingly
            String host = "smtp.gmail.com";
            String port = "465";
            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.starttls.enable", "true");
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("datlntce171894@fpt.edu.vn", "ytac vgaa luxu cgdy");// Put your email
                }
            });
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("datlntce171894@fpt.edu.vn"));// change accordingly
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Hello");
                message.setText(sendemail);
                // send message
                Transport.send(message);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            response.sendRedirect("/UserManager");
        } else if (action.equals("ban_status")) {
            String user_id = request.getParameter("user_id");
          //  boolean ban = Boolean.parseBoolean(status_raw);
                String status= request.getParameter("clockaccount");

            account accountban = acDAO.getAccount(user_id);
            String sendemail = "";
            if (accountban.getBan_status() == 1) {
                sendemail = "Dear " + accountban.getUsername() + " ,\n"
                        + "We regret to inform you that your account has been locked due to suspicious activity. Please contact our support team for further assistance.\n"
                        + "Best regards,\n"
                        + "Website Admin\n"
                        + "Hotel Booking System";
            } else {
                sendemail = "Dear " + accountban.getUsername() + " ,\n"
                        + "We are pleased to inform you that your account has been successfully unlocked. You can now log in and continue using our services. If you have any questions or encounter any issues, please contact our support team.\n"
                        + "\n"
                        + "Best regards,\n"
                        + "Website Admin\n"
                        + "Hotel Booking System";
            }
            String to = accountban.getEmail();// change accordingly
            String host = "smtp.gmail.com";
            String port = "465";
            // Get the session object
            Properties props = new Properties();
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.starttls.enable", "true");
            Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("datlntce171894@fpt.edu.vn", "ytac vgaa luxu cgdy");// Put your email
                }
            });
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("datlntce171894@fpt.edu.vn"));// change accordingly
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Hello");
                message.setText(sendemail);
                // send message
                Transport.send(message);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            acDAO.setBan_status(user_id, status);
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
