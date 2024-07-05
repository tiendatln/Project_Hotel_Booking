<%-- 
    Document   : listHotel
    Created on : Jun 24, 2024, 6:02:47 AM
    Author     : tiend
--%>

<%@page import="DAOs.hotelDAOs"%>
<%@page import="java.sql.Date"%>
<%@page import="DAOs.serviceDAOs"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.roomDAOs"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homes Guests Love</title>
        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f7f7f7;
            }
            .search-container {
                background-color: #ffd700;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .filter-container {
                background-color: #ffffff;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .property-card {
                background-color: #ffffff;
                border: none;
                border-radius: 10px;
                overflow: hidden;
                margin-bottom: 20px;
            }
            .property-card img {
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
                width: 100%;
            }
            .property-card .card-body {
                padding: 15px;
            }
            .property-title {
                font-size: 1.2rem;
                font-weight: bold;
            }
            .property-details {
                font-size: 0.9rem;
                color: #6c757d;
            }
            .price {
                font-weight: bold;
                color: #007bff;
            }
            .rating {
                font-size: 1rem;
                margin-bottom: 0.5rem;
            }
            .reviews {
                font-size: 0.9rem;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <%@include file="layout.jsp" %>
        <%
            String destination = (String) request.getSession().getAttribute("destination");
            String roomType = (String) request.getSession().getAttribute("roomType");
            long checkin = (long) request.getSession().getAttribute("checkin");
            long checkout = (long) request.getSession().getAttribute("checkout");
            Date checkinDate = new Date(checkin);
            Date checkoutDate = new Date(checkout);
        %>
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-3">
                    <div class="search-container">
                        <h5>Search</h5>
                        <form method="post" action="/searchController" onsubmit="return validateForm()">
                            <div class="form-group">
                                <label for="destination">Destination/property name:</label>
                                <input type="text" class="form-control" id="destination" name="destination" value="<%= destination%>">
                            </div>
                            <div class="form-group">
                                <label for="checkin">Check-in date</label>
                                <input type="date" class="form-control" id="checkin-date" name="checkin-date" value="<%= checkinDate%>">
                            </div>
                            <div class="form-group">
                                <label for="checkout">Check-out date</label>
                                <input type="date" class="form-control" id="checkout-date" name="checkout-date" value="<%= checkoutDate%>">
                            </div>
                            <div class="form-group">
                                <label for="guests">Guest</label>

                                <select class="form-control" id="guests" onchange="javascript: dynamicDropdown(this.options[this.selectedIndex].value);">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary btn-block" name="btnSearchHotel">Search</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-9">
                    <%
                        roomDAOs roomDAO = new roomDAOs();
                        hotelDAOs hDAO = new hotelDAOs();
                        ResultSet rs = hDAO.searchHotelByLocal(destination);
                        while (rs.next()) {
                    %>
                    <div class="property-card card">
                        <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h5 class="property-title"><%= rs.getString("hotel_name")%></h5>
                                    <p class="property-details text-success">
                                        <a href="#"><%= rs.getString("hotel_address")%></a> <br>
                                        Service: 
                                        <%
                                            serviceDAOs sDAO = new serviceDAOs();
                                            ResultSet rsv = sDAO.getServiceByHotelID(rs.getInt("hotel_id"));
                                            while (rsv.next()) {
                                        %>
                                        <%= rsv.getString("service_name")%>.
                                        <% }%>
                                        <br>

                                        <%
                                            ResultSet rrt = roomDAO.showRoomTypeByHotelID(rs.getInt("hotel_id"));
                                            while (rrt.next()) {
                                        %>

                                        <%= rrt.getString("name_type")%>.

                                        <%
                                            }
                                        %>
                                    </p>
                                </div>
                                <div class="text-right">
                                    <p class="price">
                                        <%
                                            int lowPrice = roomDAO.getLowPrice(rs.getInt("hotel_id"));
                                            int highPrice = roomDAO.getHighPrice(rs.getInt("hotel_id"));
                                        %>
                                        $<%= lowPrice%> - $<%= highPrice%>
                                    </p>

                                    <p>Includes taxes and fees</p>
                                    <a class="btn btn-primary" href="/searchController/HotelDetail/<%= rs.getInt("hotel_id")%>" >See availability</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }%>
                    <!-- Add more property cards as needed -->
                </div>
            </div>
        </div>

        <script>
            // Set the minimum check-in date to today
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("checkin-date").setAttribute("min", today);

            // Function to update the minimum check-out date based on check-in date
            function updateCheckoutDate() {
                var checkinDate = document.getElementById('checkin-date').value;
                document.getElementById('checkout-date').setAttribute("min", checkinDate);
            }

            // Set the minimum check-out date when the check-in date changes
            document.getElementById('checkin-date').addEventListener('change', updateCheckoutDate);

            function validateForm() {
                var destination = document.getElementById('destination').value;
                if (destination.trim() === "") {
                    alert("Enter a destination to start searching.");
                    return false;
                }
                var checkin = document.getElementById('checkin-date').value;
                var checkout = document.getElementById('checkout-date').value;

                if (!checkin) {
                    var today = new Date().toISOString().split('T')[0];
                    document.getElementById('checkin-date').value = today;
                    checkin = today;
                }

                if (!checkout) {
                    var today = new Date().toISOString().split('T')[0];
                    document.getElementById('checkout-date').value = today;
                    checkout = today;
                }

                var checkinDate = new Date(checkin);
                var checkoutDate = new Date(checkout);

                if (checkoutDate < checkinDate) {
                    alert('Check-out date must be after check-in date.');
                    return false;
                }

                return true;
            }
        </script>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
