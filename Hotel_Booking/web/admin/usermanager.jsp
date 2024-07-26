

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh sách nhân viên | Quản trị Admin</title>
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

        <!-- CSS JS bootstrap 5.0-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

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
                    <li class="breadcrumb-item active"><b>Account Management</b></li>
                </ul>
                <div id="clock"></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">                            

                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>

                                        <th>Username</th> 
                                        <th>Email</th>
                                        <th>Age</th>
                                        <th>Phone</th>
                                        <th>Role</th>
                                        <th>Ban status</th>
                                        <th width="104">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${user}" var="u">
                                        <tr>
<!--                                    <censored-style
                                        censorship-type="visible"
                                        replace-text="*"
                                        replace-repeat="true"
                                        >
                                        <censored><td id="id_number">${u.id_number}</td></censored> 

                                    </censored-style>-->

                                    <td>${u.username}</td>
                                    <td>${u.email}</td>
                                    <td>${u.age}</td>
                                    <td>${u.phone}</td>
                                    <c:if test="${u.is_owner == 1}"> <td>Owner</td> </c:if>
                                    <c:if test="${u.is_owner!=1}"> <td>User</td> </c:if>
                                    <c:if test="${u.ban_status==1}"><td>Ban</td></c:if>
                                    <c:if test="${u.ban_status!=1}"> <td>Normal</td> </c:if> 
                                        <td>
                                            <button class="btn btn-primary btn-sm edit" type="button" title="Set role for account" id="show-emp" data-bs-toggle="modal" data-bs-target="#ModalUP${u.username}">
                                            <i class="fas fa-edit"></i></button>
                                        <button class="btn btn-secondary btn-sm edit" type="button" title="Ban Account" id="show-editor" data-bs-toggle="modal" data-bs-target="#ModalEditor${u.username}">
                                            <i class="fas fa-user-edit"></i>
                                        </button>
                                    </td>
                                    </tr>

                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <c:forEach items="${user}" var="u">           
            <div class="modal fade" id="ModalUP${u.username}" tabindex="-1" role="dialog" aria-hidden="true" data-bs-backdrop="static"
                 data-bs-keyboard="false">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">                  
                        <form method="post" action="/UserManager?action=setowner">
                            <div class="modal-body">                      
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="exampleSelect1" class="control-label">Set Role</label>
                                        <input hidden name="user_id" value="${u.username}">
                                        <select name="check" class="form-control" id="exampleSelect1">
                                            <option value="0" ${u.is_owner eq 0 ? 'selected' : ''}>Customer</option>
                                            <option value="1" ${u.is_owner eq 1 ? 'selected' : ''}>Owner </option>
                                        </select>
                                    </div>
                                </div>
                                <BR>
                                <button class="btn btn-save" type="submit" style="background-color: lightgreen;">Save</button>
                                <a class="btn btn-cancel" data-bs-dismiss="modal" href="#" style="background-color: crimson">Don't save</a>
                                <BR>
                            </div>
                        </form>    
                    </div>
                </div>
            </div>
            <div class="modal fade" id="ModalEditor${u.username}" tabindex="-1" role="dialog" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <form method="post" action="/UserManager?action=ban_status">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="editorSelect" class="control-label">Ban Account</label>
                                        <input type="hidden" name="user_id" value="${u.username}">
                                        <select name="clockaccount" class="form-control" id="editorSelect">
                                            <option value="False" ${u.ban_status eq 0 ? 'selected' : ''}>Unban</option>
                                            <option value="True" ${u.ban_status eq 1 ? 'selected' : ''}>Ban</option>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <button class="btn btn-save" type="submit" style="background-color: lightgreen;">Save</button>
                                <a class="btn btn-cancel" data-bs-dismiss="modal" href="#" style="background-color: crimson;">Don't save</a>
                                <br>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
        <!-- Essential javascripts for application to work-->
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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
        </script>


    </body>
</html>