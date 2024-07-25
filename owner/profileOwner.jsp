<%-- 
    Document   : profileOwner
    Created on : Jul 17, 2024, 4:17:47 PM
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
        <title>Owner Profile</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">       
        <!-- CSS JS bootstrap 5.0-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <style>
            body{
                margin-top:20px;
                background:#f8f8f8
            }
            .profile-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }
            .profile-info {
                font-size: 1.1rem;
                margin-bottom: 15px;
            }
            .profile-info strong {
                color: #495057;
            }
            .profile-header {
                font-size: 1.5rem;
                font-weight: bold;
                color: #343a40;
                text-align: center;
                margin-bottom: 30px;
            }
            .btn-custom {
                background-color: cadetblue;
                color: #fff;
            }
            .btn-custom:hover {
                background-color: #5f9ea0;
            }
            .sidebar {
                padding-top: 50px;
            }
            .sidebar .btn {
                margin-bottom: 10px;
                width: 100%;
                text-align: left;
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
                <div class="col-12 col-lg-auto mb-3" style="width: 255px;">
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
                                <li class="nav-item" style="font-weight: bold"><a class="nav-link px-2" href="/profileController/ProfileUser"><i class="fa fa-fw fa-user mr-1"></i><span>My Profile</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/hotelManagerController"><i class="fa fa-fw fa-th-large mr-1"></i><span>Manage Hotel</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/serviceManagerController"><i class="fa fa-fw fa-th-large mr-1"></i><span>Manage Service</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/roomManagerController"><i class="fa fa-fw fa-th mr-1"></i><span>Manage Room</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/reserveManagerController"><i class="fa fa-fw fa-server mr-1"></i><span>Manage Booking</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/feedbackManagerController"><i class="fa fa-fw fa-send mr-1"></i><span>Manage Feedback</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="/logoutController/SignOut"><i class="fa fa-fw fa-arrow-left mr-1"></i><span>Logout</span></a></li>                         
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-9 container" >
                    <div class="row" style="">
                        <div class="card profile-card">
                            <div class="card-body">
                                <div class="profile-header text-center">Owner Profile</div>
                                <form action="/profileController/ProfileUser" method="post" onsubmit="return confirmUpdate()">
                                    <div class="row" >
                                        <div class="col-md-6 profile-info">
                                            <label for="name"><strong>Name:</strong></label>
                                            <input type="text" class="form-control" id="name" name="name" value="<%= ac.getName()%>">
                                        </div>
                                        <div class="col-md-6 profile-info">
                                            <label for="email"><strong>Email:</strong></label>
                                            <input type="email" class="form-control" id="email" name="email" value="<%= ac.getEmail()%>">
                                        </div>
                                        <div class="col-md-6 profile-info">
                                            <label for="age"><strong>Age:</strong></label>
                                            <input type="number" class="form-control" id="age" name="age" value="<%= ac.getAge()%>">
                                        </div>
                                        <div class="col-md-6 profile-info">
                                            <label for="phone"><strong>Phone:</strong></label>
                                            <input type="text" class="form-control" id="phone" name="phone" value="<%= ac.getPhone()%>">
                                        </div>
                                        <div class="col-md-6 profile-info">
                                            <label for="id_number"><strong>ID Number:</strong></label>
                                            <input type="text" class="form-control" id="id_number" name="id_number" value="<%= ac.getId_number()%>">
                                        </div>
<!--                                        <div class="col-md-6 profile-info ">
                                            <label for="report_count"><strong>Report Count:</strong></label>
                                            <input type="number" class="form-control" id="report_count" name="report_count" value="<%= ac.getReport_count()%>" readonly>
                                        </div>-->
                                    </div>
                                    <%
                                        String errorMessage = (String) request.getSession().getAttribute("errorMessage");
                                        String successMessage = (String) request.getSession().getAttribute("successMessage");
                                        if (errorMessage != null) {
                                    %>
                                    <div class="text-center">
                                        <p class="text-danger"><%= errorMessage%></p>
                                    </div>

                                    <%
                                        request.getSession().removeAttribute("errorMessage");
                                    } else if (successMessage != null) {%>
                                    <div class="text-center">
                                        <p class="text-success"><%= successMessage%></p>
                                    </div>
                                    <% }
                                        request.getSession().removeAttribute("successMessage");
                                    %>
                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn btn-custom" name="btnUpdateProfile">Update Profile</button>
                                    </div>
                                </form>
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
    <script>
                                    function confirmUpdate() {
                                        return confirm("Bạn có chắc chắn muốn thay đổi thông tin không?");
                                    }
    </script>
</body>
</html>
