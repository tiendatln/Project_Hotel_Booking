
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
                        <th scope="col">Service</th>
                        <th scope="col">Price</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <%
                    reservationDAOs reDao = new reservationDAOs();
                    ResultSet rs = reDao.getAllInfo(value);
                    while (rs.next()) {
                        int count = 1;
                %>
                <tbody>
                    <!-- Example reservation data -->
                    <tr>
                        <th scope="row"><%= count %></th>
                        <td><%= rs.getString("name")%></td>
                        <td><%= rs.getString("room_name")%></td>
                        <td><%= rs.getString("hotel_name")%></td>
                        <td><%= rs.getString("phone")%></td>
                        <td><%= rs.getDate("check_in_date")%></td>
                        <td><%= rs.getDate("check_out_date")%></td>
                        <td><%= rs.getInt("quantity")%></td>
                        <td><%= rs.getString("service_name")%></td>
                        <td><%= rs.getLong("list_price")%>$</td>
                        <td><%if (rs.getInt("status") == 1) {%>
                            Confirmed
                            <% } else if (rs.getInt("status") == 0){ %>
                            Pending
                            <% } else if(rs.getInt("status") == 2){ %>
                            Denied
                            <% } %>
                        </td>
                    </tr>
                </tbody>
                <%
                        count = count + 1;
                    } %>
            </table>
        </div>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>