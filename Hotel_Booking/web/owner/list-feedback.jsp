<%-- 
    Document   : list_feedback
    Created on : Jul 17, 2024, 2:28:06 PM
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
        <title>Manage Feedback Page</title>
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
                <div class="col-12 col-lg-auto mb-3" style="width: 235px;">
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
                                <li class="nav-item"><a class="nav-link px-2" href="/profileController/ProfileUser"><i class="fa fa-fw fa-user mr-1"></i><span>My Profile</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/hotelManagerController"><i class="fa fa-fw fa-th-large mr-1"></i><span>Manage Hotel</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/roomManagerController"><i class="fa fa-fw fa-th mr-1"></i><span>Manage Room</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/reserveManagerController"><i class="fa fa-fw fa-server mr-1"></i><span>Manage Booking</span></a></li>
                                <li class="nav-item" style="font-weight: bold"><a class="nav-link px-2" href="/feedbackManagerController"><i class="fa fa-fw fa-send mr-1"></i><span>Manage Feedback</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/logoutController/SignOut"><i class="fa fa-fw fa-arrow-left mr-1"></i><span>Logout</span></a></li>                         
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="e-tabs mb-3 px-3">
                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" href="#">Manage Feedback</a></li>
                        </ul>
                    </div>

                    <div class="row flex-lg-nowrap">
                        <div class="col mb-3">
                            <div class="e-panel card">
                                <div class="card-body">


                                    <div class="col-xl-3 col-md-6">
                                        <div class="card">
                                            <div class="card-body">
                                                <form action="/feedbackManagerController?action=search" method="POST">
                                                    <div class="form-group mb-0">

                                                        <div class="input-group mb-0">
                                                            <input type="text" class="form-control" placeholder="Search...." aria-describedby="project-search-addon" name="key" value="${keyword}"/>
                                                            <div class="input-group-append">
                                                                <button type="submit" class="btn btn-danger" type="button" id="project-search-addon" style="margin-left: 10px"><i class="fa fa-search search-icon font-12"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>                                                                     



                                <div class="e-table" style="margin: 10px">
                                    <div class="table-responsive table-lg mt-3">
                                        <div class="e-tabs mb-3 px-3"></div>
                                        <table class="table table-bordered table-hover" style='word-wrap:break-word'>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Username</th>
                                                    <th class="max-width" style="max-width: 400px;">Comment</th>                                                                                                            
                                                    <th class="max-width" style="max-width: 400px;">Hotel</th>   
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <c:forEach items="${FeedbackData}" var="feedback">
                                                <tbody>
                                                    <tr>
                                                        <td class="align-middle" >
                                                            ${feedback.id}
                                                        </td>
                                                        <td class="text-nowrap align-middle">${feedback.account.name}</td>
                                                        <td class="text-nowrap align-middle">${feedback.comment}</td>
                                                        <td class="text-nowrap align-middle"'><span>${feedback.hotel.hotel_name}</span></td>               
                                                        <td class="text-center align-middle">
                                                            <div class="btn-group align-top">
                                                                <button class="btn btn-outline-secondary badge" type="button" data-bs-toggle="modal" data-bs-target="#view-form-modal${feedback.id}"  style="background-color: #ffc107"><span style="color: #f8f8f8;">View details</span></button>&nbsp;                                                                
<!--                                                                <button class="btn btn-sm btn-outline-secondary badge trash" type="button" style="color: black;" onclick="doDelete('${feedback.id}')"><i class="fa fa-trash"></i></button>-->
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="d-flex justify-content-center">
                                        <c:if test="${message}">
                                            <span>No feedback found</span>
                                        </c:if>    
                                    </div>
                                    <c:set var="page" value="${page}"/>
                                    <div class="d-flex justify-content-center">
                                        <ul class="pagination mt-3 mb-0">
                                            <c:forEach begin="${1}" end="${num}" var="i">                                                    
                                                <li class="${i==page?"active page-item":"page-item"}"><a href="/feedbackManagerController?page=${i}&keyword=${keyword}" class="page-link">${i}</a></li>                                                    
                                                </c:forEach>
                                        </ul>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <c:forEach items="${FeedbackData}" var="feedback">
                <!--Add Hotel Form Modal -->
                <div class="modal fade" role="dialog" tabindex="-1" id="view-form-modal${feedback.id}" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Feedback Details #${feedback.id}</h5>                                
                            </div>
                            <div class="modal-body">
                                <div class="py-1">
                                    <form class="form" novalidate="" action="/reserveManagerController" method="post">                                        
                                        <div class="row">
                                            <div class="col">
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Username</label>
                                                            <input class="form-control" type="text" name="room_id" value="${feedback.account.username}" readonly style="background: #f1f1f1" disabled>
                                                        </div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label>Hotel</label>
                                                            <select name="hotel_id" class="form-control" id="exampleSelect1" readonly style="background: #f1f1f1" disabled>
                                                                <option>-- Select Hotel --</option>
                                                                <c:forEach items="${HotelData}" var="hotel">
                                                                    <option value="${hotel.hotel_id}" ${(feedback.hotel.hotel_id == hotel.hotel_id) ? "selected" : ""}>${hotel.hotel_name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col mb-3">
                                                        <div class="form-group">
                                                            <label>Description</label>
                                                            <textarea class="form-control" rows="5" placeholder="Write a description for the room" name="description" readonly style="background: #f1f1f1" disabled>${feedback.comment}</textarea>
                                                        </div>
                                                    </div>
                                                </div>                                                
                                            </div>
                                        </div>



                                </div>
                                <div class="row">
                                    <div class="col d-flex justify-content-end">                                                                                        
                                        <a class="btn btn-cancel" data-bs-dismiss="modal" href="#" style="background-color: crimson; margin-left: 15px; color: white;">Close</a>
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
                                                                        if (confirm("Are you sure to delete feedback with ID = " + id)) {
                                                                            window.location = "/feedbackManagerController?action=deletefeedback&id=" + id;
                                                                        }
                                                                    }
    </script>
</body>
</html>
