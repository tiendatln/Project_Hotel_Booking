<%@page import="java.sql.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="DAOs.hotelDAOs"%>
<%@page import="DAOs.serviceDAOs"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.roomDAOs"%>
<%@page import="Model.account"%>
<%@page import="DAOs.accountDAOs"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap-theme.min.css">
        <style>
            .product-content {
                border: 2px solid #dfe5e9;
                margin-bottom: 10px;
                margin-top: 12px;
                background: #fff;
                padding: 4px;
                -webkit-box-shadow: 0 1px 4px 0 rgba(0,0,0,0.37);
                box-shadow: 0 1px 4px 0 rgba(0,0,0,0.37);
            }

            .product-content .carousel-control.left {
                margin-left: 0
            }

            .product-content .product-image {
                background-color: #fff;
                display: block;
                min-height: 238px;
                overflow: hidden;
                position: relative
            }

            .product-content .product-deatil {
                border-bottom: 1px solid #dfe5e9;
                padding-bottom: 17px;
                padding-left: 16px;
                padding-top: 16px;
                position: relative;
                background: #fff
            }

            .product-content .product-deatil h5 a {
                color: #2f383d;
                font-size: 15px;
                line-height: 19px;
                text-decoration: none;
                padding-left: 0;
                margin-left: 0
            }

            .product-content .product-deatil h5 a span {
                color: #9aa7af;
                display: block;
                font-size: 13px
            }

            .product-content .product-deatil span.tag1 {
                border-radius: 50%;
                color: #fff;
                font-size: 15px;
                height: 50px;
                padding: 13px 0;
                position: absolute;
                right: 10px;
                text-align: center;
                top: 10px;
                width: 50px
            }

            .product-content .product-deatil span.sale {
                background-color: #21c2f8
            }

            .product-content .product-deatil span.discount {
                background-color: #71e134
            }

            .product-content .product-deatil span.hot {
                background-color: #fa9442
            }

            .product-content .description {
                font-size: 12.5px;
                line-height: 20px;
                padding: 10px 14px 16px 19px;
                background: #fff
            }

            .product-content .product-info {
                padding: 11px 19px 10px 20px
            }

            .product-content .product-info a.add-to-cart {
                color: #2f383d;
                font-size: 13px;
                padding-left: 16px
            }

            .product-content name.a {
                padding: 5px 10px;
                margin-left: 16px
            }

            .product-info.smart-form .btn {
                padding: 6px 12px;
                margin-left: 12px;
                margin-top: -10px
            }

            .product-entry .product-deatil {
                border-bottom: 1px solid #dfe5e9;
                padding-bottom: 17px;
                padding-left: 16px;
                padding-top: 16px;
                position: relative
            }

            .product-entry .product-deatil h5 a {
                color: #2f383d;
                font-size: 15px;
                line-height: 19px;
                text-decoration: none
            }

            .product-entry .product-deatil h5 a span {
                color: #9aa7af;
                display: block;
                font-size: 13px
            }

            .load-more-btn {
                background-color: #21c2f8;
                border-bottom: 2px solid #037ca5;
                border-radius: 2px;
                border-top: 2px solid #0cf;
                margin-top: 20px;
                padding: 9px 0;
                width: 100%
            }

            .product-block .product-deatil p.price-container span,
            .product-content .product-deatil p.price-container span,
            .product-entry .product-deatil p.price-container span,
            .shipping table tbody tr td p.price-container span,
            .shopping-items table tbody tr td p.price-container span {
                color: #21c2f8;
                font-family: Lato, sans-serif;
                font-size: 24px;
                line-height: 20px
            }

            .product-info.smart-form .rating label {
                margin-top: 0
            }

            .product-wrap .product-image span.tag2 {
                position: absolute;
                top: 10px;
                right: 10px;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                padding: 10px 0;
                color: #fff;
                font-size: 11px;
                text-align: center
            }

            .product-wrap .product-image span.sale {
                background-color: #57889c
            }

            .product-wrap .product-image span.hot {
                background-color: #a90329
            }

            .shop-btn {
                position: relative
            }

            .shop-btn>span {
                background: #a90329;
                display: inline-block;
                font-size: 10px;
                box-shadow: inset 1px 1px 0 rgba(0, 0, 0, .1), inset 0 -1px 0 rgba(0, 0, 0, .07);
                font-weight: 700;
                border-radius: 50%;
                padding: 2px 4px 3px!important;
                text-align: center;
                line-height: normal;
                width: 19px;
                top: -7px;
                left: -7px
            }

            .description-tabs {
                padding: 30px 0 5px!important
            }

            .description-tabs .tab-content {
                padding: 10px 0
            }

            .product-deatil {
                padding: 30px 30px 50px
            }

            .product-deatil hr+.description-tabs {
                padding: 0 0 5px!important
            }

            .product-deatil .carousel-control.left,
            .product-deatil .carousel-control.right {
                background: none!important
            }

            .product-deatil .glyphicon {
                color: #3276b1
            }

            .product-deatil .product-image {
                border-right: 0px solid #fff !important
            }

            .product-deatil .name {
                margin-top: 0;
                margin-bottom: 0
            }

            .product-deatil .name small {
                display: block
            }

            .product-deatil .name a {
                margin-left: 0
            }

            .product-deatil .price-container {
                font-size: 24px;
                margin: 0;
                font-weight: 300
            }

            .product-deatil .price-container small {
                font-size: 12px
            }

            .product-deatil .fa-2x {
                font-size: 16px!important
            }

            .product-deatil .fa-2x>h5 {
                font-size: 12px;
                margin: 0
            }

            .product-deatil .fa-2x+a,
            .product-deatil .fa-2x+a+a {
                font-size: 13px
            }

            .product-deatil .certified {
                margin-top: 10px
            }

            .product-deatil .certified ul {
                padding-left: 0
            }

            .product-deatil .certified ul li:not(first-child) {
                margin-left: -3px
            }

            .product-deatil .certified ul li {
                display: inline-block;
                background-color: #f9f9f9;
                padding: 13px 19px
            }

            .product-deatil .certified ul li:first-child {
                border-right: none
            }

            .product-deatil .certified ul li a {
                text-align: left;
                font-size: 12px;
                color: #6d7a83;
                line-height: 16px;
                text-decoration: none
            }

            .product-deatil .certified ul li a span {
                display: block;
                color: #21c2f8;
                font-size: 13px;
                font-weight: 700;
                text-align: center
            }

            .product-deatil .message-text {
                width: calc(100% - 70px)
            }

            @media only screen and (min-width:1024px) {
                .product-content div[class*=col-md-4] {
                    padding-right: 0
                }
                .product-content div[class*=col-md-8] {
                    padding: 0 13px 0 0
                }
                .product-wrap div[class*=col-md-5] {
                    padding-right: 0
                }
                .product-wrap div[class*=col-md-7] {
                    padding: 0 13px 0 0
                }
                .product-content .product-image {
                    border-right: 1px solid #dfe5e9
                }
                .product-content .product-info {
                    position: relative
                }
            }
            .form-group {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 20px;
            }

            label {
                width: 100px;
                text-align: right;
                margin-right: 5px;
                margin-left: 5px;
            }

            .sublabel {
                color: gray;
                margin: 4px;
                font-size: 11px;
            }

            input[type="text"],
            input[type="date"] {
                padding: 10px;
                font-size: 14px;
            }

            button[type="submit"] {
                padding: 10px 20px;
                background-color: #0050A0;
                border: none;
                cursor: pointer;
            }

            .custom-bg {
                background-color: #F7F7F9;
            }

            .hotel-card {
                margin-top: 20px;
            }

            .product-content {
                margin-top: 20px;
            }
        </style>
    </head>
    <body >
        <header>
            <%@include file="layout.jsp" %>
            <div class="bg-dark">
                <div class="container " >
                    <div id="myCarousel" class="carousel slide" data-ride="carousel" >
                        <ol class="carousel-indicators">
                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        </ol>
                        <div class="carousel-inner container-fluid" >
                            <div class="carousel-item active">
                                <img src="/imgs/slide3.jpg" class="d-block w-100" alt="Slide 1" style="height: 500px;">
                            </div>
                            <div class="carousel-item" >
                                <img src="/imgs/silde2.jpg" class="d-block w-100" alt="Slide 2" style="height: 500px;">
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </a>
                        <a class="carousel-control-next" href="#myCarousel" data-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <div class="container" style="background-color: brown; box-shadow: rgba(0, 0, 0, 0.17) 0px -23px 25px 0px inset, rgba(0, 0, 0, 0.15) 0px -36px 30px 0px inset, rgba(0, 0, 0, 0.1) 0px -79px 40px 0px inset, rgba(0, 0, 0, 0.06) 0px 2px 1px, rgba(0, 0, 0, 0.09) 0px 4px 2px, rgba(0, 0, 0, 0.09) 0px 8px 4px, rgba(0, 0, 0, 0.09) 0px 16px 8px, rgba(0, 0, 0, 0.09) 0px 32px 16px;">
            <div class="card custom-bg p-4 d-flex" style="box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 4px, rgba(0, 0, 0, 0.3) 0px 7px 13px -3px, rgba(0, 0, 0, 0.2) 0px -3px 0px inset;">
                <form id="hotel-form" onsubmit="return validateForm()" method="post" action="/searchController">
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="validationServer01" class="d-inline-flex">Destination</label>
                            <input type="text" placeholder="City" class="form-control" id="destination" name="destination" >
                            <c:if test="${search}">
                                <span style="color: red;">Enter a destination to start searching.</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="row" >
                        <div class="form-group col-md-5 align-items-start flex-column">
                            <label for="checkin-date" class=" d-inline-flex">Check-in</label>
                            <input type="date" class="form-control" id="checkin-date" name="checkin-date" onkeydown="return false" >
                        </div>
                        <div class="form-group col-md-5 align-items-start flex-column">
                            <label for="checkout-date" class=" d-inline-flex">Check-out</label>
                            <input type="date" class="form-control" id="checkout-date" name="checkout-date" onkeydown="return false" >
                        </div>

                        <div class="form-group col-md-2 align-items-start flex-column">
                            <label for="quantity" class="d-inline-flex ">Guests</label>

                            <input type="number" class="form-control" id="quantity" name="txtQuantity" placeholder="Enter Quantity" min="1" max="30" list="defaultNumbers">
                            <datalist id="defaultNumbers">
                                <option value="1"></option>
                                <option value="2"></option>
                                <option value="3"></option>
                                <option value="4"></option>
                                <option value="5"></option>
                                <option value="7"></option>
                                <option value="8"></option>
                                <option value="9"></option>
                                <option value="10"></option>
                            </datalist>
                        </div>
                    </div>

                    <div class="row">
                        <div class="text-left col-auto">
                            <button type="submit" class="btn btn-primary" name="btnSearchHotel">Search</button>
                        </div>
                        <div id="error" class="error text-danger"></div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Product Display Section -->
        <div class="container" style="width: 50%; ">
            <%
                roomDAOs roomDAO = new roomDAOs();
                hotelDAOs hDAO = new hotelDAOs();
                ResultSet rs = hDAO.getAllHotel();
                boolean range = true;
                int count = 0;
                long millis = System.currentTimeMillis();
                long tenDaysInMillis = 1L * 24 * 60 * 60 * 1000;
                long checkoutMillis = millis + tenDaysInMillis;
                Date checkinDate = new Date(millis);
                Date checkoutDate = new Date(checkoutMillis);
                while (rs.next() && range) {
                    String location = rs.getString("hotel_name");
                    location += rs.getString("hotel_address");
                    location.replace(' ', '+');
            %>
            <div class="property-card card row" style="margin-top: 10px; flex-direction: row; border-radius: 10px; box-shadow: rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;">
                <div class="col-4 d-flex " >
                    <img style=" border-radius: 10px; " src="<%= request.getContextPath()%>/imgs/hotel/<%= rs.getString("hotel_img")%>" class="card-img-top" alt="">
                </div>
                <div class="card-body col-8">
                    <div class="d-flex justify-content-between align-items-center row">
                        <div class="col-8">
                            <h5 class="property-title"><%= rs.getString("hotel_name")%></h5>
                            <p class="property-details text-success">
                                <a target="_blank" href="https://www.google.com/maps?q=<%= location %>"><%= rs.getString("hotel_address")%></a> <br>
                                Service: 
                                <%
                                    serviceDAOs sDAO = new serviceDAOs();
                                    ResultSet rsv = sDAO.getServiceByHotelID(rs.getInt("hotel_id"));
                                    while (rsv.next()) {
                                %>
                                <%= rsv.getString("service_name")%>.
                                <% }%>
                                <br>
                                <%= rs.getString("hotel_description")%><br>

                                <%
                                    ResultSet rrt = roomDAO.showRoomTypeByHotelID(rs.getInt("hotel_id"));
                                    while (rrt.next()) {
                                %>

                                <%= rrt.getString("name_type")%>.

                                <%
                                    }
                                %>
                            </p>
                        </div>
                        <div class="text-right col-4">
                            <p class="price">
                                <%
                                    int lowPrice = roomDAO.getLowPrice(rs.getInt("hotel_id"));
                                    int highPrice = roomDAO.getHighPrice(rs.getInt("hotel_id"));
                                %>
                                $<%= lowPrice%> - $<%= highPrice%>
                            </p>

                            <p>Includes taxes and fees</p>
                            <a class="btn btn-primary" href="/searchController/HotelDetail/<%= checkinDate%>/<%= checkoutDate%>/<%= rs.getInt("hotel_id")%>" >See availability</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    if (count >= 10) {
                        range = false;
                    }
                    count++;
                }%>
            <!-- Add more property cards as needed -->
        </div>


        <%
            String massageRegister = (String) request.getSession().getAttribute("massageRegister");
            if (massageRegister != null) {
        %> 
        <script>
            alert("Register Success");
        </script>
        <%
                request.getSession().removeAttribute("massageRegister");
            }
        %>
        <c:if test="${searchError}">
            <script>
                alert("Location not found!");
            </script>
        </c:if>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                // Set the minimum check-in date to today
                var today = new Date().toISOString().split('T')[0];
                document.getElementById("checkin-date").setAttribute("min", today);
                document.getElementById("checkout-date").setAttribute("min", today);

                // Function to update the minimum check-out date based on check-in date
                function validateForm() {
                    var checkin = document.getElementById('checkin-date').value;
                    var checkout = document.getElementById('checkout-date').value;
                    var quantity = document.getElementById('quantity').value;

                    if (!checkin) {
                        var today = new Date().toISOString().split('T')[0];
                        document.getElementById('checkin-date').value = today;
                        checkin = today;
                    }

                    if (!checkout) {
                        var today = new Date().toISOString().split('T')[0];
                        document.getElementById('checkout-date').value = today;
                        checkout = today;
                    }

                    if (!quantity) {
                        document.getElementById('quantity').value = 2;
                    }

                    var checkinDate = new Date(checkin);
                    var checkoutDate = new Date(checkout);

                    if (checkoutDate < checkinDate) {
                        document.getElementById("error").innerHTML = "Check-out date must be after check-in date.";
                        return false;
                    }

                    return true;
                }
        </script>
    </body>
</html>
