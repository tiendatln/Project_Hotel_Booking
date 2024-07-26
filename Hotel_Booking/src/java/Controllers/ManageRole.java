/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.feedbackDAOs;
import DAOs.updateRoleDAOs;
import Model.account;
import Model.feedback;
import Model.updateRole;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
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
 * @author Ngo Hong Hai - CE171752
 */
@WebServlet(name = "ManageRole", urlPatterns = {"/setrole"})
public class ManageRole extends HttpServlet {

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
        //  processRequest(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        updateRoleDAOs ud = new updateRoleDAOs();
        String user = request.getParameter("user");
        String username_raw = request.getParameter("username");
        String action = request.getParameter("action");

        try {

            if (action == null) {
                List<updateRole> listupdaterole = ud.getAllUpdateRole();
                request.setAttribute("listupdaterole", listupdaterole);
                request.getRequestDispatcher("/admin/managerole.jsp").forward(request, response);
            } else {
                if (action.equalsIgnoreCase("setrole")) {
                    account a = new account();
                    accountDAOs ad = new accountDAOs();

                    a = ad.getAccount(user);
                    ad.setStatusUpdateRole(user, 1);
                    ad.setOwner(a.getUsername());

                    String sendemail = "Dear " + a.getUsername() + ",\nYour request to register as the owner hotel has been approved. Welcome to our hotel booking system!\n"
                            + "\n"
                            + "Best regards,\n"
                            + "\n"
                            + "Website Admin\n"
                            + "Hotel Booking System";
                    String to = a.getEmail(); // change accordingly
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

                    response.sendRedirect("setrole");
                } else if (action.equalsIgnoreCase("deleteDon")) {

                    accountDAOs ad = new accountDAOs();
                    account a = ad.getAccount(username_raw);
                    ad.setStatusUpdateRole(username_raw, 2);

                    String sendemail = "Dear " + username_raw + ",\nThank you for your interest in registering to become Owner Hotel. After careful consideration, we regret to inform you that we cannot proceed with the registration at this time. Please contact us if you need further information.\n"
                            + "\n"
                            + "Best regards,\n"
                            + "Website Admin\n"
                            + "Hotel Booking System";
                    String to = a.getEmail(); // change accordingly
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
                        System.out.println("message sent successfully");
                    } catch (MessagingException e) {
                        throw new RuntimeException(e);
                    }
                    response.sendRedirect("/setrole");

                }
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
        // processRequest(request, response);

//        try {
//       
//       } catch (Exception e) {
//        }
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
