<%-- 
    Document   : layout
    Created on : Jun 19, 2024, 11:24:20 AM
    Author     : tiend
--%>

<%@page import="Model.account"%>
<%@page import="DAOs.accountDAOs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body>
        <%
            Cookie[] cList = null;
            String value = "";
            boolean flagCustomer = false;
            boolean flagOwner = false;
            boolean flagAdmin = false;
            cList = request.getCookies();
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {
                    if (cList[i].getName().equals("customer")) {
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break;
                    } else if (cList[i].getName().equals("owner")) {
                        value = cList[i].getValue();
                        flagOwner = true;
                        break;
                    } else if (cList[i].getName().equals("admin")) {
                        value = cList[i].getValue();
                        flagAdmin = true;
                        break;
                    }
                }
                if (flagOwner) {

                    response.sendRedirect("/homeController/HomeOwner");

                } else if (flagAdmin) {

                    response.sendRedirect("/homeController/HomeAdmin");

                }
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: cadetblue; box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset;">
            <a class="navbar-brand" href="/homeController/HomeCustomer">
                Our Hotel
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="/reservationController/YourReservation">Your Reservation</a></li>
                    <li class="nav-item nav-item dropdown d-flex justify-content-end">
                        <%
                            accountDAOs aDAO = new accountDAOs();
                            account ac = aDAO.getAccount(value);

                        %>
                        <a class="nav-link dropdown-toggle " href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="bi bi-image"></i>
                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                            </svg>
                            <% if (flagCustomer) {%>
                            <%= ac.getName()%>
                            <% } else { %>
                            Account
                            <% } %>
                        </a>
                        <div class="dropdown-menu " aria-labelledby="navbarDropdown" style="box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;">
                            <% if (flagCustomer) { %>

                            <a class="dropdown-item" id="layout" href="/profileController/ProfileUser">Your Profile</a>
                            <a class="dropdown-item" id="layout" href="/feedbackController/Review/<%= value %>">View FeedBack</a>
                            <a class="dropdown-item" id="layout" href="/logoutController/SignOut">Sign Out</a>
                            <% } else { %>
                            <a class="dropdown-item" id="layout" href="/loginController/login">Login</a>
                            <% }%>
                        </div>
                    </li>
                </ul>
            </div>
        </nav>
    </body>
    <style>
        #layout:hover{
            box-shadow: rgba(50, 50, 93, 0.25) 0px 30px 60px -12px inset, rgba(0, 0, 0, 0.3) 0px 18px 36px -18px inset;
        }
        #layout{
            font-family: monospace;
        }

    </style>
</html>
