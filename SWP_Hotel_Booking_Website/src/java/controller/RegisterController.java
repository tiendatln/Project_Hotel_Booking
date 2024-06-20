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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
@WebServlet(name="RegisterController", urlPatterns={"/register"})
public class RegisterController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
                AccountDAO aDAO = new AccountDAO();
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
                    response.sendRedirect("register");
                } else {
                    Account checkAccount = aDAO.getAccount(username);
                    if (checkAccount != null) {
                        request.getSession().setAttribute("checkMessage", "The account is already exist!");
                        response.sendRedirect("register");
                    } else {
                        String pass_md5 = aDAO.getMd5(password);
                        Account newAccount = new Account(username, pass_md5, false, false, false, false, 0, email, name, age, phone, id_number);
                        Account a = aDAO.addNewCusAccount(newAccount);
                        if (a == null) {
                            request.getSession().setAttribute("errorMessage", "Create Fail!");
                            response.sendRedirect("register");
                        } else {
                            request.getSession().setAttribute("successMessage", "Create Successfully!");
                            response.sendRedirect("home?role=customer");
                        }
                    }
                }
            } catch (IOException | NumberFormatException e) {
                response.sendRedirect("register");
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
