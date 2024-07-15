
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAOs.serviceDAOs"%>
<%@page import="DAOs.roomDAOs"%>
<%@page import="DAOs.accountDAOs"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.reservationDAOs"%>
<%@page import="Model.reservation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>trang quản lý</title>

        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <style>
            td{
                font-size: large
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file="layout.jsp" %>
        </header>

        <div class="container-fluid mt-5">
            <h1 class="text-center mb-4">Reservation List</h1>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Full Name</th>
                        <th scope="col">Room Name</th>
                        <th scope="col">Hotel Name</th>
                        <th scope="col">Phone Number</th>
                        <th scope="col">Check In Date</th>
                        <th scope="col">Check out Date</th>
                        <th scope="col">Quantity</th>
                        <th scope="col">Date</th>
                        <th scope="col">Price</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <%
                    int count = 1;
                %>
                <c:forEach items="${reservation}" var="reservation">

                    <tbody  >
                        <!-- Example reservation data -->
                        <tr>
                            <th scope="row"><%= count%></th>
                            <td>${reservation.account.name}</td>
                            <td>${reservation.room.room_name}</td>
                            <td>${reservation.service.hotel.hotel_name}</td>
                            <td>${reservation.account.phone}</td>
                            <td>${reservation.check_in_date}</td>
                            <td>${reservation.check_out_date}</td>
                            <td>${reservation.quantity}</td>
                            <td>${reservation.re_date}</td>
                            <td>${reservation.list_price}$</td>
                            <td>
                                <c:if test="${reservation.status == 1}">
                                    <span style="color: #00CC00">Confirmed</span>
                                </c:if>
                                <c:if test="${reservation.status == 0}">
                                    <span style="color: #007bff">Pending</span>
                                    
                                </c:if>
                                <c:if test="${reservation.status == 2}">
                                    <span style="color: red">Canceled</span>
                                </c:if>
                            </td>
                        </tr>
                    </tbody>
                    <%
                        count++;
                    %>
                </c:forEach>

            </table>
        </div>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>