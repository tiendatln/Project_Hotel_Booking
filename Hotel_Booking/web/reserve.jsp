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
        <div class="container mt-5">
            <h2 class="text-center mb-4">Timeline Example</h2>
            <ul class="timeline">
                <li>
                    <div class="timeline-badge primary"><i class="glyphicon glyphicon-check"></i></div>
                    <div class="timeline-panel">
                        <div class="timeline-heading">
                            <h4 class="timeline-title">Event 1</h4>
                            <p><small class="text-muted"><i class="glyphicon glyphicon-time"></i> 11 hours ago</small></p>
                        </div>
                        <div class="timeline-body">
                            <p>Description of event 1.</p>
                        </div>
                    </div>
                </li>
                <li class="timeline-inverted">
                    <div class="timeline-badge success"><i class="glyphicon glyphicon-check"></i></div>
                    <div class="timeline-panel">
                        <div class="timeline-heading">
                            <h4 class="timeline-title">Event 2</h4>
                            <p><small class="text-muted"><i class="glyphicon glyphicon-time"></i> 12 hours ago</small></p>
                        </div>
                        <div class="timeline-body">
                            <p>Description of event 2.</p>
                        </div>
                    </div>
                </li>
                <!-- Add more events here -->
            </ul>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            // Example script file, can be used for additional interactivity
            document.addEventListener("DOMContentLoaded", function () {
                // Custom JS code here
            });

        </script>
    </body>
</html>

