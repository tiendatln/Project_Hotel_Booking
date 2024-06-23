<%-- 
    Document   : index
    Created on : Jun 23, 2024, 9:29:08 PM
    Author     : KHA PHAM
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
         <h1>Search Rooms</h1>
    <form action="searchRooms" method="post">
        <input type="text" name="searchString" placeholder="Search..."/>
        <input type="submit" value="Search"/>
           <table border="1">
        <tr>
            <th>Room ID</th>
            <th>Room Name</th>
            <th>Room Price</th>
            <th>Room Status</th>
        </tr>
        <c:forEach var="room" items="${rooms}">
            <tr>
                <td>${room.roomId}</td>
                <td>${room.roomName}</td>
                <td>${room.roomPrice}</td>
                <td>${room.roomStatus ? "Available" : "Not Available"}</td>
            </tr>
        </c:forEach>
    </table>
    </form>
         
    </body>
</html>

