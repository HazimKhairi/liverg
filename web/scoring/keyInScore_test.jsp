
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.scoring.bean.Composite" %>
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
      <li class="nav-item  active">
       <a class="nav-link bg-primary"  href="Score" aria-expanded="false" aria-controls="ui-basic">
        <i class="icon-layout menu-icon"></i>
        <span class="menu-title">Key In Score</span>
        <i class="menu-arrow"></i>
       </a>

      </li>
      <li class="nav-item">
       <a class="nav-link" href="LiveScoringAdmin" aria-expanded="false" aria-controls="tables">
        <i class="icon-grid-2 menu-icon"></i>
        <span class="menu-title">Leaderboard</span>
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
           <form action="" class="row" method="post">
               
               <div class="col-md-3 col-sm-6">
            <select class="form-control mb-3 bg-primary text-white" id="gymnastID" name="gymnastID">
             <option class="bg-white text-dark" value="0" selected>GYMNAST</option>
             <% 
       List<Composite> listGymnast = (List<Composite>) request.getAttribute("listGymnast");
                   List<String> listSeenGymnastNames = new ArrayList<>();
        if (listGymnast != null && !listGymnast.isEmpty()) {
              int x = 0; // Initialize counter variable
        while (x < listGymnast.size()) {
                Composite composite2 = (Composite) listGymnast.get(x); // Assuming ArrayList type
              String currentTeamName = composite2.getGymnast().get(x).getGymnastName();
         if (!listSeenGymnastNames.contains(currentTeamName)) {
             %>

             <option class="bg-white text-dark" value="<%= composite2.getGymnast().get(x).getGymnastID()%>"><%= composite2.getGymnast().get(x).getGymnastName()%></option>

             <%
                 listSeenGymnastNames.add(currentTeamName);
                 }
                      x++;       
                    }
              }

             %>
            </select>
       </div>
            
            <div class="col-md-3 col-sm-6">
            <select class="form-control mb-3 bg-primary text-white" id="teamID" name="teamID" >
             <option class="bg-white text-dark" value="0" selected>TEAM</option>
             <%
               List<Composite> listTeam = (List<Composite>) request.getAttribute("listTeam");
               List<String> listSeenTeamNames = new ArrayList<>(); // Store unique team names

               if (listTeam != null && !listTeam.isEmpty()) {
                 int z = 0;
                 while (z < listTeam.size()) {
                   Composite composite3 = (Composite) listTeam.get(z);
                   String currentTeamName = composite3.getTeam().get(z).getTeamName();

                   if (!listSeenTeamNames.contains(currentTeamName)) {
                     // Display option only if name is not found in the list
             %>
             <option class="bg-white text-dark" value="<%= composite3.getTeam().get(z).getTeamID()%>"><%= currentTeamName %></option>
             <%
             listSeenTeamNames.add(currentTeamName); // Add name to list for next iteration
           }
           z++;
         }
       }
             %>
            </select>
</div>

            <div class="col-md-3 col-sm-6">
            <select class="form-control mb-3  bg-primary text-white" id="apparatusID" name="apparatusID" >
             <option class="bg-white text-dark" selected value="0">APPARATUS</option>
             <% 
                      List<Composite> listApparatus = (List<Composite>) request.getAttribute("listApparatus");  
                      List<String> listSeenApparatusNames = new ArrayList<>();
                                                             
        if (listApparatus != null && !listApparatus.isEmpty()) {
              int v = 0; // Initialize counter variable
                                                      
        while (v < listApparatus.size()) {
        Composite composite4 = (Composite) listApparatus.get(v); // Assuming ArrayList type
                 String currentApparatusName = composite4.getApparatus().get(v).getApparatusName();
        if (!listSeenApparatusNames.contains(currentApparatusName)) {
                                                       
             %>

             <option class="bg-white text-dark" value="<%= composite4.getApparatus().get(v).getApparatusID()%>"><%= composite4.getApparatus().get(v).getApparatusName()%></option>

             <%
                 }
              listSeenApparatusNames.add(currentApparatusName);
                      v++;       
                    }
              }

             %>
            </select>
            </div>
            
            <div class="col-md-3 col-sm-6">
            <select class="form-control mb-3 bg-primary text-white" id="categoryName" id="categoryName" name="categoryName"  style="font-family: 'Poppins'">
             <option class="bg-white text-dark" value="0" selected>CATEGORY</option>
             <% 
       List<Composite> listGymnast2 = (List<Composite>) request.getAttribute("listCategory");
                                   List<String> listSeenCategory = new ArrayList<>();
        if (listGymnast2 != null && !listGymnast2.isEmpty()) {
              int t = 0; // Initialize counter variable
        while (t < listGymnast2.size()) {
                Composite composite2 = (Composite) listGymnast2.get(t); // Assuming ArrayList type
                String currentGymnastCategory = composite2.getGymnast().get(t).getGymnastCategory();
                 if (!listSeenCategory.contains(currentGymnastCategory)) {
             %>

             <option class="bg-white text-dark" value="<%= composite2.getGymnast().get(t).getGymnastCategory()%>"><%= composite2.getGymnast().get(t).getGymnastCategory()%></option>


             <%
                                             
                    }
             listSeenCategory.add(currentGymnastCategory);
                      t++;  
              }
}
             %>
            </select>
</div>
            <!--<button type="submit" name="submit" class="btn btn-primary mx-3" >Filter</button>-->
           </form>

           <% 

      String category = request.getParameter("categoryName");
       String gymnastID = request.getParameter("gymnastID");
       String teamID = request.getParameter("teamID");
                           
       if(category != null){
        if(!category.equals("")){
           %>
           <h5 class="text-center ">Category <%= category %></h5>
           <% }
           }else if(gymnastID != null){
           %>
           <h5 class="text-center ">Category <%= gymnastID %></h5>
           <%
           }else if(teamID != null){
           %>
           <h5 class="text-center ">Category <%= teamID %></h5>
           <%
               }else{
           %>
           <h5 class="text-center">SELECT THE CATEGORY</h5>
           <% }%>


           <%
                                                        
               List<Composite> listScoreboard1 = (List<Composite>) request.getAttribute("listScoreboard");
                                                          
               if (listScoreboard1 != null && !listScoreboard1.isEmpty()) {
                int y = 0; // Initialize counter variable
                                                  
                  while (y < listScoreboard1.size()) {
                    Composite composite2 = (Composite) listScoreboard1.get(y); // Assuming ArrayList type
           %>

           <div class="modal fade" id="addGymnastModal<%= composite2.getGymnast().get(y).getGymnastID() %>" tabindex="-1" aria-labelledby="addGymnastModalLabel" aria-hidden="true">
            <div class="modal-dialog">
             <div class="modal-content">
              <div class="modal-header">
               <h5 class="modal-title" id="addGymnastModalLabel">Gymnast  <%= composite2.getGymnast().get(y).getGymnastName() %> Score</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
               <form id="addGymnastForm" action="updateScore" method="post">    
                <input type="hidden" name="gymnastID" value="<%= composite2.getGymnast().get(y).getGymnastID() %>">
                <input type="hidden" name="apparatusID" value="<%= composite2.getApparatus().get(y).getApparatusID() %>">
                <div class="form-group">
                 <label for="scoreD1" class="col-form-label">Score D1:</label>
                 <input type="number" class="form-control"step=any name="scoreD1" id="email" required>
                </div>

                <div class="form-group">
                 <label for="scoreD1" class="col-form-label">Score D2:</label>
                 <input type="number" class="form-control"step=any name="scoreD2" id="scoreD2" required>
                </div>

                <div class="form-group">
                 <label for="scoreD1" class="col-form-label">Score D3:</label>
                 <input type="number" class="form-control"step=any name="scoreD3" id="scoreD3" required>
                </div>

                <div class="form-group">
                 <label for="scoreD1" class="col-form-label">Score D4:</label>
                 <input type="number" class="form-control"step=any name="scoreD4" id="scoreD4" required>
                </div>

                <hr>
                <div class="form-group">
                 <label for="name" class="col-form-label">Score A1:</label>
                 <input type="number" class="form-control"step=any name="scoreA1" id="name" required>
                </div>
                <div class="form-group">
                 <label for="name" class="col-form-label">Score A2:</label>
                 <input type="number" class="form-control"step=any name="scoreA2" id="name" required>
                </div>
                <div class="form-group">
                 <label for="name" class="col-form-label">Score A3:</label>
                 <input type="number" class="form-control"step=any id="name" name="scoreA3" required>
                </div>

                <hr>
                <div class="form-group">
                 <label for="email" class="col-form-label">Score E1:</label>
                 <input type="number" class="form-control" step=any id="text" name="scoreE1" required>
                </div>
                <div class="form-group">
                 <label for="email" class="col-form-label">Score E2:</label>
                 <input type="number" class="form-control"step=any name="scoreE2" id="scoreE2" required>
                </div>
                <div class="form-group">
                 <label for="email" class="col-form-label">Score E3:</label>
                 <input type="number" class="form-control"step=any name="scoreE3" id="scoreE3" required>
                </div>

                <hr>
                <div class="form-group">
                 <label for="email" class="col-form-label">Penalty:</label>
                 <input type="number" class="form-control" step=any name="technicalDeduction" id="technicalDeduction" required>
                </div>

                <div class="form-group">
                 <label for="email" class="col-form-label">List Judge</label>
                 <select class="form-control text-dark" name="judgeID">
                  <option selected disabled value="">Please Select Judge</option>

                  <%
                            List<Judge> listJudge = (List<Judge>) request.getAttribute("judge");
                                                          
                            if (listJudge != null && !listJudge.isEmpty()) {
                             int x = 0; // Initialize counter variable
                               while (x < listJudge.size()) {
                                 Judge judge = (Judge) listJudge.get(x); // Assuming ArrayList type
                  %>

                  <option value="<%= judge.getJudgeID()%>"><%= judge.getJudgeName()%></option>

                  <%
                         x++; // Increment counter
                     }
               }
                  %>
                 </select>
                </div>

                <div class="form-group">
                 <button type="submit" name="submit" class="btn btn-primary btn-block" >Submit Score</button>

                </div>
               </form>
              </div>
             </div>
            </div>
           </div>
           <%
  y++; // Increment counter
                                                
  }
}
           %>                
           <div class="table-responsive bg-white mt-3 ">


            <table class="table table-striped mb-5 bg-white">
             <thead>
              <tr class="text-center text-white bg-primary" >
               <th>
                ID 
               </th>
               <th >
                Team
               </th>

               <th>
                Name
               </th>
               <th>
                Category
               </th>
               <th>
                Apparatus
               </th>
              </tr>
             </thead>

             <!--start row-->
             <%
                                                        
               List<Composite> listScoreboard = (List<Composite>) request.getAttribute("listScoreboard");
                                                          
               if (listScoreboard != null && !listScoreboard.isEmpty()) {
                int i = 0; // Initialize counter variable
                int count= 1;
                  while (i < listScoreboard.size()) {
                    Composite composite = (Composite) listScoreboard.get(i); // Assuming ArrayList type
             %>


             <tr class="text-center fw-bold" style="color:black;font-family: 'Poppins';">
              <td>
               <%= count %>
              </td>
              <td>
               <%= composite.getTeam().get(i).getTeamName() %>
              </td>

              <td>
               <%= composite.getGymnast().get(i).getGymnastName() %>  </td>
              <td>
               <%= composite.getGymnast().get(i).getGymnastCategory() %>  </td>
              <td>
               <div class="template-demo">
                <a href="#" class="btn btn-primary text-decoration-none" data-bs-toggle="modal" data-bs-target="#addGymnastModal<%= composite.getGymnast().get(i).getGymnastID() %>"><%= composite.getApparatus().get(i).getApparatusName() %></a>
               </div>
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
  <script>

   $("#categoryName").on("change", function () {


    $.ajax({
     type: 'POST',
     data: {
      categoryName: this.value,
      gymnastID: 0,
      teamID: 0,
      apparatusID: 0
     },
     url: 'Score',
     success: function (result) {

//                                               $("#banner").hide();
      $("#banner").html(result);

     }, error: function (jqXHR, textStatus, errorThrown) {
      console.error(jqXHR, textStatus, errorThrown);
      alert("Error retrieving live individual score. Please try again later.");
     }
    }
    )
   })

   $("#apparatusID").on("change", function () {

    $.ajax({
     type: 'POST',
     data: {
      categoryName: "",
      gymnastID: 0,
      teamID: 0,
      apparatusID: this.value
     },
     url: 'Score',
     success: function (result) {

//                                               $("#banner").hide();
      $("#banner").html(result);

     }, error: function (jqXHR, textStatus, errorThrown) {
      console.error(jqXHR, textStatus, errorThrown);
      alert("Error retrieving live individual score. Please try again later.");
     }
    }
    )
   })

   $("#teamID").on("change", function () {

    $.ajax({
     type: 'POST',
     data: {
      categoryName: "",
      gymnastID: 0,
      teamID: this.value,
      apparatusID: 0
     },
     url: 'Score',
     success: function (result) {

//                                               $("#banner").hide();
      $("#banner").html(result);

     }, error: function (jqXHR, textStatus, errorThrown) {
      console.error(jqXHR, textStatus, errorThrown);
      alert("Error retrieving live individual score. Please try again later.");
     }
    }
    )
   })
   $("#gymnastID").on("change", function () {

    $.ajax({
     type: 'POST',
     data: {
      categoryName: "",
      gymnastID: this.value,
      teamID: 0,
      apparatusID: 0
     },
     url: 'Score',
     success: function (result) {

//                                               $("#banner").hide();
      $("#banner").html(result);

     }, error: function (jqXHR, textStatus, errorThrown) {
      console.error(jqXHR, textStatus, errorThrown);
      alert("Error retrieving live individual score. Please try again later.");
     }
    }
    )
   })
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


