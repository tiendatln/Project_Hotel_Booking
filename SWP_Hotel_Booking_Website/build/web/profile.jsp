<%-- 
    Document   : profile
    Created on : Jun 20, 2024, 10:09:10 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                background-color: #f8f9fa;
            }
            .profile-card {
                margin-top: 50px;
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                overflow: hidden;
            }
            .profile-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            .profile-card .card-body {
                padding: 30px;
            }
            .profile-info {
                font-size: 1.1rem;
                margin-bottom: 15px;
            }
            .profile-info strong {
                color: #495057;
            }
            .profile-header {
                font-size: 1.5rem;
                font-weight: bold;
                color: #343a40;
                text-align: center;
                margin-bottom: 30px;
            }
            .nav-link {
                color: #ffffff !important;
            }
            .btn-custom {
                background-color: cadetblue;
                color: #fff;
            }
            .btn-custom:hover {
                background-color: #5f9ea0;
            }
            .sidebar {
                padding-top: 50px;
            }
            .sidebar .btn {
                margin-bottom: 10px;
                width: 100%;
                text-align: left;
            }
        </style>
    </head>
    <body>
        <%@include file="layout/menu.jsp" %>
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-3 sidebar">
                    <button class="btn btn-secondary" onclick="location.href = 'profile?action=updateprofile'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm80 256h64c44.2 0 80 35.8 80 80c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16c0-44.2 35.8-80 80-80zm-32-96a64 64 0 1 1 128 0 64 64 0 1 1 -128 0zm256-32H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/></svg>
                        Profile
                    </button>
                    <button class="btn btn-custom" onclick="location.href = 'profile?action=changepassword'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M336 352c97.2 0 176-78.8 176-176S433.2 0 336 0S160 78.8 160 176c0 18.7 2.9 36.8 8.3 53.7L7 391c-4.5 4.5-7 10.6-7 17v80c0 13.3 10.7 24 24 24h80c13.3 0 24-10.7 24-24V448h40c13.3 0 24-10.7 24-24V384h40c6.4 0 12.5-2.5 17-7l33.3-33.3c16.9 5.4 35 8.3 53.7 8.3zM376 96a40 40 0 1 1 0 80 40 40 0 1 1 0-80z"/></svg>
                        Change Password
                    </button>
                </div>
                <div class="col-md-9">
                    <div class="card profile-card">
                        <img src="img/slide3.jpg" class="card-img-top" alt="Profile Cover">
                        <div class="card-body">
                            <div class="profile-header">User Profile</div>
                            <form action="profile?action=update" method="post" onsubmit="return confirmUpdate()">
                                <div class="row">
                                    <div class="col-md-6 profile-info">
                                        <label for="name"><strong>Name:</strong></label>
                                        <input type="text" class="form-control" id="name" name="name" value="<%= ac.getName()%>">
                                    </div>
                                    <div class="col-md-6 profile-info">
                                        <label for="email"><strong>Email:</strong></label>
                                        <input type="email" class="form-control" id="email" name="email" value="<%= ac.getEmail()%>">
                                    </div>
                                    <div class="col-md-6 profile-info">
                                        <label for="age"><strong>Age:</strong></label>
                                        <input type="number" class="form-control" id="age" name="age" value="<%= ac.getAge()%>">
                                    </div>
                                    <div class="col-md-6 profile-info">
                                        <label for="phone"><strong>Phone:</strong></label>
                                        <input type="text" class="form-control" id="phone" name="phone" value="<%= ac.getPhone()%>">
                                    </div>
                                    <div class="col-md-6 profile-info">
                                        <label for="id_number"><strong>ID Number:</strong></label>
                                        <input type="text" class="form-control" id="id_number" name="id_number" value="<%= ac.getId_number()%>">
                                    </div>
                                    <div class="col-md-6 profile-info ">
                                        <label for="report_count"><strong>Report Count:</strong></label>
                                        <input type="number" class="form-control" id="report_count" name="report_count" value="<%= ac.getReport_count()%>" readonly>
                                    </div>
                                </div>
                                     <%
                                    String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                                    String successMessage = (String) request.getSession().getAttribute("successMessage");
                                    if (errorMessage != null) {
                                %>
                                <div class="text-center">
                                    <p class="text-danger"><%= errorMessage%></p>
                                </div>

                                <%
                                    request.getSession().removeAttribute("errorMessage");
                                } else if (successMessage != null) {%>
                                <div class="text-center">
                                    <p class="text-success"><%= successMessage%></p>
                                </div>
                                <% }
                                    request.getSession().removeAttribute("successMessage");
                                %>
                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-custom" name="btnUpdateProfile">Update Profile</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function confirmUpdate() {
                return confirm("Bạn có chắc chắn muốn thay đổi thông tin không?");
            }
        </script>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
