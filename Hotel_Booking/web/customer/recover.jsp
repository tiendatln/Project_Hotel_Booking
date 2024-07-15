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
                            <form action="/forgetPasswordOTP" method="post" >
                                <div class="form-group">
                                    <label for="username">New Password</label>
                                    <input type="text" class="form-control" id="username" placeholder="Enter username"  name="txtNewPassword" >
                                </div>
                                <div class="form-group">
                                    <label for="password">Confirm Password</label>
                                    <input type="password" class="form-control" id="password" placeholder="Enter password"  name="txtConfirmPassword" >
                                </div>

                                <div>
                                    <span id="Error"></span>
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
    </body>
</html>
