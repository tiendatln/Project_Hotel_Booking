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
</head>
<body>
    <%@include file="layout.jsp" %>
    <h3>Google Maps Example</h3>
    <div id="map"></div>
    <script>
        function initMap() {
            // Địa chỉ bạn muốn hiển thị
            const address = "1600 Amphitheatre Parkway, Mountain View, CA";

            // Tạo đối tượng Geocoder
            const geocoder = new google.maps.Geocoder();

            // Geocode địa chỉ
            geocoder.geocode({ 'address': address }, function(results, status) {
                if (status === 'OK') {
                    // Tạo bản đồ và thiết lập vị trí trung tâm theo kết quả geocode
                    const map = new google.maps.Map(document.getElementById('map'), {
                        zoom: 15,
                        center: results[0].geometry.location
                    });

                    // Thêm marker vào vị trí trung tâm
                    new google.maps.Marker({
                        map: map,
                        position: results[0].geometry.location
                    });
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
    </script>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
</html>
