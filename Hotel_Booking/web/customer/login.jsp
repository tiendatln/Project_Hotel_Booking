<%-- 
    Document   : login
    Created on : Jun 14, 2024, 3:44:03 PM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%
            Cookie[] cList = null;
            cList = request.getCookies(); //Lay tat ca cookie cua website nay tren may nguoi dung
            if (cList != null) {
                boolean flagCustomer = false;
                boolean flagAdmin = false;
                String value = "";
                for (int i = 0; i < cList.length; i++) {//Duyet qua het tat ca cookie
                    if (cList[i].getName().equals("customer")) {//nguoi dung da dang nhap
                        value = cList[i].getValue();
                        flagCustomer = true;
                        break; //thoat khoi vong lap
                    } else if (cList[i].getName().equals("admin")) {
                        flagAdmin = true;
                        break;
                    }
                }
                if (flagCustomer) {
                    response.sendRedirect("/homeController/HomeCustomer");
                } else if (flagAdmin) {
                    response.sendRedirect("/homeController/HomeAdmin");
                }
            }
        %>
        <div class="container" style="margin-top: 200px">
            <div class="row justify-content-center mt-5">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h2 class="card-title text-center">Login</h2>
                            <form action="/loginController/Home" method="post" >
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" placeholder="Enter username"  name="txtUScus" >
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" placeholder="Enter password"  name="txtPWDcus" >
                                </div>
                                <div class="text-center mt-3 mb-3">
                                    <a href="/registerController/Register">Register new account</a> |
                                    <a href="/customer/recover.jsp">Forgot Password?</a> |
                                    <a href="/registerController/Register">Login with Google</a>
                                </div>
                                <%
                                    String massageUserNull = (String) request.getSession().getAttribute("massageUserNull");
                                    String massagePassNull = (String) request.getSession().getAttribute("massagePassNull");
                                    String massageAllError = (String) request.getSession().getAttribute("massageAllError");
                                %>
                                <div>
                                    <ul>
                                        <% if (massageUserNull != null) {%>
                                        <li class="text-danger">
                                            <span><%= massageUserNull%></span>
                                        </li>
                                        <%
                                                request.getSession().removeAttribute("massageUserNull");
                                            }
                                            if (massagePassNull != null) {%>
                                        <li class="text-danger">
                                            <span><%= massagePassNull%></span>
                                        </li>
                                        <%
                                                request.getSession().removeAttribute("massagePassNull");
                                            }
                                            if (massageAllError != null) {%>
                                        <li class="text-danger">
                                            <span><%= massageAllError%></span>
                                        </li>
                                        <%
                                                request.getSession().removeAttribute("massageAllError");
                                            }%>
                                    </ul>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary btn-block" name="btnLogin">Login</button>
                                </div>
                                <div class="text-center mt-3 mb-3">
                                    <a href="/homeController/HomeCustomer">Home</a> 
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!-- Bootstrap JS and dependencies (Optional) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

