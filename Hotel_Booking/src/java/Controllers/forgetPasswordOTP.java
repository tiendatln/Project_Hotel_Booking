/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author tiend
 */
public class forgetPasswordOTP extends HttpServlet {

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
            out.println("<title>Servlet forgetPasswordOTP</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet forgetPasswordOTP at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("btnSendOTP") != null) {
            String email = request.getParameter("txtEmail");
            int otpvalue = 0;
            HttpSession mySession = request.getSession();
            if (!email.equals("")) {
                accountDAOs aDAO = new accountDAOs();
                boolean checkEmail = aDAO.checkEmailUser(email);
                if (checkEmail) {
                    // sending otp
                    Random rand = new Random();
                    otpvalue = rand.nextInt(1255650);
                    String to = email;// change accordingly
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
                            // id and
                            // password here
                        }
                    });
                    // compose message
                    try {
                        MimeMessage message = new MimeMessage(session);
                        message.setFrom(new InternetAddress("datlntce171894@fpt.edu.vn"));// change accordingly
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                        message.setSubject("Reset Password");
                        message.setText("your OTP is: " + otpvalue);
                        // send message
                        Transport.send(message);
                        System.out.println("message sent successfully");
                    } catch (MessagingException e) {
                        throw new RuntimeException(e);
                    }
                    mySession.setAttribute("otp", otpvalue);
                    mySession.setAttribute("email", email);
                    request.getRequestDispatcher("/customer/recoverOTP.jsp").forward(request, response);
                } else {
                    request.setAttribute("ErrorEmail", true);
                    request.getRequestDispatcher("/customer/EnterEmailSendOTP.jsp").forward(request, response);
                }

            }
        } else if (request.getParameter("btnEnterOTP") != null) {
            int otpEnter = Integer.valueOf(request.getParameter("otp"));
            HttpSession session = request.getSession();
            int otp = (int) session.getAttribute("otp");
            if (otpEnter == otp) {
                request.getRequestDispatcher("/customer/recover.jsp").forward(request, response);
            } else {
                request.setAttribute("messageOTP", true);
                request.getRequestDispatcher("/customer/recoverOTP.jsp").forward(request, response);
            }
        }else if(request.getParameter("btnResetPassword") != null){
            String newPass = request.getParameter("txtNewPassword");
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            accountDAOs aDAO = new accountDAOs();
            String newHashPass = accountDAOs.getMd5(newPass);
            if(aDAO.updatePasswordForget(newHashPass, email)){
                request.setAttribute("changePassword", true);
                request.getRequestDispatcher("/customer/login.jsp").forward(request, response);
            }
            request.getRequestDispatcher("/customer/recover.jsp").forward(request, response);
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
