<%-- 
    Document   : becomesOwner
    Created on : Jul 15, 2024, 9:45:43 AM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Become Owner</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="/css/becomesOwner.css">
    </head>
    <style>
        .box {
  width: 40%;
  margin: 0 auto;
  background: rgba(255,255,255,0.2);
  padding: 35px;
  border: 2px solid #fff;
  border-radius: 20px/50px;
  background-clip: padding-box;
  text-align: center;
}
.popup {
  margin: 70px auto;
  padding: 20px;
  background: #fff;
  border-radius: 5px;
  width: 30%;
  position: relative;
  transition: all 5s ease-in-out;
}

.popup h2 {
  margin-top: 0;
  color: #333;
  font-family: Tahoma, Arial, sans-serif;
}
.popup .close {
  position: absolute;
  top: 20px;
  right: 30px;
  transition: all 200ms;
  font-size: 30px;
  font-weight: bold;
  text-decoration: none;
  color: #333;
}
.popup .close:hover {
  color: #06D85F;
}
.popup .content {
  max-height: 30%;
  overflow: auto;
}

@media screen and (max-width: 700px){
  .box{
    width: 70%;
  }
  .popup{
    width: 70%;
  }
}
h1 {
  text-align: center;
  font-family: Tahoma, Arial, sans-serif;
  color: #06D85F;
  margin: 80px 0;
}
    </style>
    <body>
        <%@include file="layout.jsp" %>

        <div class="container mt-3">

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
                <!--                <div class="d-flex justify-content-between align-items-lg-center py-3 flex-column flex-lg-row">
                                    <h2 class="h5 mb-3 mb-lg-0"><a href="../../pages/admin/customers.html" class="text-muted"><i class="bi bi-arrow-left-square me-2"></i></a> Create new customer</h2>
                                    <div class="hstack gap-3">
                                        <button class="btn btn-light btn-sm btn-icon-text"><i class="bi bi-x"></i> <span class="text">Cancel</span></button>
                                        <button class="btn btn-primary btn-sm btn-icon-text"><i class="bi bi-save"></i> <span class="text">Save</span></button>
                                    </div>
                                </div>-->
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
                                                    <input type="text" name="name" class="form-control" value="${account.getName()}" disabled="">
                                                    <div class="error-message" id="firstnameError"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" name="email" class="form-control" value="${account.getEmail()}" disabled="">
                                                    <div class="error-message" id="emailError"></div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone number</label>
                                                    <input type="text" name="phone" class="form-control" value="${account.getPhone()}" disabled="">
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
                                            <div class="card mb-4">
                                                <div class="card-body">
                                                    <h3 class="h6">Business Licens Image</h3>
                                                    <input class="ml-2" type="file" name="BusinessLicensImage">
                                                    <div class="error-message" id="hotelImageError"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <button style="width: 200px" type="submit" class="btn btn-primary btn-block" name="btnConfirm">Confirm</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <c:if test="${updateError != null}">
<!--
            <div id="popup1" class="overlay">
                <div class="popup">
                    <h2>Here i am</h2>
                    <a class="close" href="#">&times;</a>
                    <div class="content">
                        Thank to pop me out of that button, but now i'm done so you can close this window.
                    </div>
                </div>
            </div>-->
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
        </script>
    </body>
</html>
