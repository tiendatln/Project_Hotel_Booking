<%-- 
    Document   : review
    Created on : Jul 20, 2024, 1:16:54 PM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>review</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCic3r4-oNwtB5j-5IVDuPe8k3vyaijOZQ&callback=initMap" async defer></script>
    <style>
        #map {
            height: 500px;
            width: 100%;
        }
    </style>

    <body>
        <%@include file="layout.jsp" %>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <div class="container bootstrap snippets bootdey" style="margin-top: 30px">
            <div class="row">
                
                <div class="post-list">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="picture">
                                <img alt="Opt wizard thumbnail" src="https://bootdey.com/img/Content/user_1.jpg">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <h4>
                                <a hre="#" class="username">Deyson Bejarano</a>
                                <label class="label label-info">#BootdeyFromDeyDey</label>
                            </h4>
                            <h5> 
                                <i class="fa fa-calendar"></i>
                                Aug 06, 12:48 
                            </h5>
                            <p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. In velit lectus, efficitur eu eros vel, luctus aliquet est. Sed sit amet ligula non mauris porta dignissim..</p>    
                        </div>
                        <div class="col-sm-4" data-no-turbolink="">
                            <a class="btn btn-info btn-download btn-round pull-right makeLoading" href="#">
                                <i class="fa fa-share"></i> View
                            </a>            
                        </div>
                    </div>
                </div>
               
            </div>
        </div>
    </body>


    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body{
            margin-top:20px;
        }

        .post-list {
            position: relative;
            padding: 5px 0;
        }

        .post-list .picture {
            max-width: 400px;
            overflow: hidden;
            height: auto;
            border-radius: 6px;
        }

        .post-list .label{
            font-weight:normal;
        }

        .post-list .picture {
            max-width: 210px;
        }

        .post-list .picture img {
            width: 100%;
        }

        .post-list h4 {
            font-size: 20px;
        }

        .post-list h5 {
            color: #888;
        }

        .post-list p {
            float: left;
        }

        .post-list:after {
            height: 1px;
            background: #EEEEEE;
            width: 83.3333%;
            bottom: 0;
            right: 0;
            content: "";
            display: block;
            position: absolute;
        }

        .post-list .btn-download {
            margin-top: 45px;
        }

        .btn-info {
            color: #1084FF;
            border-color: #269abc;
        }

        .btn-round {
            border-width: 1px;
            border-radius: 30px !important;
            opacity: 0.79;
            padding: 9px 18px;
        }
        .btn {
            border-width: 2px;
            background-color: rgba(0,0,0,0);
            font-weight: 400;
            opacity: 0.8;
            padding: 7px 16px;
        }
    </style>
</html>
