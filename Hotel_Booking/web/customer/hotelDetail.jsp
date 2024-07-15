<%-- 
    Document   : hotelDetail
    Created on : Jun 28, 2024, 10:54:49 AM
    Author     : tiend
--%>

<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@page import="Model.feedback"%>
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
                    <form action="/reserveController" method="get" class="container" id="reservationForm">
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
                                            <input hidden="" id="HotelID" name="HotelID" value="<%= h.getHotel_id()%>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%        roomDAOs rDAO = new roomDAOs();
                            ResultSet rsRoom = rDAO.getRoomByHotelID(h.getHotel_id());
                            List<room> r = (List<room>) request.getAttribute("room");
                            int i = 0;
                            while (rsRoom.next()) {
                                room room = r.get(i);
                                i++;
                                if (rsRoom.getBoolean("room_status")) {
                                    if (room.getRoom_id() == rsRoom.getInt("room_id")) {
                        %>

                        <div class="col-12 mb-3" id="room_id">
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
                                                <span name="roomType"><%= rsRType.getString("name_type")%></span>
                                                <% }%>
                                            </div>
                                        </div>  
                                        <div class="col-md-4 text-center">
                                            <span class="badge badge-dark"></span>
                                            <div class="features">
                                                <span class="text-monospace" name="room_description"><%= rsRoom.getString("room_description")%></span>
                                            </div>
                                        </div>
                                        <div class="col-md-3 text-center">
                                            <span class="price" name="room_price">$<%= rsRoom.getLong("room_price")%></span><br>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <input type="checkbox" id="roomID" name="roomID" value="<%= rsRoom.getString("room_id")%>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                    }
                                }
                            }
                        %>
                    </form>
                    <!-- End Repeat -->
                </div>
            </div>

            <div class="container" style="background-color: #99CCCC; border-radius: 10px ">
                <div class="container" style="background-color: #DDDDDD; border-radius: 10px">
                    <form method="post" action="/feedbackController" id="formFeedback">
                        <div class="flex-grow-0 py-3 px-4 border-top">
                            <div>
                                <h4>Your Feedback</h4>
                            </div>
                            <c:if test="${canFeedback}">
                                <div class="input-group">
                                    <input type="text" name="txtComment" class="form-control" placeholder="Type your message">
                                    <input name="username" type="hidden" value="<%= value%>" >
                                    <input name="hotel_id" type="hidden" value="<%= h.getHotel_id()%>" >
                                    <button class="btn btn-primary" name="btnFeedback">Send</button>
                                </div>
                            </c:if>
                            <c:if test="${!canFeedback}">
                                <div class="input-group">
                                    <input type="text" name="txtComment" class="form-control" placeholder="Type your message" disabled>
                                    <button class="btn btn-primary" name="btnFeedback" disabled>Send</button>
                                </div>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- Feedback -->
                <div class="container mt-4">
                    <div class="row">
                        <div class="col-xl-12 mb-3 mb-lg-5">
                            <div class="card">
                                <div class="d-flex card-header justify-content-between">
                                    <h5 class="me-3 mb-0">Feedback</h5>
                                    <a class="btn" style="color: #0d6efd" href="/feedbackController/ViewAll/<%= h.getHotel_id()%>">View All</a>
                                </div>
                                <div class="card-body">
                                    <ul class="list-group list-group-flush">
                                        <!--List-item-->
                                        <%
                                            int counter = 0;
                                        %>
                                        <c:forEach items="${feedback}" var="feedbackItem">
                                            <%
                                                if (counter < 5) {
                                            %>
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
                                            <%
                                                    counter++;
                                                }
                                            %>

                                        </c:forEach>

                                        <!--List-item-->

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <c:if test="${loginToReserve}">
            <script>
                alert("You must be login to reserve!");
            </script>
        </c:if>
        <c:if test="${errorFeedback}">
            <script>
                alert("Feedback can not send!");
            </script>
        </c:if>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script >
                var today = new Date().toISOString().split('T')[0];
                document.getElementById("checkInDate").setAttribute("min", today);
                document.getElementById("checkOutDate").setAttribute("min", today);
                function submitForm(actionType) {
                    if (actionType === 'change') {
                        if (checkDatesChange()) {
                            setFormAction(actionType);
                            document.getElementById('reservationForm').submit();
                        }
                    } else {
                        if (checkForm()) {
                            setFormAction(actionType);
                            document.getElementById('reservationForm').submit();
                        }
                    }
                }

                function setFormAction(actionType) {

                    var form = document.getElementById('reservationForm');
                    if (actionType === 'change') {
                        form.action = '/reserveController/Change';
                    } else {
                        form.action = '/reserveController/submit';
                    }
                }

                function checkDates() {
                    var checkInDate = document.getElementById('checkInDate').value;
                    var checkOutDate = document.getElementById('checkOutDate').value;

                    if (!checkInDate || !checkOutDate) {
                        if (!checkInDate) {
                            alert("Please fill in the check-in dates.");
                        }
                        if (!checkOutDate) {
                            alert("Please fill in the check-out dates.");
                        } else {
                            alert("Please fill in both the check-in and check-out dates.");
                        }
                        return false;
                    }
                    
                    if (new Date(checkInDate) >= new Date(checkOutDate)) {
                        alert("Check-out date must be after check-in date.");
                        return false;
                    }
                    return true;
                }

                function checkDatesChange() {
                    var checkInDate = document.getElementById('checkInDate').value;
                    var checkOutDate = document.getElementById('checkOutDate').value;
                    if (!checkInDate || !checkOutDate) {
                        return false;
                    }
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

                    return true; // Allow form submission
                }



        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"></script>
    </body>
</html>

