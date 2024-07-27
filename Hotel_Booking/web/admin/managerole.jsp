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
        <title>Owner Applications | Admin</title>
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
                    document.getElementById('main').hidden = true;
                    document.getElementById('loading').hidden = false;
                    window.location = "setrole?action=setrole&user=" + username;

                }
            }
        </script>    
        <script type="text/javascript">
            function Cancel(username) {
                if (confirm("Are you should to cancel application?")) {
                    document.getElementById('main').hidden = true;
                    document.getElementById('loading').hidden = false;
                    window.location = "setrole?action=deleteDon&username=" + username;

                }
            }
        </script>
    </head>
    <body class="app sidebar-mini rtl">
        <div id="main">

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
            <aside class="app-sidebar">

                <ul class="app-menu">
                    <li><a class="app-menu__item" href="/Dashboard" style="text-decoration: none;"><i class='app-menu__icon bx bx-tachometer'></i><span
                                class="app-menu__label">Dashboard</span></a></li>
                    <li><a class="app-menu__item" href="/UserManager" style="text-decoration: none;"><i class='app-menu__icon bx bx-user-voice'></i><span
                                class="app-menu__label">Manage User</span></a></li>

                    <li><a class="app-menu__item" href="/setrole" style="text-decoration: none;"><i class='app-menu__icon bx bx-task'></i><span
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
                            <div class="tile-body"></div>
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
        </div>
        <div id="loading" hidden="" >
            <div class="typewriter ">

                <div class="slide"><i></i></div>
                <div class="paper"></div>
                <div class="keyboard"></div>
                <h1>
                    Email is sending...
                </h1>
            </div>

        </div>
        <div id="popup" class="popup">
            <a class="close" onclick="closePopup()">&times;</a>
            <img class="popup-content" id="popup-img" />
        </div>

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
                    popupImg.src = '/imgs/owner/' + imageSrc;
                    popup.style.display = 'block';
                }

                function closePopup() {
                    var popup = document.getElementById('popup');
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

            #loading{
                display:flex;
                justify-content:center;
                align-items:center;
                height:100vh
            }
            .typewriter {
                --blue: #5C86FF;
                --blue-dark: #275EFE;
                --key: #fff;
                --paper: #EEF0FD;
                --text: #D3D4EC;
                --tool: #FBC56C;
                --duration: 1.8s;
                align-items: center;
                justify-content: center;
                position: relative;
                -webkit-animation: bounce05 var(--duration) linear infinite;
                animation: bounce05 var(--duration) linear infinite;
            }

            .typewriter .slide {
                width: 92px;
                height: 20px;
                border-radius: 3px;
                margin-left: 14px;
                transform: translateX(14px);
                background: linear-gradient(var(--blue), var(--blue-dark));
                -webkit-animation: slide05 var(--duration) ease infinite;
                animation: slide05 var(--duration) ease infinite;
            }

            .typewriter .slide:before, .typewriter .slide:after,
            .typewriter .slide i:before {
                content: "";
                position: absolute;
                background: var(--tool);
            }

            .typewriter .slide:before {
                width: 2px;
                height: 8px;
                top: 6px;
                left: 100%;
            }

            .typewriter .slide:after {
                left: 94px;
                top: 3px;
                height: 14px;
                width: 6px;
                border-radius: 3px;
            }

            .typewriter .slide i {
                display: block;
                position: absolute;
                right: 100%;
                width: 6px;
                height: 4px;
                top: 4px;
                background: var(--tool);
            }

            .typewriter .slide i:before {
                right: 100%;
                top: -2px;
                width: 4px;
                border-radius: 2px;
                height: 14px;
            }

            .typewriter .paper {
                position: absolute;
                left: 24px;
                top: -26px;
                width: 40px;
                height: 46px;
                border-radius: 5px;
                background: var(--paper);
                transform: translateY(46px);
                -webkit-animation: paper05 var(--duration) linear infinite;
                animation: paper05 var(--duration) linear infinite;
            }

            .typewriter .paper:before {
                content: "";
                position: absolute;
                left: 6px;
                right: 6px;
                top: 7px;
                border-radius: 2px;
                height: 4px;
                transform: scaleY(0.8);
                background: var(--text);
                box-shadow: 0 12px 0 var(--text), 0 24px 0 var(--text), 0 36px 0 var(--text);
            }

            .typewriter .keyboard {
                width: 120px;
                height: 56px;
                margin-top: -10px;
                z-index: 1;
                position: relative;
            }

            .typewriter .keyboard:before, .typewriter .keyboard:after {
                content: "";
                position: absolute;
            }

            .typewriter .keyboard:before {
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                border-radius: 7px;
                background: linear-gradient(135deg, var(--blue), var(--blue-dark));
                transform: perspective(10px) rotateX(2deg);
                transform-origin: 50% 100%;
            }

            .typewriter .keyboard:after {
                left: 2px;
                top: 25px;
                width: 11px;
                height: 4px;
                border-radius: 2px;
                box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                -webkit-animation: keyboard05 var(--duration) linear infinite;
                animation: keyboard05 var(--duration) linear infinite;
            }

            @keyframes bounce05 {
                85%, 92%, 100% {
                    transform: translateY(0);
                }

                89% {
                    transform: translateY(-4px);
                }

                95% {
                    transform: translateY(2px);
                }
            }

            @keyframes slide05 {
                5% {
                    transform: translateX(14px);
                }

                15%, 30% {
                    transform: translateX(6px);
                }

                40%, 55% {
                    transform: translateX(0);
                }

                65%, 70% {
                    transform: translateX(-4px);
                }

                80%, 89% {
                    transform: translateX(-12px);
                }

                100% {
                    transform: translateX(14px);
                }
            }

            @keyframes paper05 {
                5% {
                    transform: translateY(46px);
                }

                20%, 30% {
                    transform: translateY(34px);
                }

                40%, 55% {
                    transform: translateY(22px);
                }

                65%, 70% {
                    transform: translateY(10px);
                }

                80%, 85% {
                    transform: translateY(0);
                }

                92%, 100% {
                    transform: translateY(46px);
                }
            }

            @keyframes keyboard05 {
                5%, 12%, 21%, 30%, 39%, 48%, 57%, 66%, 75%, 84% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                9% {
                    box-shadow: 15px 2px 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                18% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 2px 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                27% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 12px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                36% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 12px 0 var(--key), 60px 12px 0 var(--key), 68px 12px 0 var(--key), 83px 10px 0 var(--key);
                }

                45% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 2px 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                54% {
                    box-shadow: 15px 0 0 var(--key), 30px 2px 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                63% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 12px 0 var(--key);
                }

                72% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 2px 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 10px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }

                81% {
                    box-shadow: 15px 0 0 var(--key), 30px 0 0 var(--key), 45px 0 0 var(--key), 60px 0 0 var(--key), 75px 0 0 var(--key), 90px 0 0 var(--key), 22px 10px 0 var(--key), 37px 12px 0 var(--key), 52px 10px 0 var(--key), 60px 10px 0 var(--key), 68px 10px 0 var(--key), 83px 10px 0 var(--key);
                }
            }
        </style>

    </body>
</html>