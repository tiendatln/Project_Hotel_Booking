<%-- 
    Document   : recover
    Created on : Jul 4, 2024, 3:01:42 PM
    Author     : tiend
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body{
                margin-top:20px;
                background-color: #f2f3f8;
            }
            .card {
                margin-bottom: 1.5rem;
                box-shadow: 0 1px 15px 1px rgba(52,40,104,.08);
            }
            .card {
                position: relative;
                display: -ms-flexbox;
                display: flex;
                -ms-flex-direction: column;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 1px solid #e5e9f2;
                border-radius: .2rem;
            }
        </style>
    </head>
    <body>
        <div class="container h-100">
            <div class="row" style="margin-top: 5cm">
                <div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
                    <div class="d-table-cell align-middle">

                        <div class="text-center mt-4">
                            <h1 class="h2">Reset password</h1>
                            <p class="lead">
                                Enter your email to reset your password.
                            </p>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <div class="m-sm-4">
                                    <form method="post" action="/forgetPasswordOTP">
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input class="form-control form-control-lg" type="email" id="txtEmail" name="txtEmail" placeholder="Enter your email">
                                            <span id="error"></span>
                                        </div>
                                        <div class="text-center mt-3">
                                            <button type="submit" name="btnSendOTP" class="btn btn-lg btn-primary">Send OTP</button>
                                            
                                            <!-- <button type="submit" class="btn btn-lg btn-primary">Reset password</button> -->
                                        </div>
                                        <div class="text-center m-2">
                                            <a href="/loginController/login">Back To Login</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <c:if test="${ErrorEmail}">
            <script>
                alert("Email is Wrong!"); 
            </script>
        </c:if>
            <script>
                function submitForm(){
                    var email = document.getElementById("txtEmail").value;
                    if(email === ""){
                        document.getElementById("error").innerHTML "Please enter your Email!";
                    }
                }
            </script>
    </body>
</html>
