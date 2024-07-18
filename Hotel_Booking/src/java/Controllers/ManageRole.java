/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import Model.account;
import Model.updateRole;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

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
     String action = request.getParameter("action");
        String id_raw = request.getParameter("id"); 
            accountDAOs ad = new accountDAOs();
            account a = new account();
        try {
              int id = Integer.parseInt(id_raw);
            if (action != null) {
            if (action.equals("deletedon")) {
                ad.deleteUpdateRole(id);
                response.sendRedirect("/setrole");
            }
        } 
        } catch (Exception e) {
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
        //  processRequest(request, response);
      ////  request.setCharacterEncoding("UTF-8");
      //  response.setCharacterEncoding("UTF-8");
      //  response.setContentType("text/html; charset=UTF-8");
     
      try { 
            
            
            
            
            
            
            accountDAOs ad = new accountDAOs();
            account a = new account();
            
            
            
         
      
          
            
            
            
            String user = request.getParameter("user");
            if (user != null) {
                a = ad.getAccount(user);
                ad.setOwner(a.getUsername());
                request.setAttribute("seto", a.getIs_owner());
                request.setAttribute("deleteuser", a.getUsername());
            }
            List<updateRole> listupdaterole = ad.getAllUpdateRole();
            request.setAttribute("listupdaterole", listupdaterole);
            request.getRequestDispatcher("/admin/managerole.jsp").forward(request, response);         
                response.sendRedirect("/setrole");
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
