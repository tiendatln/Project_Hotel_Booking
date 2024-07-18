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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reserve.css">
        <link rel="stylesheet" href="stylesheet">
        <style>
            .stepper-wrapper {
                margin-top: auto;
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            .stepper-item {
                position: relative;
                display: flex;
                flex-direction: column;
                align-items: center;
                flex: 1;
               
            }

            .stepper-item::before {
                position: absolute;
                content: "";
                border-bottom: 2px solid #ccc;
                width: 100%;
                top: 20px;
                left: -50%;
                z-index: 2;
            }

            .stepper-item::after {
                position: absolute;
                content: "";
                border-bottom: 2px solid #ccc;
                width: 100%;
                top: 20px;
                left: 50%;
                z-index: 2;
            }

            .stepper-item .step-counter {
                position: relative;
                z-index: 5;
                display: flex;
                justify-content: center;
                align-items: center;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: 	#AAAAAA;
                margin-bottom: 6px;
            }


            .stepper-item {
                font-weight: bold;
            }


            .stepper-item.completed .step-counter {
                background-color: #3366CC;
                color: white;
            }

            .stepper-item.completed::after {
                position: absolute;
                content: "";
                border-bottom: 2px solid #3366CC;
                width: 100%;
                top: 20px;
                left: 50%;
                z-index: 3;
            }

            .stepper-item:first-child::before {
                content: none;
            }
            .stepper-item:last-child::after {
                content: none;
            }
        </style>
    </head>
    <body>
        <%@include file="layout.jsp" %>

        <div class="pt-4 " >
            <div class="stepper-wrapper">
                <div class="stepper-item completed">
                    <div class="step-counter">1</div>
                    <div class="step-name">Choose Room</div>
                </div>
                <div class="stepper-item completed">
                    <div class="step-counter">2</div>
                    <div class="step-name">Reserve</div>
                </div>
                <div class="stepper-item active">
                    <div class="step-counter">3</div>
                    <div class="step-name">Completed</div>
                </div>
            </div>
        </div>



        <div class="container-fluid px-3 my-5 clearfix" style="width: 70%">
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
                                        <th class="text-center py-3 px-4" style="width: 120px;">Room Price</th>
                                        <th class="text-center py-3 px-4" style="width: 150px;">Room Price Total</th>
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
                                                        <p href="#" class="d-block text-primary" >${roomID.room.room_name}</p>
                                                        <input hidden="" name="roomID" value="${roomID.room.room_id}" >
                                                        <small>
                                                            <span class="text-muted">Description:</span> &nbsp;
                                                            <span class="text-muted">${roomID.room.room_description}</span> 
                                                        </small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center font-weight-semibold align-middle p-4">${roomID.room.room_price}$</td>
                                            <td class="text-center font-weight-semibold align-middle p-4">${(roomID.room.room_price * roomID.quantity) * day}$</td>
                                            <td class="align-middle p-4">
                                                <select class="form-control" id="guests" name="quantity" onchange="submitForm('change')">
                                                    <c:forEach begin="1" end="${roomID.room.room_capacity}" var="i" step="1">
                                                    <option value="1"${roomID.quantity eq  i ? 'selected' : ''}>${i}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>

                                            <td class="text-left font-weight-semibold align-middle p-4"><c:forEach items="${service}" var="service">${service.service_name}</c:forEach></td>

                                                <td class="text-center font-weight-semibold align-middle p-4">${servicePrice * roomID.quantity}$</td>
                                            <td class="text-center font-weight-semibold align-middle p-4">${((roomID.room.room_price * roomID.quantity) * day) + (servicePrice * roomID.quantity)}$</td>
                                            <td class="text-center align-middle px-0"><button onclick="submitForm('remove/' +${roomID.room.room_id})" class="shop-tooltip close float-none text-danger"  >×</button></td>
                                        </tr>
                                    </c:forEach>
                                <input hidden="" name="HotelID" value="${hotel.getHotel_id()}" >
                                </tbody>
                            </table>

                        </div>
                        <!-- / Shopping cart table -->

                        <div class="d-flex flex-wrap justify-content-between align-items-center pb-4">
                            <div class="mt-5" style="margin-left: 70px">
                                <h4 class=" font-weight-bold" style="color: #0c63e4">Name: ${nameUser.getName()}</h4>
                                <span class="text-muted font-weight-bold" >Email: ${nameUser.getEmail()}</span>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-6 ">
                                            <div>
                                                <div class="check-details">Check-in</div>
                                                <div style="color: #86b7fe" class="font-weight-bold">${checkIndate}</div>
                                                <input  hidden="" name="checkInDate" value="${checkIndate}">
                                            </div>
                                        </div>
                                        <div class="col-6 ">
                                            <div>
                                                <div class="check-details">Check-out</div>
                                                <div style="color: #86b7fe" class="font-weight-bold">${checkOutDate}</div>
                                                <input hidden="" name="checkOutDate" value="${checkOutDate}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex">
                                <div class="text-right mt-4 mr-5">
                                    <label class="text-muted font-weight-normal m-0">Service Price Total</label>
                                    <div class="text-large"><strong>${totalServicePrice}$</strong></div>
                                </div>
                                <div class="text-right mt-4">
                                    <label class="text-muted font-weight-normal m-0">Total price</label>
                                    <div class="text-large"><strong>${TotalPrice}$</strong></div>
                                </div>
                            </div>
                        </div>

                        <div class="float-right">
                            <a href="/searchController/HotelDetail/${checkIndate}/${checkOutDate}/${hotel.getHotel_id()}" class="btn btn-lg btn-default md-btn-flat mt-2 mr-3">Back to shopping</a>
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
                                    } else if (actionType === 'submit') {
                                        form.action = '/bookingController/Booking';
                                    } else {
                                        var url = '/bookingController/' + actionType;
                                        form.action = url;
                                    }
                                }
        </script>
    </body>
</html>

