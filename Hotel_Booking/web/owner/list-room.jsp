<%-- 
    Document   : list-room
    Created on : Jun 24, 2024, 8:54:19 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="Model.account"%>
<%@page import="DAOs.accountDAOs"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Room Page</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">       
        <!-- CSS JS bootstrap 5.0-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
            body{
                margin-top:20px;
                background:#f8f8f8
            }
        </style>
    </head>
    <body>                   
        <%
            Cookie[] cList = null;
            String value = "";
            boolean flagOwner = false;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie           
                    if (cList[i].getName().equals("owner")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagOwner = true;
                        break; //thoat khoi vong lap
                    }
                }
            }
        %>

        <div class="m-5">
            <div class="row flex-lg-nowrap">
                <div class="col-12 col-lg-auto mb-3" style="width: 225px;">
                    <div class="card p-3">
                        <div class="e-navlist e-navlist--active-bg">
                            <%
                                accountDAOs aDAO = new accountDAOs();
                                account ac = aDAO.getAccount(value);
                            %>
                            <ul class="nav">                                
                                <li style="margin-bottom: 15px">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                    </svg> <%= ac.getName()%></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/dashboardController"><i class="fa fa-fw fa-database mr-1"></i><span>Dashboard</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/profileController"><i class="fa fa-fw fa-user mr-1"></i><span>My Profile</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/hotelManagerController"><i class="fa fa-fw fa-th-large mr-1"></i><span>Manage Hotel</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/roomManagerController"><i class="fa fa-fw fa-th mr-1"></i><span>Manage Room</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/reserveManagerController"><i class="fa fa-fw fa-server mr-1"></i><span>Manage Booking</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="feedbackManagerController"><i class="fa fa-fw fa-send mr-1"></i><span>Manage Feedback</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/logoutController/SignOut"><i class="fa fa-fw fa-arrow-left mr-1"></i><span>Logout</span></a></li>                         
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="e-tabs mb-3 px-3">
                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" href="#">Manage room</a></li>
                        </ul>
                    </div>

                    <div class="row flex-lg-nowrap">
                        <div class="col mb-3">
                            <div class="e-panel card">
                                <div class="card-body">
                                    <div class="text-left px-xl-3">                                        
                                        <button class="btn btn-success btn-block" type="button" data-bs-toggle="modal" data-bs-target="#add-form-modal"> <i class="fa fa-fw  fa-plus"></i> Add room</button>                                              
                                    </div>
                                    <div class="col-12 col-lg-3 ms-auto" >
                                        <div class="card">
                                            <div class="card-body">                                   

                                                <form method="post" action="#">
                                                    <div class="form-group">                                                                                                                
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><i
                                                                    class="glyphicon glyphicon-envelope color-blue"></i></span> <input
                                                                placeholder="Room ID"
                                                                class="form-control" type="text" required="required">
                                                        </div>
                                                        <div class="text-center px-xl-3" style="margin-top: 5px;"><button type="submit" class="btn btn-primary" name="btnSearch">Search</button></div>
                                                    </div>

                                                </form>

                                            </div>
                                        </div>
                                    </div>



                                    <div class="e-table">
                                        <div class="table-responsive table-lg mt-3">
                                            <table class="table table-bordered table-hover" style='word-wrap:break-word'>
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Image</th>
                                                        <th class="max-width">Room Name</th>
                                                        <th>Price</th>
                                                        <th class="sortable">Room Type</th>
                                                        <th>Capacity</th>
                                                        <th class="max-width" style="max-width: 400px;">Description</th>
                                                        <th>Hotel</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <c:forEach items="${RoomData}" var="room">
                                                    <tbody>
                                                        <tr>
                                                            <td class="align-middle" >
                                                                ${room.room_id}
                                                            </td>
                                                            <td class="align-middle text-center" style="width: 100px">
                                                                <div class="bg-light d-inline-flex justify-content-center align-items-center align-top" style="width: 70px; height: 35px; border-radius: 3px;"><img src="<%= request.getContextPath()%>/imgs/room/${room.room_img }" alt="" width="75px;" height="40px;"></div>
                                                            </td>
                                                            <td class="text-nowrap align-middle">${room.room_name}</td>
                                                            <td class="text-nowrap align-middle">${room.room_price}$</td>
                                                            <td class="text-nowrap align-middle" ><span>${room.room_type.name_type}</span></td>
                                                            <td class="text-nowrap align-middle" ><span>${room.room_type.room_capacity}</span></td>
                                                            <td class="text-nowrap align-middle" style='max-width: 200px;
                                                                overflow-x: hidden;'><span>${room.room_description}</span></td>
                                                            <td class="text-nowrap align-middle"><span>${room.hotel.hotel_name}</span></td>
<!--                                                            <td class="text-center align-middle" ><i class="fa fa-fw text-secondary cursor-pointer offcanvas-body ${room.room_status ? "fa-toggle-on" : "fa-toggle-off"}"></i></td>-->
                                                            <td class="text-center align-middle" >
                                                                <c:if test="${room.room_status}">
                                                                    <span style="color: #00CC00">Active</span>
                                                                </c:if>
                                                                <c:if test="${!room.room_status}">
                                                                    <span style="color: red">Inactive</span>

                                                                </c:if>
                                                            </td>
                                                            <td class="text-center align-middle">
                                                                <div class="btn-group align-top">
                                                                    <button class="btn btn-outline-secondary badge" type="button" data-bs-toggle="modal" data-bs-target="#update-form-modal${room.room_id}" style="color: black;" >Edit</button>
                                                                    <button class="btn btn-sm btn-outline-secondary badge trash" type="button" style="color: black" onclick="doDelete('${room.room_id}')"><i class="fa fa-trash"></i></button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>


                                        <c:set var="page" value="${page}"/>
                                        <div class="d-flex justify-content-center">
                                            <ul class="pagination mt-3 mb-0">
                                                <c:forEach begin="${1}" end="${num}" var="i">                                                    
                                                    <li class="${i==page?"active page-item":"page-item"}"><a href="/roomManagerController?page=${i}" class="page-link">${i}</a></li>                                                    
                                                    </c:forEach>
                                            </ul>
                                        </div>


                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Add Form Modal -->
                <div class="modal fade" role="dialog" tabindex="-1" id="add-form-modal" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Add Room</h5>                                
                            </div>
                            <div class="modal-body">
                                <div class="py-1">
                                    <form class="form" novalidate="" action="/roomManagerController?action=insertroom" method="POST" enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col">
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Room Name</label>
                                                            <input class="form-control" type="text" name="name" placeholder="Name of room" value="">
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Room Type</label>
                                                            <select name="roomType_id" class="form-control" id="exampleSelect1">
                                                                <option>-- Select Room Type --</option>
                                                                <c:forEach items="${RoomTypeData}" var="roomType">
                                                                    <option value="${roomType.room_type_id}">${roomType.name_type}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Price</label>
                                                            <input class="form-control" name="price" type="number" required min="0" placeholder="Price per night">
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Hotel</label>
                                                            <select name="hotel_id" class="form-control" id="exampleSelect1">
                                                                <option>-- Select Hotel --</option>
                                                                <c:forEach items="${HotelData}" var="hotel">
                                                                    <option value="${hotel.hotel_id}">${hotel.hotel_name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col mb-3">
                                                        <div class="form-group">
                                                            <label>Description</label>
                                                            <textarea class="form-control" rows="5" placeholder="Write a description for the room" name="description"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="mb-2"><b>Set Room Image</b></div>
                                                <div class="row">
                                                    <div class="col">
                                                        <div id="myfileupload">
                                                            <input type="file" name="room_img"/>                                                     
                                                        </div>  
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="col-12 col-sm-6 mb-3">
                                                <div class="mb-2"><b>Set Room Status</b></div>
                                                <div class="row">
                                                    <div class="col">
                                                        <select name="status" class="form-control" id="exampleSelect1">                                                            
                                                            <option value="1">Active</option>                                               
                                                            <option value="0">Inactive</option>                                               
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                                <div class="row">
                                    <div class="col d-flex justify-content-end">
                                        <button class="btn btn-primary" type="submit" name="btnAdd">Add</button>                                                
                                        <a class="btn btn-cancel" data-bs-dismiss="modal" href="#" style="background-color: crimson; margin-left: 15px; color: white;">Cancle</a>
                                    </div>
                                </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>

                <c:forEach items="${RoomData}" var="room">
                    <!-- Update Form Modal -->
                    <div class="modal fade" role="dialog" tabindex="-1" id="update-form-modal${room.room_id}" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Update Room</h5>                                
                                </div>
                                <div class="modal-body">
                                    <div class="py-1">
                                        <form class="form" novalidate="" action="/roomManagerController?action=updateroom" method="POST" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col mb-3">
                                                    <div class="form-group">
                                                        <label>Room ID</label>
                                                        <input class="form-control" type="text" name="room_id" value="${room.room_id}" readonly style="background: #f1f1f1">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Room Name</label>
                                                                <input class="form-control" type="text" name="name" placeholder="Name of room" value="${room.room_name}">
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Room Type</label>
                                                                <select name="roomType_id" class="form-control" id="exampleSelect1">
                                                                    <option>-- Select Room Type --</option>
                                                                    <c:forEach items="${RoomTypeData}" var="roomType">
                                                                        <option value="${roomType.room_type_id}" ${(room.room_type.room_type_id == roomType.room_type_id) ? "selected" : ""}>${roomType.name_type}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Price</label>
                                                                <input class="form-control" name="price" type="number" required min="0" placeholder="Price per night" value="${room.room_price}">
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Hotel</label>
                                                                <select name="hotel_id" class="form-control" id="exampleSelect1">
                                                                    <option>-- Select Hotel --</option>
                                                                    <c:forEach items="${HotelData}" var="hotel">
                                                                        <option value="${hotel.hotel_id}" ${(room.hotel.hotel_id == hotel.hotel_id) ? "selected" : ""}>${hotel.hotel_name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col mb-3">
                                                            <div class="form-group">
                                                                <label>Description</label>
                                                                <textarea class="form-control" rows="5" placeholder="Write a description for the room" name="description">${room.room_description}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="mb-2"><b>Set Room Image</b></div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div id="myfileupload">
                                                                <input type="file" name="room_img" value="${room.room_img}"/>                                                     
                                                            </div>  
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-12 col-sm-6 mb-3">
                                                    <div class="mb-2"><b>Set Room Status</b></div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <select name="status" class="form-control" id="exampleSelect1">                                                            
                                                                <option value="1" ${(room.room_status == true) ? "selected" : ""}>Active</option>                                               
                                                                <option value="0" ${(room.room_status == false) ? "selected" : ""}>Inactive</option>                                               
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
                                    <div class="row">
                                        <div class="col d-flex justify-content-end">
                                            <button class="btn btn-primary" type="submit" name="btnUpdate">Save Changes</button>                                                
                                            <a class="btn btn-cancel" data-bs-dismiss="modal" href="#" style="background-color: crimson; margin-left: 15px; color: white;">Cancle</a>
                                        </div>
                                    </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>   
                </c:forEach>

            </div>
        </div>  

        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Custom JS -->  
        <script>
                                                                        function doDelete(id) {
                                                                            if (confirm("Are you sure to delete room with ID = " + id)) {
                                                                                window.location = "/roomManagerController?action=deleteroom&id=" + id;
                                                                            }
                                                                        }
        </script>
    </body>
</html>
