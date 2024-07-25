<%-- 
    Document   : review
    Created on : Jul 20, 2024, 1:16:54 PM
    Author     : tiend
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>review</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCic3r4-oNwtB5j-5IVDuPe8k3vyaijOZQ&callback=initMap" async defer></script>
    <style>
        #map {
            height: 500px;
            width: 100%;
        }
    </style>

    <body>
        <%@include file="layout.jsp" %>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <div class="container bootstrap snippets bootdey" style="margin-top: 30px">
            <div class="text-center">
                <h1>All Your FeedBack</h1>
            </div>
            <div class="row" style="margin-top: 20px;">
                <c:if test="${not empty fb}">
                    <c:forEach items="${fb}" var="fb">
                        <div class="" style="width: 100%; border-radius: 50px ; margin: 8px; box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset; ">
                            <div class="row" style=" flex-direction: row; " >
                                <div class="col-9 d-flex justify-content-evenly">
                                    <div style="width: 50px; " >
                                        <svg  style="width: 30px; margin-left: 10px; margin-top: 25px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M123.6 391.3c12.9-9.4 29.6-11.8 44.6-6.4c26.5 9.6 56.2 15.1 87.8 15.1c124.7 0 208-80.5 208-160s-83.3-160-208-160S48 160.5 48 240c0 32 12.4 62.8 35.7 89.2c8.6 9.7 12.8 22.5 11.8 35.5c-1.4 18.1-5.7 34.7-11.3 49.4c17-7.9 31.1-16.7 39.4-22.7zM21.2 431.9c1.8-2.7 3.5-5.4 5.1-8.1c10-16.6 19.5-38.4 21.4-62.9C17.7 326.8 0 285.1 0 240C0 125.1 114.6 32 256 32s256 93.1 256 208s-114.6 208-256 208c-37.1 0-72.3-6.4-104.1-17.9c-11.9 8.7-31.3 20.6-54.3 30.6c-15.1 6.6-32.3 12.6-50.1 16.1c-.8 .2-1.6 .3-2.4 .5c-4.4 .8-8.7 1.5-13.2 1.9c-.2 0-.5 .1-.7 .1c-5.1 .5-10.2 .8-15.3 .8c-6.5 0-12.3-3.9-14.8-9.9c-2.5-6-1.1-12.8 3.4-17.4c4.1-4.2 7.8-8.7 11.3-13.5c1.7-2.3 3.3-4.6 4.8-6.9l.3-.5z"/></svg>
                                    </div>
                                    <div >
                                        <h4>
                                            <a hre="#" class="username">${fb.account.name}</a>
                                            <label class="label label-info"></label>
                                        </h4>
                                            <h6>${fb.hotel.hotel_name}</h6>
                                        <p  class="description ">${fb.comment}</p>
                                    </div>

                                </div>
                                <div class="col-3  d-flex justify-content-center" style="align-items: center">
                                    <a id="btn" class="btn btn-info  btn-round pull-right makeLoading" href="/searchController/HotelDetail/${checkinDate}/${checkoutDate}/${fb.hotel.hotel_id}">
                                        <i  class="fa fa-share"></i> 
                                        View Hotel
                                    </a>
                                    <a id="btn" class="btn btn-info  btn-round pull-right makeLoading" onclick="showCustomAlert('/feedbackController/deleteFeedbackByAll/${fb.hotel.hotel_id}/${fb.id}')">
                                        <i class="fa fa-trash" ></i>
                                    </a>
                                </div>
                            </div>


                        </div>
                    </c:forEach>
                </c:if>

            </div>
            <c:if test="${empty fb}">
                <div class="text-center" style="margin-top: 6cm">
                    <h1>
                        You Do Not have Any FeedBack
                    </h1>
                </div>
            </c:if>
        </div>
    </body>

    <script>
        function showCustomAlert(url) {
            // Create a custom alert box with SweetAlert
            Swal.fire({
                title: 'Delete your FeedBack',
                text: 'Do you want to delete your feedback?',
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
    <script src=
            "https://cdn.jsdelivr.net/npm/sweetalert2@11">
    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body{
            margin-top:20px;
        }
        .custom-confirm-button {
            margin-right: 10px; /* Adjust as needed */
        }

        .custom-cancel-button {
            margin-left: 10px; /* Adjust as needed */
        }
        .post-list {
            position: relative;
            padding: 5px 0;
        }

        .post-list .picture {
            max-width: 400px;
            overflow: hidden;
            height: auto;
            border-radius: 6px;
        }

        .post-list .label{
            font-weight:normal;
        }

        .post-list .picture {
            max-width: 210px;
        }

        .post-list .picture img {
            width: 100%;
        }

        .post-list h4 {
            font-size: 20px;
        }

        .post-list h5 {
            color: #888;
        }

        .post-list p {
            float: left;
        }

        .post-list:after {
            height: 1px;
            background: #EEEEEE;
            width: 83.3333%;
            bottom: 0;
            right: 0;
            content: "";
            display: block;
            position: absolute;
        }

        .post-list .btn-download {
            margin-top: 45px;
        }

        .btn-info {
            color: #1084FF;
            border-color: #269abc;
        }

        .btn-round {
            border-width: 1px;
            border-radius: 30px !important;
            opacity: 0.79;
            padding: 9px 18px;
        }
        #btn {
            border-width: 2px;
            background-color: rgba(0,0,0,0);
            font-weight: 400;
            opacity: 0.8;
            padding: 7px 16px;
        }
    </style>
</html>
