<%-- 
    Document   : pubDashboard
    Created on : 3 May 2024, 10:34:10 pm
    Author     : 60199
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Public Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
      * {
        margin: 0;
        padding: 0;
        font-family: sans-serif;
    }

    .banner {
        width: 100%;
        height: 100vh;
        background-image: linear-gradient(rgba(0,0,0,0.3),rgba(0,0,0,0.3)),url('assets/img/curved-images/sport8.jpg');
        background-size: cover;
        background-position: center;
    }

    .navbar {
        width: 85%;
        margin: auto;
        padding: 35px 0;
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }

    .logo {
        width: 120px;
        cursor: pointer;
    }

    .navbar ul {
        list-style: none;
        display: flex;
    }

    .navbar ul li {
        margin: 0 20px;
        position: relative;
    }

    .navbar ul li a {
        text-decoration: none;
        color: #fff;
        text-transform: uppercase;
        font-family: Arial, sans-serif; /* Example font-family */
        font-size: 16px; /* Example font-size */
        font-weight: bold; /* Example font-weight */
    }

    .navbar ul li::after {
        content: '';
        height: 3px;
        width: 0;
        background: pink;
        position: absolute;
        left: 0;
        bottom: -10px;
        transition: width 0.5s; /* Apply transition property */
    }

    .navbar ul li:hover::after {
        width: 100%;
    }
    </style>
</head>
<body>
    <div class="banner">
        <div class="navbar">
            <ul>
                <li><a href="publicGymDetails.jsp">Gymnast Details</a></li>
                <li><a href="publicJudgesDetail.jsp">Judge Details</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>
    </div>
</body>
</html>
