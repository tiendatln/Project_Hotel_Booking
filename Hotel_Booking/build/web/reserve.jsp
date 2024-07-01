<%-- 
    Document   : reserve
    Created on : Jun 28, 2024, 4:53:03 PM
    Author     : tiend
--%>

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
        <h2>Reserve Room</h2>
    <form action="insert" method="post">
        <input type="hidden" name="room_id" value="${param.room_id}" />
        <label for="customer_name">Name:</label>
        <input type="text" id="customer_name" name="customer_name" required>
        <br>
        <label for="customer_email">Email:</label>
        <input type="email" id="customer_email" name="customer_email" required>
        <br>
        <label for="check_in">Check-In Date:</label>
        <input type="date" id="check_in" name="check_in" required>
        <br>
        <label for="check_out">Check-Out Date:</label>
        <input type="date" id="check_out" name="check_out" required>
        <br>
        <input type="submit" value="Reserve">
    </form>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

