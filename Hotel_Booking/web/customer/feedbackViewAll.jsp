<%-- 
    Document   : feedbackViewAll
    Created on : Jul 13, 2024, 9:35:11 PM
    Author     : tiend
--%>

<%@page import="java.sql.Date"%>
<%@page import="Model.hotel"%>
<%@page import="DAOs.hotelDAOs"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Model.account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles.css" rel="stylesheet">
        <style>
            body{
                margin-top:20px;
                background:#EDF1F9;
            }
            .card {
                box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
            }
            .avatar {
                width: 3rem;
                height: 3rem;
                font-size: .765625rem;
            }
            a {
                text-decoration:none;
            }
        </style>
    </head>
    <body>
        <%@include file="layout.jsp" %>
        <%
            hotelDAOs hDAO = new hotelDAOs();
            int hotel_id = (int) request.getAttribute("hotel_id");
            hotel h = hDAO.getHotelDetailById(hotel_id);
            long millis = System.currentTimeMillis();
            long tenDaysInMillis = 1L * 24 * 60 * 60 * 1000;
            long checkoutMillis = millis + tenDaysInMillis;
            Date checkinDate = new Date(millis);
            Date checkoutDate = new Date(checkoutMillis);
        %>
        <div class="text-center m-3" >
            <h1>
                <%= h.getHotel_name()%>
            </h1>
        </div>
        <div class="container mt-4">
            <div class="row">
                <div class="col-xl-12 mb-3 mb-lg-5">
                    <div class="card">
                        <div class="d-flex card-header justify-content-between">
                            <h5 class="me-3 mb-0">Feedback</h5>
                            <a class="btn" style="color: #0d6efd" href="/searchController/HotelDetail/<%= checkinDate%>/<%= checkoutDate%>/<%= hotel_id%>">Back to Hotel</a>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <!--List-item-->

                                <c:forEach items="${feedback}" var="feedbackItem">

                                    <li class="list-group-item pt-0">
                                        <div class="d-flex align-items-center">
                                            <div>
                                                <svg style="width: 20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                                <!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                                                <path d="M512 240c0 114.9-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6C73.6 471.1 44.7 480 16 480c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4l0 0 0 0 0 0 0 0 .3-.3c.3-.3 .7-.7 1.3-1.4c1.1-1.2 2.8-3.1 4.9-5.7c4.1-5 9.6-12.4 15.2-21.6c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208z"/>
                                                </svg>
                                            </div>
                                            <div class="m-3">
                                                <h5 style="color: #0d6efd">${feedbackItem.account.name}</h5>
                                                <p class="mb-0">${feedbackItem.comment}</p>
                                            </div>
                                        </div>
                                    </li>


                                </c:forEach>

                                <!--List-item-->

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    </body>
</html>
