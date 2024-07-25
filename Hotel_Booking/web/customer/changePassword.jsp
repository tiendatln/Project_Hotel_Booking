<%-- 
    Document   : changePassword
    Created on : Jun 21, 2024, 12:26:15 AM
    Author     : tiend
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
        <!-- Bootstrap CSS -->
        <link rel="icon" href="<%= request.getContextPath()%>/imgs/icon.jpg">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .change-password-page {
                background-color: #f8f9fa;
            }
            .change-password-page .profile-card {
                margin-top: 50px;
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            .change-password-page .profile-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            .change-password-page .profile-card .card-body {
                padding: 30px;
            }
            .change-password-page .profile-info {
                font-size: 1.1rem;
                margin-bottom: 15px;
            }
            .change-password-page .profile-info strong {
                color: #495057;
            }
            .change-password-page .title {
                font-size: 1.5rem;
                font-weight: bold;
                color: #343a40;
                text-align: center;
                margin-bottom: 30px;
            }
            /*.change-password-page .nav-link {
                color: #ffffff !important;
            }*/
            .change-password-page .btn-custom {
                background-color: cadetblue;
                color: #fff;
            }
            .change-password-page .btn-custom:hover {
                background-color: #5f9ea0;
                box-shadow: rgba(50, 50, 93, 0.25) 0px 30px 60px -12px inset, rgba(0, 0, 0, 0.3) 0px 18px 36px -18px inset;
            }
            .change-password-page .sidebar {
                padding-top: 50px;
            }
            .change-password-page .sidebar .btn {
                margin-bottom: 10px;
                width: 100%;
                text-align: left;
            }

        </style>
    </head>
    <body class="change-password-page">
        <%@include file="layout.jsp" %>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-3 sidebar">
                    <button class="btn btn-custom" onclick="location.href = '/profileController/ProfileUser'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm80 256h64c44.2 0 80 35.8 80 80c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16c0-44.2 35.8-80 80-80zm-32-96a64 64 0 1 1 128 0 64 64 0 1 1 -128 0zm256-32H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/></svg>
                        Profile
                    </button>
                    <button class="btn btn-secondary" onclick="location.href = '/profileController/ChangePassword'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M336 352c97.2 0 176-78.8 176-176S433.2 0 336 0S160 78.8 160 176c0 18.7 2.9 36.8 8.3 53.7L7 391c-4.5 4.5-7 10.6-7 17v80c0 13.3 10.7 24 24 24h80c13.3 0 24-10.7 24-24V448h40c13.3 0 24-10.7 24-24V384h40c6.4 0 12.5-2.5 17-7l33.3-33.3c16.9 5.4 35 8.3 53.7 8.3zM376 96a40 40 0 1 1 0 80 40 40 0 1 1 0-80z"/></svg>
                        Change Password
                    </button>
                    <button class="btn btn-custom" onclick="location.href = '/profileController/BecomeOwner'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M192 0c-41.8 0-77.4 26.7-90.5 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H320c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H282.5C269.4 26.7 233.8 0 192 0zm0 64a32 32 0 1 1 0 64 32 32 0 1 1 0-64zM112 192H272c8.8 0 16 7.2 16 16s-7.2 16-16 16H112c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/></svg>
                        Become Owner
                    </button>
                </div>
                <div class="container col-md-9">
                    <div class="card profile-card">
                        <div class="card-header text-center profile-header title" style="font-size: 1.5rem;
                             font-weight: bold;
                             color: #343a40;">
                            Change Password
                        </div>
                        <div class="card-body">
                            <form action="/profileController/ChangePassword" method="post" id="changePasswordForm" >
                                <div class="form-group">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword" name="oldPass" minlength="5" required>
                                </div>
                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPass" required>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" required>
                                </div>
                                <div>
                                    <ul style="margin: 20px;">
                                        <li hidden="true" style=" color: red;" id="Error"></li>
                                        <c:if test="${not empty errorMessage}">
                                        <li id="Error1" style=" color: red;">${errorMessage}</li>
                                        </c:if>
                                        
                                    </ul>
                                    
                                <button style="margin-top: 10px" type="submit" class="btn btn-primary btn-block" name="btnChangePass">Change Password</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('changePasswordForm').addEventListener('submit', function (event) {
                let isValid = true;
                var newPass = document.getElementById('newPassword').value;
                var confirmPass = document.getElementById('confirmPassword').value;
                if (newPass !== confirmPass) {
                    isValid = false;
                    document.getElementById('Error').innerHTML = "New Password and Confirm Password do not match!";
                    document.getElementById('Error').hidden = false;
                    document.getElementById('Error1').hidden = true;
                }
                
                
                if (!isValid) {
                    event.preventDefault();
                }
            });
        </script>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Custom JS -->

    </body>
</html>
