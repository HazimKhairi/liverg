<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Skydash Admin</title>
        <!-- plugins:css -->
        <link rel="stylesheet" href="vendors/feather/feather.css">
        <link rel="stylesheet" href="vendors/ti-icons/css/themify-icons.css">
        <link rel="stylesheet" href="vendors/css/vendor.bundle.base.css">
        <!-- endinject -->
        <!-- Plugin css for this page -->
        <!-- End plugin css for this page -->
        <!-- inject:css -->
        <link rel="stylesheet" href="css/vertical-layout-light/style.css">
        <!-- endinject -->
        <link rel="shortcut icon" href="images/favicon.png" />
    </head>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: sans-serif;
        }
        .banner {
            width: 100%;
            height: 100vh;
            background-image: linear-gradient(rgba(0,0,0,0.3),rgba(0,0,0,0.3)),url('../registration/assets/img/curved-images/sport8.jpg');
            background-size: cover;
            background-position: center;
        }

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
    </style>
    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <div class="banner">
                <div class="navbar__">
                    <ul>
                        <li><a href="publicgymdetails.jsp">Gymnast Details</a></li>
                        <li><a href="publicJudgesDetail.jsp">Judge Details</a></li>
                        <li><a href="login.jsp">Login</a></li>
                    </ul>
                </div>

                <div class="card mr-4 ml-4" >
                    <div class="card-body">
                        <h4 class="card-title">Enter Score Table</h4>
                        <p class="card-description">
                            by Head Judge</code>
                        </p>
                        <!-- table add score -->
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>
                                            Team
                                        </th>
                                        <th>
                                            ID 
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
                                <tbody>
                                    <tr>
                                        <td class="py-1">
                                            <img src="images/faces/face1.jpg" alt="image"/>
                                        </td>
                                        <td>
                                            G01
                                        </td>
                                        <td>
                                            Muhammad Irfan Rozlan
                                        </td>
                                        <td>
                                            Junior Olympic (JO)
                                        </td>
                                        <td>
                                            <div class="template-demo">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Ball</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A1:</label>
                                                                        <input type="number" class="form-control" name="scoreA1" id="name" required>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A2:</label>
                                                                        <input type="number" class="form-control" name="scoreA2" id="name" required>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A3:</label>
                                                                        <input type="number" class="form-control" id="name" name="scoreA3" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E1</label>
                                                                        <input type="number" class="form-control" id="text" name="scoreE1" required>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E2</label>
                                                                        <input type="number" class="form-control" name="scoreE2" id="email" required>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E3</label>
                                                                        <input type="number" class="form-control" name="scoreE3" id="email" required>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score D1</label>
                                                                        <input type="number" class="form-control" name="scoreD1" id="email" required>
                                                                    </div>
                                                                    
                                                                     <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score D2</label>
                                                                        <input type="number" class="form-control" name="scoreD2" id="email" required>
                                                                    </div>
                                                                     <div class="form-group">
                                                                        <label for="email" class="col-form-label">Penalty</label>
                                                                        <input type="number" class="form-control" name="technicalDeduction" id="email" required>
                                                                    </div>
                                                                    
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" form="submitForm" class="btn btn-primary mr-2">Submit</button>
                                                                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Hoop</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" form="submitForm" class="btn btn-primary mr-2">Submit</button>
                                                                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Rings</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" form="submitForm" class="btn btn-primary mr-2">Submit</button>
                                                                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Ribbon</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" form="submitForm" class="btn btn-primary mr-2">Submit</button>
                                                                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-1">
                                            <img src="images/faces/face2.jpg" alt="image"/>
                                        </td>
                                        <td>
                                            G02
                                        </td>
                                        <td>
                                            Wan Nur Fatimah Ayuni
                                        </td>
                                        <td>
                                            Junior Olympic (JO)
                                        </td>
                                        <td>
                                            <div class="template-demo">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Ball</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                                                <button class="btn btn-light">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Hoop</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                                                <button class="btn btn-light">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Rings</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" class="btn btn-primary mr-2">Submit</button>
                                                                <button class="btn btn-light">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Ribbon</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" form="submitForm" class="btn btn-primary mr-2">Submit</button>
                                                                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-1">
                                            <img src="images/faces/face3.jpg" alt="image"/>
                                        </td>
                                        <td>
                                            G03
                                        </td>
                                        <td>
                                            Muhammad Hazim Khairi
                                        </td>
                                        <td>
                                            Junior Olympic (JO)
                                        </td>
                                        <td>
                                            <div class="template-demo">
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Ball</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="submit" form="submitForm" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Hoop</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="submit" form="submitForm" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Rings</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="submit" form="submitForm" class="btn btn-primary">Submit</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Ribbon</button>
                                                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Add Score</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="submitForm">
                                                                    <div class="form-group">
                                                                        <label for="name" class="col-form-label">Score A:</label>
                                                                        <input type="text" class="form-control" id="name" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email" class="col-form-label">Score E</label>
                                                                        <input type="email" class="form-control" id="email" required>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="message" class="col-form-label">Score D</label>
                                                                        <textarea class="form-control" id="message" required></textarea>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" form="submitForm" class="btn btn-primary mr-2">Submit</button>
                                                                <button type="button" class="btn btn-light" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- content-wrapper ends -->
        <!-- partial:partials/_footer.html -->
        <footer class="footer">
            <div class="d-sm-flex justify-content-center justify-content-sm-between">
                <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright © 2024 All rights reserved.</span>
                <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Hand-crafted & made with <i class="ti-heart text-danger ml-1"></i>&nbsp;By Muhammad Hazim</span>
            </div>
        </footer>
        <!-- partial -->
    </div>
    <!-- main-panel ends -->
</div>
<!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->
<!-- plugins:js -->
<script src="vendors/js/vendor.bundle.base.js"></script>
<!-- endinject -->
<!-- Plugin js for this page -->
<!-- End plugin js for this page -->
<!-- inject:js -->
<script src="js/off-canvas.js"></script>
<script src="js/hoverable-collapse.js"></script>
<script src="js/template.js"></script>
<script src="js/settings.js"></script>
<script src="js/todolist.js"></script>
<!-- endinject -->
<!-- Custom js for this page-->
<!-- End custom js for this page-->
</body>

</html>
