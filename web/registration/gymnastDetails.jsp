<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="com.registration.bean.Team" %>
<%@ page import="com.registration.bean.Apparatus" %>
<%@ page import="com.registration.bean.Event" %>

<%
    // Check if user is logged in
    String userRole = (String) session.getAttribute("userRole");
    Integer staffID = (Integer) session.getAttribute("staffID");

    if (userRole == null) {
        response.sendRedirect("../LogoutServlet");
        return;
    }

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Team> teams = new ArrayList<>();
    List<Apparatus> apparatusList = new ArrayList<>();
    List<Event> eventList = new ArrayList<>();

    try {
        DBConnect db = new DBConnect();
        con = db.getConnection();
        stmt = con.createStatement();

        // Fetching data from TEAM table
        rs = stmt.executeQuery("SELECT * FROM TEAM");
        while (rs.next()) {
            Team team = new Team();
            team.setTeamID(rs.getInt("teamID"));
            team.setTeamName(rs.getString("teamName"));
            teams.add(team);
        }
        rs.close();

        // Fetching data from APPARATUS table
        rs = stmt.executeQuery("SELECT * FROM APPARATUS");
        while (rs.next()) {
            Apparatus apparatus = new Apparatus();
            apparatus.setApparatusID(rs.getInt("apparatusID"));
            apparatus.setApparatusName(rs.getString("apparatusName"));
            apparatusList.add(apparatus);
        }
        rs.close();

        // Fetching data from EVENT table
        rs = stmt.executeQuery("SELECT * FROM EVENT");
        while (rs.next()) {
            Event event = new Event();
            event.setEventID(rs.getInt("eventID"));
            event.setEventName(rs.getString("eventName"));
            eventList.add(event);
        }
        rs.close();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gymnast Management - LIVERG</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5.3.2 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome 6.5.1 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <!-- Choices.js for multi-select -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/bbbootstrap/libraries@main/choices.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Sidebar */
        .dashboard-sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            height: 100vh;
            background: linear-gradient(180deg, #1a3a5c 0%, #0d2840 100%);
            padding: 20px 0;
            z-index: 1000;
            overflow-y: auto;
        }

        .sidebar-logo {
            padding: 10px 25px 30px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
        }

        .sidebar-logo h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 28px;
            font-weight: 800;
            margin: 0;
        }

        .sidebar-logo .live {
            color: #00d4aa;
        }

        .sidebar-logo .rg {
            color: #e91e8c;
        }

        .sidebar-nav {
            padding: 0 15px;
        }

        .nav-section {
            margin-bottom: 25px;
        }

        .nav-section-title {
            color: rgba(255,255,255,0.4);
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 0 15px;
            margin-bottom: 10px;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 5px;
            transition: all 0.3s ease;
            font-size: 14px;
        }

        .sidebar-nav a:hover {
            background: rgba(255,255,255,0.1);
            color: #fff;
        }

        .sidebar-nav a.active {
            background: linear-gradient(135deg, #00d4aa 0%, #00a085 100%);
            color: #fff;
            font-weight: 500;
        }

        .sidebar-nav a i {
            width: 20px;
            text-align: center;
            font-size: 16px;
        }


        /* Main Content */
        .main-content {
            margin-left: 260px;
            min-height: 100vh;
            background: #f0f2f5;
        }

        /* Header */
        .dashboard-header {
            background: #fff;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: #1a3a5c;
            margin: 0;
        }

        .header-title p {
            font-size: 13px;
            color: #6c757d;
            margin: 0;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding: 10px 15px 10px 40px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            width: 300px;
            font-size: 14px;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            outline: none;
            border-color: #00d4aa;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(0,212,170,0.1);
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: linear-gradient(135deg, #00d4aa 0%, #00a085 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 600;
            font-size: 16px;
        }

        /* Content Area */
        .content-area {
            padding: 30px;
        }

        /* Stats Cards */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: #fff;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .stat-card .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 15px;
        }

        .stat-card .stat-icon.gymnasts {
            background: rgba(139,92,246,0.15);
            color: #8b5cf6;
        }

        .stat-card .stat-icon.teams {
            background: rgba(0,212,170,0.15);
            color: #00d4aa;
        }

        .stat-card .stat-icon.events {
            background: rgba(233,30,140,0.15);
            color: #e91e8c;
        }

        .stat-card .stat-icon.apparatus {
            background: rgba(59,130,246,0.15);
            color: #3b82f6;
        }

        .stat-card h3 {
            font-size: 28px;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 5px;
        }

        .stat-card p {
            font-size: 13px;
            color: #6c757d;
            margin: 0;
        }

        /* Table Card */
        .table-card {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .table-card-header {
            padding: 20px 25px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-card-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: #1a3a5c;
            margin: 0;
        }

        .btn-add {
            background: linear-gradient(135deg, #00d4aa 0%, #1a3a5c 100%);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,212,170,0.3);
            color: #fff;
        }

        /* Table Styles */
        .table-responsive {
            padding: 0 25px 25px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e9ecef;
        }

        .data-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
            color: #495057;
            vertical-align: middle;
        }

        .data-table tbody tr:hover {
            background: #f8f9fa;
        }

        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Badge Styles */
        .badge-category {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-u12 {
            background: rgba(233,30,140,0.15);
            color: #e91e8c;
        }

        .badge-u9 {
            background: rgba(139,92,246,0.15);
            color: #8b5cf6;
        }

        .badge-apparatus {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 500;
            background: rgba(0,212,170,0.15);
            color: #00a085;
            margin: 2px;
        }

        /* Action Buttons */
        .btn-action {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0 3px;
        }

        .btn-edit {
            background: rgba(59,130,246,0.15);
            color: #3b82f6;
        }

        .btn-edit:hover {
            background: #3b82f6;
            color: #fff;
        }

        .btn-delete {
            background: rgba(220,53,69,0.15);
            color: #dc3545;
        }

        .btn-delete:hover {
            background: #dc3545;
            color: #fff;
        }

        .btn-view {
            background: rgba(139,92,246,0.15);
            color: #8b5cf6;
        }

        .btn-view:hover {
            background: #8b5cf6;
            color: #fff;
        }

        /* Modal Styles */
        .modal-content {
            border: none;
            border-radius: 15px;
        }

        .modal-header {
            background: linear-gradient(135deg, #1a3a5c 0%, #0d2840 100%);
            color: #fff;
            border-radius: 15px 15px 0 0;
            padding: 20px 25px;
        }

        .modal-title {
            font-weight: 600;
        }

        .modal-header .btn-close {
            filter: brightness(0) invert(1);
        }

        .modal-body {
            padding: 25px;
        }

        .modal-body .form-label {
            font-weight: 500;
            color: #1a3a5c;
            margin-bottom: 8px;
        }

        .modal-body .form-control,
        .modal-body .form-select {
            border-radius: 10px;
            border: 1px solid #e0e0e0;
            padding: 12px 15px;
            font-size: 14px;
        }

        .modal-body .form-control:focus,
        .modal-body .form-select:focus {
            border-color: #00d4aa;
            box-shadow: 0 0 0 3px rgba(0,212,170,0.1);
        }

        .modal-footer {
            border-top: 1px solid #f0f0f0;
            padding: 15px 25px;
        }

        .btn-submit {
            background: linear-gradient(135deg, #00d4aa 0%, #1a3a5c 100%);
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,212,170,0.3);
        }

        .btn-cancel {
            background: #f0f0f0;
            color: #6c757d;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #e0e0e0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state img {
            width: 150px;
            margin-bottom: 20px;
            opacity: 0.7;
        }

        .empty-state h4 {
            color: #6c757d;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #adb5bd;
            font-size: 14px;
        }

        /* Choices.js Custom Styles */
        .choices__inner {
            border-radius: 10px !important;
            border: 1px solid #e0e0e0 !important;
            padding: 10px 12px !important;
            min-height: 48px !important;
            background: #fff !important;
        }

        .choices__inner:focus {
            border-color: #00d4aa !important;
            box-shadow: 0 0 0 3px rgba(0,212,170,0.1) !important;
        }

        .choices__list--dropdown {
            border-radius: 10px !important;
            border: 1px solid #e0e0e0 !important;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1) !important;
        }

        .choices__item--selectable.is-highlighted {
            background: rgba(0,212,170,0.15) !important;
            color: #1a3a5c !important;
        }

        .choices__item {
            background: linear-gradient(135deg, #00d4aa 0%, #00a085 100%) !important;
            border: none !important;
            border-radius: 15px !important;
            padding: 4px 10px !important;
        }

        .choices__button {
            border-left: 1px solid rgba(255,255,255,0.3) !important;
        }

        /* Image Modal */
        .img-container {
            text-align: center;
            padding: 20px;
        }

        .img-container img {
            max-width: 100%;
            max-height: 500px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .stats-row {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 991px) {
            .dashboard-sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .dashboard-sidebar.show {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .sidebar-toggle {
                display: block !important;
            }
        }

        @media (max-width: 768px) {
            .stats-row {
                grid-template-columns: 1fr;
            }

            .search-box input {
                width: 200px;
            }

            .table-responsive {
                overflow-x: auto;
            }
        }

        /* Hide sidebar toggle on desktop */
        .sidebar-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 20px;
            color: #1a3a5c;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <input type="hidden" id="staffID" value="<%= staffID %>">

    <!-- Sidebar -->
    <aside class="dashboard-sidebar" id="sidebar">
        <div class="sidebar-logo">
            <h2><span class="live">LIVE</span><span class="rg">RG</span></h2>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section">
                <div class="nav-section-title">Main Menu</div>
                <a href="dashboard.jsp"><i class="fas fa-th-large"></i> Dashboard</a>
            </div>

            <% if ("superadmin".equals(userRole) || "staff".equals(userRole)) { %>
            <div class="nav-section">
                <div class="nav-section-title">Management</div>
                <a href="headDetails.jsp"><i class="fas fa-user-tie"></i> Head Judges</a>
                <a href="judgesDetails.jsp"><i class="fas fa-gavel"></i> Judges</a>
            </div>
            <% } %>

            <div class="nav-section">
                <div class="nav-section-title">Competitions</div>
                <a href="eventDetails.jsp"><i class="fas fa-calendar-alt"></i> Events</a>
                <a href="teamDetails.jsp"><i class="fas fa-users"></i> Teams</a>
                <a href="gymnastDetails.jsp" class="active"><i class="fas fa-running"></i> Gymnasts</a>
            </div>

            <div class="nav-section">
                <div class="nav-section-title">Scoring</div>
                <a href="../scoring/jury/juryAccess.jsp"><i class="fas fa-desktop"></i> Jury Panel</a>
            </div>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="dashboard-header">
            <div class="d-flex align-items-center gap-3">
                <button class="sidebar-toggle" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="header-title">
                    <h1>Gymnast Management</h1>
                    <p>Manage all registered gymnasts</p>
                </div>
            </div>

            <div class="header-actions">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search gymnasts..." onkeyup="filterTable()">
                </div>
                <div class="user-avatar">
                    <%= userRole != null ? userRole.substring(0, 1).toUpperCase() : "U" %>
                </div>
            </div>
        </header>

        <!-- Content Area -->
        <div class="content-area">
            <!-- Stats Row -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="stat-icon gymnasts">
                        <i class="fas fa-running"></i>
                    </div>
                    <h3 id="totalGymnasts">0</h3>
                    <p>Total Gymnasts</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon teams">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3><%= teams.size() %></h3>
                    <p>Teams</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon events">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <h3><%= eventList.size() %></h3>
                    <p>Events</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon apparatus">
                        <i class="fas fa-circle"></i>
                    </div>
                    <h3><%= apparatusList.size() %></h3>
                    <p>Apparatus Types</p>
                </div>
            </div>

            <!-- Table Card -->
            <div class="table-card">
                <div class="table-card-header">
                    <h3><i class="fas fa-running me-2"></i>Gymnast List</h3>
                    <% if (staffID == null) { %>
                    <button class="btn-add" data-bs-toggle="modal" data-bs-target="#AddGymnastModal">
                        <i class="fas fa-plus"></i> Add Gymnast
                    </button>
                    <% } %>
                </div>

                <div class="table-responsive">
                    <table class="data-table" id="gymnastTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>IC Number</th>
                                <th>School</th>
                                <th>Category</th>
                                <th>Apparatus</th>
                                <th>Team</th>
                                <th>Event</th>
                                <% if (staffID == null) { %>
                                <th>Actions</th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody id="gymnastTableBody">
                            <!-- Data loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Add Gymnast Modal -->
    <div class="modal fade" id="AddGymnastModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-user-plus me-2"></i>Add New Gymnast</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxAddGymnast" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Gymnast Name</label>
                                <input type="text" name="gymnastName" id="gymnastName" class="form-control" placeholder="Enter full name">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Identity Card Number</label>
                                <input type="text" name="gymnastIC" id="gymnastIC" class="form-control" placeholder="Enter IC number">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">IC Picture</label>
                                <input type="file" class="form-control" name="gymnastPic" id="gymnastPic" accept="image/*">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">School</label>
                                <input type="text" name="gymnastSchool" id="gymnastSchool" class="form-control" placeholder="Enter school name">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Category</label>
                                <select name="gymnastCategory" id="gymnastCategory" class="form-select">
                                    <option value="" hidden>Select Category</option>
                                    <option value="U12">U12</option>
                                    <option value="U9">U9</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Team</label>
                                <select name="gymnastTeam" id="gymnastTeam" class="form-select">
                                    <option value="" hidden>Select Team</option>
                                    <% for (Team team : teams) { %>
                                    <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Event</label>
                                <select name="gymnastEvent" id="gymnastEvent" class="form-select">
                                    <option value="" hidden>Select Event</option>
                                    <% for (Event event : eventList) { %>
                                    <option value="<%= event.getEventID() %>"><%= event.getEventName() %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Apparatus (Multiple)</label>
                                <select name="select2" id="select2" class="form-select" multiple>
                                    <% for (Apparatus apparatus : apparatusList) { %>
                                    <option value="<%= apparatus.getApparatusID() %>"><%= apparatus.getApparatusName() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-submit" onclick="addGymnast()">
                        <i class="fas fa-save me-2"></i>Save Gymnast
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Gymnast Modal -->
    <div class="modal fade" id="updateGymnastModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Update Gymnast</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxUpdateGymnast" enctype="multipart/form-data">
                        <input type="hidden" name="updateGymnastID" id="updateGymnastID">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Gymnast Name</label>
                                <input type="text" name="updateGymnastName" id="updateGymnastName" class="form-control">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Identity Card Number</label>
                                <input type="text" name="updateGymnastIC" id="updateGymnastIC" class="form-control">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">IC Picture (Leave empty to keep current)</label>
                                <input type="file" class="form-control" name="updateGymnastPic" id="updateGymnastPic" accept="image/*">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">School</label>
                                <input type="text" name="updateGymnastSchool" id="updateGymnastSchool" class="form-control">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Category</label>
                                <select name="updateGymnastCategory" id="updateGymnastCategory" class="form-select">
                                    <option value="U12">U12</option>
                                    <option value="U9">U9</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Team</label>
                                <select name="updateGymnastTeam" id="updateGymnastTeam" class="form-select">
                                    <option value="" hidden>Select Team</option>
                                    <% for (Team team : teams) { %>
                                    <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Event</label>
                                <select name="updateGymnastEvent" id="updateGymnastEvent" class="form-select">
                                    <option value="" hidden>Select Event</option>
                                    <% for (Event event : eventList) { %>
                                    <option value="<%= event.getEventID() %>"><%= event.getEventName() %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Current Apparatus</label>
                                <div id="apparatusValuesContainer" class="mb-2"></div>
                                <label class="form-label">New Apparatus (Multiple)</label>
                                <select name="select3" id="select3" class="form-select" multiple>
                                    <% for (Apparatus apparatus : apparatusList) { %>
                                    <option value="<%= apparatus.getApparatusID() %>"><%= apparatus.getApparatusName() %></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-submit" onclick="updateGymnast()">
                        <i class="fas fa-save me-2"></i>Update Gymnast
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- View Image Modal -->
    <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-id-card me-2"></i>Identity Card Image</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="imageContainer" class="img-container"></div>
                    <input type="hidden" id="imageGymnastID">
                    <input type="hidden" id="imageGymnastPIC">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white" style="background: linear-gradient(135deg, #dc3545 0%, #b02a37 100%) !important;">
                    <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center py-4">
                    <i class="fas fa-trash-alt text-danger" style="font-size: 48px; margin-bottom: 20px;"></i>
                    <h5>Are you sure?</h5>
                    <p class="text-muted">This action cannot be undone. The gymnast will be permanently deleted.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">
                        <i class="fas fa-trash me-2"></i>Delete
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/gh/bbbootstrap/libraries@main/choices.min.js"></script>

    <script>
        // Initialize Choices.js for multi-select
        var choicesSelect2, choicesSelect3;

        $(document).ready(function() {
            // Initialize Choices for Add form
            choicesSelect2 = new Choices('#select2', {
                removeItemButton: true,
                maxItemCount: 5,
                searchResultLimit: 5,
                renderChoiceLimit: 5,
                itemSelectText: 'Click to select',
                placeholderValue: 'Select apparatus'
            });

            // Initialize Choices for Update form
            choicesSelect3 = new Choices('#select3', {
                removeItemButton: true,
                maxItemCount: 5,
                searchResultLimit: 5,
                renderChoiceLimit: 5,
                itemSelectText: 'Click to select',
                placeholderValue: 'Select apparatus'
            });

            // Load gymnast data
            fetchGymnastData();
        });

        // Sidebar toggle for mobile
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('show');
        }

        // Table search/filter
        function filterTable() {
            var input = document.getElementById('searchInput');
            var filter = input.value.toLowerCase();
            var table = document.getElementById('gymnastTable');
            var tr = table.getElementsByTagName('tr');

            for (var i = 1; i < tr.length; i++) {
                var td = tr[i].getElementsByTagName('td');
                var found = false;

                for (var j = 0; j < td.length; j++) {
                    if (td[j]) {
                        var txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }

                tr[i].style.display = found ? '' : 'none';
            }
        }

        // Fetch gymnast data
        function fetchGymnastData() {
            var staffID = $('#staffID').val();

            $.ajax({
                type: 'GET',
                url: '../ListGymnastServlet',
                dataType: 'JSON',
                success: function(data) {
                    $('#gymnastTableBody').empty();
                    $('#totalGymnasts').text(data.length);

                    if (data.length === 0) {
                        $('#gymnastTableBody').html(
                            '<tr><td colspan="' + (staffID === 'null' ? '9' : '8') + '">' +
                            '<div class="empty-state">' +
                            '<i class="fas fa-running" style="font-size: 60px; color: #dee2e6; margin-bottom: 15px;"></i>' +
                            '<h4>No Gymnasts Found</h4>' +
                            '<p>Add your first gymnast to get started</p>' +
                            '</div></td></tr>'
                        );
                    } else {
                        $.each(data, function(index, gymnast) {
                            var row = $('<tr>');

                            // Row number
                            row.append($('<td>').text(index + 1));

                            // Name
                            row.append($('<td>').html('<strong>' + gymnast.gymnastName + '</strong>'));

                            // IC with view button
                            var icCell = $('<td>').text(gymnast.gymnastIC);
                            var viewBtn = $('<button>')
                                .addClass('btn-action btn-view ms-2')
                                .html('<i class="fas fa-eye"></i>')
                                .attr('title', 'View IC')
                                .click(function() { viewImage(gymnast.gymnastID); });
                            icCell.append(viewBtn);
                            row.append(icCell);

                            // School
                            row.append($('<td>').text(gymnast.gymnastSchool));

                            // Category with badge
                            var categoryBadge = $('<span>')
                                .addClass('badge-category')
                                .addClass(gymnast.gymnastCategory === 'U12' ? 'badge-u12' : 'badge-u9')
                                .text(gymnast.gymnastCategory);
                            row.append($('<td>').append(categoryBadge));

                            // Apparatus badges
                            var apparatusCell = $('<td>');
                            if (gymnast.apparatusList) {
                                var apparatusArray = gymnast.apparatusList.split(',');
                                apparatusArray.forEach(function(app) {
                                    apparatusCell.append($('<span>').addClass('badge-apparatus').text(app.trim()));
                                });
                            }
                            row.append(apparatusCell);

                            // Team
                            row.append($('<td>').text(gymnast.teamName));

                            // Event
                            row.append($('<td>').text(gymnast.eventName));

                            // Actions (only for non-staff)
                            if (staffID === 'null') {
                                var actionCell = $('<td>');

                                var editBtn = $('<button>')
                                    .addClass('btn-action btn-edit')
                                    .html('<i class="fas fa-edit"></i>')
                                    .attr('title', 'Edit')
                                    .click(function() { displayGymnast(gymnast.gymnastID); });

                                var deleteBtn = $('<button>')
                                    .addClass('btn-action btn-delete')
                                    .html('<i class="fas fa-trash"></i>')
                                    .attr('title', 'Delete')
                                    .click(function() { deleteGymnast(gymnast.gymnastID); });

                                actionCell.append(editBtn, deleteBtn);
                                row.append(actionCell);
                            }

                            $('#gymnastTableBody').append(row);
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching gymnast data:", error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to load gymnast data'
                    });
                }
            });
        }

        // Add gymnast
        function addGymnast() {
            var gymnastName = $("#gymnastName").val().trim();
            var gymnastIC = $("#gymnastIC").val().trim();
            var gymnastPic = $("#gymnastPic").val().trim();
            var gymnastSchool = $("#gymnastSchool").val().trim();
            var gymnastCategory = $("#gymnastCategory").val();
            var gymnastTeam = $("#gymnastTeam").val();
            var gymnastEvent = $("#gymnastEvent").val();
            var selectedValues = choicesSelect2.getValue(true);

            // Validation
            var missing = [];
            if (!gymnastName) missing.push('Gymnast Name');
            if (!gymnastIC) missing.push('IC Number');
            if (!gymnastPic) missing.push('IC Picture');
            if (!gymnastSchool) missing.push('School');
            if (!gymnastCategory) missing.push('Category');
            if (!gymnastTeam) missing.push('Team');
            if (!gymnastEvent) missing.push('Event');
            if (!selectedValues || selectedValues.length === 0) missing.push('Apparatus');

            if (missing.length > 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Missing Fields',
                    html: '<p>Please fill in:</p><ul style="text-align:left;">' +
                          missing.map(f => '<li>' + f + '</li>').join('') + '</ul>'
                });
                return;
            }

            var formData = new FormData($('#ajaxAddGymnast')[0]);
            formData.append('#select2', selectedValues.join(','));

            $.ajax({
                type: 'POST',
                url: '../AddGymnastServlet',
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    try {
                        var response = JSON.parse(data);
                        var msg = response[0].msg;

                        if (msg == 1) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success!',
                                text: 'Gymnast added successfully',
                                timer: 2000,
                                showConfirmButton: false
                            });
                            $('#ajaxAddGymnast')[0].reset();
                            choicesSelect2.removeActiveItems();
                            bootstrap.Modal.getInstance(document.getElementById('AddGymnastModal')).hide();
                            fetchGymnastData();
                        } else if (msg == 3) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'Invalid File',
                                text: 'Only image files are allowed'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to add gymnast'
                            });
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX error:', error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while processing your request'
                    });
                }
            });
        }

        // Display gymnast for editing
        function displayGymnast(gymnastID) {
            $.ajax({
                type: 'GET',
                url: '../DisplayGymnastServlet',
                data: { gymnastID: gymnastID },
                dataType: 'JSON',
                success: function(gymnast) {
                    $('#updateGymnastName').val(gymnast.gymnastName);
                    $('#updateGymnastIC').val(gymnast.gymnastIC);
                    $('#updateGymnastSchool').val(gymnast.gymnastSchool);
                    $('#updateGymnastCategory').val(gymnast.gymnastCategory);
                    $('#updateGymnastID').val(gymnast.gymnastID);
                    $('#updateGymnastTeam').val(gymnast.teamID);
                    $('#updateGymnastEvent').val(gymnast.eventID);

                    // Display current apparatus
                    if (gymnast.apparatusList) {
                        var apparatusArray = gymnast.apparatusList.split(',');
                        var html = '';
                        apparatusArray.forEach(function(app) {
                            html += '<span class="badge-apparatus">' + app.trim() + '</span>';
                        });
                        $('#apparatusValuesContainer').html(html);
                    }

                    // Clear previous selections in select3
                    choicesSelect3.removeActiveItems();

                    var modal = new bootstrap.Modal(document.getElementById('updateGymnastModal'));
                    modal.show();
                },
                error: function(xhr, status, error) {
                    console.error("Error retrieving gymnast:", error);
                }
            });
        }

        // Update gymnast
        function updateGymnast() {
            var selectedValues = choicesSelect3.getValue(true);
            var formData = new FormData($('#ajaxUpdateGymnast')[0]);

            if (selectedValues && selectedValues.length > 0) {
                formData.append('select3', selectedValues.join(','));
            }

            $.ajax({
                type: 'POST',
                url: '../UpdateGymnastServlet',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Updated!',
                            text: 'Gymnast updated successfully',
                            timer: 2000,
                            showConfirmButton: false
                        });
                        bootstrap.Modal.getInstance(document.getElementById('updateGymnastModal')).hide();
                        fetchGymnastData();
                    } else if (response.msg === 2) {
                        Swal.fire({
                            icon: 'warning',
                            title: 'Invalid File',
                            text: 'Only image files are allowed'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to update gymnast'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error updating gymnast:", error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'An error occurred while updating'
                    });
                }
            });
        }

        // Delete gymnast
        function deleteGymnast(gymnastID) {
            var modal = new bootstrap.Modal(document.getElementById('confirmationModal'));
            modal.show();

            // Remove previous click handlers and add new one
            $('#confirmDeleteBtn').off('click').on('click', function() {
                $.ajax({
                    type: 'POST',
                    url: '../DeleteGymnastServlet',
                    data: { gymnastID: gymnastID },
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Deleted!',
                            text: 'Gymnast deleted successfully',
                            timer: 2000,
                            showConfirmButton: false
                        });
                        modal.hide();
                        fetchGymnastData();
                    },
                    error: function(xhr, status, error) {
                        console.error("Error deleting gymnast:", error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Failed to delete gymnast'
                        });
                    }
                });
            });
        }

        // View IC image
        function viewImage(gymnastID) {
            $.ajax({
                type: 'GET',
                url: '../DisplayGymnastServlet',
                data: { gymnastID: gymnastID },
                dataType: 'JSON',
                success: function(gymnast) {
                    var imagePath = '/liverg/registration/uploads/' + gymnast.gymnastICPic;
                    var img = $('<img>').attr('src', imagePath).addClass('img-fluid');
                    $('#imageContainer').empty().append(img);

                    var modal = new bootstrap.Modal(document.getElementById('imageModal'));
                    modal.show();
                },
                error: function(xhr, status, error) {
                    console.error("Error retrieving image:", error);
                }
            });
        }
    </script>
</body>
</html>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
