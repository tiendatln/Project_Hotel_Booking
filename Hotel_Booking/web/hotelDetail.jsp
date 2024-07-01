<%-- 
    Document   : hotelDetail
    Created on : Jun 28, 2024, 10:54:49 AM
    Author     : tiend
--%>

<%@page import="DAOs.serviceDAOs"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.roomDAOs"%>
<%@page import="Model.hotel"%>
<%@page import="DAOs.hotelDAOs"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>hotel Detail</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="styles.css" rel="stylesheet">
        <style>
            .apartment-type {
                font-size: 1.25rem;
                font-weight: bold;
            }
            .price {
                color: red;
                font-weight: bold;
            }
            .discount {
                color: green;
                font-weight: bold;
            }
            .badge {
                font-size: 0.875rem;
            }
            .features {
                font-size: 0.875rem;
                color: #555;
            }
            .features span {
                display: block;
            }
            .availability-container {
                margin-top: 20px;
            }
            .header-section {
                padding: 15px;
                border-bottom: 1px solid #ddd;
            }
        </style>
    </head>

    <body>
        <%@include file="layout.jsp"%>
        <%
            hotelDAOs hDAO = new hotelDAOs();
            int hotelID = (int) request.getSession().getAttribute("hotelID");
            hotel h = hDAO.getHotelDetailById(hotelID);
        %>
        <div class="container mt-4" >
            <h1 class="display-4"><%= h.getHotel_name()%></h1>
            <p class="lead"><i class="fas fa-map-marker-alt"></i> <%= h.getHotel_address()%> – <a href="#">Great
                    location - show map</a></p>

            <div class="row">

                <div class="row">
                    <div class="col-md-8">
                        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <c:forEach items="${roomImg}" varStatus="status">
                                    <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                                    </c:forEach>
                            </ol>
                            <div class="carousel-inner" style="width: 700px">
                                <c:forEach items="${roomImg}" var="room" varStatus="status">
                                    <div class="carousel-item ${status.first ? 'active' : ''}">
                                        <img src="<%= request.getContextPath()%>/imgs/room/${room.room_img}" class="d-block w-100" alt="...">
                                    </div>
                                </c:forEach>
                            </div>
                            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Very Good <span class="badge badge-primary">8.2</span></h5>
                                <p class="card-text"><i>"too cheap of a price for an amazing 4 stars experience"</i></p>
                                <p class="card-text"><i class="fas fa-user"></i> Tin – Vietnam</p>
                                <hr>
                                <h6>Staff <span class="badge badge-success">8.8</span></h6>
                            </div>
                        </div>
                        <div id="map" style="height: 200px;"></div>
                    </div>
                </div>
            </div>

            <div class="my-4">
                <div>
                    <h5 style="color: #0c63e4">Sevice</h5>
                </div>
                <div class="row">
                    <div class="col text-center">
                        <%
                            serviceDAOs sDAO = new serviceDAOs();
                            ResultSet rsService = sDAO.getServiceByHotelID(h.getHotel_id());
                            while (rsService.next()) {
                        %>
                        <span class="badge badge-info"><%= rsService.getString("service_name")%></span>
                        <% }%>
                    </div>
                </div>
            </div>

            <div class="my-4">
                <h2>About the Property</h2>
                <p><%= h.getHotel_description()%></p>
            </div>

            <div class="container availability-container">
                <div class="header-section" >
                    <h3>Availability</h3>
                    <div class="d-flex justify-content-center">
                        <div style="display: flex inline; box-sizing: border-box; border: 4px solid yellow; background-color: yellow; border-radius: 10px">
                            <input type="date" class="form-control" value="2024-07-03">
                            <h4>-</h4>
                            <input type="date" class="form-control" value="2024-07-19">
                        </div>
                        <div style="box-sizing: border-box; border: 4px solid yellow; border-radius: 10px">
                            <select class="form-control">
                                <option>2 adults · 0 children · 1 room</option>
                            </select>
                        </div>
                        <div style="box-sizing: border-box; border: 4px solid yellow; border-radius: 10px">
                            <a class="btn btn-primary" >Change search</a>
                        </div>
                    </div>
                </div>

                <!-- Room List -->
                <div class="row mt-3">
                    <!-- Repeat for each room type -->
                    <div class="col-12">
                        <div class="card" style="background-color: #007bff">
                            <div class="card-body" style="background-color: #ddd">
                                <div class="row">
                                    <div class="col-md-3 text-center">
                                        <h5>Room Type</h5>
                                    </div>
                                    <div class="col-md-2 text-center">

                                    </div>
                                    <div class="col-md-2 text-center ">
                                        <h5>Price</h5>
                                    </div>
                                    <div class="col-md-3 text-center ">

                                    </div>
                                    <div class="col-md-2 text-center">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        roomDAOs rDAO = new roomDAOs();
                        ResultSet rsRoom = rDAO.getRoomByHotelID(h.getHotel_id());
                        while (rsRoom.next()) {
                            if (rsRoom.getBoolean("room_status")) {
                    %>
                    <div class="col-12 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 apartment-type">
                                        <%= rsRoom.getString("room_name")%>
                                        <%
                                            ResultSet rsRType = rDAO.showRoomTypeByRoomID(rsRoom.getInt("room_id"));
                                        %>
                                        <div class="features">
                                            <% while (rsRType.next()) {%>
                                            <span><%= rsRType.getString("name_type")%></span>
                                            <% }%>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-center">
                                        <span class="badge badge-dark">Entire apartment · 105 m²</span>
                                        <div class="features">
                                            <span></span>
                                        </div>
                                    </div>
                                    <div class="col-md-2 text-center">
                                        <span class="price">$<%= rsRoom.getLong("room_price")%> </span><br>
                                        <span class="discount">40% off</span>
                                    </div>
                                    <div class="col-md-3 text-center">
                                        <span class="badge badge-success">Free cancellation before July 2, 2024</span><br>
                                        <span>No prepayment needed - pay at the property</span>
                                    </div>
                                    <div class="col-md-2 text-center">
                                        <a class="btn btn-primary mt-2" href="/reservationController/Reserve">I'll reserve</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }
                    }%>
                    <!-- End Repeat -->
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script>
            function initMap() {
                var location = {lat: 10.345, lng: 107.084};
                var map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 15,
                    center: location
                });
                var marker = new google.maps.Marker({
                    position: location,
                    map: map
                });
            }
        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"></script>
    </body>
</html>

