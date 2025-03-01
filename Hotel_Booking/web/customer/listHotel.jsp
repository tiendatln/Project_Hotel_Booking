<%-- 
    Document   : listHotel
    Created on : Jun 24, 2024, 6:02:47 AM
    Author     : tiend
--%>

<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@page import="Model.hotel"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            String destination = (String) request.getAttribute("destination");
            long checkin = (long) request.getAttribute("checkin");
            long checkout = (long) request.getAttribute("checkout");
            Date checkinDate = new Date(checkin);
            Date checkoutDate = new Date(checkout);
            int i = 0;
        %>
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-3">
                    <div class="search-container" style="box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;">
                        <h5>Search</h5>
                        <form method="post" action="/searchController" onsubmit="return validateForm()" >
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
                                <label for="quantity"> Quantity</label>
                                <input type="number" class="form-control" id="quantity" name="txtQuantity" placeholder="Enter Quantity" min="1" max="30" list="defaultNumbers" value="${searchQuantity}">
                                <datalist id="defaultNumbers">
                                    <option value="1"></option>
                                    <option value="2"></option>
                                    <option value="3"></option>
                                    <option value="4"></option>
                                    <option value="5"></option>
                                    <option value="6"></option>
                                    <option value="7"></option>
                                    <option value="8"></option>
                                    <option value="9"></option>
                                    <option value="10"></option>
                                </datalist>
                            </div>
                            <span id="error" class="text-danger"></span>
                            <button type="submit" class="btn btn-primary btn-block" name="btnSearchHotel">Search</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-9">

                    <c:forEach items="${hotel}" var="h">
                        <%
                            roomDAOs roomDAO = new roomDAOs();
                            List<hotel> ht = (List<hotel>) request.getAttribute("hotel");
                            int lowPrice = roomDAO.getLowPrice(ht.get(i).getHotel_id());
                            int highPrice = roomDAO.getHighPrice(ht.get(i).getHotel_id());
                            String location = ht.get(i).getHotel_name();
                            location += ht.get(i).getHotel_address();
                            location.replace(' ', '+');
                            i++;
                        %>
                        <div class="property-card card" style="flex-direction: row;box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;">
                            <img style="width: 250px; height: 250px; border-radius: 10px;" src="<%= request.getContextPath()%>/imgs/hotel/${h.hotel_img}" class="card-img-top" alt="">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center" >
                                    <div>
                                        <h5 class="property-title">${h.hotel_name}</h5>
                                        <p class="property-details text-success">
                                            <a target="_blank" href="https://www.google.com/maps?q=<%= location %>">${h.hotel_address}</a> <br>
                                            Service: 

                                            <c:forEach items="${service}" var="s">
                                                <c:if test="${s.hotel.hotel_id == h.hotel_id}">
                                                    ${s.service_name} -
                                                </c:if>
                                            </c:forEach>

                                            <br>
                                        </p>
                                    </div>
                                    <div class="text-right">
                                        <p class="price">

                                            $<%= lowPrice%> - $<%= highPrice%>
                                        </p>

                                        <p>Includes taxes and fees</p>
                                        <a class="btn btn-primary" href="/searchController/HotelDetail/<%= checkinDate%>/<%= checkoutDate%>/${h.hotel_id}" >See availability</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                    <!-- Add more property cards as needed -->
                </div>
            </div>
        </div>

        <script>
            // Set the minimum check-in date to today
            var Today = new Date().toISOString().split('T')[0];
                var today = new Date();
                today.setDate(today.getDate() + 1);
                var tomorrow = today.toISOString().split('T')[0];
                console.log(tomorrow);
                today.setDate(today.getDate() + 1);
                var day2 = today.toISOString().split('T')[0];
                console.log(tomorrow);
            document.getElementById("checkin-date").setAttribute("min", tomorrow);
            document.getElementById("checkout-date").setAttribute("min", day2);

            // Function to update the minimum check-out date based on check-in date
            function validateForm() {
                var checkin = document.getElementById('checkin-date').value;
                var checkout = document.getElementById('checkout-date').value;

                if (!checkin) {
                    
                    document.getElementById('checkin-date').value = tomorrow;
                    checkin = tomorrow;
                }

                if (!checkout) {
                    
                    document.getElementById('checkout-date').value = tomorrow;
                    checkout = tomorrow;
                }

                var checkinDate = new Date(checkin);
                var checkoutDate = new Date(checkout);

                if (checkoutDate < checkinDate) {
                    document.getElementById("error").innerHTML = "Check-out date must be after check-in date.";
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
