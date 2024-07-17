/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import Model.account;
import jakarta.servlet.http.Cookie;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author tiend
 */
public class profileController extends HttpServlet {

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
            out.println("<title>Servlet profileController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet profileController at " + request.getContextPath() + "</h1>");
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
        boolean flagCustomer = false;
        boolean flagOwner = false;
        cList = request.getCookies();
        if (cList != null) {
            for (int i = 0; i < cList.length; i++) {
                if (cList[i].getName().equals("customer")) {
                    flagCustomer = true;
                    break;
                } else if (cList[i].getName().equals("owner")) {
                    flagOwner = true;
                    break;
                }
            }
            if (flagOwner) {
                request.getRequestDispatcher("/owner/profileOwner.jsp").forward(request, response);
            }
            String path = request.getRequestURI();
            if (path.endsWith("/ProfileUser")) {
                if (flagCustomer || flagOwner) {
                    request.getRequestDispatcher("/customer/profileUser.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/homeController/HomeCustomer");
                }
            } else if (path.endsWith("/ChangePassword")) {
                request.getRequestDispatcher("/customer/changePassword.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("/homeController/HomeCustomer");
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
        accountDAOs aDAO = new accountDAOs();
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
                    response.sendRedirect("/profileController/ProfileUser");
                } else {
                    account newAccount = new account(value, "", (byte) 0, (byte) 0, (byte) 0, (byte) 0, 0, email, name, age, phone, id_number);
                    account a = aDAO.updateAccount(newAccount);
                    if (a == null) {
                        request.getSession().setAttribute("errorMessage", "Update Fail!");
                        response.sendRedirect("/profileController/ProfileUser");
                    } else {
                        request.getSession().setAttribute("successMessage", "Update Successfully!");
                        response.sendRedirect("/profileController/ProfileUser");
                    }

                }
            } catch (Exception e) {
                response.sendRedirect("/profileController/ProfileUser");
            }
        }
        if (request.getParameter("btnChangePass") != null) {
            try {
                String oldPassword = request.getParameter("oldPass");
                String newPassword = request.getParameter("newPass");
                if (oldPassword.equals("") || newPassword.equals("")) {
                    request.getSession().setAttribute("errorMessage", "Please fill in all the information!");
                    response.sendRedirect("/profileController/ChangePassword");
                } else {
                    String newPassMD5 = accountDAOs.getMd5(newPassword);
                    account newPass = new account(value, newPassMD5, (byte) 0, (byte) 0, (byte) 0, (byte) 0, 0, "", "", 0, "", "");
                    account a = aDAO.changePassword(newPass);
                    if (a == null) {
                        request.getSession().setAttribute("errorMessage", "Update Fail!");
                        response.sendRedirect("/profileController/ChangePassword");
                    } else {
                        request.getSession().setAttribute("successMessage", "Update Successfully!");
                        response.sendRedirect("/profileController/ChangePassword");
                    }
                }
            } catch (Exception e) {
                response.sendRedirect("/profileController/ChangePassword");
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
