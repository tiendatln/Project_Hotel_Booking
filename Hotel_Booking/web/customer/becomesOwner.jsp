<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Become Owner</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="/css/becomesOwner.css">
    </head>

    <body>
        <%@include file="layout.jsp" %>

        <div class="container mt-5">

            <div class="row">
                <div class="col-md-3 sidebar">
                    <button class="btn btn-custom" onclick="location.href = '/profileController/ProfileUser'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm80 256h64c44.2 0 80 35.8 80 80c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16c0-44.2 35.8-80 80-80zm-32-96a64 64 0 1 1 128 0 64 64 0 1 1 -128 0zm256-32H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/></svg>
                        Profile
                    </button>
                    <button class="btn btn-custom" onclick="location.href = '/profileController/ChangePassword'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M336 352c97.2 0 176-78.8 176-176S433.2 0 336 0S160 78.8 160 176c0 18.7 2.9 36.8 8.3 53.7L7 391c-4.5 4.5-7 10.6-7 17v80c0 13.3 10.7 24 24 24h80c13.3 0 24-10.7 24-24V448h40c13.3 0 24-10.7 24-24V384h40c6.4 0 12.5-2.5 17-7l33.3-33.3c16.9 5.4 35 8.3 53.7 8.3zM376 96a40 40 0 1 1 0 80 40 40 0 1 1 0-80z"/></svg>
                        Change Password
                    </button>
                    <button class="btn btn-secondary" onclick="location.href = '/profileController/BecomeOwner'">
                        <svg style="width: 20px;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M192 0c-41.8 0-77.4 26.7-90.5 64H64C28.7 64 0 92.7 0 128V448c0 35.3 28.7 64 64 64H320c35.3 0 64-28.7 64-64V128c0-35.3-28.7-64-64-64H282.5C269.4 26.7 233.8 0 192 0zm0 64a32 32 0 1 1 0 64 32 32 0 1 1 0-64zM112 192H272c8.8 0 16 7.2 16 16s-7.2 16-16 16H112c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/></svg>
                        Become Owner
                    </button>
                </div>            

                <div class="container col-md-9">
                    <form action="/becomesOwnerController" method="post" id="becomeOwner" enctype="multipart/form-data">
                        <!-- Main content -->
                        <div class="row">
                            <!-- Left side -->
                            <div class="col-lg-12">
                                <!-- Basic information -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <h3 class="h6 mb-4">Basic information</h3>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Name</label>
                                                    <input type="text" name="name" class="form-control" value="<%= ac.getName()%>" disabled="">
                                                    <div class="error-message" id="firstnameError"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" name="email" class="form-control" value="<%= ac.getEmail()%>" disabled="">
                                                    <div class="error-message" id="emailError"></div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone number</label>
                                                    <input type="text" name="phone" class="form-control" value="<%= ac.getPhone()%>" disabled="">
                                                    <div class="error-message" id="phoneError"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Address -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <h3 class="h6 mb-4">Hotel</h3>
                                        <div class="mb-3">
                                            <label class="form-label">Hotel Name</label>
                                            <input type="text" name="hotel" class="form-control">
                                            <div class="error-message" id="hotelError"></div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Address</label>
                                            <input type="text" name="address" class="form-control">
                                            <div class="error-message" id="addressError"></div>
                                        </div>
                                        <div class="row">
                                            <div class="card mb-4 ml-3">
                                                <div class="card-body m">
                                                    <h3 class="h6">Business License Image</h3>
                                                    <input class="ml-2" type="file" name="BusinessLicensImage" id="BusinessLicensImage" accept=".jpg,.jpeg,.png,.gif,.bmp">
                                                    <div class="error-message" id="hotelImageError"></div>
                                                    <img id="imagePreview" src="#" alt="Image Preview" style="display: none; width: 200px; margin-top: 10px;">
                                                </div>
                                            </div>
                                        </div>
                                        <div >
                                            <div >
                                                <button style="width: 200px; margin-bottom: 10px" type="submit" class="btn btn-primary btn-block" name="btnConfirm">Confirm</button>
                                                <a  href="/viewUpdateOwnerControlller/View">View Request</a>
                                            </div >
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <c:if test="${updateMesage}">


            <script>
                alert("The send request success.");

            </script>
        </c:if>
        <c:if test="${updateExist}">


            <script>
                alert("The send request already exists.");

            </script>
        </c:if>

        <script>
            document.getElementById('becomeOwner').addEventListener('submit', function (event) {
                let isValid = true;

                document.querySelectorAll('.error-message').forEach(function (error) {
                    error.textContent = '';
                });

                // Check hotel
                let hotel = document.querySelector('input[name="hotel"]');
                if (hotel.value.trim() === '') {
                    document.getElementById('hotelError').textContent = 'Hotel name is required.';
                    isValid = false;
                }

                // Check address
                let address = document.querySelector('input[name="address"]');
                if (address.value.trim() === '') {
                    document.getElementById('addressError').textContent = 'Address is required.';
                    isValid = false;
                }

                // Check hotel image
                let hotelImage = document.querySelector('input[name="BusinessLicensImage"]');
                if (hotelImage.files.length === 0) {
                    document.getElementById('hotelImageError').textContent = 'Hotel image is required.';
                    isValid = false;
                }

                // Prevent form submission if validation fails
                if (!isValid) {
                    event.preventDefault();
                }
            });

            // Display image preview
// Display image preview
            document.getElementById('BusinessLicensImage').addEventListener('change', function (event) {
                let file = event.target.files[0];
                if (file) {
                    let reader = new FileReader();
                    reader.onload = function (e) {
                        let img = document.getElementById('imagePreview');
                        img.src = e.target.result;
                        img.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                } else {
                    document.getElementById('imagePreview').style.display = 'none';
                }
            });

        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>