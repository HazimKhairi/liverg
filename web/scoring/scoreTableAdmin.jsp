
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.scoring.bean.Composite" %>
<%@page import="com.scoring.bean.Event" %>
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
    height:100%;
    font-family: "Poppins", sans-serif;
   }
   .banner {
    /*                width: 100%;
                    height: 100vh;
                    background-image: url('registration/assets/img/curved-images/sport8.jpg');
                    background-size: cover;
                    background-position: center;*/
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

   .navbar{
    background-image: url('registration/assets/img/bg-image.jpg');
    background-size: cover;
    background-position: center;
   }

  </style>
 </head>
 <body>


  <div class="banner">

   <nav class="navbar navbar-expand-lg navbar-light"  >
    <div class="container-fluid">
     <a class="navbar-brand fw-bold" href="#">RG SCORING</a>
     <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
     </button>
     <div class="collapse navbar-collapse" id="navbarSupportedContent">
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
      <!--<a class="btn btn-outline-dark fw-bold bg-dark text-white mt-2 fw-bold " style="float:right;font-size:16px"  href="Login" >SIGN IN &nbsp;<i class="fas fa-user"></i></a>-->
     </div>
    </div>
   </nav>


   <% 
                   List<Composite> listGymnast5 = (List<Composite>) request.getAttribute("listScoreboard");
                                   
                          
                             
                            Composite composite5 = (Composite) listGymnast5.get(0); // Assuming ArrayList type
                             String currentGymnastName1 = composite5.getGymnast().get(0).getGymnastName();
                                        
   %>

   <div class="container-fluid bg-dark h-400">
    <div class="py-4 ml-4">
     <h1 class="text-white">SCORE ADMIN DETAILS</h1>    
    </div>

   </div>




   <!--            
               <div class="navbar__ navbar bg-dark" >
                   <ul class="">
                       <li><a href="Login">Login</a></li>
                   </ul>
               </div>-->

   <div class="container-fluid pt-5 " style="padding-bottom:100px;  background-image: url('registration/assets/img/bg-image.jpg');
        background-size: cover;
        background-position: center; " >
    <div class="card"  >
     <div class="card-body" style="border-radius:4px;font-family: 'Poppins', sans-serif;">
          <h1 class=" text-center " style="font-size:25px"><% 
                        List<Event> listEvent = (List<Event>) request.getAttribute("dataEvent") ;
                        out.print(listEvent.get(0).getEventName());
                        %></h1>
      <p class="text-muted text-center" style="font-size:12px">The official Rythmic Gymnastic Ranking.The Most Up To Date Ranking Featuring</p>
      <h5 class="text-center mb-1" style="font-size:15px">Last Update 27 May 2024 - 08:40 pm UTC</h5>
      <h5 class="text-center mb-1" style="font-size:15px"><%= currentGymnastName1%></h5>

      <a class="btn btn-sm btn-dark text-white" href="LiveScoringAdmin?eventID=<%= request.getParameter("eventID")%>">Back To Individual Admin Score</a>
      <!--                        <div class="wrapper" style="display:flex">
                                  <form action="" class="d-flex" method="post">
                                      <select class="form-control mb-3 ml-3" name="gymnastID" style="width:300px">
                                          <option value="0" selected>Filter The Gymnast</option>
      <% 
List<Composite> listGymnast = (List<Composite>) request.getAttribute("listGymnast");
             List<String> listSeenGymnast = new ArrayList<>();
 if (listGymnast != null && !listGymnast.isEmpty()) {
       int x = 0; // Initialize counter variable
 while (x < listGymnast.size()) {
         Composite composite2 = (Composite) listGymnast.get(x); // Assuming ArrayList type
          String currentGymnastName = composite2.getGymnast().get(x).getGymnastName();
                                                        
  if(!listSeenGymnast.contains(currentGymnastName)){
      %>

      <option value="<%= composite2.getGymnast().get(x).getGymnastID()%>"><%= composite2.getGymnast().get(x).getGymnastName()%></option>

      <%
          listSeenGymnast.add(currentGymnastName);
          }
               x++;       
             }
       }

      %>
  </select>
  <select class="form-control mb-3 ml-3" name="teamID" style="width:200px">
      <option value="0" selected>Filter The Team</option>
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
      <option value="<%= composite3.getTeam().get(z).getTeamID()%>"><%= currentTeamName %></option>
      <%
      listSeenTeamNames.add(currentTeamName); // Add name to list for next iteration
    }
    z++;
  }
}
      %>
  </select>

  <select class="form-control mb-3 ml-3" name="apparatusID" style="width:200px">
      <option selected value="0">Filter The Apparatus</option>
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

      <option value="<%= composite4.getApparatus().get(v).getApparatusID()%>"><%= composite4.getApparatus().get(v).getApparatusName()%></option>

      <%
          }
       listSeenApparatusNames.add(currentApparatusName);
               v++;       
             }
       }

      %>
  </select>
  <select class="form-control mb-3 ml-3" name="categoryName" style="width:250px">
      <option value="0" selected>Filter The Category</option>
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

      <option value="<%= composite2.getGymnast().get(t).getGymnastCategory()%>"><%= composite2.getGymnast().get(t).getGymnastCategory()%></option>

      <%
                                             
             }
listSeenCategory.add(currentGymnastCategory);
               t++;  
       }
}
      %>
  </select>



  <button type="submit" name="submit" class="btn btn-primary ml-3" style="height:50px">Filter</button>
</form>
</div>-->


      <div class="table-responsive pt-3 ">
       <div class="center">
        <table class="table mb-5 table-striped text-center" id="table" style="width:100%;max-height:500px;">
         <thead >
          <tr> 
           <th rowspan="2">BIL</th>
           <th rowspan="2">GYMNAST</th>
           <th rowspan="2">CLUB</th>
           <th rowspan="2">APPARATUS</th>
           <th colspan="6">
            DIFFICULTY
           </th>
           <th rowspan="2">
            Total D
           </th>
           <th colspan="4">
            EXECUTION
           </th>
           <th colspan="4">
            ARTISTRY
           </th>
           <th rowspan="2">
            Total D+E+A
           </th>
           <th rowspan="2">PENALTY</th> 
           <th rowspan="2" style="position: sticky; right: 0; z-index: 2;background-color:white">FINAL SCORE</th>
           <!--<th rowspan="2">RANK</th>-->
          </tr>

          <tr>
           <th>D1</th>
           <th>D2</th>
           <th>D1-D2</th>
           <th>D3</th>
           <th>D4</th>
           <th>D3-D4</th>

           <th>A1</th>
           <th>A2</th>
           <th>A3</th>
           <th>10 - A (A)</th>
           <th>E1</th>
           <th>E2</th>
           <th>E3</th>
           <th>10 - E (E)</th>
          </tr>

         </thead>
         <tbody>
          <!--start td-->
          <% 
               List<Composite> listScoreboard = (List<Composite>) request.getAttribute("listScoreboard");
                                                          
                                                          
                                                          
                                if (listScoreboard != null && !listScoreboard.isEmpty()) {
                                 int i = 0; // Initialize counter variable
                                 int rank =1;
                                   while (i < listScoreboard.size()) {
                                     Composite composite = (Composite) listScoreboard.get(i); // Assuming ArrayList type
          %>




          <tr>
           <td ><%= rank %></td>
           <td><%= composite.getGymnast().get(i).getGymnastName()%></td>
           <td><%= composite.getTeam().get(i).getTeamName()%></td>
           <td><%= composite.getApparatus().get(i).getApparatusName()%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreD1())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreD2())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getAverageD1andD2())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreD3())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreD4())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getAverageD3andD4())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).totalScoreD())%></td>

           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreA1()) %></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreA2())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreA3())%></td>
           <td><%= String.format("%.2f",10 - (composite.getScore().get(i).getMiddleAScoreA())) %></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreE1())%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreE2()) %></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getScoreE3()) %></td>
           <td><%= String.format("%.2f",10 - (composite.getScore().get(i).getMiddleEScore()))%></td>
           <td><%= composite.getScore().get(i).getTotalScore()%></td>
           <td><%= String.format("%.2f",composite.getScore().get(i).getTechnicalDeduction())%></td>
           <td class="bg-light" style="position: sticky; right: 0; z-index: 2;"><%= String.format("%.2f",composite.getScore().get(i).getFinalScore()) %></td>
           <!--<td><%= composite.getGymnast().get(i).getGymnastID()%></td>-->
          </tr>
          <%
              i++; // Increment counter
              rank++;                                                  
              }
        }
          %>
          <!--end td-->
         </tbody>
        </table>


       </div>
      </div>
     </div>
    </div>                
   </div>
  </div>


  <script>


//               function sortTableByFinalScore() {
//                                var table = document.getElementById("table");
//                                var tableBody = table.getElementsByTagName('tbody')[0];
//
//                                // Create an array to store data with gymnast information and final score
//                             
//                                var gymnastData = {};
//                                for (var i = 0; i < tableBody.rows.length; i++) {
//
//                                    var row = tableBody.rows[i];
//                                    var gymnastName = row.cells[1].textContent;
//                                    var clubName = row.cells[2].textContent; // Assuming club name is in the 3rd cell
//                                    var apparatusName = row.cells[3].textContent; // Assuming apparatus name is in the 4th cell
//
//                                    // Extract remaining data for each score category (D, E, A)
//                                    var scoreD1 = parseFloat(row.cells[4].textContent);
//                                    var scoreD2 = parseFloat(row.cells[5].textContent);
//                                    var averageD1andD2 = parseFloat(row.cells[6].textContent);
//                                    var scoreD3 = parseFloat(row.cells[7].textContent);
//                                    var scoreD4 = parseFloat(row.cells[8].textContent);
//                                    var averageD3andD4 = parseFloat(row.cells[9].textContent);
//                                    var totalD = parseFloat(row.cells[10].textContent);
//
//                                    var scoreE1 = parseFloat(row.cells[11].textContent);
//                                    var scoreE2 = parseFloat(row.cells[12].textContent);
//                                    var scoreE3 = parseFloat(row.cells[13].textContent);
//                                    var totalE = parseFloat(row.cells[14].textContent);
//
//                                    var scoreA1 = parseFloat(row.cells[15].textContent);
//                                    var scoreA2 = parseFloat(row.cells[16].textContent);
//                                    var scoreA3 = parseFloat(row.cells[17].textContent);
//                                    var totalA = parseFloat(row.cells[18].textContent);
//
//                                    var totalScore = parseFloat(row.cells[19].textContent);
//
//                                    var penalty = parseFloat(row.cells[20].textContent);
//
//                                    var finalScore = parseFloat(row.cells[21].textContent);
//                                    var gymnastID = parseFloat(row.cells[22].textContent);
//
//                                    
//                                    if (!gymnastData[gymnastName]) {
//                                        gymnastData[gymnastName] = {
//                                            name: gymnastName,
//                                            clubName: clubName,
//                                            apparatusName: apparatusName,
//                                            scoreD1: scoreD1,
//                                            scoreD2: scoreD2,
//                                            averageD1andD2: averageD1andD2,
//                                            scoreD3: scoreD3,
//                                            scoreD4: scoreD4,
//                                            averageD3andD4: averageD3andD4,
//                                            totalD: totalD,
//                                            scoreE1: scoreE1,
//                                            scoreE2: scoreE2,
//                                            scoreE3: scoreE3,
//                                            totalE: totalE,
//                                            scoreA1: scoreA1,
//                                            scoreA2: scoreA2,
//                                            scoreA3: scoreA3,
//                                            totalA: totalA,
//                                            totalScore: totalScore,
//                                            penalty: penalty,
//                                            finalScore: finalScore,
//                                            totalFinalScore: 0,
//                                            gymnastID: gymnastID
//                                        };
//                                    }
//                                    gymnastData[gymnastName].totalFinalScore += finalScore;
//                                    // Push data object to the array
////                                    data.push({
////                                        gymnastName: gymnastName,
////                                        clubName: clubName,
////                                        apparatusName: apparatusName,
////                                        scoreD1: scoreD1,
////                                        scoreD2: scoreD2,
////                                        averageD1andD2: averageD1andD2,
////                                        scoreD3: scoreD3,
////                                        scoreD4: scoreD4,
////                                        averageD3andD4: averageD3andD4,
////                                        totalD: totalD,
////                                        scoreE1: scoreE1,
////                                        scoreE2: scoreE2,
////                                        scoreE3: scoreE3,
////                                        totalE: totalE,
////                                        scoreA1: scoreA1,
////                                        scoreA2: scoreA2,
////                                        scoreA3: scoreA3,
////                                        totalA: totalA,
////                                        totalScore: totalScore,
////                                        penalty: penalty,
////                                        FinalScore: FinalScore
////                                    });
//                                }
//                                var sortedGymnastData = Object.values(gymnastData).sort(function (a, b) {
//                                    return a.name.localeCompare(b.name);
//                                });
//                                
//
//                                // Sort the data array by final score (descending order)
////                                data.sort(function (a, b) {
////                                    return b.FinalScore - a.FinalScore;
////                                });
//
//                                // Clear the existing table body (optional)
//                                tableBody.innerHTML = "";
//
//                                // Rebuild the table body with sorted data
//                                for (var i = 0; i < sortedGymnastData.length; i++) {
//                                    var gymnast = sortedGymnastData[i];
//                                    var row = document.createElement("tr");
//
//                                    row.innerHTML = "<td>" + (i + 1) + "</td>" +
//                                            "<td>" + gymnast.name + "</td>" +
//                                            "<td>" + gymnast.clubName + "</td>" +
//                                            "<td>" + gymnast.apparatusName + "</td>" +
//                                            "<td>" + gymnast.scoreD1 + "</td>" +
//                                            "<td>" + gymnast.scoreD2 + "</td>" +
//                                            "<td>" + gymnast.averageD1andD2 + "</td>" +
//                                            "<td>" + gymnast.scoreD3 + "</td>" +
//                                            "<td>" + gymnast.scoreD4 + "</td>" +
//                                            "<td>" + gymnast.averageD3andD4 + "</td>" +
//                                            "<td>" + gymnast.totalD + "</td>" +
//                                            "<td>" + gymnast.scoreE1 + "</td>" +
//                                            "<td>" + gymnast.scoreE2 + "</td>" +
//                                            "<td>" + gymnast.scoreE3 + "</td>" +
//                                            "<td>" + gymnast.totalE + "</td>" +
//                                            "<td>" + gymnast.scoreA1 + "</td>" +
//                                            "<td>" + gymnast.scoreA2 + "</td>" +
//                                            "<td>" + gymnast.scoreA3 + "</td>" +
//                                            "<td>" + gymnast.totalA + "</td>" +
//                                            "<td>" + gymnast.totalScore + "</td>" +
//                                            "<td>" + gymnast.penalty + "</td>" +
//                                            "<td>" + parseFloat(gymnast.finalScore) + "</td>" +
//                                            "<td>" + parseFloat(gymnast.totalFinalScore).toFixed(2) + "</td>";
//                                         
//                                            tableBody.appendChild(row);
//
//                                }
//                                
//                                
//                                
//                            }
//                            sortTableByFinalScore();

//            function sortTableByFinalScore() {
//                var table = document.getElementById("table");
//                var tableBody = table.getElementsByTagName('tbody')[0];
//
//                // Create an array to store data with gymnast information and final score
//                var data = [];
//                for (var i = 0; i < tableBody.rows.length; i++) {
//                   var gymnastName = row.cells[1].textContent;
//                                    var clubName = row.cells[2].textContent; // Assuming club name is in the 3rd cell
//                                    var apparatusName = row.cells[3].textContent; // Assuming apparatus name is in the 4th cell
//
//                                    // Extract remaining data for each score category (D, E, A)
//                                    var scoreD1 = parseFloat(row.cells[4].textContent);
//                                    var scoreD2 = parseFloat(row.cells[5].textContent);
//                                    var averageD1andD2 = parseFloat(row.cells[6].textContent);
//                                    var scoreD3 = parseFloat(row.cells[7].textContent);
//                                    var scoreD4 = parseFloat(row.cells[8].textContent);
//                                    var averageD3andD4 = parseFloat(row.cells[9].textContent);
//                                    var totalD = parseFloat(row.cells[10].textContent);
//
//                                    var scoreE1 = parseFloat(row.cells[11].textContent);
//                                    var scoreE2 = parseFloat(row.cells[12].textContent);
//                                    var scoreE3 = parseFloat(row.cells[13].textContent);
//                                    var totalE = parseFloat(row.cells[14].textContent);
//
//                                    var scoreA1 = parseFloat(row.cells[15].textContent);
//                                    var scoreA2 = parseFloat(row.cells[16].textContent);
//                                    var scoreA3 = parseFloat(row.cells[17].textContent);
//                                    var totalA = parseFloat(row.cells[18].textContent);
//
//                                    var totalScore = parseFloat(row.cells[19].textContent);
//
//                                    var penalty = parseFloat(row.cells[20].textContent);
//
//                                    var finalScore = parseFloat(row.cells[21].textContent);
//                                    var gymnastID = parseFloat(row.cells[22].textContent);
//                                    
//                   data.push({
//                                        gymnastName: gymnastName,
//                                        clubName: clubName,
//                                        apparatusName: apparatusName,
//                                        scoreD1: scoreD1,
//                                        scoreD2: scoreD2,
//                                        averageD1andD2: averageD1andD2,
//                                        scoreD3: scoreD3,
//                                        scoreD4: scoreD4,
//                                        averageD3andD4: averageD3andD4,
//                                        totalD: totalD,
//                                        scoreE1: scoreE1,
//                                        scoreE2: scoreE2,
//                                        scoreE3: scoreE3,
//                                        totalE: totalE,
//                                        scoreA1: scoreA1,
//                                        scoreA2: scoreA2,
//                                        scoreA3: scoreA3,
//                                        totalA: totalA,
//                                        totalScore: totalScore,
//                                        penalty: penalty,
//                                        FinalScore: FinalScore
//                                    });
//                }
//
//                // Sort the data array by final score (descending order)
//                data.sort(function (a, b) {
//                    return b.finalScore - a.finalScore;
//                });
//
//                // Clear the existing table body (optional)
//                tableBody.innerHTML = "";
//
//                // Rebuild the table body with sorted data
//                for (var i = 0; i < data.length; i++) {
//                    var row = document.createElement("tr");
//
//                    row.innerHTML = "<td>" + (i + 1) + "</td>" +
//                            "<td>" + data[i].gymnastName + "</td>" +
//                            "<td>" + data[i].clubName + "</td>" +
//                            "<td>" + data[i].apparatusName + "</td>" +
//                            "<td>" + data[i].scoreD.toFixed(2) + "</td>" +
//                            "<td>" + data[i].scoreA.toFixed(2) + "</td>" +
//                            "<td>" + data[i].scoreE.toFixed(2) + "</td>" +
//                            "<td>" + data[i].totalScore.toFixed(2) + "</td>" +
//                            "<td>" + data[i].penalty.toFixed(2) + "</td>" +
//                            "<td>" + data[i].finalScore.toFixed(2) + "</td>";
//                    tableBody.appendChild(row);
//                }
//            }


//            sortTableByFinalScore();





  </script>
  <!-- End custom js for this page-->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
 </body>

</html>