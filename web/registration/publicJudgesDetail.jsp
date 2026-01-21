<%-- 
    Document   : publicJudgesDetail
    Created on : 3 May 2024, 10:42:21 pm
    Author     : 60199
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Public Judges Details</title>

    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="assets/css/nucleo-icons.css" rel="stylesheet" type="text/css"/>
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css"/>
  <!-- CSS Files -->
  <link id="pagestyle" href="../assets/css/soft-ui-dashboard.css?v=1.0.3" rel="stylesheet" />
    <style>
           * {
        margin: 0;
        padding: 0;
        font-family: sans-serif;
    }

    .banner {
        width: 100%;
        height: 100vh;
        background-image: linear-gradient(rgba(0,0,0,0.3),rgba(0,0,0,0.3)),url('../assets/img/curved-images/sport8.jpg');
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
        margin: 0 40px;
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

<body class="g-sidenav-show bg-gray-100">      
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent mt-4">
    <div class="container">
      <a class="navbar-brand font-weight-bolder ms-lg-0 ms-3 text-white" href="pubDashboard.jsp">
        Sport Gymnastic Dashboard
      </a>
        
        
      <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon mt-2">
          <span class="navbar-toggler-bar bar1"></span>
          <span class="navbar-toggler-bar bar2"></span>
          <span class="navbar-toggler-bar bar3"></span>
        </span>
      </button>                                         
  </nav>
   
    <section class="min-vh-100 mb-8">
    <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('assets/img/curved-images/bg1.jpg');">
      <span class="mask bg-gradient-dark opacity-0"></span>
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-5 text-center mx-auto">

          </div>
        </div>
      </div>
    </div>
      
        <div class="container-fluid py-4">
        <div class="row mb-3">
            <div class="col-md-6">
                <label for="categoryFilter" class="form-label">Filter by Place Of Duty</label>
            <div class="d-flex">
                <select id="categoryFilter" class="form-select me-2"> 
                    <option value="">All Categories</option>
                    <option value="Pre-Junior Under 12">Sekolah Sukan Malaysia</option>
                    <!-- Add more options if needed -->
                </select>
            </div>
        </div>
         <div class="row">
            <div class="col-12">
                <div class="card mb-4">
                    <div class="card-header pb-0">
                        <h6>Judge Personal Information</h6>
                    </div>
                    <div class="card-body px-0 pt-0 pb-2">
                        <div class="table-responsive p-0">
                            <table class="table align-items-center mb-0">
                                <thead>
                                    <tr>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="color: blue !important; font-size: 0.9rem !important;">Name</th>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="color: blue !important; font-size: 0.9rem !important;">Identity Card</th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="color: blue !important; font-size: 0.9rem !important;">Place Of Duty</th>
                                   
                                        <th class="text-secondary opacity-7"></th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="d-flex px-2 py-1">
                                                <div>
                                                    <img src="assets/img/sport4.jpg" class="avatar avatar-sm me-3" alt="user1">
                                                </div>
                                                <div class="d-flex flex-column justify-content-center">
                                                    <h6 class="mb-0 text-sm">Ahmad Bin Jusoh</h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <p class="text-xs font-weight-bold mb-0">050607100225</p>
                                        </td>
                                        <td class="align-middle text-center">
                                            <span class="text-secondary text-xs font-weight-bold">Sekolah Sukan Malaysia</span>
                                        </td>
                                        
                                    </tr>
                                    
                                     <tr>
                                        <td>
                                            <div class="d-flex px-2 py-1">
                                                <div>
                                                    <img src="assets/img/sport4.jpg" class="avatar avatar-sm me-3" alt="user1">
                                                </div>
                                                <div class="d-flex flex-column justify-content-center">
                                                    <h6 class="mb-0 text-sm">Lee Guang Eng</h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <p class="text-xs font-weight-bold mb-0">050607100225</p>
                                        </td>
                                        <td class="align-middle text-center">
                                            <span class="text-secondary text-xs font-weight-bold">Sekolah Sukan Malaysia</span>
                                        </td>
                                     
                                    </tr>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
        
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Get the filter dropdown element
            const categoryFilter = document.getElementById('categoryFilter');

            // Add event listener to detect changes in the filter dropdown
            categoryFilter.addEventListener('change', function () {
                // Get the selected category value
                const selectedCategory = categoryFilter.value;

                // Get all table rows
                const rows = document.querySelectorAll('tbody tr');

                // Loop through each row and hide/show based on the selected category
                rows.forEach(row => {
                    const categoryCell = row.querySelector('.category-cell'); // Assuming you add a class to the category cell
                    const category = categoryCell.textContent.trim();

                    if (selectedCategory === '' || category === selectedCategory) {
                        row.style.display = ''; // Show the row
                    } else {
                        row.style.display = 'none'; // Hide the row
                    }
                });
            });
        });
    </script>
    
    
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const searchInput = document.getElementById('searchInput');
        
        // Add event listener to detect changes in the search input
        searchInput.addEventListener('input', function () {
            const searchText = searchInput.value.toLowerCase();
            const tableRows = document.querySelectorAll('.table tbody tr');
            
            tableRows.forEach(row => {
                const rowData = row.textContent.toLowerCase();
                if (rowData.includes(searchText)) {
                    row.style.display = ''; // Show row if it matches search text
                } else {
                    row.style.display = 'none'; // Hide row if it doesn't match
                }
            });
        });
    });
</script>

      
      
  </section>
  <!-- -------- END FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <!--   Core JS Files   -->
  <script src="../assets/js/core/popper.min.js"></script>
  <script src="../assets/js/core/bootstrap.min.js"></script>
  <script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
   document.addEventListener('DOMContentLoaded', function () {
  var win = navigator.platform.indexOf('Win') > -1;
  if (win && document.querySelector('#sidenav-scrollbar')) {
    var options = {
      damping: '0.5'
    };
    var scrollbar = Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
  }
});
  </script>
  
  <!--   Core JS Files   -->
  <script src="assets/js/core/popper.min.js"></script>
  <script src="assets/js/core/bootstrap.min.js"></script>
  <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
 
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../assets/js/soft-ui-dashboard.min.js?v=1.0.3"></script>
</body>
</html>
