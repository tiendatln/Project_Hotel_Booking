
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAOs.serviceDAOs"%>
<%@page import="DAOs.roomDAOs"%>
<%@page import="DAOs.accountDAOs"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.reservationDAOs"%>
<%@page import="Model.reservation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>trang quản lý</title>

        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <style>
            td{
                font-size: large
            }
            .container {
                text-align: center;
            }

            h1 {
                color: green;
            }
            .custom-confirm-button {
                margin-right: 10px; /* Adjust as needed */
            }

            .custom-cancel-button {
                margin-left: 10px; /* Adjust as needed */
            }
        </style>
    </head>
    <body>
        <header>
            <%@include file="layout.jsp" %>
        </header>

        <div class="container-fluid mt-5">
            <h1 class="text-center mb-4">Reservation List</h1>
            <c:if test="${not empty reservation}">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Full Name</th>
                            <th scope="col">Room Name</th>
                            <th scope="col">Hotel Name</th>
                            <th scope="col">Phone Number</th>
                            <th scope="col">Check In Date</th>
                            <th scope="col">Check out Date</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Date</th>
                            <th scope="col">Price</th>
                            <th scope="col">Status</th>
                            <th scope="col" style="width: 40px"></th>
                        </tr>
                    </thead>
                    <%
                        int count = 1;
                    %>
                    <c:forEach items="${reservation}" var="reservation">

                        <tbody  >
                            <!-- Example reservation data -->
                            <tr>
                                <th scope="row"><%= count%></th>
                                <td>${reservation.account.name}</td>
                                <td>${reservation.room.room_name}</td>
                                <td>${reservation.service.hotel.hotel_name}</td>
                                <td>${reservation.account.phone}</td>
                                <td>${reservation.check_in_date}</td>
                                <td>${reservation.check_out_date}</td>
                                <td>${reservation.quantity}</td>
                                <td>${reservation.re_date}</td>
                                <td>${reservation.list_price}$</td>
                                <td>
                                    <c:if test="${reservation.status == 1}">
                                        <span style="color: #00CC00">Confirmed</span>
                                    </c:if>
                                    <c:if test="${reservation.status == 0}">
                                        <span style="color: #007bff">Pending</span>

                                    </c:if>
                                    <c:if test="${reservation.status == 2}">
                                        <span style="color: red">Denied</span>
                                    </c:if>
                                    <c:if test="${reservation.status == 3}">
                                        <span style="color: red">Customer Cancel</span>
                                    </c:if>
                                </td>
                                <c:if test="${reservation.status == 0}">
                                    <td><a class="btn btn-danger button" onclick="showCustomAlert('/reservationController/Cancel/${reservation.id}')" >Cancel</a></td>
                                </c:if>
                                <c:if test="${reservation.status == 1}">
                                    <td><a class="btn btn-danger button" href="/searchController/HotelDetail/${reservation.check_in_date}/${reservation.check_out_date}/${reservation.service.hotel.hotel_id}" >Send FeedBack</a></td>
                                </c:if>
                                <c:if test="${reservation.status > 1}">
                                    <td></td>
                                </c:if>
                            </tr>
                        </tbody>
                        <%
                            count++;
                        %>
                    </c:forEach>

                </table>
            </c:if>
            <c:if test="${empty reservation}">
                <div class="text-center" style="margin-top: 6cm">
                    <h2 style="font-optical-sizing: auto;  ">No Reservation Available</h2>
                    <h4 style="font-style: oblique; font-optical-sizing: auto;">( you have not made any reservation )</h4>
                </div>
            </c:if>
        </div>



        <script src=
                "https://cdn.jsdelivr.net/npm/sweetalert2@11">
        </script>


        <script>
            function showCustomAlert(url) {
                // Create a custom alert box with SweetAlert
                Swal.fire({
                    title: 'Cancel your reservation',
                    text: 'This action cannot be roll back!',
                    showCancelButton: true,
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                    customClass: {
                        confirmButton: ' btn btn-danger custom-confirm-button ',
                        cancelButton: 'btn btn-success custom-cancel-button'
                    },
                    buttonsStyling: false
                }).then((result) => {
                    if (result.isConfirmed) {
                        // Redirect to the specified URL after user clicks Yes
                        window.location.href = url;
                    }
                });
            }
        </script>

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
/*            <!-- HTML !-->
            <button class="button-14" role="button">
            <div class="button-14-top text">Button 14</div>
            <div class="button-14-bottom"></div>
            <div class="button-14-base"></div>
            </button>*/

            /* CSS */
            .button-14 {
                touch-action: manipulation;
                -webkit-appearance: none;
                appearance: none;
                position: relative;
                border-width: 0;
                padding: 0 8px 12px;
                min-width: 10em;
                box-sizing: border-box;
                background: transparent;
                font: inherit;
                cursor: pointer;
            }

            .button-14-top {
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                z-index: 0;
                padding: 8px 16px;
                transform: translateY(0);
                text-align: center;
                color: #fff;
                text-shadow: 0 -1px rgba(0, 0, 0, .25);
                transition-property: transform;
                transition-duration: .2s;
                -webkit-user-select: none;
                user-select: none;
            }

            .button-14:active .button-14-top {
                transform: translateY(6px);
            }

            .button-14-top::after {
                content: '';
                position: absolute;
                z-index: -1;
                border-radius: 4px;
                width: 100%;
                height: 100%;
                box-sizing: content-box;
                background-image: radial-gradient(#cd3f64, #9d3656);
                text-align: center;
                color: #fff;
                box-shadow: inset 0 0 0px 1px rgba(255, 255, 255, .2), 0 1px 2px 1px rgba(255, 255, 255, .2);
                transition-property: border-radius, padding, width, transform;
                transition-duration: .2s;
            }

            .button-14:active .button-14-top::after {
                border-radius: 6px;
                padding: 0 2px;
            }

            .button-14-bottom {
                position: absolute;
                z-index: -1;
                bottom: 4px;
                left: 4px;
                border-radius: 8px / 16px 16px 8px 8px;
                padding-top: 6px;
                width: calc(100% - 8px);
                height: calc(100% - 10px);
                box-sizing: content-box;
                background-color: #803;
                background-image: radial-gradient(4px 8px at 4px calc(100% - 8px), rgba(255, 255, 255, .25), transparent), radial-gradient(4px 8px at calc(100% - 4px) calc(100% - 8px), rgba(255, 255, 255, .25), transparent), radial-gradient(16px at -4px 0, white, transparent), radial-gradient(16px at calc(100% + 4px) 0, white, transparent);
                box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.5), inset 0 -1px 3px 3px rgba(0, 0, 0, .4);
                transition-property: border-radius, padding-top;
                transition-duration: .2s;
            }

            .button-14:active .button-14-bottom {
                border-radius: 10px 10px 8px 8px / 8px;
                padding-top: 0;
            }

            .button-14-base {
                position: absolute;
                z-index: -2;
                top: 4px;
                left: 0;
                border-radius: 12px;
                width: 100%;
                height: calc(100% - 4px);
                background-color: rgba(0, 0, 0, .15);
                box-shadow: 0 1px 1px 0 rgba(255, 255, 255, .75), inset 0 2px 2px rgba(0, 0, 0, .25);
            }

        </style>
    </body>
</html>