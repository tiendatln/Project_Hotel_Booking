<%-- 
    Document   : recover
    Created on : Jul 15, 2024, 5:49:00 PM
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

    <body>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <div class="container" style="margin-top: 200px">
            <div class="row justify-content-center mt-5">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Reset Password</h2>
                            <form action="/forgetPasswordOTP" method="post" onsubmit="return checkPassword()">
                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" placeholder="Enter password" name="txtNewPassword" minlength="5">
                                    <span id="ErrorNewPassword" class="text-danger"></span>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" placeholder="Enter password" name="txtConfirmPassword" minlength="5">
                                    <span id="ErrorConfirmPassword" class="text-danger"></span>
                                </div>
                                <div>
                                    <span id="ErrorPassword" class="text-danger"></span>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block" name="btnResetPassword">Reset Password</button>
                                </div>
                                <div class="text-center mt-3 mb-3">
                                    <a href="/homeController/HomeCustomer">Home</a> 
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function checkPassword() {
                var newPassword = document.getElementById('newPassword').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                var valid = true;

                document.getElementById('ErrorNewPassword').innerHTML = "";
                document.getElementById('ErrorConfirmPassword').innerHTML = "";
                document.getElementById('ErrorPassword').innerHTML = "";

                if (newPassword === "") {
                    document.getElementById('ErrorNewPassword').innerHTML = "Please Enter New Password.";
                    valid = false;
                }
                if (confirmPassword === "") {
                    document.getElementById('ErrorConfirmPassword').innerHTML = "Please Enter Confirm Password.";
                    valid = false;
                }
                if (newPassword !== confirmPassword) {
                    document.getElementById('ErrorPassword').innerHTML = "New Password and Confirm Password do not match!";
                    valid = false;
                }
                return valid;
            }
        </script>
    </body>
</html>
