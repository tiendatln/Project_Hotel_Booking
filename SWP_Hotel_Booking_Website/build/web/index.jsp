<%-- 
    Document   : index
    Created on : Jun 14, 2024, 8:44:07 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="dao.AccountDAO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>       

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Cabin:400,500,600,700&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">           
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>
    <body>
        <%@include file="layout/menu.jsp" %>

        <div class="container mt-5">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">

                <!-- Indicators/dots -->
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                </ol>

                <!-- The slideshow/carousel -->
                <div class="carousel-inner container-fluid">
                    <div class="carousel-item active">
                        <img src="img/slide3.jpg" class="d-block w-100" alt="Slide 1" style="height: 500px;">
                    </div>
                    <div class="carousel-item">
                        <img src="img/silde2.jpg" class="d-block w-100" alt="Slide 2" style="height: 500px;">
                    </div>
                </div>

                <!-- Left and right controls/icons -->
                <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </a>
                <a class="carousel-control-next" href="#myCarousel" data-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </a>
            </div>
        </div>

        <div class="container" style="background-color: brown; margin-top: 20px;">
            <div class="card custom-bg p-4 d-flex">
                <form id="hotel-form" onsubmit="return validateForm()">
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="validationServer01" class="d-inline-flex">Destination</label>
                            <input type="text" placeholder="City" class="form-control" id="destination" name="destination"
                                   required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="checkin-date" class=" d-inline-flex">Check-in</label>
                            <input type="date" class="form-control" id="checkin-date" name="checkin-date"
                                   onkeydown="return false" required>
                        </div>
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="checkout-date" class=" d-inline-flex">Check-out</label>
                            <input type="date" class="form-control" id="checkout-date" name="checkout-date"
                                   onkeydown="return false" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="guests" class="d-inline-flex ">Guests</label>
                            <select class="form-control" id="guests"
                                    onchange="javascript: dynamicDropdown(this.options[this.selectedIndex].value);">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                            </select>
                        </div>
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="rooms" class="d-inline-flex ">Room Type</label>
                            <select id="inputState" class="form-control">
                                <option selected>Choose...</option>
                                <option>...</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="text-left col-auto">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                        <div id="error" class="error text-danger"></div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-auto w-100" style="margin-top: 20px">

            </div>
        </div>


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                                        document.getElementById('hotel-form').addEventListener('submit', function (event) {
                                            var checkin = document.getElementById('checkin-date').value;
                                            var checkout = document.getElementById('checkout-date').value;
                                            if (new Date(checkin) >= new Date(checkout)) {
                                                alert('Check-out date must be later than check-in date.');
                                                event.preventDefault();
                                            }
                                        });
        </script>
    </body>
</html>
