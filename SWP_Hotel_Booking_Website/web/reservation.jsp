<%-- 
    Document   : reservation
    Created on : Jun 20, 2024, 8:07:25 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.ServiceDAO"%>
<%--<%@page import="com.nimbusds.jose.crypto.impl.AAD"%>--%>
<%@page import="dao.RoomDAO"%>
<%@page import="dao.AccountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dao.ReservationDAO"%>
<%@page import="model.Reservation"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>        
        <%@include file="layout/menu.jsp" %>

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
                        <th scope="col">Service</th>
                        <th scope="col">Price</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <%
                    ReservationDAO reDao = new ReservationDAO();
                    ResultSet rs = reDao.getAllInfo(value);
                    while (rs.next()) {
                        int count = 1;
                %>
                <tbody>
                    <!-- Example reservation data -->
                    <tr>
                        <th scope="row"><%=count%></th>
                        <td><%= rs.getString("name")%></td>
                        <td><%= rs.getString("room_name")%></td>
                        <td><%= rs.getString("hotel_name")%></td>
                        <td><%= rs.getString("phone")%></td>
                        <td><%= rs.getDate("check_in_date")%></td>
                        <td><%= rs.getDate("check_out_date")%></td>
                        <td><%= rs.getInt("quantity")%></td>
                        <td><%= rs.getString("service_description")%></td>
                        <td><%= rs.getLong("list_price")%>$</td>
                        <td><%if (rs.getBoolean("status") == true) {%>
                            confirmed
                            <% } else { %>
                            unconfimred
                            <% } %></td>
                    </tr>
                </tbody>
                <%
                        count++;
                    } %>
            </table>
        </div>        
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
