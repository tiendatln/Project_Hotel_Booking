/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

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
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        Cookie[] cList = null;
        boolean flagCustomer = false;
        boolean flagOwner = false;
        cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
        if (cList != null) {
            for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap                    
                    flagCustomer = true;
                    break;
                } else if (cList[i].getName().equals("owner")) {
                    flagOwner = true;
                    break;
                }
            }
            if (action.equalsIgnoreCase("updateprofile")) {
                if (flagCustomer || flagOwner) {
                    request.getRequestDispatcher("profile.jsp").forward(request, response);
                } else {
                    response.sendRedirect("login");
                }
            } else if (action.equalsIgnoreCase("changepassword")) {
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            }
            
        } else {
            response.sendRedirect("login");
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
        Cookie[] cList = null;
        String value = "";
        cList = request.getCookies();
        if (cList != null) {
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("customer")) {
                    value = cList[i].getValue();
                    break;
                } else if (cList[i].getName().equals("owner")) {
                    value = cList[i].getValue();
                    break;
                }
            }
        }
        AccountDAO aDAO = new AccountDAO();
        if (request.getParameter("btnUpdateProfile") != null) {
            try {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                int age = Integer.valueOf(request.getParameter("age"));
                String phone = request.getParameter("phone");
                String id_number = request.getParameter("id_number");
                if (email.equals("") || name.equals("")
                        || phone.equals("") || id_number.equals("")) {
                    request.getSession().setAttribute("errorMessage", "Please fill in all the information!");
                    response.sendRedirect("profile?action=updateprofile");
                } else {
                    Account newAccount = new Account(value, "", false, false, false, false, 0, email, name, age, phone, id_number);
                    Account a = aDAO.updateAccount(newAccount);
                    if (a == null) {
                        request.getSession().setAttribute("errorMessage", "Update Fail!");
                        response.sendRedirect("profile?action=updateprofile");
                    } else {
                        request.getSession().setAttribute("successMessage", "Update Successfully!");
                        response.sendRedirect("profile?action=updateprofile");
                    }

                }
            } catch (Exception e) {
                response.sendRedirect("profile?action=updateprofile");
            }
        }
        if (request.getParameter("btnChangePass") != null) {
            try {
                String oldPassword = request.getParameter("oldPass");
                String newPassword = request.getParameter("newPass");
                if (oldPassword.equals("") || newPassword.equals("")) {
                    request.getSession().setAttribute("errorMessage", "Please fill in all the information!");
                    response.sendRedirect("profile?action=changepassword");
                } else {
                    String newPassMD5 = AccountDAO.getMd5(newPassword);
                    Account newPass = new Account(value, newPassMD5, false, false, false, false, 0, "", "", 0, "", "");
                    Account a = aDAO.changePassword(newPass);
                    if (a == null) {
                        request.getSession().setAttribute("errorMessage", "Update Fail!");
                        response.sendRedirect("profile?action=changepassword");
                    } else {
                        request.getSession().setAttribute("successMessage", "Update Successfully!");
                        response.sendRedirect("profile?action=changepassword");
                    }
                }
            } catch (Exception e) {
                response.sendRedirect("profile?action=changepassword");
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
