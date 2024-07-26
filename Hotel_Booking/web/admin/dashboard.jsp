<%-- 
    Document   : index
    Created on : Mar 14, 2024, 4:32:54 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản trị Admin</title>
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <!-- or -->
        <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css"
              href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/bootstrap.mim.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css//main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css//font-awesome.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Dynamic data passed from the backend
                const feedbackData = {
                    approved: ${requestScope.confirm},
                    pending: ${requestScope.pending},
                    rejected: ${requestScope.cancel},
                    cancel: ${requestScope.customerCancel}
                };

                // Get context with jQuery - using jQuery's .get() method.
                const ctx = document.getElementById('feedbackStatusChart').getContext('2d');

                // Create a new chart instance
                new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: ['Approved', 'Pending', 'Rejected', 'Cancel'],
                        datasets: [{
                                data: [feedbackData.approved, feedbackData.pending, feedbackData.rejected, feedbackData.cancel],
                                backgroundColor: ['#4caf50', '#007bff', '#f44336', '#ffd700']
                            }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (tooltipItem) {
                                        return tooltipItem.label + ': ' + tooltipItem.raw;
                                    }
                                }
                            }
                        }
                    }
                });
            });
        </script>


    </head>
    <body class="app sidebar-mini rtl">
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
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">

            <hr>
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
                    <li class="breadcrumb-item active"><b>Dashboard</b></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Total Customers</h4>
                                    <p><b>${requestScope.countuser}  Customers</b></p>
                                    <p class="info-tong">Total number of managed Customer.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                                <div class="info">
                                    <h4>Total owners</h4>
                                    <p><b>${requestScope.countowner} Owners</b></p>
                                    <p class="info-tong">Total number of managed Owners.</p>
                                </div>
                            </div>
                        </div>
                        <!-- col-6 -->
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-building-house fa-3x'></i>
                                <div class="info">
                                    <h4>Total Hotels</h4>
                                    <p><b>${requestScope.hotel} Hotels</b></p>
                                    <p class="info-tong">Total number of hotels managed.</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-message-rounded-dots fa-3x'></i>
                                <div class="info">
                                    <h4>Total Feedbacks</h4>
                                    <p><b>${requestScope.feedback} Feedbacks</b></p>
                                    <p class="info-tong">Total number of feedbacks received.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-home-alt-2 fa-3x'></i>
                                <div class="info">
                                    <h4>Total Rooms</h4>
                                    <p><b>${requestScope.room} Rooms</b></p>
                                    <p class="info-tong">Total number of rooms available.</p>
                                </div>
                            </div>
                        </div>

                        <!-- col-6 -->
<!--                        <div class="col-md-6">
                            <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng đơn hàng</h4>
                                    <p><b>${requestScope.bill} đơn hàng</b></p>
                                    <p class="info-tong">Tổng số hóa đơn bán hàng trong tháng.</p>
                                </div>
                            </div>
                        </div>-->
                        <!-- col-6 -->
<!--                        <div class="col-md-6">
                            <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                                <div class="info">
                                    <h4>Sắp hết hàng</h4>
                                    <p><b>${requestScope.low} sản phẩm</b></p>
                                    <p class="info-tong">Số sản phẩm cảnh báo hết cần nhập thêm.</p>
                                </div>
                            </div>
                        </div>-->
                        <div class="col-md-6">
                            <div class="widget-small info coloured-icon">
                                <div class="info">
                                    <h4>Reservation Review Status</h4>
                                    <a>Total Booking: ${requestScope.total}</a>
                                    <canvas id="feedbackStatusChart"></canvas>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="text-center" style="font-size: 13px">
                <p><b>Copyright
                        <script type="text/javascript">
                            document.write(new Date().getFullYear());
                        </script> Hotel Booking System
                    </b></p>
            </div>
        </main>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->

        <!--===============================================================================================-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pace/1.2.4/pace.min.js"></script>
        <!--===============================================================================================-->
        <!--===============================================================================================-->        
    </body>
</html>