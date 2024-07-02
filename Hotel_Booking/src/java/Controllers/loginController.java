/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
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
public class loginController extends HttpServlet {

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
            out.println("<title>Servlet loginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet loginController at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
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
        if (request.getParameter("btnLogin") != null) {
            Cookie[] cList;
            cList = request.getCookies();
            if (cList != null) {
                for (Cookie cList1 : cList) { //Duyet qua het tat ca cookie
                    cList1.setMaxAge(0);
                    cList1.setPath("/");
                    response.addCookie(cList1);
                }
            }
            accountDAOs aDAO = new accountDAOs();
            String us = request.getParameter("txtUScus");
            String pwd = request.getParameter("txtPWDcus");
            if (us.equals("")) {
                request.getSession().setAttribute("massageUserNull", "Please Enter Username!");
            }
            if (pwd.equals("") || us.equals("")) {
                if (pwd.equals("")) {
                    request.getSession().setAttribute("massagePassNull", "Please Enter Password!");
                }
                response.sendRedirect("/loginController/login");
            }
            if (!pwd.equals("") && !us.equals("")) {
                if (!aDAO.checkPassword(us, pwd) || !aDAO.checkUser(us)) {
                    request.getSession().setAttribute("massageAllError", "Username or Password are incorrect!");
                    response.sendRedirect("/loginController/login");
                } else {
                    String setRole = aDAO.checkAccount(us);
                    Cookie c = new Cookie(setRole, us);
                    c.setMaxAge(3 * 24 * 60 * 60); //Thiet lap han su dung 3 ngay
                    c.setPath("/");
                    response.addCookie(c);
                    if (setRole.equalsIgnoreCase("admin")) {
                        response.sendRedirect("/homeController/HomeAdmin");
                    } else if (setRole.equalsIgnoreCase("owner")) {
                        response.sendRedirect("/homeController/HomeOwner");
                    } else {
                        response.sendRedirect("/homeController/HomeCustomer");
                    }
                }
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
