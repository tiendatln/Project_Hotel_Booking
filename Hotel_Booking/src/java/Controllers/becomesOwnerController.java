/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.accountDAOs;
import DAOs.updateRoleDAOs;
import Model.account;
import Model.updateRole;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author tiend
 */
@MultipartConfig
public class becomesOwnerController extends HttpServlet {

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
            out.println("<title>Servlet becomesOwnerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet becomesOwnerController at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        if (request.getParameter("btnConfirm") != null) {
            String file = request.getSession().getServletContext().getRealPath("/imgs/owner");
            String[] s = file.split("\\\\");
            String fileImg = "";
            for (int i = 0; i < s.length; i++) {
                if (!s[i].equals("build")) {
                    fileImg += s[i];
                    if (i < s.length - 1) {
                        fileImg += "\\";
                    }
                }
            }
            fileImg.substring(0, fileImg.length() - 1);
            String value = "";
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        break; //thoat khoi vong lap
                    }
                }
            }
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String hotel_name = request.getParameter("hotel");
            String address = request.getParameter("address");
            updateRoleDAOs urDAO = new updateRoleDAOs();

            accountDAOs aDAO = new accountDAOs();
            account ac = aDAO.getAccount(value);

            boolean checkExist = urDAO.getUpdateExistByUsername(value);

            if (!checkExist) {
                Part part = request.getPart("BusinessLicensImage");
                Path fileName = Paths.get(part.getSubmittedFileName());
                if (!Files.exists(Paths.get(fileImg))) {
                    Files.createDirectories(Paths.get(fileImg));
                }

                String BusinessLicensImage = fileName.getFileName().toString();
                part.write(fileImg + "/" + fileName);
                updateRole up = new updateRole(0, hotel_name, address, BusinessLicensImage, 0, ac);
                if (up == null) {
                    request.setAttribute("updateMesage", "asfaf");
                    request.getRequestDispatcher("/customer/becomesOwner.jsp").forward(request, response);
                } else {
                    updateRole addUp = urDAO.insertUpdateRole(up);
                    if (addUp == null) {
                        request.setAttribute("updateMesage", "asfaaaas");
                        request.getRequestDispatcher("/customer/becomesOwner.jsp").forward(request, response);
                    }
                }
                request.setAttribute("updateMesage", true);
                request.getRequestDispatcher("/customer/becomesOwner.jsp").forward(request, response);
            }
            request.setAttribute("updateExist", true);
            request.getRequestDispatcher("/customer/becomesOwner.jsp").forward(request, response);
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
