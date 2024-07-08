<%-- 
    Document   : reserve
    Created on : Jun 28, 2024, 4:53:03 PM
    Author     : tiend
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Timeline Example</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="stylesheet">
        <link rel="stylesheet" href="css/reserve.css">
    </head>
    <body>
        <%@include file="layout.jsp" %>
        <div class="container px-3 my-5 clearfix">
            <!-- Shopping cart table -->
            <div class="card">
                <div class="card-header">
                    <h2>Shopping Cart</h2>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered m-0">
                            <thead>
                                <tr>
                                    <!-- Set columns width -->
                                    <th class="text-center py-3 px-4" style="min-width: 400px;">Product Name &amp; Details</th>
                                    <th class="text-right py-3 px-4" style="width: 100px;">Price</th>
                                    <th class="text-center py-3 px-4" style="width: 120px;">Quantity</th>
                                    <th class="text-right py-3 px-4" style="width: 100px;">Total</th>
                                    <th class="text-center align-middle py-3 px-0" style="width: 40px;"><a href="#" class="shop-tooltip float-none text-light" title="" data-original-title="Clear cart"><i class="ino ion-md-trash"></i></a></th>
                                </tr>
                            </thead>
                            <tbody>
                                    <%
                                        List<Integer> roomID = (List<Integer>) request.getSession().getAttribute("RoomID");
                                        for (int i = 0; i < roomID.size() -1 ; i++){
                                    %>
                                    <tr>
                                        <td class="p-4">
                                            <div class="media align-items-center">
                                                <div class="media-body">
                                                    <a href="#" class="d-block text-dark"><%= roomID.get(i) %></a>
                                                    <small>
                                                        <span class="text-muted">Color:</span>
                                                        <span class="ui-product-color ui-product-color-sm align-text-bottom" style="background:#e81e2c;"></span> &nbsp;
                                                        <span class="text-muted">Size: </span> EU 37 &nbsp;
                                                        <span class="text-muted">Ships from: </span> China
                                                    </small>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-right font-weight-semibold align-middle p-4">$57.55</td>
                                        <td class="align-middle p-4"><input type="text" class="form-control text-center" value="2"></td>
                                        <td class="text-right font-weight-semibold align-middle p-4">$115.1</td>
                                        <td class="text-center align-middle px-0"><a href="#" class="shop-tooltip close float-none text-danger" title="" data-original-title="Remove">×</a></td>
                                    </tr>
                                    <% 
                                        }
                                    %>

                            </tbody>
                        </table>
                    </div>
                    <!-- / Shopping cart table -->

                    <div class="d-flex flex-wrap justify-content-between align-items-center pb-4">
                        <div class="mt-4">
                            <label class="text-muted font-weight-normal">Promocode</label>
                            <input type="text" placeholder="ABC" class="form-control">
                        </div>
                        <div class="d-flex">
                            <div class="text-right mt-4 mr-5">
                                <label class="text-muted font-weight-normal m-0">Discount</label>
                                <div class="text-large"><strong>$20</strong></div>
                            </div>
                            <div class="text-right mt-4">
                                <label class="text-muted font-weight-normal m-0">Total price</label>
                                <div class="text-large"><strong>$1164.65</strong></div>
                            </div>
                        </div>
                    </div>

                    <div class="float-right">
                        <button type="button" class="btn btn-lg btn-default md-btn-flat mt-2 mr-3">Back to shopping</button>
                        <a href="/reservationController/InfoReserve" class="btn btn-lg btn-primary mt-2">Next Step</a>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

