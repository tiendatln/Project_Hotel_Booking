<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registration Form</title>
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
            .error-message {
                color: red;
                font-size: 0.9rem;
                margin-top: 0.5rem;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="text-center">Register</h2>
                    <div class="card">
                        <div class="card-body">
                            <form action="/registerController/Register" method="post" id="registrationForm">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="txtUs" placeholder="Enter username" >
                                    <span class="error-message" id="usernameError"></span>
                                </div>
                                <div class="form-group position-relative">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="txtPwd" placeholder="Enter password" >
                                    <span class="error-message" id="passwordError"></span>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="text" class="form-control" id="email" name="txtEmail" placeholder="Enter email" >
                                    <span class="error-message" id="emailError"></span>
                                </div>
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" id="name" name="txtName" placeholder="Enter your name" >
                                    <span class="error-message" id="nameError"></span>
                                    <c:if test="emailExist">
                                        <span class="error-message">Email is Exist.</span>
                                    </c:if>
                                </div>
                                <div class="form-group">
                                    <label for="age">Age</label>
                                    <input type="number" class="form-control" id="age" name="txtAge" placeholder="Enter your age" >
                                    <span class="error-message" id="ageError"></span>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone</label>
                                    <input type="text" class="form-control" id="phone" name="txtPhone" placeholder="Enter your phone number" >
                                    <span class="error-message" id="phoneError"></span>
                                </div>
                                <div class="form-group">
                                    <label for="id_number">ID Number</label>
                                    <input type="text" class="form-control" id="id_number" name="txtIdNumber" placeholder="Enter your ID number" >
                                    <span class="error-message" id="idNumberError"></span>
                                </div>
                                <% String checkMessage = (String) request.getSession().getAttribute("checkMessage");
                                    if (checkMessage != null) { %>
                                    <div class="text-center">
                                        <p class="text-danger"><%= checkMessage %></p>
                                    </div>
                                <% request.getSession().removeAttribute("checkMessage"); } %>
                                <button type="submit" class="btn btn-primary btn-block" name="btnRegister">Register</button>
                                <div class="text-center m-2">
                                    <a href="/loginController/login">Back to Login</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- Custom JavaScript to validate form -->
        <script>
            // Form validation
            document.getElementById('registrationForm').addEventListener('submit', function (event) {
                let isValid = true;

                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;
                const email = document.getElementById('email').value;
                const name = document.getElementById('name').value;
                const age = document.getElementById('age').value;
                const phone = document.getElementById('phone').value;
                const idNumber = document.getElementById('id_number').value;

                // Regular expressions
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                const phonePattern = /^(0|84)(2(0[3-9]|1[0-6|8|9]|2[0-2|5-9]|3[2-9]|4[0-9]|5[1|2|4-9]|6[0-3|9]|7[0-7]|8[0-9]|9[0-4|6|7|9])|3[2-9]|5[5|6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])([0-9]{7})$/;
                const idPattern = /^([0-9]{10})$|^([0-9]{12})$/;

                // Clear previous error messages
                document.querySelectorAll('.error-message').forEach((element) => element.innerHTML = '');

                // Check for empty fields
                if (!username) {
                    document.getElementById('usernameError').innerHTML = 'Username is required.';
                    isValid = false;
                }
                if (!password) {
                    document.getElementById('passwordError').innerHTML = 'Password is required.';
                    isValid = false;
                }
                if (!email) {
                    document.getElementById('emailError').innerHTML = 'Email is required.';
                    isValid = false;
                } else if (!emailPattern.test(email)) {
                    document.getElementById('emailError').innerHTML = 'Please enter a valid email address.';
                    isValid = false;
                }
                if (!name) {
                    document.getElementById('nameError').innerHTML = 'Name is required.';
                    isValid = false;
                }
                if (!age) {
                    document.getElementById('ageError').innerHTML = 'Age is required.';
                    isValid = false;
                }else if (age<=0) {
                    document.getElementById('ageError').innerHTML = 'Age must be greater than 0.';
                    isValid = false;
                }
                if (!phone) {
                    document.getElementById('phoneError').innerHTML = 'Phone number is required.';
                    isValid = false;
                } else if (!phonePattern.test(phone)) {
                    document.getElementById('phoneError').innerHTML = 'Please enter a valid Vietnamese phone number.';
                    isValid = false;
                }
                if (!idNumber) {
                    document.getElementById('idNumberError').innerHTML = 'ID number is required.';
                    isValid = false;
                } else if (!idPattern.test(idNumber)){
                    document.getElementById('idNumberError').innerHTML = 'ID number must be a 10 or 12 digits number.';
                    isValid = false;
                }                

                if (!isValid) {
                    event.preventDefault();
                }
            });
        </script>
    </body>
</html>
