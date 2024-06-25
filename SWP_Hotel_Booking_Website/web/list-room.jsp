<%-- 
    Document   : room
    Created on : Jun 20, 2024, 8:40:24 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Page</title>
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Cabin:400,500,600,700&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">           
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>
    <body>
        <%@include file="layout/menu.jsp" %>
        
        <div class="container" style="background-color: brown; margin-top: 20px;">
            <div class="card custom-bg p-4 d-flex">
                <form id="hotel-form" onsubmit="return validateForm()">
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="validationServer01" class="d-inline-flex">Destination</label>
                            <input type="text" placeholder="City" class="form-control" id="destination" name="destination"
                                   required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="checkin-date" class=" d-inline-flex">Check-in</label>
                            <input type="date" class="form-control" id="checkin-date" name="checkin-date"
                                   onkeydown="return false" required>
                        </div>
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="checkout-date" class=" d-inline-flex">Check-out</label>
                            <input type="date" class="form-control" id="checkout-date" name="checkout-date"
                                   onkeydown="return false" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="guests" class="d-inline-flex ">Guests</label>
                            <select class="form-control" id="guests"
                                    onchange="javascript: dynamicDropdown(this.options[this.selectedIndex].value);">
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
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="rooms" class="d-inline-flex ">Room Type</label>
                            <select id="inputState" class="form-control">
                                <option selected>Choose...</option>
                                <option>...</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="text-left col-auto">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                        <div id="error" class="error text-danger"></div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-auto w-100" style="">

            </div>
        </div>

        <section class="rooms-section spad">
            <div class="container">
                <div class="row">
                    <c:forEach items="${RoomData}" var="room">                        

                        <div class="col-lg-4 col-md-6">
                            <div class="room-item">                            
                                <a href="room?action=roomdetail&room_id=${room.room_id}"><img src="img/room/room-details.jpg" alt=""></a>
                                <div class="ri-text">                                
                                    <h4><a href="room?action=roomdetail&room_id=${room.room_id}" style="color: black">${room.room_type.name_type}</a></h4>
                                    <h3>${room.room_price}$<span>/Pernight</span></h3>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td class="r-o">No.Room:</td>
                                                <td>${room.room_name}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Capacity:</td>
                                                <td>Max persion ${room.room_type.room_capacity}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Hotel:</td>
                                                <td>${room.hotel.hotel_name}</td>
                                            </tr>          
                                            <tr>
                                                <td class="r-o">Location:</td>
                                                <td>${room.hotel.hotel_address}</td>
                                            </tr> 
                                        </tbody>
                                    </table>                                
                                    <a href="room?action=roomdetail&room_id=${room.room_id}" class="primary-btn" title="quick_view">More Details</a>
                                </div>
                            </div>                            
                        </div>                           
                    </c:forEach>    


                    <c:set var="page" value="${page}"/>
                    <div class="col-lg-12">
                        <div class="room-pagination" >
                            <ul>
                                <c:forEach begin="${1}" end="${num}" var="i">
                                    <li class="${i==page?"current":""}"><a href="room?page=${i}">${i}</a></li>
                                    </c:forEach>

                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                        document.getElementById('hotel-form').addEventListener('submit', function (event) {
                                            var checkin = document.getElementById('checkin-date').value;
                                            var checkout = document.getElementById('checkout-date').value;
                                            if (new Date(checkin) >= new Date(checkout)) {
                                                alert('Check-out date must be later than check-in date.');
                                                event.preventDefault();
                                            }
                                        });
        </script>
    </body>
</html>
