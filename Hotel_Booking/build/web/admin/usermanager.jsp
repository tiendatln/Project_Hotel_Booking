

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
                <li><a class="app-nav__item" href="home"><i class='bx bx-log-out bx-rotate-180'></i> </a>

                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="admin/images/user.png" width="50px"
                                                alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><b>${sessionScope.account.username}</b></p>
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="dashboard" style="text-decoration: none;"><i class='app-menu__icon bx bx-tachometer'></i><span
                            class="app-menu__label">Control</span></a></li>
                <li><a class="app-menu__item" href="usermanager" style="text-decoration: none;"><i class='app-menu__icon bx bx-user-voice'></i><span
                            class="app-menu__label">Manage User</span></a></li>
                <li><a class="app-menu__item" href="productmanager" style="text-decoration: none;"><i
                            class='app-menu__icon bx bx-purchase-tag-alt'></i><span class="app-menu__label">Quản lý sản phẩm</span></a>
                </li>
                <li><a class="app-menu__item" href="ordermanager" style="text-decoration: none;"><i class='app-menu__icon bx bx-task'></i><span
                            class="app-menu__label">Quản lý đơn hàng</span></a></li>
            </ul>
        </aside>


        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><b>Danh sách người dùng</b></li>
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
                                        <th>ID khách hàng</th>
                                        <th>Tên khách hàng</th> 
                                        <th>Email</th>
                                        <th>Age</th>
                                        <th>Phone</th>
                                        <th>isOwner</th>
                                        <th>Ban_status</th>
                                        <th width="104">Tính năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.user}" var="u">
                                        <tr>
                                            <td>${u.id_number}</td>
                                            <td>${u.username}</td>
                                            <td>${u.email}</td>
                                            <td>${u.age}</td>
                                            <td>${u.phone}</td>
                                            <c:if test="${u.owner==true}"> <td>Owner</td> </c:if>
                                            <c:if test="${u.owner!=true}"> <td>User</td> </c:if>
                                            <c:if test="${u.ban_status==true}"><td>Lock</td></c:if>
                                            <c:if test="${u.ban_status!=true}"> <td>Normal</td> </c:if> 
                                            <td>
                                                <button class="btn btn-primary btn-sm edit" type="button" title="Grant of administrative privileges" id="show-emp" data-bs-toggle="modal" data-bs-target="#ModalUP${u.id_number}">
                                                    <i class="fas fa-edit"></i></button>
                                                <button class="btn btn-secondary btn-sm edit" type="button" title="Lock Account" id="show-editor" data-bs-toggle="modal" data-bs-target="#ModalEditor${u.id_number}">
                                                    <i class="fas fa-user-edit"></i>
                                                </button>
                                                <button class="btn btn-primary btn-sm trash" type="button" title="Xóa" value="${u.id_number}" style="background-color: red; border:none;"><i
                                                        class="fas fa-trash-alt"></i>
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
        <c:forEach items="${requestScope.user}" var="u">           
            <div class="modal fade" id="ModalUP${u.id_number}" tabindex="-1" role="dialog" aria-hidden="true" data-bs-backdrop="static"
                 data-bs-keyboard="false">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">                  
                        <form method="post" action="usermanager?action=setowner">
                            <div class="modal-body">                      
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="exampleSelect1" class="control-label">Add Manage</label>
                                        <input hidden name="user_id" value="${u.id_number}">
                                        <select name="check" class="form-control" id="exampleSelect1">
                                            <option value="0">Cancel</option>
                                            <option value="1">Accept </option>
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
            <div class="modal fade" id="ModalEditor${u.id_number}" tabindex="-1" role="dialog" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <form method="post" action="usermanager?action=ban_status">
                            <div class="modal-body">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="editorSelect" class="control-label">Clock Account</label>
                                        <input type="hidden" name="user_id" value="${u.id_number}">
                                        <select name="clockaccount" class="form-control" id="editorSelect">
                                            <option value="False">Cancel</option>
                                            <option value="True">Accept</option>
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
        <script type="text/javascript">$('#sampleTable').DataTable();</script>           
        <script>

            $(document).ready(jQuery(function () {
                jQuery(".trash").click(function () {
                    swal({
                        title: "Cảnh báo",
                        text: "Bạn có chắc chắn là muốn xóa account này?",
                        buttons: ["Hủy bỏ", "Đồng ý"],
                    })
                            .then((willDelete) => {
                                if (willDelete) {
                                    window.location = "usermanager?action=deleteaccount&id_number=" + $(this).attr("value");
                                    swal("Đã xóa thành công.", {
                                    });
                                }
                            });
                });
            }));
        </script>    
    </body>
</html>
