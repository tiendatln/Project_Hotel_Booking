<%-- 
    Document   : dashboard
    Created on : Jul 15, 2024, 2:18:26 PM
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
        <title>Dashboard</title>
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
                                <li class="nav-item" style="font-weight: bold"><a class="nav-link px-2" href="/dashboardController"><i class="fa fa-fw fa-database mr-1"></i><span>Dashboard</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/profileController/ProfileUser"><i class="fa fa-fw fa-user mr-1"></i><span>My Profile</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/hotelManagerController"><i class="fa fa-fw fa-th-large mr-1"></i><span>Manage Hotel</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/roomManagerController"><i class="fa fa-fw fa-th mr-1"></i><span>Manage Room</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/reserveManagerController"><i class="fa fa-fw fa-server mr-1"></i><span>Manage Booking</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/feedbackManagerController"><i class="fa fa-fw fa-send mr-1"></i><span>Manage Feedback</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/logoutController/SignOut"><i class="fa fa-fw fa-arrow-left mr-1"></i><span>Logout</span></a></li>                         
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="e-tabs mb-3 px-3">
                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" href="#">Dashboard</a></li>
                        </ul>
                    </div>

                    <div class="row flex-lg-nowrap">
                        <div class="col mb-3">
                            <div class="e-panel card">
                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-pattern">
                                                <div class="card-body">
                                                    <div class="float-right">
                                                        <i class="fa fa-th-large text-primary h4 ml-3"></i>
                                                    </div>
                                                    <h5 class="font-size-20 mt-0 pt-1">${requestScope.hotel}</h5>
                                                    <p class="text-muted mb-0">Number of hotels</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-pattern">
                                                <div class="card-body">
                                                    <div class="float-right">
                                                        <i class="fa fa-th text-primary h4 ml-3"></i>
                                                    </div>
                                                    <h5 class="font-size-20 mt-0 pt-1">${requestScope.room}</h5>
                                                    <p class="text-muted mb-0">Number of rooms</p>
                                                </div>
                                            </div>
                                        </div>                                       
                                        <div class="col-xl-4 col-md-6">
                                            <div class="card bg-pattern">
                                                <div class="card-body">
                                                    <div class="float-right">
                                                        <i class="fa fa-send text-primary h4 ml-3"></i>
                                                    </div>
                                                    <h5 class="font-size-20 mt-0 pt-1">${requestScope.feedback}</h5>
                                                    <p class="text-muted mb-0">Number of feedbacks</p>
                                                </div>
                                            </div>
                                        </div>                                        
                                    </div> 



                                    <div class="e-table" style="margin-top: 20px">
                                        <div class="e-tabs mb-3 px-3">
                                            <ul class="nav nav-tabs">
                                                <li class="nav-item"><a class="nav-link active" href="#">Manage Booking</a></li>
                                            </ul>
                                        </div>
                                        <div class="row" style="margin: 0 10px 0 0">
                                            <div class="col-xl-6 col-lg-6" style="margin-top: 10px">
                                                <div class="card l-bg-cherry" >
                                                    <div class="card-statistic-3 p-4">
                                                        <!--                                                        <div class="card-icon card-icon-large"><i class="fas fa-shopping-cart"></i></div>-->
                                                        <div class="mb-4">
                                                            <h5 class="card-title mb-0">Confirmed</h5>
                                                        </div>
                                                        <div class="row align-items-center mb-2 d-flex">
                                                            <div class="col-8">
                                                                <h2 class="d-flex align-items-center mb-0">
                                                                    ${requestScope.confirm}
                                                                </h2>
                                                            </div>
                                                            <!--                                                            <div class="col-4 text-right">
                                                                                                                            <span>12.5% <i class="fa fa-arrow-up"></i></span>
                                                                                                                        </div>-->
                                                        </div>
                                                        <div class="progress mt-1 " data-height="8" style="height: 8px;">
                                                            <div class="progress-bar l-bg-cyan" role="progressbar" data-width="${requestScope.perconfirm}%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: ${requestScope.perconfirm}%;"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6 col-lg-6" style="margin-top: 10px">
                                                <div class="card l-bg-cherry">
                                                    <div class="card-statistic-3 p-4">
                                                        <!--                                                        <div class="card-icon card-icon-large"><i class="fas fa-shopping-cart"></i></div>-->
                                                        <div class="mb-4">
                                                            <h5 class="card-title mb-0">Pending</h5>
                                                        </div>
                                                        <div class="row align-items-center mb-2 d-flex">
                                                            <div class="col-8">
                                                                <h2 class="d-flex align-items-center mb-0">
                                                                    ${requestScope.pending}
                                                                </h2>
                                                            </div>
                                                            <!--                                                                                                                        <div class="col-4 text-right">
                                                                                                                                                                                        <span>12.5% <i class="fa fa-arrow-up"></i></span>
                                                                                                                                                                                    </div>-->
                                                        </div>
                                                        <div class="progress mt-1 " data-height="8" style="height: 8px;">
                                                            <div class="progress-bar l-bg-cyan" role="progressbar" data-width="${requestScope.perpending}%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: ${requestScope.perpending}%;"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6 col-lg-6" style="margin-top: 10px">
                                                <div class="card l-bg-cherry">
                                                    <div class="card-statistic-3 p-4">
                                                        <!--                                                        <div class="card-icon card-icon-large"><i class="fas fa-shopping-cart"></i></div>-->
                                                        <div class="mb-4">
                                                            <h5 class="card-title mb-0">Canceled</h5>
                                                        </div>
                                                        <div class="row align-items-center mb-2 d-flex">
                                                            <div class="col-8">
                                                                <h2 class="d-flex align-items-center mb-0">
                                                                    ${requestScope.cancel}
                                                                </h2>
                                                            </div>
                                                            <!--                                                            <div class="col-4 text-right">
                                                                                                                            <span>12.5% <i class="fa fa-arrow-up"></i></span>
                                                                                                                        </div>-->
                                                        </div>
                                                        <div class="progress mt-1 " data-height="8" style="height: 8px;">
                                                            <div class="progress-bar l-bg-cyan" role="progressbar" data-width="${requestScope.percancel}%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="width: ${requestScope.percancel}%;"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6 col-lg-6" style="margin-top: 10px">
                                                <div class="card l-bg-cherry">
                                                    <div class="card-statistic-3 p-4">
                                                        <!--                                                        <div class="card-icon card-icon-large"><i class="fas fa-shopping-cart"></i></div>-->
                                                        <div class="mb-4">
                                                            <h5 class="card-title mb-0">Total booking</h5>
                                                        </div>
                                                        <div class="row align-items-center mb-2 d-flex">
                                                            <div class="col-8">
                                                                <h2 class="d-flex align-items-center mb-0">
                                                                    ${requestScope.total}
                                                                </h2>
                                                            </div>
                                                            <!--                                                            <div class="col-4 text-right">
                                                                                                                            <span>12.5% <i class="fa fa-arrow-up"></i></span>
                                                                                                                        </div>-->
                                                        </div>
                                                        <div data-height="8" style="height: 8px;">                                                            
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>





                                </div>
                            </div>  

                            <!-- jQuery and Bootstrap JS -->
                            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
                            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

                            <!-- Custom JS -->  

                            </body>
                            </html>
