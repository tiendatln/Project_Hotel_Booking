<%@page import="Model.account"%>
<%@page import="DAOs.accountDAOs"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <style>
            .form-group {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 20px;
            }

            label {
                width: 100px;
                text-align: right;
                margin-right: 5px;
                margin-left: 5px;
            }

            .sublabel {
                color:gray;
                margin:4px;
                font-size: 11px;
            }

            input[type="text"],
            input[type="date"] {
                padding: 10px;
                font-size: 14px;
            }

            button[type="submit"] {
                padding: 10px 20px;
                background-color: #0050A0;
                border: none;
                cursor: pointer;
            }

            .custom-bg {
                background-color: #F7F7F9;
            }

            .hotel-card {
                margin-top: 20px;
            }
        </style>
    </head>
    <body style="background-color: azure">
        <header>
            <%
                Cookie[] cList = null;
                String value = "";
                boolean flagCustomer = false;
                cList = request.getCookies();
                if (cList != null) {
                    for (int i = 0; i < cList.length; i++) {
                        if (cList[i].getName().equals("customer")) {
                            value = cList[i].getValue();
                            flagCustomer = true;
                            break;
                        }
                    }
                }
            %>
            <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: cadetblue">
                <a class="navbar-brand" href="#">Our Hotel</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link" href="/reservationController/showAll">Your Reservation</a></li>
                        <li class="nav-item nav-item dropdown">
                            <%
                                accountDAOs aDAO = new accountDAOs();
                                account ac = aDAO.getAccount(value);
                            %>
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="bi bi-image"></i>
                                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                </svg>
                                <% if (flagCustomer) { %>
                                    <%= ac.getName() %>
                                <% } else { %>
                                    Account
                                <% } %>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="/loginController/new">Your Profile</a>
                                <div class="dropdown-divider"></div>
                                <% if (flagCustomer) { %>
                                    <a class="dropdown-item" href="/logoutController/SignOut">Sign Out</a>
                                <% } else { %>
                                    <a class="dropdown-item" href="/loginController/login">Login</a>
                                <% } %>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="container mt-5">
                <div id="myCarousel" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    </ol>
                    <div class="carousel-inner container-fluid">
                        <div class="carousel-item active">
                            <img src="/imgs/slide3.jpg" class="d-block w-100" alt="Slide 1" style="height: 500px;">
                        </div>
                        <div class="carousel-item">
                            <img src="/imgs/silde2.jpg" class="d-block w-100" alt="Slide 2" style="height: 500px;">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#myCarousel" data-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </a>
                    <a class="carousel-control-next" href="#myCarousel" data-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </a>
                </div>
            </div>
        </header>
        <div class="container" style="background-color: brown">
            <div class="card custom-bg p-4 d-flex">
                <form id="hotel-form" onsubmit="return validateForm()">
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="validationServer01" class="d-inline-flex">Destination</label>
                            <input type="text" placeholder="City" class="form-control" id="destination" name="destination" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="checkin-date" class=" d-inline-flex">Check-in</label>
                            <input type="date" class="form-control" id="checkin-date" name="checkin-date" onkeydown="return false" required>
                        </div>
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="checkout-date" class=" d-inline-flex">Check-out</label>
                            <input type="date" class="form-control" id="checkout-date" name="checkout-date" onkeydown="return false" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="guests" class="d-inline-flex ">Guests</label>
                            <select class="form-control" id="guests" onchange="javascript: dynamicDropdown(this.options[this.selectedIndex].value);">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                            </select>
                        </div>
                        <div class="form-group col-md align-items-start flex-column">
                            <label for="rooms" class="d-inline-flex ">Room Type</label>
                            <select id="inputState" class="form-control">
                                <option selected>Choose...</option>
                                <option>...</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="text-left col-auto">
                            <button type="submit" class="btn btn-primary">Search hotels</button>
                        </div>
                        <div id="error" class="error text-danger"></div>
                    </div>
                </form>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <!-- Hotel Card 1 -->
                <div class="col-md-4 hotel-card">
                    <div class="card">
                        <img src="/imgs/hotel1.jpg" class="card-img-top" alt="Hotel 1">
                        <div class="card-body">
                            <h5 class="card-title">Hotel Name 1</h5>
                            <p class="card-text">Brief description of the hotel.</p>
                            <a href="#" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <!-- Hotel Card 2 -->
                <div class="col-md-4 hotel-card">
                    <div class="card">
                        <img src="/imgs/hotel2.jpg" class="card-img-top" alt="Hotel 2">
                        <div class="card-body">
                            <h5 class="card-title">Hotel Name 2</h5>
                            <p class="card-text">Brief description of the hotel.</p>
                            <a href="#" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <!-- Hotel Card 3 -->
                <div class="col-md-4 hotel-card">
                    <div class="card">
                        <img src="/imgs/hotel3.jpg" class="card-img-top" alt="Hotel 3">
                        <div class="card-body">
                            <h5 class="card-title">Hotel Name 3</h5>
                            <p class="card-text">Brief description of the hotel.</p>
                            <a href="#" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-auto w-100"></div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            document.getElementById('hotel-form').addEventListener('submit', function (event) {
                var checkin = document.getElementById('checkin-date').value;
                var checkout = document.getElementById('checkout-date').value;
                if (new Date(checkin) >= new Date(checkout)) {
                    alert('Check-out date must be later than check-in date.');
                    event.preventDefault();
                }
            });
        </script>
    </body>
</html>
