<%-- 
    Document   : order
    Created on : Mar 14, 2024, 5:16:23 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh sách đơn hàng | Quản trị Admin</title>
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">

        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

        <script type="text/javascript">
            function doSetRole(username) {
                if (confirm("Are you certain to set " + username + "'s role to owner?")) {
                    window.location = "setrole?action=setrole&user=" + username;

                }
            }
        </script>    
        <script type="text/javascript">
            function Cancel(username) {
                if (confirm("Are you should to cancel application?")) {
                    window.location = "setrole?action=deleteDon&username=" + username;

                }
            }
        </script>
    </head>
    <body >
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
                                            aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">


                <!-- User Menu-->
                <li><a class="app-nav__item" href="/logoutController/SignOut"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->

        <div class="app-sidebar__overlay" data-toggle="sidebar"  ></div>
        <aside class="app-sidebar" id="sidebar">
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="/Dashboard"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Dashboard</span></a></li>
                <li><a class="app-menu__item" href="/UserManager"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Manage User</span></a></li>

                <li><a class="app-menu__item" href="/setrole"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Owner Applications</span></a></li>
                <li><a class="app-menu__item" href="/feedbackmanage" style="text-decoration: none;"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Feedback Manage</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><b>Upgrade to owner applications</b></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">                            
                        </div>
                        <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0" id="sampleTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Hotel Name</th>
                                    <th>Hotel Address</th>
                                    <th>Image</th>
                                    <th>Username</th>
                                    <th>Action</th>
                                    <th>Set Status</th>   
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.listupdaterole}" var="i">
                                    <c:set var="st" value="${i.account.is_owner}"/>
                                    <tr>        
                                        <td>${i.id}</td>
                                        <td>${i.hotel_name}</td>
                                        <td>${i.hotel_address}</td>
                                        <td><a href="javascript:void(0)" onclick="showPopup('${i.business_licens_img}')">
                                                <img src="/imgs/owner/${i.business_licens_img}" width="80" height="80" />
                                            </a></td>

                                        <td>${i.account.username}</td>                                     
                                        <td>
                                            <c:if test="${i.status==0}">
                                                <h5>Pending</h5>
                                            </c:if>
                                            <c:if test="${i.status==1}">
                                                <h5>Approved</h5>
                                            </c:if>
                                            <c:if test="${i.status==2}">
                                                <h5 class="text-danger">Cancel</h5>
                                            </c:if>  

                                        </td>
                                        <c:if test="${i.status == 0}">
                                            <td>
                                                <button class="btn btn-primary btn-sm edit" title="Set Role" onclick="doSetRole('${i.account.username}')" type="button" title="Grant of administrative privileges" id="show-emp" data-bs-toggle="modal" >
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-primary btn-sm font-weight-bold" type="button" title="Cancel" onclick="Cancel('${i.account.username}')"  style="background-color: red; border:none; color: #000;"> 
                                                    X
                                                </button>
                                            </td>   
                                        </c:if>
                                    </tr>
                                </c:forEach>                           
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </main>

        <!-- Essential javascripts for application to work-->
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="admin/js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
                                                    $('#sampleTable').DataTable({
                                                        language: {
                                                            // Set language options to English
                                                            "sEmptyTable": "No data available in table",
                                                            "sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
                                                            "sInfoEmpty": "Showing 0 to 0 of 0 entries",
                                                            "sInfoFiltered": "(filtered from _MAX_ total entries)",
                                                            "sInfoPostFix": "",
                                                            "sInfoThousands": ",",
                                                            "sLengthMenu": "Show _MENU_ entries",
                                                            "sLoadingRecords": "Loading...",
                                                            "sProcessing": "Processing...",
                                                            "sSearch": "Search:",
                                                            "sZeroRecords": "No matching records found",
                                                            "oPaginate": {
                                                                "sFirst": "First",
                                                                "sLast": "Last",
                                                                "sNext": "Next",
                                                                "sPrevious": "Previous"
                                                            },
                                                            "oAria": {
                                                                "sSortAscending": ": activate to sort column ascending",
                                                                "sSortDescending": ": activate to sort column descending"
                                                            }
                                                        }
                                                    });
                                                    function showPopup(imageSrc) {
                                                        var popup = document.getElementById('popup');
                                                        var popupImg = document.getElementById('popup-img');
                                                        document.getElementById('sidebar').hidden = true;
                                                        popupImg.src = '/imgs/owner/' + imageSrc;
                                                        popup.style.display = 'block';
                                                    }

                                                    function closePopup() {
                                                        var popup = document.getElementById('popup');
                                                        document.getElementById('sidebar').hidden = false;
                                                        popup.style.display = 'none';
                                                    }

        </script>
        <style>
            .popup {
                display: none;
                position: fixed;
                z-index: 1;
                padding-top: 100px;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;

                overflow: auto;
                background-color: rgba(0,0,0,0.8);
            }

            /* Popup content */
            .popup-content {
                margin: auto;
                display: block;
                width: 80%;
                max-width: 70%;
            }

            /* Close button */
            .close {
                position: absolute;
                top: 2cm;
                right: 2cm;
                color: #fff;
                font-size: 80px;
                font-weight: bold;
                transition: 0.3s;
            }

            .close:hover,
            .close:focus {
                color: #bbb;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
        <div id="popup" class="popup">
            <a class="close" onclick="closePopup()">&times;</a>
            <img class="popup-content" id="popup-img" />
        </div>
    </body>
</html>