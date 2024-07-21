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
import Model.feedback;
import Model.hotel;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
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
 * @author ASUS
 */
@WebServlet(name = "FeedbackManage", urlPatterns = {"/feedbackmanage"})
public class FeedbackManage extends HttpServlet {

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
            out.println("<title>Servlet FeedbackManage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackManage at " + request.getContextPath() + "</h1>");
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
        //   processRequest(request, response);
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
            roomDAOs rd = new roomDAOs();
            hotelDAOs hd = new hotelDAOs();
            reservationDAOs redb = new reservationDAOs();
            serviceDAOs sd = new serviceDAOs();
            accountDAOs ad = new accountDAOs();
            feedbackDAOs fdb = new feedbackDAOs();
            List<hotel> hotel = hd.getHotelByUser(value);
            List<feedback> fb = null;
//            if (key != null) {
//    fb = fdb.SearchFeedbackByKeyWord(key);
//            } else {
//                
//            }
            fb = fdb.getFeedbackByAdmin();
            if (fb.size() < 1) {
                request.setAttribute("message", true);
            }
            int i = 0;
            while (i < fb.size()) {
                account ac = ad.getAccount(fb.get(i).getAccount().getUsername());
                hotel h = hd.getHotelDetailById(fb.get(i).getHotel().getHotel_id());
                fb.get(i).setAccount(ac);
                fb.get(i).setHotel(h);
                i++;
            }
            int page, numberpage = 6;
            int size = fb.size();
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
            List<feedback> feedback = fdb.getListByPage(fb, start, end);
            request.setAttribute("keyword", key);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("HotelData", hotel);
            request.setAttribute("FeedbackData", feedback);
            request.getRequestDispatcher("/admin/feedbackmanage.jsp").forward(request, response);
        } else {
            if (action.equalsIgnoreCase("deletefeedback")) {
                feedbackDAOs fdb = new feedbackDAOs();
                String feedback_id_raw = request.getParameter("id");
                int feedback_id = Integer.parseInt(feedback_id_raw);
                accountDAOs ad = new accountDAOs();
                account a = new account();
                List<feedback> f = fdb.getFeedbackByID(feedback_id);
                String sendemail = "";
                for (int i = 0; i < f.size(); i++) {
                    a = ad.getAccount(f.get(i).getAccount().getUsername());
                    sendemail +="Dear "+ a.getUsername() + ",\nWe confirm that your feedback with the content: '" + f.get(i).getComment() + "' has been removed from our system. Please note that any further inappropriate responses may result in account suspension.\n"
                            + "\n"
                            + "Best regards,  \n"
                            + "Website Admin\n"
                            + "Hotel Reservation System";
                }
                String to = a.getEmail();// change accordingly
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
                //    request.setAttribute("message", "OTP is sent to your email id");
                fdb.deleteFeedback(feedback_id);
                response.sendRedirect("/feedbackmanage");
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
