<%-- 
    Document   : menu
    Created on : Mar 13, 2024, 8:21:33 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>


<header>
    <%
        Cookie[] cList = null;
        String value = "";
        boolean flagCustomer = false;
        cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
        if (cList != null) {
            for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                    value = cList[i].getValue();
                    flagCustomer = true;
                    break; //thoat khoi vong lap
                }
            }
        }
    %>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: cadetblue">
        <a class="navbar-brand" href="home">Our Hotel</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">

                <li class="nav-item"><a class="nav-link" href="room">Room </a></li>
                <li class="nav-item"><a class="nav-link" href="reservation">Your Reservation </a></li>
                <li class="nav-item nav-item dropdown" >
                    <%
                        AccountDAO aDAO = new AccountDAO();
                        Account ac = aDAO.getAccount(value);
                    %>
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" ><i class="bi bi-image"></i><svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                        </svg>
                        <%if (flagCustomer) {%>
                        <%= ac.getName()%>
                        <% } else {%>
                        Account
                        <% }%>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">                            
                        <div class="dropdown-divider"></div>
                        <%if (flagCustomer) { %>
                        <a class="dropdown-item" href="profile?action=updateprofile">Your Profile</a>
                        <a class="dropdown-item" href="logout">Sign Out</a>
                        <% } else {%>
                        <a class="dropdown-item" href="login">Login</a>
                        <a class="dropdown-item" href="register">Register User</a>
                        <% }%>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
    
</header>
