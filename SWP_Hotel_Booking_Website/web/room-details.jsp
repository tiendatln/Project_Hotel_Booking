<%-- 
    Document   : room-details
    Created on : Jun 15, 2024, 8:19:15 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet">        
        <link href="https://fonts.googleapis.com/css?family=Cabin:400,500,600,700&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">                   
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>
    <body>
        <section class="room-details-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        
<!--                        <div class="room-details-item">
                            <img src="img/room/room-details.jpg" alt="">
                            <div class="rd-text">
                                <div class="rd-title">
                                    <h3>Premium King Room</h3>
                                    <div class="rdt-right">
                                        <div class="rate">
                                            <input type="radio" id="star5" name="rate" value="5" />
                                            <label for="star5" title="text">5 stars</label>
                                            <input type="radio" id="star4" name="rate" value="4" />
                                            <label for="star4" title="text">4 stars</label>
                                            <input type="radio" id="star3" name="rate" value="3" />
                                            <label for="star3" title="text">3 stars</label>
                                            <input type="radio" id="star2" name="rate" value="2" />
                                            <label for="star2" title="text">2 stars</label>
                                            <input type="radio" id="star1" name="rate" value="1" />
                                            <label for="star1" title="text">1 star</label>
                                        </div>
                                        <a href="#">Booking Now</a>
                                    </div>
                                </div>
                                <h2>159$<span>/Pernight</span></h2>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="r-o">Size:</td>
                                            <td>30 ft</td>
                                        </tr>
                                        <tr>
                                            <td class="r-o">Capacity:</td>
                                            <td>Max persion 5</td>
                                        </tr>
                                        <tr>
                                            <td class="r-o">Bed:</td>
                                            <td>King Beds</td>
                                        </tr>
                                        <tr>
                                            <td class="r-o">Services:</td>
                                            <td>Wifi, Television, Bathroom,...</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <p class="f-para">Motorhome or Trailer that is the question for you. Here are some of the
                                    advantages and disadvantages of both, so you will be confident when purchasing an RV.
                                    When comparing Rvs, a motorhome or a travel trailer, should you buy a motorhome or fifth
                                    wheeler? The advantages and disadvantages of both are studied so that you can make your
                                    choice wisely when purchasing an RV. Possessing a motorhome or fifth wheel is an
                                    achievement of a lifetime. It can be similar to sojourning with your residence as you
                                    search the various sites of our great land, America.</p>
                                <p>The two commonly known recreational vehicle classes are the motorized and towable.
                                    Towable rvs are the travel trailers and the fifth wheel. The rv travel trailer or fifth
                                    wheel has the attraction of getting towed by a pickup or a car, thus giving the
                                    adaptability of possessing transportation for you when you are parked at your campsite.
                                </p>
                            </div>
                        </div>-->
                                                
                        <div class="room-details-item">
                            <img src=${Data.room_img} alt="">
                            <div class="rd-text">
                                <div class="rd-title">
                                    <h3>${Data.room_type.name_type}</h3>
                                    <div class="rdt-right">
                                        <div class="rate">
                                            <input type="radio" id="star5" name="rate" value="5" />
                                            <label for="star5" title="text">5 stars</label>
                                            <input type="radio" id="star4" name="rate" value="4" />
                                            <label for="star4" title="text">4 stars</label>
                                            <input type="radio" id="star3" name="rate" value="3" />
                                            <label for="star3" title="text">3 stars</label>
                                            <input type="radio" id="star2" name="rate" value="2" />
                                            <label for="star2" title="text">2 stars</label>
                                            <input type="radio" id="star1" name="rate" value="1" />
                                            <label for="star1" title="text">1 star</label>
                                        </div>
                                        <a href="#">Booking Now</a>
                                    </div>
                                </div>
                                <h2>${Data.room_price}$<span>/Pernight</span></h2>
                                <table>
                                    <tbody>
                                         <tr>
                                                <td class="r-o">No.Room:</td>
                                                <td>${Data.room_name}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Capacity:</td>
                                                <td>Max persion ${Data.room_type.room_capacity}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Hotel:</td>
                                                <td>${Data.hotel.hotel_name}</td>
                                            </tr>                                        
                                    </tbody>
                                </table>
                                <p class="f-para">${Data.room_type.room_description}</p>                                
                            </div>
                        </div>                        
                        
                        <div class="rd-reviews">
                            <h4>Reviews</h4>
                            <div class="review-item">                            
                                <div class="ri-text">                                
                                    <div class="rate" style="float: right">
                                        <input type="radio" id="star5" name="rate" value="5" />
                                        <label for="star5" title="text">5 stars</label>
                                        <input type="radio" id="star4" name="rate" value="4" />
                                        <label for="star4" title="text">4 stars</label>
                                        <input type="radio" id="star3" name="rate" value="3" />
                                        <label for="star3" title="text">3 stars</label>
                                        <input type="radio" id="star2" name="rate" value="2" />
                                        <label for="star2" title="text">2 stars</label>
                                        <input type="radio" id="star1" name="rate" value="1" />
                                        <label for="star1" title="text">1 star</label>
                                    </div>
                                    <h5 style="font-weight: bold">Brandon Kelley</h5>
                                    <p>Neque porro qui squam est, qui dolorem ipsum quia dolor sit amet, consectetur,
                                        adipisci velit, sed quia non numquam eius modi tempora. incidunt ut labore et dolore
                                        magnam.</p>
                                </div>
                            </div>
                            <div class="review-item">                            
                                <div class="ri-text">                                
                                    <div class="rate" style="float: right">
                                        <input type="radio" id="star5" name="rate" value="5" />
                                        <label for="star5" title="text">5 stars</label>
                                        <input type="radio" id="star4" name="rate" value="4" />
                                        <label for="star4" title="text">4 stars</label>
                                        <input type="radio" id="star3" name="rate" value="3" />
                                        <label for="star3" title="text">3 stars</label>
                                        <input type="radio" id="star2" name="rate" value="2" />
                                        <label for="star2" title="text">2 stars</label>
                                        <input type="radio" id="star1" name="rate" value="1" />
                                        <label for="star1" title="text">1 star</label>
                                    </div>
                                    <h5 style="font-weight: bold">Brandon Kelley</h5>
                                    <p>Neque porro qui squam est, qui dolorem ipsum quia dolor sit amet, consectetur,
                                        adipisci velit, sed quia non numquam eius modi tempora. incidunt ut labore et dolore
                                        magnam.</p>
                                </div>
                            </div>
                        </div>
                        <div class="review-add">
                            <h4>Add Review</h4>
                            <form action="#" class="ra-form">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <input type="text" placeholder="Name*">
                                    </div>
                                    <div class="col-lg-6">
                                        <input type="text" placeholder="Email*">
                                    </div>
                                    <div class="col-lg-12">
                                        <div>
                                            <h5>You Rating:</h5>
                                            <div class="rate" style="position: relative; bottom: 9px;">
                                                <input type="radio" id="star5" name="rate" value="5" />
                                                <label for="star5" title="text">5 stars</label>
                                                <input type="radio" id="star4" name="rate" value="4" />
                                                <label for="star4" title="text">4 stars</label>
                                                <input type="radio" id="star3" name="rate" value="3" />
                                                <label for="star3" title="text">3 stars</label>
                                                <input type="radio" id="star2" name="rate" value="2" />
                                                <label for="star2" title="text">2 stars</label>
                                                <input type="radio" id="star1" name="rate" value="1" />
                                                <label for="star1" title="text">1 star</label>
                                            </div>
                                        </div>
                                        <textarea placeholder="Your Review"></textarea>
                                        <button type="submit">Submit Now</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                   
                    
                </div>
            </div>
        </section>

    </body>
</html>
