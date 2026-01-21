
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.scoring.bean.Composite" %>
<%@page import="com.scoring.bean.Event" %>
<%@page import="com.scoring.bean.Judge" %>
<%@page import="java.util.*" %>
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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

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
    font-family: 'Poppins';
   }
   /* Sidebar styles */
   .sidenav {
    overflow-y: auto;
    transition: width 0.3s ease;
    width: 72px; /* Initial width */
    background-color: #fff; /* Sidebar background color */
    box-shadow: 0px 8px 10px rgba(0, 0, 0, 0.1); /* Sidebar shadow */
   }

   .navbar-toggler {
    border: none;
    background: transparent;
    cursor: pointer;
    transition: transform 0.3s ease; /* Smooth transition for the button */
   }

   .navbar-toggler:hover {
    transform: scale(1.1); /* Scale up the button on hover */
   }

   .sidenav:hover {
    width: 250px; /* Expanded width on hover */
   }

   .sidenav-header {
    padding: 15px; /* Padding for the header */
   }

   .navbar-brand {
    display: flex;
    align-items: center;
    padding: 10px;
    margin-bottom: 10px;
   }

   .nav-link {
    padding: 10px;
    transition: padding 0.3s ease;
   }

   /* Adjust padding of individual links on hover */
   .nav-item:hover .nav-link {
    padding: 15px;
   }

   /* Icon styles */
   .icon-shape {
    width: 40px; /* Icon container width */
    height: 40px; /* Icon container height */
    border-radius: 50%; /* Make icon container circular */
    transition: all 0.3s ease;
   }

   /* Expand individual icons on hover */
   .nav-item:hover .icon-shape {
    width: 60px;
    height: 60px;
   }

   /* Active link styles */
   .nav-link.active {
    background-color: #f8f9fe; /* Active link background color */
    color: #5e72e4; /* Active link text color */
    font-weight: 600; /* Bold font weight for active link */
   }

   .nav-link.active .icon-shape {
    background-color: #f8f9fe; /* Active icon background color */
    color: #5e72e4; /* Active icon color */
   }
   .sidebar-toggle-btn {
            display: none; /* Initially hide the toggle button */
        }
   
   
    @media (max-width: 1000.98px) {
        .sidebar-toggle-btn {
        display: block; /* Show the toggle button */
    }
            .sidebar-offcanvas {
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
                position: fixed;
                padding-top: 8px; /* Height of navbar */
                left: 0px;
            }
            .sidebar-offcanvas.show {
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }
            
            
            
        }


  </style>

 </head>

 <body>
  <div class="container-scroller" id="banner">
   <!-- partial:partials/_navbar.html -->
   <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
<!--     <a class="navbar-brand brand-logo mr-5" href=""> <img src="assets/img/curved-images/gymnastLogo.png"
                                                           class="mr-1" alt="logo" /></a>
     <a class="navbar-brand brand-logo-mini" href=""><img src="assets/img/curved-images/miniLogo.png" alt="logo" /></a>-->
    </div>
    <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
     <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
      <span class="icon-menu"></span>
     </button>
        

        
     <ul class="navbar-nav navbar-nav-right">
        <li class="nav-item dropdown">
            <!-- Dropdown menu content -->
        </li>
        <li class="nav-item nav-profile dropdown">
            <div aria-labelledby="profileDropdown">
                <a href="LogoutServlet" class="dropdown-item">
                    <i class="ti-power-off text-primary"></i>
                    Logout
                </a>
            </div>
        </li>
        <li class="nav-item">
            <!-- Sidebar Toggle Button (Font Awesome Icon) -->
            <button class="sidebar-toggle-btn" type="button" data-toggle="sidebar">
                <i class="fas fa-bars"></i> <!-- Font Awesome icon for bars -->
            </button>
        </li>
    </ul>
    </div>
   </nav>
   <!-- partial -->
   <div class="container-fluid page-body-wrapper">
    <!-- partial:partials/_settings-panel.html -->

    <!-- partial:partials/_sidebar.html -->
    <nav class="sidebar sidebar-offcanvas" id="sidebar">
     <ul class="nav">
      <li class="nav-item">
       <a class="nav-link "  href="Score" aria-expanded="false" aria-controls="ui-basic">
        <i class="icon-layout menu-icon"></i>
        <span class="menu-title">Key In Score</span>
        <i class="menu-arrow"></i>
       </a>

      </li>
      <li class="nav-item">
       <a class="nav-link bg-primary" href="EventAdmin" aria-expanded="false" aria-controls="">
        <i class="icon-grid-2 menu-icon"></i>
        <span class="menu-title">Events</span>
        <i class="menu-arrow"></i>
       </a>
      </li>
     </ul>
    </nav>
    <!-- partial -->
    <div class="main-panel">
     <div class="content-wrapper">
      <!--                        <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('registration/assets/img/curved-images/sport8.jpg');">
                                  <span class="mask bg-gradient-dark opacity-0"></span>
                                  <div class="container">
                                      <div class="row justify-content-center">
                                      </div>
                                  </div>
                              </div>-->

      <div class="container-fluid py-4">
       <div class="row">
        <div class="col-12">
         <div class="card mt-2">
          <div class="card-header pb-0">
           <h6>Gymnast Score Information</h6>
          </div>
          <div class="card-body pb-0 container-fluid">
              
           <div class="table-responsive bg-white mt-3 ">


            <table class="table table-striped mb-5 bg-white">
             <thead>
              <tr class="text-center text-white bg-primary" >
               <th>
                No. 
               </th>
               <th>
                Event Name
               </th>
               <th>
                Event Date
               </th>
               <th>
                Action
               </th>
              </tr>
             </thead>

             <!--start row-->
             <%
                                                        
               List<Event> listEvent = (List<Event>) request.getAttribute("events");
                                                          
               if (listEvent != null && !listEvent.isEmpty()) {
                int i = 0; // Initialize counter variable
                int count= 1;
                  while (i < listEvent.size()) {
             %>


             <tr class="text-center fw-bold" style="color:black;font-family: 'Poppins';">
              <td>
               <%= count %>
              </td>
              <td>
               <%= listEvent.get(i).getEventName() %>
              </td>

              <td>
               <%= listEvent.get(i).getEventDate() %>  
              </td>
              
              <td>
                  <a class="btn btn-primary" href="LiveScoringAdmin?eventID=<%= listEvent.get(i).getEventID() %>">View Leaderboard</a>
             
              </td>
             </tr>

             <%
                 i++; // Increment counter
               count++;
                 }
}
             %>

             <!--end row-->

            </table>
           </div>
          </div>
         </div>
        </div>
       </div>
      </div>

      <footer class="footer">
       <div class="d-sm-flex justify-content-center justify-content-sm-between">
        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2024<a href="" target="_blank"></a> Gymnastic Scoring System. All rights reserved.</span>
        <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i></span>
       </div>
      </footer>

     </div>
    </div>
   </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

  <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
  <script>$(document).ready(function() {
    $('.sidebar-toggle-btn').on('click', function() {
        $('.sidebar-offcanvas').toggleClass('show');
    });
});
</script>
  <!--   Core JS Files   -->
  <script src="registration/vendors/js/vendor.bundle.base.js" type="text/javascript"></script>
  <script src="registration/assets/js/core/popper.min.js"></script>
  <script src="registration/assets/js/core/bootstrap.min.js"></script>
  <script src="registration/assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="registration/assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script src="registration/assets/off-canvas.js" type="text/javascript"></script>
  <script src="registration/assets/hoverable-collapse.js" type="text/javascript"></script>
  <script src="registration/assets/template.js" type="text/javascript"></script>
  <script src="registration/assets/settings.js" type="text/javascript"></script>
  <script src="registration/assets/todolist.js" type="text/javascript"></script>


 </body>
</html>


