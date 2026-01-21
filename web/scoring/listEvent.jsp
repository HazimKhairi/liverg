
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.scoring.bean.Event" %>
<%@page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" href="assets/img/favicon.png">
        <link href="registration/vendors/feather/feather.css" rel="stylesheet" type="text/css"/>
        <link href="registration/vendors/ti-icons/css/themify-icons.css" rel="stylesheet" type="text/css"/>
        <link href="registration/vendors/css/vendor.bundle.base.css" rel="stylesheet" type="text/css"/>
        <link href="registration/assets/css/vertical-layout-light/style.css" rel="stylesheet" type="text/css"/>
        <link rel="shortcut icon" href="registration/assets/img/favicon.png" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <title>
            Gymnast Personal Information
        </title>
        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Nucleo Icons -->
        <link href="registration/assets/css/nucleo-icons.css" rel="stylesheet" type="text/css"/>
        <link href="registration/assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
        <!-- Font Awesome Icons -->
        <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
        <link href="registration/assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
        <!-- CSS Files -->
        <link href="registration/assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <style>
            body{
                font-family: "Poppins", sans-serif;
                padding-top: 90px;
            }
            .center {
                text-align: center; /* Center-align content */
            }

            .center th[rowspan], .center img {
                vertical-align: middle; /* Vertically center images and header cells with rowspan */
            }

            /*            .banner {
                            width: 100%;
                            height: 100vh;
                            background-image: url('registration/assets/img/bg-image.jpg');
                            background-size: cover;
                            background-position: center;
                        }*/

            .navbar__ {
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

            .navbar__ ul {
                list-style: none;
                display: flex;
            }

            .navbar__ ul li {
                margin: 0 20px;
                position: relative;
            }

            .navbar__ ul li a {
                text-decoration: none;
                color: #fff;
                text-transform: uppercase;
                font-family: Arial, sans-serif; /* Example font-family */
                font-size: 16px; /* Example font-size */
                font-weight: bold; /* Example font-weight */
            }

            .navbar__ ul li::after {
                content: '';
                height: 3px;
                width: 0;
                background: pink;
                position: absolute;
                left: 0;
                bottom: -10px;
                transition: width 0.5s; /* Apply transition property */
            }

            .navbar__ ul li:hover::after {
                width: 100%;
            }
            .navbar {
                background-image: url('scoring/assets/img/bg-image.jpg');
                background-size: cover;
                background-position: right;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1030;
            }
            td{
                width:50px;
                height:50px;
                font-size:25px;
            }


        </style>
    </head>
    <body>


        <div class="banner" id="banner">
            <nav class="navbar navbar-expand-lg navbar-light" >
                <div class="container-fluid">
                    <a class="navbar-brand fw-bold" href="#">RG SCORING</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="" id="navbarSupportedContent">
                        <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <!--<a class="nav-link active" aria-current="page" href="#">Home</a>-->
                            </li>
                            <li class="nav-item">
                                <!--<a class="nav-link" href="#">Link</a>-->
                            </li>
                            <li class="nav-item dropdown">
                                <!--          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Dropdown
                                          </a>-->
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="#">Action</a></li>
                                    <li><a class="dropdown-item" href="#">Another action</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li><a class="dropdown-item" href="#">Something else here</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <!--<a class="nav-link">Link</a>-->
                            </li>
                        </ul>
                        <a class="btn btn-outline-white fw-bold mt-2 fw-bold " style="float:right;font-size:16px;background-color:black;color:#2F94CE"  href="index.jsp" >SIGN IN &nbsp;<i class="fas fa-user"></i></a>
                    </div>
                </div>
            </nav>



            <div class="container-fluid  h-400" style="background-color:black;">
                <div class="py-4 ml-4">
                    <h1 class="" style="color:#2F94CE;margin-left: 20px">List Event</h1>    

                </div>

            </div>

            <div class="container-fluid">
                <div class="card mt-2" style="background-image: url('assets/img/bg-image.jpg'); width: 100%;
                     background-size: cover;
                     background-position: center;" >
                    <div class="card-body pb-0" style="">

                        <div class="row">
                            <%  
                                List<Event> events = (List<Event>) request.getAttribute("events"); %>

                            <%! 
    public String formatDateString(String dateString) {
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd"); // Adjust to your input format
            SimpleDateFormat outputFormat = new SimpleDateFormat("d MMM yyyy");
            Date date = inputFormat.parse(dateString);
            return outputFormat.format(date);
        } catch (Exception e) {
            return dateString; // Return original if parsing fails
        }
    }
%>
                           <%
    if (events != null && !events.isEmpty()) {
        for (Event event : events) {
%>
    <div class="col-xl-3 col-md-6 col-sm-12">
        <a href="LiveIndividualScore?eventID=<%= event.getEventID() %>" class="text-decoration-none text-dark">
            <div class="card mb-3">
                <div class="card-content">
                    <div class="card-body">
                        <div class="media d-flex">
                            <div class="media-body text-center">
                                <h3 style="font-size:18px;"><%= event.getEventName() %></h3>
                                <span>Event Start: <%= formatDateString(event.getEventDate()) %></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </a>
    </div>
<%
        }
    } else {
%>
    <div class="col-12 text-center py-5">
        <i class="fas fa-calendar-times fa-4x text-muted mb-3"></i>
        <h4>No Events Available</h4>
        <p class="text-muted">There are no events to display at this time.</p>
        <a href="../registration/eventDetails.jsp" class="btn btn-primary mt-2">Create Event</a>
    </div>
<%
    }
%>

                        </div>

                    </div>


                </div>                              


            </div>                
        </div>

        <!-- Footer -->
        <footer class="bg-body-tertiary text-center">
            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
                � 2024 Copyright
                | All Right Reserved
            </div>
            <!-- Copyright -->
        </footer>
        <!-- Footer -->
    </div>


    <!-- End custom js for this page-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

</body>
</html>