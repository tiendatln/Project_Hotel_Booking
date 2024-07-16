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
.card-stepper {
    z-index: 0;
}

#progressbar-2 {
    color: #455A64;
}

#progressbar-2 li {
    list-style-type: none;
    font-size: 13px;
    width: 33.33%;
    float: left;
    position: relative;
}

#progressbar-2 #step1:before {
    content: '\f058';
    font-family: "Font Awesome 5 Free";
    color: #fff;
    width: 37px;
    margin-left: 0px;
    padding-left: 0px;
}

#progressbar-2 #step2:before {
    content: '\f058';
    font-family: "Font Awesome 5 Free";
    color: #fff;
    width: 37px;
}

#progressbar-2 #step3:before { /* CSS cho bước 3 */
    content: '\f058';
    font-family: "Font Awesome 5 Free";
    color: #fff;
    width: 37px;
}

#progressbar-2 li:before {
    line-height: 37px;
    display: block;
    font-size: 12px;
    background: #c5cae9;
    border-radius: 50%;
}

#progressbar-2 li:after {
    content: '';
    width: 100%;
    height: 10px;
    background: #c5cae9;
    position: absolute;
    left: 0%;
    right: 0%;
    top: 15px;
    z-index: -1;
}

#progressbar-2 li:nth-child(1):after {
    left: 1%;
    width: 100%;
}

#progressbar-2 li:nth-child(2):after {
    left: 1%;
    width: 100%;
}


#progressbar-2 li.active:before,
#progressbar-2 li.active:after {
    background: #6520ff;
}

        </style>
    </head>
    <body>
        <%@include file="layout.jsp" %>

        <div class="container ">
    <div class="row d-flex justify-content-center align-items-center h-100 container py-5 ">
        <div class="col-12">
            <div class="card card-stepper" style="border-radius: 16px;">
                <div class="card-body p-5">
                    <ul id="progressbar-2" class="d-flex justify-content-between mx-0 mt-0 mb-5 px-0 pt-0 pb-2">
                        <li class="step0 active text-center" id="step1"></li>
                        <li class="step0 active text-center" id="step2"></li>
                        <li class="step0 text-center" id="step3"></li> <!-- Thêm bước 3 -->
                    </ul>

                    <div class="d-flex justify-content-between">
                        <div class="d-lg-flex align-items-center">
                            <i class="fas fa-clipboard-list fa-3x me-lg-4 mb-3 mb-lg-0"></i>
                            <div>
                                <p class="fw-bold mb-1">Order</p>
                                <p class="fw-bold mb-0">Processed</p>
                            </div>
                        </div>
                        <div class="d-lg-flex align-items-center">
                            <i class="fas fa-box-open fa-3x me-lg-4 mb-3 mb-lg-0"></i>
                            <div>
                                <p class="fw-bold mb-1">Order</p>
                                <p class="fw-bold mb-0">Shipped</p>
                            </div>
                        </div>
                        <div class="d-lg-flex align-items-center">
                            <i class="fas fa-box-open fa-3x me-lg-4 mb-3 mb-lg-0"></i>
                            <div>
                                <p class="fw-bold mb-1">Order</p>
                                <p class="fw-bold mb-0">Shipped</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


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
                                        <th class="text-center py-3 px-4" style="width: 120px;">Room Price</th>
                                        <th class="text-center py-3 px-4" style="width: 120px;">Room Price</th>
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
                            <div class="mt-4">
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

