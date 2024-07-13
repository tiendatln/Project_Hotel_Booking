<%-- 
    Document   : hotelDetail
    Created on : Jun 28, 2024, 10:54:49 AM
    Author     : tiend
--%>

<%@page import="Model.room"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="DAOs.serviceDAOs"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.roomDAOs"%>
<%@page import="Model.hotel"%>
<%@page import="DAOs.hotelDAOs"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

            <div class="container" style="width: 700px">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators" >
                        <c:forEach items="${roomImg}" varStatus="status">
                            <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="${status.first ? 'active' : ''}"></li>
                            </c:forEach>
                    </ol>
                    <div class="carousel-inner" >
                        <c:forEach items="${roomImg}" var="room" varStatus="status">
                            <div class="carousel-item ${status.first ? 'active' : ''}" >
                                <img src="<%= request.getContextPath()%>/imgs/room/${room.room_img}" class="d-block w-100" alt="...">
                            </div>
                        </c:forEach>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next " href="#carouselExampleIndicators" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>

            <div class="my-4"">
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
                <!--                <div class="header-section" >
                                    <h3>Availability</h3>
                                                        <form method="post" action="/reservationController" onsubmit="return validateForm()">
                                    <div class="d-flex justify-content-center">
                <%

                %>
                <div style="display: flex inline; box-sizing: border-box; border: 4px solid yellow; background-color: yellow; border-radius: 10px">
                    <input type="date" class="form-control" name="checkInDate" >
                    <h4>-</h4>
                    <input type="date" class="form-control" name="checkOutDate" >
                </div>
                <div style="box-sizing: border-box; border: 4px solid yellow; border-radius: 10px">
                    <select class="form-control">
                        <option>2 adults · 0 children · 1 room</option>
                    </select>
                </div>
                <div style="box-sizing: border-box; border: 4px solid yellow; border-radius: 10px">
                    <a class="btn btn-primary" name="btnChangesearch">Change search</a>
                </div>
            </div>
                                </form>
        </div>-->

                <!-- Room List -->
                <div class="row mt-3">
                    <form action="/reserveController" method="get" class="container" id="reservationForm" onsubmit="return checkForm()">
                        <div class="header-section">
                            <h3>Availability</h3>
                            <div class="d-flex justify-content-center">
                                <div style="display: flex inline; box-sizing: border-box; border: 4px solid yellow; background-color: yellow; border-radius: 10px">
                                    <input type="date" class="form-control" id="checkInDate" name="checkInDate" onchange="submitForm('change')">
                                    <h4>-</h4>
                                    <input type="date" class="form-control" id="checkOutDate" name="checkOutDate" onchange="submitForm('change')">
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="card" style="background-color: #007bff">
                                <div class="card-body" style="background-color: #ddd">
                                    <div class="row">
                                        <div class="col-md-3 text-center">
                                            <h5>Room Type</h5>
                                        </div>
                                        <div class="col-md-4 text-center">
                                            <h5>Room Description</h5>
                                        </div>
                                        <div class="col-md-3 text-center">
                                            <h5>Price per day</h5>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <button class="btn btn-primary" type="submit" id="reserve-link" name="btnReserve" onclick="setFormAction('submit')">I'll reserve</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%                            List<room> room = (List<room>) request.getAttribute("room");
                            int i = 0;
                            while (i < room.size()) {
                                room r = room.get(i);
                                i++;
                        %>
                        <div class="col-12 mb-3" id="room_id">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3 apartment-type">
                                            <%= r.getRoom_name()%>
                                            <%
                                                roomDAOs rDAO = new roomDAOs();
                                                ResultSet rsRType = rDAO.showRoomTypeByRoomID(r.getRoom_id());
                                            %>
                                            <div class="features">
                                                <% while (rsRType.next()) {%>
                                                <span name="roomType"><%= rsRType.getString("name_type")%></span>
                                                <% }%>
                                            </div>
                                        </div>  
                                        <div class="col-md-4 text-center">
                                            <span class="badge badge-dark"></span>
                                            <div class="features">
                                                <span class="text-monospace" name="room_description"><%= r.getRoom_description()%></span>
                                            </div>
                                        </div>
                                        <div class="col-md-3 text-center">
                                            <span class="price" name="room_price">$ <%= r.getRoom_price()%></span><br>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <input type="checkbox" id="roomID" name="roomID" value="<%= r.getRoom_id()%>">
                                            <input hidden="" id="HotelID" name="HotelID" value="<%= h.getHotel_id()%>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </form>
                    <!-- End Repeat -->
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <c:if test="${loginToReserve != null}">
            <script>
                                                alert("You must be login to reserve!");
            </script>
        </c:if>
        <script >
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("checkInDate").setAttribute("min", today);
            document.getElementById("checkOutDate").setAttribute("min", today);
            function submitForm(actionType) {
                if (checkDates()) {
                    setFormAction(actionType);
                    document.getElementById('reservationForm').submit();
                }
            }

            function setFormAction(actionType) {
                var checkInDate = document.getElementById('checkInDate').value;
                var checkOutDate = document.getElementById('checkOutDate').value;
                var form = document.getElementById('reservationForm');
                if (actionType === 'change') {
                    form.action = '/searchController/Change/' + checkInDate + checkOutDate +<%= h.getHotel_id()%>;
                } else {
                    form.action = '/reserveController';
                }
            }

            function checkDates() {
                var checkInDate = document.getElementById('checkInDate').value;
                var checkOutDate = document.getElementById('checkOutDate').value;

                if (new Date(checkInDate) >= new Date(checkOutDate)) {
                    alert("Check-out date must be after check-in date.");
                    return false;
                }
                return true;
            }

            function checkCheckboxes() {
                var checkboxes = document.querySelectorAll('input[type="checkbox"]');
                var isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);

                if (!isChecked) {
                    alert("Please select at least one room.");
                    return false;
                }
                return true;
            }

            function checkForm() {
                return checkDates() && checkCheckboxes();
            }

            function checkCheckboxes() {
                // Get all checkboxes with the name 'quantity'
                var checkboxes = document.querySelectorAll('input[name="roomID"]');
                // Check if any of the checkboxes are checked
                var anyChecked = Array.prototype.slice.call(checkboxes).some(x => x.checked);
                // If none are checked, prevent form submission and alert the user
                if (!anyChecked) {
                    alert("Please select at least one room to reserve.");
                    return false; // Prevent form submission
                }
                validateForm();
                return true; // Allow form submission
            }

            function validateForm() {

                var checkin = document.getElementById('checkInDate').value;
                var checkout = document.getElementById('checkOuDdate').value;

                if (!checkin) {
                    var today = new Date().toISOString().split('T')[0];
                    document.getElementById('checkInDate').value = today;
                    checkin = today;
                }

                if (!checkout) {
                    var today = new Date().toISOString().split('T')[0];
                    document.getElementById('checkOuDdate').value = today;
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
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"></script>
    </body>
</html>

