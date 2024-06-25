<%-- 
    Document   : register
    Created on : Jun 20, 2024, 8:39:38 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .card {
                border: none;
                border-radius: 1rem;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .card-body {
                padding: 2rem;
            }
            .form-group label {
                font-weight: bold;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }
            .fa-eye, .fa-eye-slash {
                position: absolute;
                bottom: 4px;
                right: 10px;
                transform: translateY(-50%);
                cursor: pointer;
            }
            h2 {
                margin-bottom: 1rem;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                font-weight: 700;
            }
            .container {
                margin-top: 5%;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="text-center">Register User</h2>
                    <div class="card">
                        <div class="card-body">
                            <form action="register" method="post">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="txtUs" placeholder="Enter username" required>
                                </div>
                                <div class="form-group position-relative">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="txtPwd" placeholder="Enter password" required>
                                    <i class="fa fa-eye-slash" id="togglePassword"></i>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" name="txtEmail" placeholder="Enter email" required>
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" id="name" name="txtName" placeholder="Enter your name" required>
                                </div>
                                <div class="form-group">
                                    <label for="age">Age</label>
                                    <input type="number" class="form-control" id="age" name="txtAge" placeholder="Enter your age" required>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone</label>
                                    <input type="text" class="form-control" id="phone" name="txtPhone" placeholder="Enter your phone number" required>
                                </div>
                                <div class="form-group">
                                    <label for="id_number">ID Number</label>
                                    <input type="text" class="form-control" id="id_number" name="txtIdNumber" placeholder="Enter your ID number" required>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block" name="btnRegister">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <%
            String checkMessage = (String) request.getSession().getAttribute("checkMessage");
            if (checkMessage != null) {
        %>
        <div class="text-center">
            <p class="text-danger"><%= checkMessage%></p>
        </div>

        <%
                    request.getSession().removeAttribute("checkMessage");
                }%>


        <!-- Bootstrap JS and dependencies (Optional) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- Custom JavaScript to toggle password visibility -->
        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const togglePassword = document.querySelector('#togglePassword');
                const password = document.querySelector('#password');

                togglePassword.addEventListener('click', function (e) {
                    // Toggle the type attribute
                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                    password.setAttribute('type', type);
                    // Toggle the eye slash icon
                    this.classList.toggle('fa-eye');
                    this.classList.toggle('fa-eye-slash');
                });
            });
        </script>
    </body>
</html>
