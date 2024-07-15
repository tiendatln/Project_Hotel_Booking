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
    </head>
    <style>
        body{
            margin-top:20px;
        }
        .mail-seccess {
            text-align: center;
            background: #fff;
            border-top: 1px solid #eee;
        }
        .mail-seccess .success-inner {
            display: inline-block;
        }
        .mail-seccess .success-inner h1 {
            font-size: 100px;
            text-shadow: 3px 5px 2px #3333;
            color: #006DFE;
            font-weight: 700;
        }
        .mail-seccess .success-inner h1 span {
            display: block;
            font-size: 25px;
            color: #333;
            font-weight: 600;
            text-shadow: none;
            margin-top: 20px;
        }
        .mail-seccess .success-inner p {
            padding: 20px 15px;
        }
        .mail-seccess .success-inner .btn{
            color:#fff;
        }
    </style>
    <body>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <section class="mail-seccess section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 offset-lg-3 col-12">
                        <!-- Error Inner -->
                        <div class="success-inner">
                            <h1><i class="fa fa-envelope"></i><span>Your Booking Successfully!</span></h1>
                            <p>Please pay attention to your phone, the hotel will call to confirm</p>
                            <h4>thank you</h4>
                            <a href="#" class="btn btn-primary btn-lg">Go Home</a>
                            <a href="/reservationController/YourReservation" class="btn btn-primary btn-lg">Contin</a>
                        </div>
                        <!--/ End Error Inner -->
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
