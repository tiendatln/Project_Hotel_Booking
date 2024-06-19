<%-- 
    Document   : index
    Created on : Jun 14, 2024, 8:44:07 PM
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
        <!--                <section class="rooms-section spad">
                            <div class="container">
                                <div class="row">
                                    <div class="col-lg-4 col-md-6">
                                        <div class="room-item">
                                            <img src="img/room/room-1.jpg" alt="">
                                            <div class="ri-text">
                                                <h4>Premium King Room</h4>
                                                <h3>159$<span>/Pernight</span></h3>
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td class="r-o">Size:</td>
                                                            <td>30 ft</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="r-o">Capacity:</td>
                                                            <td>Max persion 3</td>
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
                                                <a href="room-details.jsp" class="primary-btn">More Details</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="room-item">
                                            <img src="img/room/room-2.jpg" alt="">
                                            <div class="ri-text">
                                                <h4>Deluxe Room</h4>
                                                <h3>159$<span>/Pernight</span></h3>
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
                                                <a href="room-details.jsp" class="primary-btn">More Details</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="room-item">
                                            <img src="img/room/room-3.jpg" alt="">
                                            <div class="ri-text">
                                                <h4>Double Room</h4>
                                                <h3>159$<span>/Pernight</span></h3>
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td class="r-o">Size:</td>
                                                            <td>30 ft</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="r-o">Capacity:</td>
                                                            <td>Max persion 2</td>
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
                                                <a href="room-details.jsp" class="primary-btn">More Details</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="room-item">
                                            <img src="img/room/room-4.jpg" alt="">
                                            <div class="ri-text">
                                                <h4>Luxury Room</h4>
                                                <h3>159$<span>/Pernight</span></h3>
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td class="r-o">Size:</td>
                                                            <td>30 ft</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="r-o">Capacity:</td>
                                                            <td>Max persion 1</td>
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
                                                <a href="room-details.jsp" class="primary-btn">More Details</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="room-item">
                                            <img src="img/room/room-5.jpg" alt="">
                                            <div class="ri-text">
                                                <h4>Room With View</h4>
                                                <h3>159$<span>/Pernight</span></h3>
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td class="r-o">Size:</td>
                                                            <td>30 ft</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="r-o">Capacity:</td>
                                                            <td>Max persion 1</td>
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
                                                <a href="room-details.jsp" class="primary-btn">More Details</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="room-item">
                                            <img src="img/room/room-6.jpg" alt="">
                                            <div class="ri-text">
                                                <h4>Small View</h4>
                                                <h3>159$<span>/Pernight</span></h3>
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td class="r-o">Size:</td>
                                                            <td>30 ft</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="r-o">Capacity:</td>
                                                            <td>Max persion 2</td>
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
                                                <a href="room-details.jsp" class="primary-btn">More Details</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="room-pagination">
                                            <a href="#">1</a>
                                            <a href="#">2</a>                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>-->

        <section class="rooms-section spad">
            <div class="container">
                <div class="row">
                    <c:forEach items="${RoomData}" var="room">                        

                        <div class="col-lg-4 col-md-6">
                            <div class="room-item">                            
                                <a href="room?action=roomdetail&room_id=${room.room_id}"><img src="${room.room_img}" alt=""></a>
                                <div class="ri-text">                                
                                    <h4><a href="room?action=roomdetail&room_id=${room.room_id}" style="color: black">${room.room_type.name_type}</a></h4>
                                    <h3>${room.room_price}$<span>/Pernight</span></h3>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td class="r-o">No.Room:</td>
                                                <td>${room.room_name}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Capacity:</td>
                                                <td>Max persion ${room.room_type.room_capacity}</td>
                                            </tr>
                                            <tr>
                                                <td class="r-o">Hotel:</td>
                                                <td>${room.hotel.hotel_name}</td>
                                            </tr>                                        
                                        </tbody>
                                    </table>                                
                                    <a href="room?action=roomdetail&room_id=${room.room_id}" class="primary-btn" title="quick_view">More Details</a>
                                </div>
                            </div>                            
                        </div>                           
                    </c:forEach>    


                    <c:set var="page" value="${page}"/>
                    <div class="col-lg-12">
                        <div class="room-pagination">
                            <ul>
                                <c:forEach begin="${1}" end="${num}" var="i">
                                    <li class="${i==page?"current":""}"><a href="room?page=${i}">${i}</a></li>
                                    </c:forEach>

                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </section>
                    
    </body>
</html>
