<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>

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

    <title>Organization Management</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <link href="assets/css/nucleo-icons.css" rel="stylesheet" type="text/css"/>
    <link href="assets/css/nucleo-svg.css" rel="stylesheet" type="text/css"/>
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <link href="assets/css/soft-ui-dashboard.css" rel="stylesheet" type="text/css"/>

    <style>
        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: -30px;
        }
        .table th, .table td {
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
        .page-header {
            margin-top: 80px !important;
        }
        .sidebar {
            padding-top: 70px;
        }
        .sidebar-toggle-btn {
            display: none;
        }
        @media (max-width: 1000.98px) {
            .sidebar-toggle-btn {
                display: block;
            }
            .sidebar-offcanvas {
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
                position: fixed;
                padding-top: 8px;
                left: 0px;
            }
            .sidebar-offcanvas.show {
                -webkit-transform: translateX(0);
                transform: translateX(0);
            }
        }
        .badge-active {
            background-color: #28a745;
            color: white;
        }
        .badge-inactive {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>

<body>
    <div class="container-scroller">
        <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
            <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
                <a class="navbar-brand brand-logo mr-5" href=""><img src="assets/img/curved-images/gymnastLogo.png" class="mr-1" alt="logo" /></a>
                <a class="navbar-brand brand-logo-mini" href=""><img src="assets/img/curved-images/miniLogo.png" alt="logo" /></a>
            </div>
            <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                    <span class="icon-menu"></span>
                </button>
                <ul class="navbar-nav navbar-nav-right">
                    <li class="nav-item nav-profile dropdown">
                        <div aria-labelledby="profileDropdown">
                            <a href="../LogoutServlet" class="dropdown-item">
                                <i class="ti-power-off text-primary"></i>
                                Logout
                            </a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <button class="sidebar-toggle-btn" type="button" data-toggle="sidebar">
                            <i class="fas fa-bars"></i>
                        </button>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container-fluid page-body-wrapper">
            <%
                String userRole = (String) session.getAttribute("userRole");
                Integer staffID = (Integer) session.getAttribute("staffID");

                if (userRole != null && userRole.equals("superadmin")) {
            %>
            <jsp:include page="superAdminNavbar.jsp" />
            <%
                } else {
                    response.sendRedirect("../LogoutServlet");
                    return;
                }
            %>

            <div class="main-panel">
                <div class="content-wrapper">
                    <section class="min-vh-100 mb-8">
                        <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('assets/img/curved-images/sport8.jpg');">
                            <span class="mask bg-gradient-dark opacity-0"></span>
                        </div>

                        <div class="container-fluid py-4">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card mb-2" style="margin-top: -30px;">
                                        <div class="card-header pb-0 d-flex justify-content-between align-items-center">
                                            <h6>Organization Management</h6>
                                            <input type="hidden" id="staffID" value="<%= staffID %>">
                                            <div class="d-flex">
                                                <a href="#" class="btn btn-sm bg-gradient-dark my-4 mb-2 me-2" data-bs-toggle="modal" data-bs-target="#addOrgModal">Add Organization</a>
                                            </div>
                                        </div>
                                        <div class="card-body px-0 pt-0 pb-2">
                                            <div class="table-responsive p-0">
                                                <table class="table">
                                                    <thead class="thead-light">
                                                        <tr>
                                                            <th scope="col">#</th>
                                                            <th scope="col">Organization Name</th>
                                                            <th scope="col">Username</th>
                                                            <th scope="col">Password</th>
                                                            <th scope="col">Assigned Events</th>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="orgTableBody">
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
                        <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright 2024 Gymnastic Scoring System</span>
                    </div>
                </footer>
            </div>
        </div>
    </div>

    <!-- Add Organization Modal -->
    <div class="modal fade" id="addOrgModal" tabindex="-1" aria-labelledby="addOrgModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addOrgModalLabel">Add Organization</h5>
                    <button type="button" id="closeAddModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxAddOrg">
                        <div class="mb-3">
                            <label class="form-label">Organization Name</label>
                            <input type="text" class="form-control" name="teamName" id="teamName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="orgUsername" id="orgUsername" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="text" class="form-control" name="orgPassword" id="orgPassword" required>
                        </div>
                        <input type="hidden" name="staffID" value="<%= staffID %>">
                        <button type="button" onclick="addOrganization()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Submit</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Organization Modal -->
    <div class="modal fade" id="updateOrgModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update Organization</h5>
                    <button type="button" id="closeUpdateModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxUpdateOrg">
                        <input type="hidden" name="teamID" id="updateTeamID">
                        <div class="mb-3">
                            <label class="form-label">Organization Name</label>
                            <input type="text" class="form-control" name="teamName" id="updateTeamName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="orgUsername" id="updateOrgUsername" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="text" class="form-control" name="orgPassword" id="updateOrgPassword" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-control" name="orgStatus" id="updateOrgStatus">
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>
                        <button type="button" onclick="updateOrganization()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Update</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Confirmation</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this organization?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Assign Event Modal -->
    <div class="modal fade" id="assignEventModal" tabindex="-1" aria-labelledby="assignEventModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="assignEventModalLabel">Assign Event to Organization</h5>
                    <button type="button" id="closeAssignModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxAssignEvent">
                        <input type="hidden" name="teamID" id="assignTeamID">
                        <div class="mb-3">
                            <label class="form-label">Organization</label>
                            <input type="text" class="form-control" id="assignOrgName" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Select Event to Assign</label>
                            <select class="form-control" name="eventID" id="assignEventSelect" required>
                                <option value="">-- Select Event --</option>
                            </select>
                        </div>
                        <button type="button" onclick="assignEvent()" class="btn btn-sm bg-gradient-dark my-4 mb-2">Assign Event</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- View Assigned Events Modal -->
    <div class="modal fade" id="viewEventsModal" tabindex="-1" aria-labelledby="viewEventsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewEventsModalLabel">Assigned Events</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h6 id="viewEventsOrgName"></h6>
                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Event Name</th>
                                    <th>Event Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="assignedEventsTableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

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

    <script>
        function fetchOrganizations() {
            $.ajax({
                type: 'GET',
                url: '../ListOrganizationServlet',
                dataType: 'json',
                success: function(data) {
                    $('#orgTableBody').empty();
                    var rowIndex = 1;

                    if (data.length === 0) {
                        $('#orgTableBody').html('<tr><td colspan="7" class="text-center"><div style="margin: 0 auto;"><img src="sleepingcat.gif" alt="Cat Image" style="max-width: 150px;"><p style="font-family: Comic Sans MS, cursive; text-transform: uppercase;">NO ORGANIZATIONS YET</p></div></td></tr>');
                    } else {
                        $.each(data, function(index, org) {
                            var statusBadge = org.orgStatus === 'active'
                                ? '<span class="badge badge-active">Active</span>'
                                : '<span class="badge badge-inactive">Inactive</span>';

                            // Build assigned events display
                            var eventsDisplay = '-';
                            if (org.assignedEvents && org.assignedEvents.length > 0) {
                                eventsDisplay = '<span class="badge bg-primary me-1">' + org.assignedEvents.length + ' event(s)</span>' +
                                    '<button class="btn btn-sm btn-outline-primary" onclick="viewAssignedEvents(' + org.teamID + ', \'' + escapeHtml(org.teamName) + '\')" data-bs-toggle="modal" data-bs-target="#viewEventsModal"><i class="bi bi-eye"></i></button>';
                            }

                            var row = '<tr>' +
                                '<td>' + rowIndex + '</td>' +
                                '<td><strong>' + org.teamName + '</strong></td>' +
                                '<td>' + (org.orgUsername || '-') + '</td>' +
                                '<td>' + (org.orgPassword || '-') + '</td>' +
                                '<td>' + eventsDisplay + '</td>' +
                                '<td>' + statusBadge + '</td>' +
                                '<td>' +
                                    '<button class="btn btn-sm bg-gradient-success me-1" onclick="openAssignEventModal(' + org.teamID + ', \'' + escapeHtml(org.teamName) + '\')" data-bs-toggle="modal" data-bs-target="#assignEventModal" title="Assign Event"><i class="bi bi-calendar-plus"></i></button>' +
                                    '<button class="btn btn-sm bg-gradient-info" onclick="editOrganization(' + org.teamID + ', \'' + escapeHtml(org.teamName) + '\', \'' + escapeHtml(org.orgUsername || '') + '\', \'' + escapeHtml(org.orgPassword || '') + '\', \'' + org.orgStatus + '\')" data-bs-toggle="modal" data-bs-target="#updateOrgModal" title="Edit"><i class="bi bi-pencil-fill"></i></button>' +
                                '</td>' +
                            '</tr>';

                            $('#orgTableBody').append(row);
                            rowIndex++;
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching organizations:", error);
                }
            });
        }

        function escapeHtml(text) {
            if (!text) return '';
            return text.replace(/'/g, "\\'").replace(/"/g, '\\"');
        }

        $(document).ready(function() {
            fetchOrganizations();
        });

        function addOrganization() {
            var teamName = $("#teamName").val().trim();
            var orgUsername = $("#orgUsername").val().trim();
            var orgPassword = $("#orgPassword").val().trim();

            if (!teamName || !orgUsername || !orgPassword) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Please fill all required fields',
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000
                });
                return;
            }

            var data = $("#ajaxAddOrg").serialize();

            $.ajax({
                type: 'POST',
                url: '../AddOrganizationServlet',
                data: data,
                dataType: 'JSON',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Organization Added Successfully!',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000
                        });
                        $('#ajaxAddOrg')[0].reset();
                        $("#closeAddModal").trigger('click');
                        fetchOrganizations();
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: response.message || 'Failed to add organization',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error adding organization:", error);
                }
            });
        }

        function editOrganization(teamID, teamName, orgUsername, orgPassword, orgStatus) {
            $('#updateTeamID').val(teamID);
            $('#updateTeamName').val(teamName);
            $('#updateOrgUsername').val(orgUsername);
            $('#updateOrgPassword').val(orgPassword);
            $('#updateOrgStatus').val(orgStatus);
        }

        function updateOrganization() {
            var data = $("#ajaxUpdateOrg").serialize();

            $.ajax({
                type: 'POST',
                url: '../UpdateOrganizationServlet',
                data: data,
                dataType: 'JSON',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Organization Updated Successfully!',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000
                        });
                        $("#closeUpdateModal").trigger('click');
                        fetchOrganizations();
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Failed to update organization',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error updating organization:", error);
                }
            });
        }

        // Open Assign Event Modal
        function openAssignEventModal(teamID, teamName) {
            $('#assignTeamID').val(teamID);
            $('#assignOrgName').val(teamName);

            // Fetch available events (not assigned to any organization)
            $.ajax({
                type: 'GET',
                url: '../ListAvailableEventsServlet',
                dataType: 'json',
                success: function(events) {
                    $('#assignEventSelect').empty();
                    $('#assignEventSelect').append('<option value="">-- Select Event --</option>');

                    if (events.length === 0) {
                        $('#assignEventSelect').append('<option value="" disabled>No available events</option>');
                    } else {
                        $.each(events, function(index, event) {
                            $('#assignEventSelect').append('<option value="' + event.eventID + '">' + event.eventName + ' (' + event.eventDate + ')</option>');
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching available events:", error);
                }
            });
        }

        // Assign Event to Organization
        function assignEvent() {
            var teamID = $('#assignTeamID').val();
            var eventID = $('#assignEventSelect').val();

            if (!eventID) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Please select an event',
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 3000
                });
                return;
            }

            $.ajax({
                type: 'POST',
                url: '../AssignEventToOrgServlet',
                data: { teamID: teamID, eventID: eventID },
                dataType: 'JSON',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Event Assigned Successfully!',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000
                        });
                        $("#closeAssignModal").trigger('click');
                        fetchOrganizations();
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: response.message || 'Failed to assign event',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error assigning event:", error);
                }
            });
        }

        // View Assigned Events
        function viewAssignedEvents(teamID, teamName) {
            $('#viewEventsOrgName').text('Organization: ' + teamName);

            $.ajax({
                type: 'GET',
                url: '../ListAssignedEventsServlet',
                data: { teamID: teamID },
                dataType: 'json',
                success: function(events) {
                    $('#assignedEventsTableBody').empty();

                    if (events.length === 0) {
                        $('#assignedEventsTableBody').html('<tr><td colspan="4" class="text-center">No events assigned</td></tr>');
                    } else {
                        $.each(events, function(index, event) {
                            var row = '<tr>' +
                                '<td>' + (index + 1) + '</td>' +
                                '<td>' + event.eventName + '</td>' +
                                '<td>' + event.eventDate + '</td>' +
                                '<td><button class="btn btn-sm btn-danger" onclick="unassignEvent(' + event.eventID + ', ' + teamID + ')"><i class="bi bi-x-circle"></i> Remove</button></td>' +
                            '</tr>';
                            $('#assignedEventsTableBody').append(row);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching assigned events:", error);
                }
            });
        }

        // Unassign Event from Organization
        function unassignEvent(eventID, teamID) {
            Swal.fire({
                title: 'Remove Event?',
                text: 'Are you sure you want to remove this event from the organization?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Yes, remove it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: 'POST',
                        url: '../UnassignEventServlet',
                        data: { eventID: eventID },
                        dataType: 'JSON',
                        success: function(response) {
                            if (response.success) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Event Removed!',
                                    toast: true,
                                    position: 'top-end',
                                    showConfirmButton: false,
                                    timer: 3000
                                });
                                viewAssignedEvents(teamID, $('#viewEventsOrgName').text().replace('Organization: ', ''));
                                fetchOrganizations();
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Failed to remove event',
                                    toast: true,
                                    position: 'top-end',
                                    showConfirmButton: false,
                                    timer: 3000
                                });
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("Error removing event:", error);
                        }
                    });
                }
            });
        }
    </script>

    <script>
        $(document).ready(function() {
            $('.sidebar-toggle-btn').on('click', function() {
                $('.sidebar-offcanvas').toggleClass('show');
            });
        });
    </script>
</body>
</html>
