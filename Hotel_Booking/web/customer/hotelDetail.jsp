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

    </head>

    <body>
        <%@include file="layout.jsp"%>
        <%
            hotelDAOs hDAO = new hotelDAOs();
            int hotelID = (int) request.getAttribute("hotelID");
            hotel h = hDAO.getHotelDetailById(hotelID);
            String location = h.getHotel_name();
            location += h.getHotel_address();
            location.replace(' ', '+');
        %>
        <div class="container mt-4" >
            <h1 class="display-4"><%= h.getHotel_name()%></h1>
            <p class="lead"><i class="fas fa-map-marker-alt"></i> <%= h.getHotel_address()%> – <a target="_blank" href="https://www.google.com/maps?q=<%= location %>">Great
                    location - show map</a></p>

            <div class="row">
                <div class=" col-9">
                    <div id="carouselExampleIndicators " class="carousel slide" data-ride="carousel">
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
                <div class="col-3" >
                    <h4 style="margin-bottom:  10px">Hotel Location</h4>
                        <iframe 
                            id="map"
                            style="border:0; height: 12rem; "
                            loading="lazy"
                            allow-scripts="false"
                            allowfullscreen
                            referrerpolicy="no-referrer-when-downgrade " 
                            src="https://www.google.com/maps/embed/v1/place?key=AIzaSyCic3r4-oNwtB5j-5IVDuPe8k3vyaijOZQ&q=1600+<%= location %>">
                        </iframe>
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

            <div class=" availability-container">
                <div class="header-section" >
                    <h3>Availability</h3>
                    <form method="get" action="/searchController/Change" onsubmit="return checkDates()">
                        <div class="d-flex justify-content-center" >



                            <div style="display: flex inline; box-sizing: border-box; border: 4px solid orange; background-color: orange; border-radius: 10px">
                                <input type="date" class="form-control" id="checkInDate" name="checkInDate" value="${checkInDate}" >
                                <h4>-</h4>
                                <input type="date" class="form-control" id="checkOutDate" name="checkOutDate" value="${checkOutDate}" >
                                <input hidden="" id="HotelID" name="HotelID" value="<%= h.getHotel_id()%>">
                                <!--onchange="submitForm('change')"-->
                            </div>


                            <div style="box-sizing: border-box; border: 4px solid orange; border-radius: 10px">
                                <button class="btn btn-primary" type="submit" name="btnChangesearch">Change search</button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Room List -->
                <div class="row mt-3">
                    <form action="/reserveController/submit" method="get" class="container" id="reservationForm" onsubmit="return checkCheckboxes()">
                        <input hidden="" type="date" class="form-control" id="checkInDate" name="checkInDate" value="${checkInDate}" >

                        <input hidden="" type="date" class="form-control" id="checkOutDate" name="checkOutDate" value="${checkOutDate}" >

                        <div class="col-12" id="fun">
                            <div class="card" style="background-color: #007bff">
                                <div class="card-body" style="background-color: #ddd">
                                    <div class="row">
                                        <div class="col-md-3 text-center">
                                            <h5>Room Name & Room Type</h5>
                                        </div>
                                        <div class="col-md-3 text-center">
                                            <h5>Room Description</h5>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <h5>Price per day</h5>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <h5>Available Rooms</h5>
                                        </div>
                                        <div class="col-md-2 text-center">
                                            <button class="btn btn-primary" type="submit" id="reserve-link" name="btnReserve" >I'll reserve</button>
                                            <input hidden="" id="HotelID" name="HotelID" value="<%= h.getHotel_id()%>">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${empty r}">
                            <div class="col-12 mb-3">
                                <div class="card " style="box-shadow: rgba(50, 50, 93, 0.25) 0px 30px 60px -12px inset, rgba(0, 0, 0, 0.3) 0px 18px 36px -18px inset;">
                                    <div class="card-body">
                                        <div class="text-center">
                                            <h4>Room is currently sold out</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:forEach items="${r}" var="ro">

                            <c:if test="${ro.room_status}">
                                <div class="col-12 mb-3" id="room_id" >
                                    <div class="card" style="box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset;">
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-3 apartment-type">
                                                    ${ro.room_name}

                                                    <div class="features">

                                                        <span name="roomType">${ro.room_type.name_type}</span>

                                                    </div>
                                                </div>  
                                                <div class="col-md-3 text-center">
                                                    <span class="badge badge-dark"></span>
                                                    <div class="features">
                                                        <span class="text-monospace" name="room_description">${ro.room_description}</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 text-center">
                                                    <span class="price" name="room_price">$${ro.room_price}</span><br>
                                                </div>
                                                <div class="col-md-2 text-center">

                                                    <span class="price" name="capacity" >${ro.room_capacity}</span><br>
                                                    <input hidden="" name="quantity" value="${ro.room_capacity}">
                                                </div>
                                                <div class="col-md-2 text-center">

                                                    <div class="checkbox-wrapper-31" id="check">
                                                        <input type="checkbox" id="roomID" name="roomID" value="${ro.room_id}">
                                                        <svg viewBox="0 0 35.6 35.6" >
                                                        <circle class="background" cx="17.8" cy="17.8" r="17.8" ></circle>
                                                        <circle class="stroke" cx="17.8" cy="17.8" r="14.37" ></circle>
                                                        <polyline class="check"  points="11.78 18.12 15.55 22.23 25.17 12.87"></polyline>
                                                        </svg>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                        </c:forEach>
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
                                <div class="input-group" style="box-shadow: rgba(6, 24, 44, 0.4) 0px 0px 0px 2px, rgba(6, 24, 44, 0.65) 0px 4px 6px -1px, rgba(255, 255, 255, 0.08) 0px 1px 0px inset;">
                                    <input type="text" name="txtComment" class="form-control" placeholder="Type your message">
                                    <input name="username" type="hidden" value="<%= value%>" >
                                    <input name="hotel_id" type="hidden" value="<%= h.getHotel_id()%>" >
                                    <input hidden="" type="date" class="form-control" id="checkInDate" name="checkInDate" value="${checkInDate}" >

                                    <input hidden="" type="date" class="form-control" id="checkOutDate" name="checkOutDate" value="${checkOutDate}" >
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
                                            <li class="list-group-item pt-0"style="box-shadow: rgba(6, 24, 44, 0.4) 0px 0px 0px 2px, rgba(6, 24, 44, 0.65) 0px 4px 6px -1px, rgba(255, 255, 255, 0.08) 0px 1px 0px inset;"> 
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script >
                var Today = new Date().toISOString().split('T')[0];
                var today = new Date();
                today.setDate(today.getDate() + 1);
                var tomorrow = today.toISOString().split('T')[0];
                console.log(tomorrow);
                document.getElementById("checkInDate").setAttribute("min", Today);
                document.getElementById("checkOutDate").setAttribute("min", tomorrow);
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
                    document.getElementById('reservationForm').submit();
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
                    document.getElementById('reservationForm').submit();
                    return true;
                }

                function checkForm() {
                    return checkDates() && checkCheckboxes();
                }

//                function checkCheckboxes() {
//                    // Get all checkboxes with the name 'quantity'
//                    var checkboxes = document.querySelectorAll('input[name="roomID"]');
//                    // Check if any of the checkboxes are checked
//                    var anyChecked = Array.prototype.slice.call(checkboxes).some(x => x.checked);
//                    // If none are checked, prevent form submission and alert the user
//                    if (!anyChecked) {
//                        alert("Please select at least one room to reserve.");
//                        return false; // Prevent form submission
//                    }
//                    do
//                    return true; // Allow form submission
//                }



        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=initMap"></script>
    </body>
    <style>
        /*        #check:hover {
                    
                    display: inline-block;
                    font-size: 50px;
                    color: #f39c12;
                    animation: ring 1s infinite;
                }
        
                @keyframes ring {
                    0% {
                        transform: rotate(0);
                    }
                    10% {
                        transform: rotate(30deg);
                    }
                    20% {
                        transform: rotate(60deg);
                    }
                    30% {
                        transform: rotate(90deg);
                    }
                    40% {
                        transform: rotate(120deg);
                    }
                    50% {
                        transform: rotate(150deg);
                    }
                    60% {
                        transform: rotate(180deg);
                    }
                    70% {
                        transform: rotate(210deg);
                    }
                    80% {
                        transform: rotate(240deg);
                    }
                    90% {
                        transform: rotate(270deg);
                    }
                    95% {
                        transform: rotate(300deg);
                    }
                    100% {
                        transform: rotate(330deg);
                    }
                }*/


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

        .checkbox-wrapper-31:hover .check {
            stroke-dashoffset: 0;
        }

        .checkbox-wrapper-31 {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 40px;
        }
        .checkbox-wrapper-31 .background {
            fill: #ccc;
            transition: ease all 0.6s;
            -webkit-transition: ease all 0.6s;
        }
        .checkbox-wrapper-31 .stroke {
            fill: none;
            stroke: #fff;
            stroke-miterlimit: 10;
            stroke-width: 2px;
            stroke-dashoffset: 100;
            stroke-dasharray: 100;
            transition: ease all 0.6s;
            -webkit-transition: ease all 0.6s;

        }
        .checkbox-wrapper-31 .check {
            fill: none;
            stroke: #fff;
            stroke-linecap: round;
            stroke-linejoin: round;
            stroke-width: 2px;
            stroke-dashoffset: 22;
            stroke-dasharray: 22;
            transition: ease all 0.6s;
            -webkit-transition: ease all 0.6s;

        }
        .checkbox-wrapper-31 input[type=checkbox] {
            position: absolute;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
            margin: 0;
            opacity: 0;
            -appearance: none;
            -webkit-appearance: none;
        }
        .checkbox-wrapper-31 input[type=checkbox]:hover {
            cursor: pointer;
        }
        .checkbox-wrapper-31 input[type=checkbox]:checked + svg .background {
            fill: #6cbe45;

        }
        .checkbox-wrapper-31 input[type=checkbox]:checked + svg .stroke {
            stroke-dashoffset: 0;
        }
        .checkbox-wrapper-31 input[type=checkbox]:checked + svg .check {
            stroke-dashoffset: 0;
        }

    </style>
</html>

