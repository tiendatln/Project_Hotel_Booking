<%-- 
    Document   : bookingSuccess
    Created on : Jul 15, 2024, 7:39:41 AM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookingSuccess.css">
    </head>
    <body>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="styles.css">
        <%@include file="layout.jsp" %>
        <section class="mail-seccess section">
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
                    <div class="stepper-item completed">
                        <div class="step-counter">3</div>
                        <div class="step-name">Completed</div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 offset-lg-3 col-12">
                        <!-- Error Inner -->
                        <div class="success-inner">
                            <h1>
                                <svg class="success" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path fill="#00b37d" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>                                
                                <span>Your Booking Successfully!</span>
                            </h1>
                            <p>Please pay attention to your phone, the hotel will call to confirm</p>
                            <h4>Thank You</h4>

                        </div>
                        <div style="flex-direction: column">
                            <div class="mb-2">
                                <a href="/homeController/HomeCustomer" class="btn btn-primary btn-lg">Go Home</a>
                            </div>
                            <div>
                                <a href="/reservationController/YourReservation" class="btn btn-primary btn-lg">View Reservation</a> 
                            </div>
                        </div>


                        <!--/ End Error Inner -->
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
