
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
                    <h1 class="" style="color:#2F94CE;margin-left: 20px">Rankings</h1>    

                </div>

            </div>


            <!--                        <div class="navbar__ navbar bg-dark" >
                                        <ul class="">
                                            <li><a href="Login">SIGN IN <i class="fas fa-fw fa-people"></i></a></li>
                                        </ul>
                                    </div>-->

            <div class="container-fluid">
                <div class="card mt-2" style="background-image: url('scoring/assets/img/bg-image.jpg'); width: 100%;
                     background-size: cover;
                     background-position: center;" >
                    <div class="card-body pb-0" style="">
                        <a class="btn btn-sm btn-dark text-white" href="ListEvent">Back To Event</a>
                        <form action="LiveIndividualScore" class="mt-4 " method="post">
                            <div class="d-flex mx-auto justify-content-center flex-wrap">

                                <div class="col-sm-6 col-md-4 mb-3 justify-content-center d-flex">

                                    <select class="form-control mb-3 ml-3 text-white fw-600" name="gymnastID" id="gymnastID" style="background-color:#2F94CE; width:200px;">
                                        <option class="bg-white text-dark " style=""  value="0" hidden selected>GYMNAST</option>
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

                                        <option class="bg-white text-dark" value="<%= composite2.getGymnast().get(x).getGymnastID()%>"><%= composite2.getGymnast().get(x).getGymnastName()%></option>

                                        <%
                                            listSeenGymnast.add(currentGymnastName);
                                            }
                                                 x++;       
                                               }
                                         }

                                        %>
                                    </select>

                                </div>

                                <div class="col-sm-6 mb-3 col-md-4 justify-content-center d-flex">
                                    <select class="form-control mb-3 ml-3  text-white" name="teamID" id="teamID" style="width:200px;font-family: 'Poppins';background-color:#2F94CE;">
                                        <option class="bg-white text-dark" value="0" hidden selected>TEAM</option>
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

                                <!--                                <select class="form-control mb-3 ml-3 bg-dark text-white " name="apparatusID" id="apparatusID" style="width:200px;font-family: 'Poppins'">
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
                            </select>-->
                                <div class="col-sm-6 mb-3 col-md-4 justify-content-center d-flex">
                                    <select class="form-control mb-3 ml-3  text-white" id="categoryName" id="categoryName" name="categoryName"  style="background-color:#2F94CE;width:200px;font-family: 'Poppins'">
                                        <option class="bg-white text-dark" value="0" hidden selected>CATEGORY</option>
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

                            </div>
                            <!--                            <div class="d-flex align-items-center  justify-content-center">
                                                            <button type="submit" name="submit" class="btn btn-primary ml-3" style="height:50px;width:20%;">FILTER</button>    
                                                        </div>-->

                        </form>

                    </div>
                    <hr>                                

                    <h1 class=" text-center " style="font-size:25px"><% 
                        List<Event> listEvent = (List<Event>) request.getAttribute("dataEvent") ;
                        out.print(listEvent.get(0).getEventName());
                        %></h1>
                    <p class="text-muted text-center" style="font-size:12px">The official Rythmic Gymnastic Ranking.The Most Up To Date Ranking Featuring</p>

                    <h5 class="text-center mb-1" style="font-size:15px">Last Update <%=  request.getAttribute("datetime") %></h5>




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


                    <div class="wrapper" style="display:flex">
                        <div class="table-responsive bg-white mt-3 ">
                            <div class="center">
                                <table class="table table-striped mb-5 bg-white" id="sourceTable" style="width:100%;max-height:500px;">
                                    <thead>
                                        <tr >
                                            <th >GymnastID</th>
                                            <th>GYMNAST</th>
                                            <th>CLUB</th>
                                            <th>FREE</th>
                                            <th>RIBBON</th>
                                            <th>HOOP</th>
                                            <th>BALL</th>
                                            <th>CLUBS</th>
                                            <th>INDIVIDUAL SCORE</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 
                                          List<Composite> listScoreboard = (List<Composite>) request.getAttribute("listScoreboard");
                                          Map<String, Double> individualScores = new HashMap<>();
                                          List<String> listSeenGymnastScore = new ArrayList<>();

                                          if (listScoreboard != null && !listScoreboard.isEmpty()) {
                                            int i = 0; // Initialize counter variable
                                            int rank = 1;
                                            while (i < listScoreboard.size()) {
                                              Composite composite = (Composite) listScoreboard.get(i); 
                                              String currentGymnastScore = composite.getGymnast().get(i).getGymnastName();
                                              String gymnastName = composite.getGymnast().get(i).getGymnastName();
                                              double finalScore = composite.getScore().get(i).getFinalScore();
                                              boolean gymnastShown = individualScores.containsKey(gymnastName);
                                              Double currentIndividualScore = individualScores.get(gymnastName);
                                              individualScores.put(gymnastName, currentIndividualScore == null ? finalScore : currentIndividualScore + finalScore);
                              //                                              if (!listSeenGymnastScore.contains(currentGymnastScore)) {
                                        %>

                                        <tr>
                                            <td><%= composite.getGymnast().get(i).getGymnastID()%></td>
                                            <td><%= composite.getGymnast().get(i).getGymnastName()%></td>
                                            <td><%= composite.getTeam().get(i).getTeamName()%></td>

                                            <% if(composite.getApparatus().get(i).getApparatusName().equals("Free Hand")){%>
                                            <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                            <% }else{%>
                                            <td></td>
                                            <% }%>

                                            <% if(composite.getApparatus().get(i).getApparatusName().equals("Ribbon")){ %>
                                            <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                            <% }else{%>
                                            <td></td>
                                            <% } %>

                                            <% if(composite.getApparatus().get(i).getApparatusName().equals("Hoop")){ %>
                                            <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                            <% }else{%>
                                            <td></td>
                                            <% }%>

                                            <% if(composite.getApparatus().get(i).getApparatusName().equals("Ball")){ %>
                                            <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                            <% }else{ %>
                                            <td></td>
                                            <% } %>

                                            <% if(composite.getApparatus().get(i).getApparatusName().equals("Clubs")){ %>
                                            <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>
                                            <% }else{ %>
                                            <td></td>
                                            <% } %>

                                            <td><%= String.format("%.3f", composite.getScore().get(i).getFinalScore()) %></td>

                                            <td><a href="LiveScoring?gymnastID='" <%= composite.getGymnast().get(i).getGymnastID()%> >info > </a></td>
                                        </tr>

                                        <%
                              //                                          listSeenGymnastScore.add(currentGymnastScore);
                              //                                      }
                                      i++; // Increment counter
                                      rank++;
                                    }
                                  }
                                        %>
                                    </tbody>
                                </table>


                                <table class="table table-hover mb-5"  id="resultTable" style="width:100%;max-height:500px;">
                                    <thead>
                                        <tr class="text-white"  style="background-color:#2F94CE;">
                                            <th class="h-100">RANK</th>
                                            <th>GYMNAST</th>
                                            <th>TEAM</th>
                                            <th>FREE</th>
                                            <th>RIBBON</th>
                                            <th>HOOP</th>
                                            <th>BALL</th>
                                            <th>CLUBS</th>
                                            <th style="position: sticky; right: 0; background-color: #2F94CE; z-index: 2;">INDIVIDUAL SCORE</th>
                                            <th>ACTION</th>
                                        </tr>
                                    </thead>
                                    <tbody style="color:black;font-weight: bold"></tbody>
                                </table>

                                <script>

                                    function rankingTable() {

                                        const sourceTable = document.getElementById('sourceTable');
                                        const resultTableBody = document.getElementById('resultTable').getElementsByTagName('tbody')[0];

                                        // Function to calculate gymnast score (can be modified based on your table structure)
                                        function getGymnastScore(row) {
                                            const gymnastScoreCell = row.getElementsByTagName('td')[8]; // Assuming score is in 3rd column (index 2)
                                            return parseFloat(gymnastScoreCell.innerText);
                                        }

                                        // Function to get gymnast ID (modify based on your table structure)
                                        function getGymnastID(row) {
                                            const gymnastIDCell = row.getElementsByTagName('td')[0]; // Assuming ID is in 1st column (index 0)
                                            return gymnastIDCell.innerText;
                                        }

                                        // Extract and accumulate data from source table
                                        const gymnastData = {};
                                        for (const row of sourceTable.getElementsByTagName('tr')) {
                                            if (row.rowIndex === 0)
                                                continue; // Skip header row
                                            const gymnastName = row.getElementsByTagName('td')[1].innerText;
                                            const clubName = row.getElementsByTagName('td')[2].innerText;
                                            const score = getGymnastScore(row);
                                            const gymnastID = getGymnastID(row);
                                            const freeScore = row.getElementsByTagName('td')[3].innerText;
                                            const ribbonScore = row.getElementsByTagName('td')[4].innerText;
                                            const hoopScore = row.getElementsByTagName('td')[5].innerText;
                                            const ballScore = row.getElementsByTagName('td')[6].innerText;
                                            const clubsScore = row.getElementsByTagName('td')[7].innerText;

                                            console.log(clubsScore);

                                            // Check if gymnast exists in gymnastData
                                            if (!gymnastData.hasOwnProperty(gymnastName)) {
                                                gymnastData[gymnastName] = {gymnastName, clubName, gymnastID, freeScore: 0, ribbonScore: 0, hoopScore: 0, ballScore: 0, clubsScore: 0, score: 0};
                                            }

                                            // Accumulate score for existing gymnast
                                            gymnastData[gymnastName].score += score;
                                            gymnastData[gymnastName].freeScore += freeScore;
                                            gymnastData[gymnastName].ribbonScore += ribbonScore;
                                            gymnastData[gymnastName].hoopScore += hoopScore;
                                            gymnastData[gymnastName].ballScore += ballScore;
                                            gymnastData[gymnastName].clubsScore += clubsScore;
                                        }

                                        // Convert gymnastData object to array and sort
                                        const gymnastDataArray = Object.values(gymnastData);
                                        gymnastDataArray.sort((a, b) => b.score - a.score);

                                        // Generate ranking and populate result table
                                        let rank = 1;
                                        for (const gymnast of gymnastDataArray) {
                                            const tableRow = document.createElement('tr');
                                            const rankCell = document.createElement('td');
                                            rankCell.innerText = rank++;

                                            const gymnastNameCell = document.createElement('td');
                                            gymnastNameCell.innerText = gymnast.gymnastName;

                                            const clubNameCell = document.createElement('td');
                                            clubNameCell.innerText = gymnast.clubName;


                                            const freeCell = document.createElement('td');
                                            if (parseFloat(gymnast.freeScore).toFixed(2) == 0.00) {
                                                freeCell.innerText = "";
                                            } else {
                                                freeCell.innerText = parseFloat(gymnast.freeScore).toFixed(2);
                                            }

                                            const ropeCell = document.createElement('td');
                                            if (parseFloat(gymnast.ribbonScore).toFixed(2) == 0.00) {
                                                ropeCell.innerText = "";
                                            } else {
                                                ropeCell.innerText = parseFloat(gymnast.ribbonScore).toFixed(2);
                                            }

                                            const hoopCell = document.createElement('td');
                                            if (parseFloat(gymnast.hoopScore).toFixed(2) == 0.00) {
                                                hoopCell.innerText = "";
                                            } else {
                                                hoopCell.innerText = parseFloat(gymnast.hoopScore).toFixed(2);
                                            }

                                            const ballCell = document.createElement('td');
                                            if (parseFloat(gymnast.ballScore).toFixed(2) == 0.00) {
                                                ballCell.innerText = "";
                                            } else {
                                                ballCell.innerText = parseFloat(gymnast.ballScore).toFixed(2);
                                            }

                                            const clubsCell = document.createElement('td');
                                            if (parseFloat(gymnast.clubsScore).toFixed(2) == 0.00) {
                                                clubsCell.innerText = "";
                                            } else {
                                                clubsCell.innerText = parseFloat(gymnast.clubsScore).toFixed(2);
                                            }

                                            let eventID = document.getElementById("eventID").value;

                                            const scoreCell = document.createElement('td');
                                            scoreCell.style.position = 'sticky';
                                            scoreCell.style.right = '0';
                                            scoreCell.style.backgroundColor = 'white';
                                            scoreCell.style.zIndex = '2';
                                            const scoreAnchor = document.createElement('a');
                                            scoreAnchor.innerText = gymnast.score.toFixed(2);
                                            // You can customize the link URL here

                                            scoreCell.appendChild(scoreAnchor);
                                            const actionCell = document.createElement('td');
                                            actionCell.innerHTML = '<a href="LiveScoring?gymnastID=' + gymnast.gymnastID + '&eventID=' + eventID + '">info > </a>';

                                            tableRow.appendChild(rankCell);
                                            tableRow.appendChild(gymnastNameCell);
                                            tableRow.appendChild(clubNameCell);
                                            tableRow.appendChild(freeCell);
                                            tableRow.appendChild(ropeCell);
                                            tableRow.appendChild(hoopCell);
                                            tableRow.appendChild(ballCell);
                                            tableRow.appendChild(clubsCell);
                                            tableRow.appendChild(scoreCell);
                                            tableRow.appendChild(actionCell);

                                            resultTableBody.appendChild(tableRow);
                                        }

                                        sourceTable.style.display = "none";
                                    }
                                    rankingTable();

                                </script>


                                <input hidden value="<%= request.getParameter("eventID") %>" id="eventID">
                            </div>
                        </div>
                    </div>
                </div>                
            </div>

            <!-- Footer -->
            <footer class="bg-body-tertiary text-center">
                <!-- Copyright -->
                <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
                    © 2024 Copyright
                    | All Right Reserved
                </div>
                <!-- Copyright -->
            </footer>
            <!-- Footer -->
        </div>


        <!-- End custom js for this page-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <script>

                                    $("#categoryName").on("change", function () {
                                        let eventID = document.getElementById("eventID").value;
                                        $.ajax({
                                            type: 'POST',
                                            data: {
                                                categoryName: this.value,
                                                gymnastID: 0,
                                                teamID: 0,
                                                apparatusID: 0
                                            },
                                            url: 'LiveIndividualScore?eventID=' + eventID,
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
                                        let eventID = document.getElementById("eventID").value;
                                        $.ajax({
                                            type: 'POST',
                                            data: {
                                                categoryName: "",
                                                gymnastID: 0,
                                                teamID: 0,
                                                apparatusID: this.value
                                            },
                                            url: 'LiveIndividualScore?eventID=' + eventID,
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
                                        let eventID = document.getElementById("eventID").value;
                                        $.ajax({
                                            type: 'POST',
                                            data: {
                                                categoryName: "",
                                                gymnastID: 0,
                                                teamID: this.value,
                                                apparatusID: 0
                                            },
                                            url: 'LiveIndividualScore?eventID=' + eventID,
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
                                        let eventID = document.getElementById("eventID").value;
                                        $.ajax({
                                            type: 'POST',
                                            data: {
                                                categoryName: "",
                                                gymnastID: this.value,
                                                teamID: 0,
                                                apparatusID: 0
                                            },
                                            url: 'LiveIndividualScore?eventID=' + eventID,
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
    </body>
</html>