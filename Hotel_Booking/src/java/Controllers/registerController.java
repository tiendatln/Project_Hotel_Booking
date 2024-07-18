/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import Model.account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.Random;
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
public class registerController extends HttpServlet {

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
            out.println("<title>Servlet registerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet registerController at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/Register")) {
            request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
        } else if (path.endsWith("/EnterOTP")) {
            request.getRequestDispatcher("/customer/enterOTP.jsp").forward(request, response);
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
        if (request.getParameter("btnRegister") != null) {
            try {
                accountDAOs aDAO = new accountDAOs();
                String username = request.getParameter("txtUs");
                String password = request.getParameter("txtPwd");
                String email = request.getParameter("txtEmail");
                String name = request.getParameter("txtName");
                int age = Integer.valueOf(request.getParameter("txtAge"));
                String phone = request.getParameter("txtPhone");
                String id_number = request.getParameter("txtIdNumber");

                if (username.equals("") || password.equals("") || email.equals("") || name.equals("")
                        || phone.equals("") || id_number.equals("")) {
                    request.getSession().setAttribute("errorMessage", "Please fill in all the information!");
                    response.sendRedirect("/registerController/Register");
                } else {
                    account checkAccount = aDAO.getAccount(username);
                    if (checkAccount != null) {
                        request.getSession().setAttribute("checkMessage", "The account is already exist!");
                        response.sendRedirect("/registerController/Register");
                    } else {
                        int otpvalue = 0;
                        HttpSession mySession = request.getSession();
                        if (!email.equals("")) {
                            // sending otp
                            boolean checkEmail = aDAO.checkEmailUser(email);
                            if (!checkEmail) {
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
                                    message.setSubject("Hello");
                                    message.setText("your OTP is: " + otpvalue);
                                    // send message
                                    Transport.send(message);
                                    System.out.println("message sent successfully");
                                } catch (MessagingException e) {
                                    throw new RuntimeException(e);
                                }
                                mySession.setAttribute("otp", otpvalue);
                                mySession.setAttribute("username", username);
                                mySession.setAttribute("password", password);
                                mySession.setAttribute("email", email);
                                mySession.setAttribute("name", name);
                                mySession.setAttribute("age", age);
                                mySession.setAttribute("phone", phone);
                                mySession.setAttribute("id_number", id_number);
                                request.setAttribute("message", "OTP is sent to your email id");
                                response.sendRedirect("/registerController/EnterOTP");
                            }else{
                                request.setAttribute("emailExist", true);
                                request.getRequestDispatcher("/customer/register.jsp").forward(request, response);
                            }
                        }
                        //request.setAttribute("connection", con);
                    }
                }
            } catch (IOException | NumberFormatException e) {
                response.sendRedirect("/registerController/Register");
            }
        } else if (request.getParameter("btnRegisterOTP") != null) {
            int value = Integer.parseInt(request.getParameter("otp"));
            HttpSession session = request.getSession();
            int otp = (int) session.getAttribute("otp");
            String username = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");
            String email = (String) session.getAttribute("email");
            String name = (String) session.getAttribute("name");
            int age = (int) session.getAttribute("age");
            String phone = (String) session.getAttribute("phone");
            String id_number = (String) session.getAttribute("id_number");
            if (value == otp) {
                accountDAOs aDAO = new accountDAOs();
                String pass_md5 = accountDAOs.getMd5(password);
                account newAccount = new account(username, pass_md5, (byte) 0, (byte) 0, (byte) 0, (byte) 0, 0, email, name, age, phone, id_number);
                account a = aDAO.addNewCusAccount(newAccount);
                if (a == null) {
                    response.sendRedirect("/registerController/Register");
                } else {
                    request.getSession().setAttribute("massageRegister", "success");
                    response.sendRedirect("/homeController/HomeCustomer");
                }
            } else {
                request.getSession().setAttribute("messageOTP", "Wrong OTP");
                response.sendRedirect("/registerController/EnterOTP");
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
