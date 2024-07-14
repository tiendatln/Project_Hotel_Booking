<%-- 
    Document   : reserve
    Created on : Jun 28, 2024, 4:53:03 PM
    Author     : tiend
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Timeline Example</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="stylesheet">
        <link rel="stylesheet" href="css/reserve.css">
    </head>
    <body>
        <%@include file="layout.jsp" %>
        <div class="container px-3 my-5 clearfix">
            <!-- Shopping cart table -->
            <div class="card">
                <div class="card-header">
                    <h3>${hotel.getHotel_name()}</h3>
                </div>
                <div class="card-body">
                    <form method="get" action="/bookingController" id="reservationForm" >
                        <div class="table-responsive">

                            <table class="table table-bordered m-0">
                                <thead>
                                    <tr>
                                        <!-- Set columns width -->
                                        <th class="text-center py-3 px-4" style="min-width: 200px;">Product Name &amp; Details</th>
                                        <th class="text-center py-3 px-4" style="width: 150px;">Room Price</th>
                                        <th class="text-center py-3 px-4" style="width: 120px;">Quantity</th>
                                        <th class="text-center py-3 px-4" style="width: 120px;">Service</th>
                                        <th class="text-center py-3 px-4" style="width: 120px;">Service Price</th>
                                        <th class="text-center py-3 px-4" style="width: 120px;">Total</th>
                                        <th class="text-center align-middle py-3 px-0" style="width: 40px;"><a href="#" class="shop-tooltip float-none text-light" title="" data-original-title="Clear cart"><i class="ino ion-md-trash"></i></a></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${roomID}" var="roomID">
                                        <tr>
                                            <td class="p-4">
                                                <div class="media align-items-center">
                                                    <div class="media-body">
                                                        <p href="#" class="d-block text-dark" >${roomID.room.room_name}</p>
                                                        <input hidden="" name="roomID" value="${roomID.room.room_id}" >
                                                        <small>
                                                            <span class="text-muted">Description:</span> &nbsp;
                                                            <span class="text-muted">${roomID.room.room_description}</span> 
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center font-weight-semibold align-middle p-4">$${(roomID.room.room_price * roomID.quantity) * day}</td>
                                            <td class="align-middle p-4">
                                                <select class="form-control" id="guests" name="quantity" onchange="submitForm('change')">
                                                    <option value="1"${roomID.quantity eq 1 ? 'selected' : ''}>1</option>
                                                    <option value="2"${roomID.quantity eq 2 ? 'selected' : ''}>2</option>
                                                    <option value="3"${roomID.quantity eq 3 ? 'selected' : ''}>3</option>
                                                    <option value="4"${roomID.quantity eq 4 ? 'selected' : ''}>4</option>
                                                    <option value="5"${roomID.quantity eq 5 ? 'selected' : ''}>5</option>
                                                    <option value="6"${roomID.quantity eq 6 ? 'selected' : ''}>6</option>
                                                    <option value="7"${roomID.quantity eq 7 ? 'selected' : ''}>7</option>
                                                    <option value="8"${roomID.quantity eq 8 ? 'selected' : ''}>8</option>
                                                    <option value="9"${roomID.quantity eq 9 ? 'selected' : ''}>9</option>
                                                    <option value="10"${roomID.quantity eq 10 ? 'selected' : ''}>10</option>
                                                </select>
                                            </td>

                                            <td class="text-left font-weight-semibold align-middle p-4"><c:forEach items="${service}" var="service">${service.service_name}</c:forEach></td>
                                            
                                                <td class="text-center font-weight-semibold align-middle p-4">$${servicePrice * roomID.quantity}</td>
                                            <td class="text-center font-weight-semibold align-middle p-4">$${((roomID.room.room_price * roomID.quantity) * day) + (servicePrice * roomID.quantity)}</td>
                                            <td class="text-center align-middle px-0"><button onclick="submitForm('remove/' +${roomID.room.room_id})" class="shop-tooltip close float-none text-danger"  >×</button></td>
                                        </tr>
                                    </c:forEach>
                                <input hidden="" name="HotelID" value="${hotel.getHotel_id()}" >
                                </tbody>
                            </table>

                        </div>
                        <!-- / Shopping cart table -->

                        <div class="d-flex flex-wrap justify-content-between align-items-center pb-4">
                            <div class="mt-4">
                                <h4 class="text-dark font-weight-bold">Name: ${nameUser.getName()}</h4>
                                <span class="text-muted font-weight-bold" >Email: ${nameUser.getEmail()}</span>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-6 check-details">
                                            <div>
                                                <div>Check-in</div>
                                                <div class="font-weight-bold">${checkIndate}</div>
                                                <input hidden="" name="checkInDate" value="${checkIndate}">
                                            </div>
                                        </div>
                                        <div class="col-6 check-details">
                                            <div>
                                                <div>Check-out</div>
                                                <div class="font-weight-bold">${checkOutDate}</div>
                                                <input hidden="" name="checkOutDate" value="${checkOutDate}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex">
                                <div class="text-right mt-4 mr-5">
                                    <label class="text-muted font-weight-normal m-0">Service Price Total</label>
                                    <div class="text-large"><strong>$${totalServicePrice}</strong></div>
                                </div>
                                <div class="text-right mt-4">
                                    <label class="text-muted font-weight-normal m-0">Total price</label>
                                    <div class="text-large"><strong>$${TotalPrice}</strong></div>
                                </div>
                            </div>
                        </div>

                        <div class="float-right">
                            <a href="/searchController/HotelDetail/${hotel.getHotel_id()}" class="btn btn-lg btn-default md-btn-flat mt-2 mr-3">Back to shopping</a>
                            <button  onclick="submitForm('submit')" class="btn btn-lg btn-primary mt-2">Booking</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                            function submitForm(actionType) {
                                
                                    setFormAction(actionType);
                                    document.getElementById('reservationForm').submit();
                                
                            }
                            function setFormAction(actionType) {

                                var form = document.getElementById('reservationForm');
                                if (actionType === 'change') {
                                    form.action = '/bookingController/Change';
                                } else if (actionType ==='submit') {
                                    form.action = '/bookingController/Booking';
                                } else {
                                    var url = '/bookingController/' + actionType;
                                    form.action = url;
                                }
                            }
        </script>
    </body>
</html>

