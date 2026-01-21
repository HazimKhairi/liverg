<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

 <head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.png">
  <link href="vendors/feather/feather.css" rel="stylesheet" type="text/css"/>
  <link href="vendors/ti-icons/css/themify-icons.css" rel="stylesheet" type="text/css"/>
  <link href="vendors/css/vendor.bundle.base.css" rel="stylesheet" type="text/css"/>
  <link href="assets/css/vertical-layout-light/style.css" rel="stylesheet" type="text/css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <link rel="shortcut icon" href="assets/img/favicon.png" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">

  <title>
   Clerk Information
  </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="assets/css/nucleo-icons.css" rel="stylesheet" type="text/css"/>
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
  <!-- CSS Files -->
  <link href="assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css"/>

   <style>
        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: -30px;
        }

        .table th,
        .table td {
            vertical-align: middle;
            text-align: center;
        }

        .table thead th {
            background-color: #343a40;
            color: #fff;
        }

        .table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .container-fluid {
            padding: 20px;
            background-color: #f8f9fa;
            padding-top: 0;
            margin-top: 0px;
        }

        .card-header h6 {
            font-size: 1.25rem;
            font-weight: bold;
        }

        .modal-body {
            text-align: left;
        }

        .page-body-wrapper {
            padding-top: 0px;
        }

        .page-header {
            margin-top: 80px !important; /* Create space between the header and the image */
        }

        .sidebar {
            padding-top: 70px; /* Add padding to avoid overlap with fixed header */
        }

        .toast.bg-success {
            background-color: #28a745;
        }

        .toast.bg-danger {
            background-color: #dc3545;
        }

        .toast .toast-header {
            border-bottom: none;
        }

        .toast .toast-body {
            color: #ffffff;
        }

        .toast .btn-close {
            filter: invert(100%);
        }

        .toast-container {
            z-index: 9999;
        }

        .toast {
            margin-bottom: 1rem;
        }
        
        
.sidebar-toggle-btn {
    display: none; /* Initially hide the toggle button */
}
   
   @media (max-width: 800px) {
    .btn-primary {
        padding: 10px; /* Adjust padding as needed */
    }
    .fas {
        font-size: 1.5rem; /* Adjust icon size as needed */
    }
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
   <div class="container-scroller">
    <!-- partial:../../partials/_navbar.html -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
     <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
     <a class="navbar-brand brand-logo mr-5" href=""> <img src="assets/img/curved-images/gymnastLogo.png"
                                                           class="mr-1" alt="logo" /></a>
     <a class="navbar-brand brand-logo-mini" href=""><img src="assets/img/curved-images/miniLogo.png" alt="logo" /></a>
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
                <a href="../LogoutServlet" class="dropdown-item">
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

     <%
         // Get the staffID and userRole from the session
         Integer staffID = (Integer) session.getAttribute("staffID");
         String userRole = (String) session.getAttribute("userRole");

         // Redirect to LogoutServlet if userRole is null
         if (userRole == null) {
             response.sendRedirect("../LogoutServlet");
         } else if (userRole.equals("clerk")) {
     %>
     <jsp:include page="clerkNavbar.jsp" />
     <%
         } else if (userRole.equals("staff")) {
     %>
     <jsp:include page="staffNavbar.jsp" />
     <%
         } else if (userRole.equals("superadmin")) {
     %>
     <jsp:include page="superAdminNavbar.jsp" />
     <%
         } else if (userRole.equals("organization")) {
     %>
     <jsp:include page="organizationNavbar.jsp" />
     <%
         } else {
             // Redirect to LogoutServlet if userRole is not recognized
             response.sendRedirect("../LogoutServlet");
         }
     %>



     <div class="main-panel">
      <div class="content-wrapper">
       <section class="min-vh-100 mb-8">
        <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('assets/img/curved-images/sport8.jpg');">
         <span class="mask bg-gradient-dark opacity-0"></span>
         <div class="container">
          <div class="row justify-content-center">
          </div>
         </div>
        </div>

        <div class="container-fluid py-4">
         <div class="row">
          <div class="col-12">
           <div class="card mb-2" style="margin-top: -30px;"> <!-- Negative margin to pull the card upwards -->
            <div class="card-header pb-0 d-flex justify-content-between align-items-center">
             <h6>Clerk Personal Information</h6>
             <a href="#" class="btn btn-sm bg-gradient-dark my-4 mb-2" data-bs-toggle="modal" data-bs-target="#addClerkModal">Add</a>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
             <div class="table-responsive p-0">
              <table class="table">
               <thead class="thead-light">
                <tr>
                 <th scope="col">#</th>
                 <th scope="col">Clerk Name</th>
                 <th scope="col">Clerk Username</th>
                 <th scope="col">Clerk Password</th>
                 <th scope="col">Action</th>

                </tr>
               </thead>

               <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                 <div class="modal-content">
                  <div class="modal-header">
                   <h5 class="modal-title" id="confirmationModalLabel">Confirmation</h5>
                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                   Are you sure you want to delete the data?
                  </div>
                  <div class="modal-footer">
                   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                   <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                  </div>
                 </div>
                </div>
               </div>
               <tbody id="clerksTableBody">

                <!-- Modal Add Clerk -->
               <div class="modal fade" id="addClerkModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                 <div class="modal-content">
                  <div class="modal-header">
                   <h5 class="modal-title" id="exampleModalLabel">Add Clerk</h5>
                   <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                   <!-- Your form content goes here -->
                   <form id="ajaxAddClerk">
                    <div class="mb-3">
                     <label class="form-label">Clerk Name</label>
                     <input type="text" name="name" id="name" class="form-control">
                    </div>
                    <div class="mb-3">
                     <label class="form-label">Clerk Username</label>
                     <input type="text" name="username" id="username" class="form-control">
                    </div>

                    <div class="mb-3">
                     <label class="form-label">Password</label>
                     <div class="input-group">
                      <input type="password" name="password" id="password" class="form-control">

                      <span class="input-group-text">
                       <i class="bi bi-eye" id="togglePassword" style="cursor: pointer;" onclick="togglePasswordVisibility('password', 'confirmPassword', 'togglePassword')"></i>
                      </span>

                     </div>
                    </div>

                    <div class="mb-3">
                     <label class="form-label">Confirm Password</label>
                     <div class="input-group">
                      <input type="password" name="confirmPassword" id="confirmPassword" class="form-control">
                     </div>
                    </div>

                    <div class="mb-3">
                     <input type="text" name="userid" hidden class="form-control" value="<%= staffID %>">
                    </div>
                    <button type="button" onclick="addClerk()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                   </form>
                  </div>
                  <div class="modal-footer">
                   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  </div>
                 </div>
                </div>
               </div>

               <!-- Update Clerk Modal -->
               <div class="modal fade" id="updateClerkModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                 <div class="modal-content">
                  <div class="modal-header">
                   <h5 class="modal-title">Update Clerk</h5>
                   <button type="button" id="closeModalUpdate" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                   <!-- Update Clerk Form -->
                   <form id="ajaxUpdateClerk">
                    <div class="mb-3">
                     <label class="form-label">Clerk Name</label>
                     <input type="text" name="updateName" id="updateName" class="form-control">
                    </div>
                    <div class="mb-3">
                     <label class="form-label">Clerk Username</label>
                     <input type="text" name="updateClerkName" id="updateClerkName" class="form-control">
                    </div>
                    <div class="mb-3">
                     <label class="form-label">Password</label>
                     <div class="input-group">
                      <input type="password" name="updateClerkPassword" id="updateClerkPassword" class="form-control">
                      <span class="input-group-text">
                       <i class="bi bi-eye" id="toggleUpdatePassword" style="cursor: pointer;" onclick="togglePasswordVisibility('updateClerkPassword', 'updateConfirmPassword', 'toggleUpdatePassword')"></i>
                      </span>
                     </div>
                    </div>
                    <div class="mb-3">
                     <label class="form-label">Confirm Password</label>
                     <div class="input-group">
                      <input type="password" name="updateConfirmPassword" id="updateConfirmPassword" class="form-control">
                     </div>
                    </div>
                    <div class="mb-3">
                     <input type="text" hidden name="updateClerkID" id="updateClerkID" class="form-control">
                    </div>
                    <button type="button" onclick="validateAndUpdateClerk()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                   </form>
                  </div>
                  <div class="modal-footer">
                   <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  </div>
                 </div>
                </div>
               </div>

               </tbody>
              </table>
             </div>
            </div>
           </div>
          </div>
         </div>
        </div>

       </section>
      </div>
      <footer class="footer">
       <div class="d-sm-flex justify-content-center justify-content-sm-between">
        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright � 2024<a
          href="" target="_blank"></a> Gymnastic Scoring System</span>
       </div>
      </footer>
     </div>
    </div>
   </div>



   <!--   Core JS Files   -->
   <script src="vendors/js/vendor.bundle.base.js" type="text/javascript"></script>
   <script src="assets/js/core/popper.min.js"></script>
   <script src="assets/js/core/bootstrap.min.js"></script>
   <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
   <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
   <script src="assets/off-canvas.js" type="text/javascript"></script>
   <script src="assets/hoverable-collapse.js" type="text/javascript"></script>
   <script src="assets/template.js" type="text/javascript"></script>
   <script src="assets/settings.js" type="text/javascript"></script>
   <script src="assets/todolist.js" type="text/javascript"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js'></script>
   <script src="https://cdn.lordicon.com/qjzruarw.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


   <script>
                     function fetchClerksData() {
                      $.ajax({
                       type: 'GET',
                       url: '../ListClerksServlet',
                       dataType: 'json',
                       success: function (data) {
                        // Clear existing table content
                        $('#clerksTableBody').empty();

                        var rowIndex = 1;
                        // Check if data is empty
                        if (data.length === 0) {
                         // If data is empty, display image and message
                         $('#clerksTableBody').html('<tr><td colspan="5" class="text-center"><div style="margin: 0 auto;"><img src="sleepingcat.gif" alt="Cat Image" class="centered-image" style="max-width: 400px; max-height: 150px; width: 150px; height: auto;"><p style="font-family: Comic Sans MS, cursive; text-transform: uppercase;">CURRENTLY NO DATA</p></div></td></tr>');
                        } else {
                         // Iterate over received data and generate HTML for each clerk
                         $.each(data, function (index, clerk) {
                          // Create table row for clerk data
                          var row = $('<tr>');
                          // Create table cells for clerk ID, username, and password
                          //var clerkIDCell = $('<td>').text(clerk.clerkID);
                          var rowNumberCell = $('<td>').text(rowIndex).addClass('align-middle text-center text-sm');
                          var clerkNameCell = $('<td>').text(clerk.clerkName);
                          var clerkUsernameCell = $('<td>').text(clerk.clerkUsername);
                          //var clerkPasswordCell = $('<td>').text(clerk.clerkPassword).addClass('align-middle text-center text-sm');

                          // Create password cell with hidden password
                          var passwordSpan = $('<span>').text(clerk.clerkPassword).hide().css('margin-right', '10px');
                          ;

                          var showPasswordButton = $('<button>')
                                  .attr('class', 'btn bg-gradient-dark')
                                  .html('<i class="bi bi-eye"></i>')
                                  .click(function () {
                                   if (passwordSpan.is(':visible')) {
                                    passwordSpan.hide();
                                    $(this).html('<i class="bi bi-eye"></i>');
                                   } else {
                                    passwordSpan.show();
                                    $(this).html('<i class="bi bi-eye-slash"></i>');
                                   }
                                  });
                          var clerkPasswordCell = $('<td>').addClass('align-middle text-center text-sm')
                                  .append(passwordSpan, showPasswordButton);

                          // Create edit and delete buttons
                          var editButton = $('<button>').addClass('btn bg-gradient-dark')
                                  .html('<i class="bi bi-file-earmark-check-fill bi-lg"></i>')
                                  .attr('data-bs-toggle', 'modal')
                                  .attr('data-bs-target', '#updateClerkModal')
                                  .css('margin-right', '5px');

                          var deleteButton = $('<button>').addClass('btn bg-gradient-dark')
                                  .html('<i class="bi bi-trash2-fill"></i>')
                                  .attr('data-bs-toggle', 'modal')
                                  .attr('data-bs-target', '#confirmationModal');

                          // Add click event handlers to buttons
                          editButton.click(function () {
                           console.log("Updating Clerk ID:", clerk.clerkID);
                           displayClerk(clerk.clerkID); //Pass Parameter
                          });

                          deleteButton.click(function () {
                           deleteClerk(clerk.clerkID); // Implement deleteClerk function
                          });

                          // Append buttons to a cell
                          var actionCell = $('<td>').addClass('align-middle text-center text-sm').append(editButton, deleteButton);

                          // Append cells to the row
                          row.append(rowNumberCell, clerkNameCell, clerkUsernameCell, clerkPasswordCell, actionCell);

                          // Append row to the table body
                          $('#clerksTableBody').append(row);

                          rowIndex++;
                         });

                        }

                       },
                       error: function (xhr, status, error) {
                        console.error("Error occurred during AJAX request:", error);
                       }
                      });
                     }
                     $(document).ready(function () {
                      fetchClerksData();
                     });
   </script>


   <script>
    var msg = null;
    function addClerk() {
     var name = $("#name").val().trim();
     var username = $("#username").val().trim();
     var password = $("#password").val().trim();
     var confirmPassword = $("#confirmPassword").val().trim();

     if (!name || !username || !password || !confirmPassword) {
      const Toast = Swal.mixin({
       toast: true,
       position: "top-end",
       showConfirmButton: false,
       timer: 3000,
       timerProgressBar: false,
       customClass: 'swal-wide'
      });

      let message = '<small style="color:red">';
      if (!name)
       message += '<li>Clerk Name</li>';
      if (!username)
       message += '<li>Clerk Username</li>';
      if (!password)
       message += '<li>Password</li>';
      if (!confirmPassword)
       message += '<li>Confirm Password</li></small>';

      Toast.fire({
       icon: 'warning',
       title: '<b>Please Fill All Required Fields</b>',
       html: message
      });
      return;
     }

     if (password !== confirmPassword) {
      const Toast = Swal.mixin({
       toast: true,
       position: "top-end",
       showConfirmButton: false,
       timer: 3000,
       timerProgressBar: false,
       customClass: 'swal-wide'
      });

      Toast.fire({
       icon: 'warning',
       title: "<b>Password Does Not Match</b>"
      });
      return;
     }

     var data = $("#ajaxAddClerk").serialize();

     $.ajax({
      type: 'POST',
      url: '../AddClerkServlet',
      data: data,
      dataType: 'JSON',

      success: function (data) {
       msg = data[0].msg

       if (msg == 1) {
        $('#ajaxAddClerk')[0].reset();
        $("#closeModal").trigger('click');
        fetchClerksData();
        //Success Alert
        const Toast = Swal.mixin({
         toast: true,
         position: "top-end",
         showConfirmButton: false,
         timer: 3000,
         heightAuto: true,
         timerProgressBar: false,
         iconColor: 'green',
         customClass: 'swal-wide',
        });
        Toast.fire({
         icon: 'success',
         title: '<b>Clerk <span style="color: green;"> Added</span> Successfully!</b>'
        });

       } else {
        alert('Data Not Inserted');
       }
      }
     })
    }
   </script>

   <script>
    // Function to handle deletion after confirmation
    function deleteClerk(clerkID) {
     console.log("Deleting Clerk ID:", clerkID);
     // Show confirmation modal
     $('#confirmationModal').modal('show');
     $('#confirmDeleteBtn').click(function () {
      $.ajax({
       type: 'POST',
       url: '../DeleteClerkServlet',
       data: {clerkID: clerkID},
       success: function (response) {
        console.log("Clerk deleted successfully");
        fetchClerksData();

        const Toast = Swal.mixin({
         toast: true,
         position: "top-end",
         showConfirmButton: false,
         timer: 3000,
         heightAuto: true,
         timerProgressBar: false,
         iconColor: 'green',
         customClass: 'swal-wide',
        });
        Toast.fire({
         icon: 'success',
         title: '<b>Clerk <span style="color: red;"> Deleted</span> Successfully!</b>'
        });
       },
       error: function (xhr, status, error) {
        // Handle error
        console.error("Error deleting clerk:", error);
       }
      });

      $('#confirmationModal').modal('hide');
     });
    }
   </script>

   <script>
    function validateAndUpdateClerk() {
     var password = $("#updateClerkPassword").val().trim();
     var confirmPassword = $("#updateConfirmPassword").val().trim();

     // Check if passwords match
     if (password !== confirmPassword) {
      alert("Passwords do not match.");
      return;
     } else {
      updateClerk();
     }
    }
    function updateClerk() {
     var formData = $("#ajaxUpdateClerk").serialize();

     $.ajax({
      type: 'POST',
      url: '../UpdateClerkServlet',
      data: formData,
      dataType: 'JSON',
      success: function (response) {
       if (response.success) {
        const Toast = Swal.mixin({
         toast: true,
         position: "top-end",
         showConfirmButton: false,
         timer: 3000,
         heightAuto: true,
         timerProgressBar: false,
         iconColor: 'green',
         customClass: 'swal-wide',
        });
        Toast.fire({
         icon: 'success',
         title: '<b>Clerk <span style="color: green;"> Updated</span> Successfully!</b>'
        });
        $("#closeModalUpdate").trigger('click');
        fetchClerksData();
       } else {
        alert('Failed to update clerk information. Please try again.');
       }
      },
      error: function (xhr, status, error) {
       console.error("Error updating clerk information:", error);
       alert('An error occurred while updating clerk information. Please try again later.');
      }
     });
    }
   </script>

   <script>
    function displayClerk(clerkID) {

     $.ajax({
      type: 'GET',
      url: '../DisplayClerkServlet',
      data: {clerkID: clerkID},
      dataType: 'JSON',
      success: function (clerk) {
       $('#updateName').val(clerk.clerkName);
       $('#updateClerkName').val(clerk.clerkUsername);
       $('#updateClerkPassword').val(clerk.clerkPassword);
       $('#updateConfirmPassword').val(clerk.clerkPassword);
       $('#updateClerkID').val(clerk.clerkID);
       $('#updateClerkModal').modal('show');
      },
      error: function (xhr, status, error) {
       console.error("Error retrieving clerk information:", error);
      }
     });
    }
   </script>

   <script>
    $(document).ready(function () {
     function togglePasswordVisibility(passwordFieldId1, passwordFieldId2, toggleIconId) {
      var passwordField1 = document.getElementById(passwordFieldId1);
      var passwordField2 = document.getElementById(passwordFieldId2);
      var toggleIcon = document.getElementById(toggleIconId);

      if (passwordField1 && passwordField2 && toggleIcon) {
       if (passwordField1.type === "password") {
        passwordField1.type = "text";
        passwordField2.type = "text";
        toggleIcon.classList.remove("bi-eye");
        toggleIcon.classList.add("bi-eye-slash");
       } else {
        passwordField1.type = "password";
        passwordField2.type = "password";
        toggleIcon.classList.remove("bi-eye-slash");
        toggleIcon.classList.add("bi-eye");
       }
      } else {
       console.error('One or more elements not found:', {
        passwordField1,
        passwordField2,
        toggleIcon
       });
      }
     }

     // Attach the function to the global scope
     window.togglePasswordVisibility = togglePasswordVisibility;
    });
   </script>
   
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $('.sidebar-toggle-btn').on('click', function() {
        $('.sidebar-offcanvas').toggleClass('show');
    });
});
</script>

  </body>
 </html>
