<%-- 
    Document   : enterOTP
    Created on : Jun 23, 2024, 5:21:36 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OTP Verification Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f8f9fa;
            }
            .otp-container {
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .otp-input {
                width: 40px;
                height: 40px;
                text-align: center;
                font-size: 1.2rem;
                margin: 0 5px;
            }
        </style>
    </head>
    <body>
        <div class="otp-container text-center">
            <h3 class="mb-4">OTP Verification</h3>
            <form id="otp-form" method="post" action="register">
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i
                                class="glyphicon glyphicon-envelope color-blue"></i></span> <input
                            id="opt" name="otp" placeholder="Enter OTP"
                            class="form-control" type="text" required="required">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" name="btnRegisterOTP" >Verify OTP</button>
            </form>
        </div>

        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- Custom JS -->

    </body>
</html>
