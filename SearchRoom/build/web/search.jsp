<%-- 
    Document   : list
    Created on : Jun 23, 2024, 2:18:06 PM
    Author     : KHA PHAM
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Room</title>
    </head>
    <body>
  <h1>Search Results</h1>
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
    </body>
</html>
