<%-- 
    Document   : list-room
    Created on : Jun 24, 2024, 8:54:19 PM
    Author     : Ngo Hong Hai - CE171752
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Room Page</title>
        <!-- Main CSS-->
        <!--<link rel="stylesheet" type="text/css" href="owner/css/main.css">-->
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
        <style>
            body{
                margin-top:20px;
            }
            .cart-item-thumb {
                display: block;
                width: 10rem
            }

            .cart-item-thumb>img {
                display: block;
                width: 100%
            }

            .product-card-title>a {
                color: #222;
            }

            .font-weight-semibold {
                font-weight: 600 !important;
            }

            .product-card-title {
                display: block;
                margin-bottom: .75rem;
                padding-bottom: .875rem;
                border-bottom: 1px dashed #e2e2e2;
                font-size: 1rem;
                font-weight: normal;
            }

            .text-muted {
                color: #888 !important;
            }

            .bg-secondary {
                background-color: #f7f7f7 !important;
            }

            .accordion .accordion-heading {
                margin-bottom: 0;
                font-size: 1rem;
                font-weight: bold;
            }
            .font-weight-semibold {
                font-weight: 600 !important;
            }
        </style>
    </head>
    <body>      

        
        <div class="container pb-5 mt-n2 mt-md-n3">
    <div class="row">
        <div class="col-xl-9 col-md-8">
            <h2 class="h6 d-flex flex-wrap justify-content-between align-items-center px-4 py-3 bg-secondary"><span>Products</span><a class="font-size-sm" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-left" style="width: 1rem; height: 1rem;"><polyline points="15 18 9 12 15 6"></polyline></svg>Continue shopping</a></h2>
            <!-- Item-->
            <div class="d-sm-flex justify-content-between my-4 pb-4 border-bottom">
                <div class="media d-block d-sm-flex text-center text-sm-left">
                    <a class="cart-item-thumb mx-auto mr-sm-4" href="#"><img src="https://www.bootdey.com/image/240x240/FF0000/000000" alt="Product"></a>
                    <div class="media-body pt-3">
                        <h3 class="product-card-title font-weight-semibold border-0 pb-0"><a href="#">Calvin Klein Jeans Keds</a></h3>
                        <div class="font-size-sm"><span class="text-muted mr-2">Size:</span>8.5</div>
                        <div class="font-size-sm"><span class="text-muted mr-2">Color:</span>Black</div>
                        <div class="font-size-lg text-primary pt-2">$125.00</div>
                    </div>
                </div>
                <div class="pt-2 pt-sm-0 pl-sm-3 mx-auto mx-sm-0 text-center text-sm-left" style="max-width: 10rem;">
                    <div class="form-group mb-2">
                        <label for="quantity1">Quantity</label>
                        <input class="form-control form-control-sm" type="number" id="quantity1" value="1">
                    </div>
                    <button class="btn btn-outline-secondary btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-refresh-cw mr-1">
                            <polyline points="23 4 23 10 17 10"></polyline>
                            <polyline points="1 20 1 14 7 14"></polyline>
                            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
                        </svg>Update cart</button>
                    <button class="btn btn-outline-danger btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2 mr-1">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>Remove</button>
                </div>
            </div>
            <!-- Item-->
            <div class="d-sm-flex justify-content-between my-4 pb-4 border-bottom">
                <div class="media d-block d-sm-flex text-center text-sm-left">
                    <a class="cart-item-thumb mx-auto mr-sm-4" href="#"><img src="https://www.bootdey.com/image/240x240/1E90FF/000000" alt="Product"></a>
                    <div class="media-body pt-3">
                        <h3 class="product-card-title font-weight-semibold border-0 pb-0"><a href="#">The North Face Hoodie</a></h3>
                        <div class="font-size-sm"><span class="text-muted mr-2">Size:</span>XL</div>
                        <div class="font-size-sm"><span class="text-muted mr-2">Color:</span>Gray</div>
                        <div class="font-size-lg text-primary pt-2">$134.00</div>
                    </div>
                </div>
                <div class="pt-2 pt-sm-0 pl-sm-3 mx-auto mx-sm-0 text-center text-sm-left" style="max-width: 10rem;">
                    <div class="form-group mb-2">
                        <label for="quantity2">Quantity</label>
                        <input class="form-control form-control-sm" type="number" id="quantity2" value="1">
                    </div>
                    <button class="btn btn-outline-secondary btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-refresh-cw mr-1">
                            <polyline points="23 4 23 10 17 10"></polyline>
                            <polyline points="1 20 1 14 7 14"></polyline>
                            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
                        </svg>Update cart</button>
                    <button class="btn btn-outline-danger btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2 mr-1">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>Remove</button>
                </div>
            </div>
            <!-- Item-->
            <div class="d-sm-flex justify-content-between my-4 pb-4 border-bottom">
                <div class="media d-block d-sm-flex text-center text-sm-left">
                    <a class="cart-item-thumb mx-auto mr-sm-4" href="#"><img src="https://www.bootdey.com/image/240x240/FF8C00/000000" alt="Product"></a>
                    <div class="media-body pt-3">
                        <h3 class="product-card-title font-weight-semibold border-0 pb-0"><a href="#">Medicine Chameleon Sunglasses</a></h3>
                        <div class="font-size-sm"><span class="text-muted mr-2">Lenses:</span>Chameleon</div>
                        <div class="font-size-sm"><span class="text-muted mr-2">Frame:</span>Gray / Black</div>
                        <div class="font-size-lg text-primary pt-2">$47.00</div>
                    </div>
                </div>
                <div class="pt-2 pt-sm-0 pl-sm-3 mx-auto mx-sm-0 text-center text-sm-left" style="max-width: 10rem;">
                    <div class="form-group mb-2">
                        <label for="quantity3">Quantity</label>
                        <input class="form-control form-control-sm" type="number" id="quantity3" value="1">
                    </div>
                    <button class="btn btn-outline-secondary btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-refresh-cw mr-1">
                            <polyline points="23 4 23 10 17 10"></polyline>
                            <polyline points="1 20 1 14 7 14"></polyline>
                            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
                        </svg>Update cart</button>
                    <button class="btn btn-outline-danger btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2 mr-1">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>Remove</button>
                </div>
            </div>
            <!-- Item-->
            <div class="d-sm-flex justify-content-between my-4">
                <div class="media d-block d-sm-flex text-center text-sm-left">
                    <a class="cart-item-thumb mx-auto mr-sm-4" href="#"><img src="https://www.bootdey.com/image/240x240/eeeeee/000000" alt="Product"></a>
                    <div class="media-body pt-3">
                        <h3 class="product-card-title font-weight-semibold border-0 pb-0"><a href="#">Adidas Performance Hat</a></h3>
                        <div class="font-size-sm"><span class="text-muted mr-2">Material:</span>Acrylic</div>
                        <div class="font-size-sm"><span class="text-muted mr-2">Color:</span>Pink / Dark green</div>
                        <div class="font-size-lg text-primary pt-2">$19.00</div>
                    </div>
                </div>
                <div class="pt-2 pt-sm-0 pl-sm-3 mx-auto mx-sm-0 text-center text-sm-left" style="max-width: 10rem;">
                    <div class="form-group mb-2">
                        <label for="quantity4">Quantity</label>
                        <input class="form-control form-control-sm" type="number" id="quantity4" value="1">
                    </div>
                    <button class="btn btn-outline-secondary btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-refresh-cw mr-1">
                            <polyline points="23 4 23 10 17 10"></polyline>
                            <polyline points="1 20 1 14 7 14"></polyline>
                            <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
                        </svg>Update cart</button>
                    <button class="btn btn-outline-danger btn-sm btn-block mb-2" type="button">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2 mr-1">
                            <polyline points="3 6 5 6 21 6"></polyline>
                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                            <line x1="10" y1="11" x2="10" y2="17"></line>
                            <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>Remove</button>
                </div>
            </div>
        </div>
        <!-- Sidebar-->
        <div class="col-xl-3 col-md-4 pt-3 pt-md-0">
            <h2 class="h6 px-4 py-3 bg-secondary text-center">Subtotal</h2>
            <div class="h3 font-weight-semibold text-center py-3">$325.00</div>
            <hr>
            <h3 class="h6 pt-4 font-weight-semibold"><span class="badge badge-success mr-2">Note</span>Additional comments</h3>
            <textarea class="form-control mb-3" id="order-comments" rows="5"></textarea>
            <a class="btn btn-primary btn-block" href="#">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-credit-card mr-2">
                    <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                    <line x1="1" y1="10" x2="23" y2="10"></line>
                </svg>Proceed to Checkout</a>
            <div class="pt-4">
                <div class="accordion" id="cart-accordion">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="accordion-heading font-weight-semibold"><a href="#promocode" role="button" data-toggle="collapse" aria-expanded="true" aria-controls="promocode">Apply promo code<span class="accordion-indicator"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-up"><polyline points="18 15 12 9 6 15"></polyline></svg></span></a></h3>
                        </div>
                        <div class="collapse show" id="promocode" data-parent="#cart-accordion">
                            <div class="card-body">
                                <form class="needs-validation" novalidate="">
                                    <div class="form-group">
                                        <input class="form-control" type="text" id="cart-promocode" placeholder="Promo code" required="">
                                        <div class="invalid-feedback">Please provide a valid promo code!</div>
                                    </div>
                                    <button class="btn btn-outline-primary btn-block" type="submit">Apply promo code</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <h3 class="accordion-heading font-weight-semibold"><a class="collapsed" href="#shipping" role="button" data-toggle="collapse" aria-expanded="true" aria-controls="shipping">Shipping estimates<span class="accordion-indicator"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-up"><polyline points="18 15 12 9 6 15"></polyline></svg></span></a></h3>
                        </div>
                        <div class="collapse" id="shipping" data-parent="#cart-accordion">
                            <div class="card-body">
                                <form class="needs-validation" novalidate="">
                                    <div class="form-group">
                                        <select class="form-control custom-select" required="">
                                            <option value="">Choose your country</option>
                                            <option value="Australia">Australia</option>
                                            <option value="Belgium">Belgium</option>
                                            <option value="Canada">Canada</option>
                                            <option value="Finland">Finland</option>
                                            <option value="Mexico">Mexico</option>
                                            <option value="New Zealand">New Zealand</option>
                                            <option value="Switzerland">Switzerland</option>
                                            <option value="United States">United States</option>
                                        </select>
                                        <div class="invalid-feedback">Please choose your country!</div>
                                    </div>
                                    <div class="form-group">
                                        <select class="form-control custom-select" required="">
                                            <option value="">Choose your city</option>
                                            <option value="Bern">Bern</option>
                                            <option value="Brussels">Brussels</option>
                                            <option value="Canberra">Canberra</option>
                                            <option value="Helsinki">Helsinki</option>
                                            <option value="Mexico City">Mexico City</option>
                                            <option value="Ottawa">Ottawa</option>
                                            <option value="Washington D.C.">Washington D.C.</option>
                                            <option value="Wellington">Wellington</option>
                                        </select>
                                        <div class="invalid-feedback">Please choose your city!</div>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" type="text" placeholder="ZIP / Postal code" required="">
                                        <div class="invalid-feedback">Please provide a valid zip!</div>
                                    </div>
                                    <button class="btn btn-outline-primary btn-block" type="submit">Calculate shipping</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--        <main class="app-content" style="background-color: lightblue">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><b>List Room</b></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href="#" title="Thêm"><i class="fas fa-plus"></i>
                                        Add room</a>
                                </div>                                
                            </div>
                            <form action="#" method="GET">
                                <table class="table table-hover table-bordered" id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th>Room ID</th>
                                            <th>No.room</th>
                                            <th>Room type</th>
                                            <th>Price</th>
                                            <th>Capacity</th>                                            
                                            <th>Description</th>
                                            <th>Status</th>
                                            <th>Image</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${RoomData}" var="room">
                                            <tr>
                                                <td>${room.room_id}</td>
                                                <td>${room.room_name}</td>
                                                <td>${room.room_type.name_type}</td>
                                                <td>${room.room_price}</td>
                                                <td>${room.room_type.room_capacity}</td>
                                                <td>${room.room_type.room_description}</td>
                                                <td>${room.room_status ? 'Ready' : 'Not ready'}</td>                                                
                                                <td><img src="${room.room_img}" alt="" width="100px;"></td>

                                                <td>
                                                    <button class="btn btn-primary btn-sm trash" type="button" title="Xóa" value="${room.room_id}" style="background-color: red; border:none;"><i
                                                            class="fas fa-trash-alt"></i>
                                                    </button>
                                                    <button class="btn btn-primary btn-sm edit" type="button" title="Sửa" id="show-emp"
                                                            data-bs-toggle="modal" data-bs-target="#ModalUP${room.room_id}"><i class="fas fa-edit"></i>
                                                    </button>
                                                </td>
                                            </tr>


                                        </c:forEach>
                                    </tbody>
                                </table>
                            </form>

                            <c:forEach items="${RoomData}" var="room">

                                <form action="#" method="POST">

                                    
                                    MODAL
                                    

                                    <div class="modal fade" id="ModalUP${room.room_id}" tabindex="-1" role="dialog" aria-hidden="true" data-bs-backdrop="static"
                                         data-bs-keyboard="false">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="form-group  col-md-12">
                                                            <span class="thong-tin-thanh-toan">
                                                                <h5>Update room</h5>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Room ID</label>
                                                            <input class="form-control" type="text" readonly name="room_id" value="${room.room_id}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label for="exampleSelect1" class="control-label">Room Type</label>
                                                            <select name="category_id" class="form-control" id="exampleSelect1">
                                                                <option>-- Select room type --</option>
                                                                <c:forEach items="${RoomTypeData}" var="type">
                                                                    <option value="${type.room_type_id}" selected>${type.name_type}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">No.Room</label>
                                                            <input class="form-control" type="text" name="room_name" required value="${room.room_name}">
                                                        </div>
                                                        <div class="form-group col-md-6">
                                                            <label class="control-label">Price</label>
                                                            <input class="form-control" type="number" name="room_price" required value="${room.room_price}" min="0">
                                                        </div>                                                        

                                                                                                                <div class="form-group col-md-6">
                                                                                                                    <label class="control-label">Số lượng</label>
                                                                                                                    <input class="form-control" type="text" name="product_quantity" value="${p.quantity}" min="0">
                                                                                                                </div>
                                                        anh san pham
                                                        <div class="form-group col-md-12">
                                                            <label class="control-label">Room Image</label>
                                                            <div id="myfileupload">
                                                                <input type="file" name="room_img" value="${room.room_img}" onchange="readURL(this);" />
                                                            </div>                                                            
                                                        </div>

                                                                                                                <div class="form-group col-md-6">
                                                                                                                    <label class="control-label">Description</label>
                                                                                                                    <input class="form-control" type="text" name="product_describe" value="${p.product_describe}">
                                                                                                                    <input class="form-control" type="<textarea id="id" name="room_" rows="3" cols="6" value="${room.room_type.room_description}"></textarea>"
                                                                                                                </div>
                                                    </div>
                                                    <BR>
                                                    <button class="btn btn-save" type="submit" style="background-color: lightgreen">Save</button>
                                                    <a class="btn btn-cancel" data-bs-dismiss="modal" href="#" style="background-color: crimson">Cancle</a>
                                                    <BR>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                  MODAL
                                    
                                </form>
                            </c:forEach>

                        </div>
                    </div>
                </div>
            </div>
        </main>-->
    </body>
</html>
