<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

    </head>

    <body>
        <div class="container-scroller bg-dark" >
            <div class="container-fluid "  >
                <div class="content-wrapper bg-dark d-flex align-items-center auth px-0">
                    <div class="row w-100 mx-0 bg-dark" style="">
                        <div class="col-lg-6 mx-auto ">
                            <div class="auth-form-light  text-left py-2  rounded">
                                <div class="brand-logo text-center">

                                </div>



                                <h4 class="text-center " >${listScoreboard.get(0).getGymnast().get(i).getGymnastName()} SCORE <br> </h4>
                                <form id="submitForm" action="" class="mx-5" method="post">


                                    <input type="hidden" name="gymnastID" value="<%= request.getParameter("gymnastID")%>">

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
                                                       int i = 0; // Initialize counter variable
                                                         while (i < listJudge.size()) {
                                                           Judge judge = (Judge) listJudge.get(i); // Assuming ArrayList type
                                            %>

                                            <option value="<%= judge.getJudgeID()%>"><%= judge.getJudgeName()%></option>

                                            <%
                                                   i++; // Increment counter
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
                <!-- content-wrapper ends -->
            </div>

            <!-- page-body-wrapper ends -->
        </div>




    </body>

</html>

</body>

</html>







