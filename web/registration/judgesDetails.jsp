<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page import="com.registration.bean.Team" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    if (userRole == null) {
        response.sendRedirect("../LogoutServlet");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "User";

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Team> teams = new ArrayList<>();

    Integer staffID = (Integer) session.getAttribute("staffID");
    Integer clerkID = (Integer) session.getAttribute("clerkID");

    try {
        DBConnect db = new DBConnect();
        con = db.getConnection();
        stmt = con.createStatement();

        rs = stmt.executeQuery("SELECT * FROM TEAM");
        while (rs.next()) {
            Team team = new Team();
            team.setTeamID(rs.getInt("teamID"));
            team.setTeamName(rs.getString("teamName"));
            teams.add(team);
        }
        rs.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Judges - LIVERG Scoring System</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

    <style>
        :root {
            --sidebar-width: 280px;
            --header-height: 70px;
            --primary-cyan: #00d4aa;
            --primary-magenta: #e91e8c;
            --primary-purple: #8b5cf6;
            --primary-blue: #1a3a5c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .dashboard-sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: var(--sidebar-width);
            background: linear-gradient(180deg, #1a3a5c 0%, #0d2840 100%);
            z-index: 1000;
            transition: all 0.3s ease;
            overflow-y: auto;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
        }

        .sidebar-logo-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--primary-cyan), var(--primary-magenta));
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
        }

        .sidebar-logo-text {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 1.75rem;
            letter-spacing: -0.5px;
        }

        .sidebar-nav {
            padding: 1rem 0;
        }

        .sidebar-section {
            padding: 0.5rem 1.5rem;
            margin-top: 0.5rem;
        }

        .sidebar-section-title {
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: rgba(255,255,255,0.4);
            margin-bottom: 0.5rem;
        }

        .sidebar-nav-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.5rem;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
        }

        .sidebar-nav-item:hover {
            background: rgba(255,255,255,0.05);
            color: white;
            border-left-color: rgba(0, 212, 170, 0.5);
        }

        .sidebar-nav-item.active {
            background: rgba(0, 212, 170, 0.1);
            color: #00d4aa;
            border-left-color: #00d4aa;
        }

        .sidebar-nav-item i {
            width: 20px;
            text-align: center;
            font-size: 1rem;
        }

        .sidebar-nav-item span {
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Main Content */
        .dashboard-main {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
        }

        /* Header */
        .dashboard-header {
            background: white;
            height: var(--header-height);
            padding: 0 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .sidebar-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 1.25rem;
            color: #1a3a5c;
            cursor: pointer;
        }

        .page-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1a3a5c;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .page-title i {
            color: var(--primary-cyan);
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .header-search {
            position: relative;
        }

        .header-search input {
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            width: 250px;
            font-size: 0.875rem;
            transition: all 0.2s;
        }

        .header-search input:focus {
            outline: none;
            border-color: #00d4aa;
            box-shadow: 0 0 0 3px rgba(0, 212, 170, 0.1);
        }

        .header-search i {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }

        .user-dropdown {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.5rem;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .user-dropdown:hover {
            background: #f1f5f9;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #00d4aa, #1a3a5c);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }

        .user-info {
            text-align: left;
        }

        .user-name {
            font-size: 0.875rem;
            font-weight: 600;
            color: #1a3a5c;
        }

        .user-role {
            font-size: 0.75rem;
            color: #64748b;
            text-transform: capitalize;
        }

        /* Content Area */
        .dashboard-content {
            padding: 2rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-icon.cyan {
            background: rgba(0, 212, 170, 0.1);
            color: var(--primary-cyan);
        }

        .stat-icon.magenta {
            background: rgba(233, 30, 140, 0.1);
            color: var(--primary-magenta);
        }

        .stat-icon.purple {
            background: rgba(139, 92, 246, 0.1);
            color: var(--primary-purple);
        }

        .stat-value {
            font-size: 1.75rem;
            font-weight: 700;
            color: #1a3a5c;
        }

        .stat-label {
            font-size: 0.875rem;
            color: #64748b;
        }

        /* Data Card */
        .data-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .data-card-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .data-card-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1a3a5c;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .data-card-title i {
            color: var(--primary-cyan);
        }

        .btn-add {
            padding: 0.625rem 1.25rem;
            background: linear-gradient(135deg, #00d4aa, #1a3a5c);
            border: none;
            border-radius: 0.5rem;
            color: white;
            font-size: 0.875rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 212, 170, 0.3);
        }

        .data-card-body {
            padding: 0;
        }

        /* Table */
        .liverg-table {
            width: 100%;
            border-collapse: collapse;
        }

        .liverg-table thead th {
            background: #f8fafc;
            padding: 0.875rem 1rem;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #64748b;
            text-align: left;
            border-bottom: 2px solid #e2e8f0;
        }

        .liverg-table tbody td {
            padding: 1rem;
            font-size: 0.875rem;
            color: #334155;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .liverg-table tbody tr:hover {
            background: #f8fafc;
        }

        .liverg-table tbody tr:last-child td {
            border-bottom: none;
        }

        .row-number {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, rgba(139, 92, 246, 0.1), rgba(233, 30, 140, 0.1));
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.875rem;
            color: var(--primary-purple);
        }

        .judge-name {
            font-weight: 600;
            color: #1a3a5c;
        }

        .team-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.35rem 0.75rem;
            background: rgba(0, 212, 170, 0.1);
            color: var(--primary-cyan);
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .action-btns {
            display: flex;
            gap: 0.5rem;
        }

        .btn-action {
            width: 36px;
            height: 36px;
            border: none;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-edit {
            background: rgba(0, 212, 170, 0.1);
            color: var(--primary-cyan);
        }

        .btn-edit:hover {
            background: var(--primary-cyan);
            color: white;
            transform: translateY(-2px);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .btn-delete:hover {
            background: #ef4444;
            color: white;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        .empty-state h4 {
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: #94a3b8;
            font-size: 0.875rem;
        }

        /* Modal Styles */
        .modal-content {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            border-bottom: 1px solid #e2e8f0;
            padding: 1.25rem 1.5rem;
            background: #f8fafc;
            border-radius: 1rem 1rem 0 0;
        }

        .modal-title {
            font-weight: 600;
            color: #1a3a5c;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modal-title i {
            color: var(--primary-cyan);
        }

        .modal-body {
            padding: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            font-size: 0.75rem;
            font-weight: 600;
            color: #64748b;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            transition: all 0.2s;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary-cyan);
            box-shadow: 0 0 0 3px rgba(0, 212, 170, 0.1);
        }

        .modal-footer {
            border-top: 1px solid #e2e8f0;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: flex-end;
            gap: 0.75rem;
        }

        .btn-modal {
            padding: 0.625rem 1.25rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-modal-secondary {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        .btn-modal-secondary:hover {
            background: #e2e8f0;
        }

        .btn-modal-primary {
            background: linear-gradient(135deg, #00d4aa, #1a3a5c);
            color: white;
        }

        .btn-modal-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 212, 170, 0.3);
        }

        .btn-modal-danger {
            background: #ef4444;
            color: white;
        }

        .btn-modal-danger:hover {
            background: #dc2626;
        }

        /* Footer */
        .dashboard-footer {
            padding: 1.5rem 2rem;
            text-align: center;
            color: #64748b;
            font-size: 0.875rem;
            border-top: 1px solid #e2e8f0;
            background: white;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .dashboard-sidebar {
                transform: translateX(-100%);
            }

            .dashboard-sidebar.open {
                transform: translateX(0);
            }

            .dashboard-main {
                margin-left: 0;
            }

            .sidebar-toggle {
                display: block;
            }

            .sidebar-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }

            .sidebar-overlay.open {
                display: block;
            }
        }

        @media (max-width: 768px) {
            .dashboard-content {
                padding: 1rem;
            }

            .header-search {
                display: none;
            }

            .user-info {
                display: none;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar Overlay (Mobile) -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <!-- Sidebar -->
    <aside class="dashboard-sidebar" id="sidebar">
        <div class="sidebar-header">
            <a href="dashboard.jsp" class="sidebar-logo">
                <div class="sidebar-logo-text">
                    <span style="color: #00d4aa;">LIVE</span><span style="color: #e91e8c;">RG</span>
                </div>
            </a>
        </div>

        <nav class="sidebar-nav">
            <div class="sidebar-section">
                <div class="sidebar-section-title">Main Menu</div>
            </div>
            <a href="dashboard.jsp" class="sidebar-nav-item">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>

            <% if (userRole.equals("superadmin") || userRole.equals("staff")) { %>
            <div class="sidebar-section">
                <div class="sidebar-section-title">Management</div>
            </div>
            <a href="headDetails.jsp" class="sidebar-nav-item">
                <i class="fas fa-user-shield"></i>
                <span>Head Judges</span>
            </a>
            <a href="judgesDetails.jsp" class="sidebar-nav-item active">
                <i class="fas fa-gavel"></i>
                <span>Judges</span>
            </a>
            <% } %>

            <div class="sidebar-section">
                <div class="sidebar-section-title">Competitions</div>
            </div>
            <a href="eventDetails.jsp" class="sidebar-nav-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Events</span>
            </a>
            <a href="teamDetails.jsp" class="sidebar-nav-item">
                <i class="fas fa-users"></i>
                <span>Teams</span>
            </a>
            <a href="gymnastDetails.jsp" class="sidebar-nav-item">
                <i class="fas fa-running"></i>
                <span>Gymnasts</span>
            </a>

            <div class="sidebar-section">
                <div class="sidebar-section-title">Scoring</div>
            </div>
            <a href="../scoring/jury/juryAccess.jsp" class="sidebar-nav-item">
                <i class="fas fa-desktop"></i>
                <span>Jury Panel</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="dashboard-main">
        <!-- Header -->
        <header class="dashboard-header">
            <div class="header-left">
                <button class="sidebar-toggle" id="sidebarToggle">
                    <i class="fas fa-bars"></i>
                </button>
                <h1 class="page-title">
                    <i class="fas fa-gavel"></i>
                    Judges Management
                </h1>
            </div>

            <div class="header-right">
                <div class="header-search">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search judges...">
                </div>

                <div class="user-dropdown dropdown">
                    <div data-bs-toggle="dropdown">
                        <div class="user-avatar">
                            <%= userName.substring(0, 1).toUpperCase() %>
                        </div>
                    </div>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="../LogoutServlet"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </div>
                <div class="user-info d-none d-md-block">
                    <div class="user-name"><%= userName %></div>
                    <div class="user-role"><%= userRole %></div>
                </div>
            </div>
        </header>

        <!-- Content -->
        <div class="dashboard-content">
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon cyan">
                        <i class="fas fa-gavel"></i>
                    </div>
                    <div>
                        <div class="stat-value" id="totalJudges">0</div>
                        <div class="stat-label">Total Judges</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon magenta">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <div class="stat-value"><%= teams.size() %></div>
                        <div class="stat-label">Total Teams</div>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon purple">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div>
                        <div class="stat-value" id="activeJudges">0</div>
                        <div class="stat-label">Active Judges</div>
                    </div>
                </div>
            </div>

            <!-- Data Card -->
            <div class="data-card">
                <div class="data-card-header">
                    <h3 class="data-card-title">
                        <i class="fas fa-gavel"></i>
                        Judges List
                    </h3>
                    <input type="hidden" id="staffID" value="<%= staffID %>">
                    <% if (staffID == null) { %>
                    <button class="btn-add" data-bs-toggle="modal" data-bs-target="#addJudgeModal">
                        <i class="fas fa-plus"></i> Add Judge
                    </button>
                    <% } %>
                </div>
                <div class="data-card-body">
                    <table class="liverg-table">
                        <thead>
                            <tr>
                                <th style="width: 60px;">#</th>
                                <th>Judge Name</th>
                                <th>Identity Card</th>
                                <th>Place of Duty</th>
                                <th>Team</th>
                                <% if (staffID == null) { %>
                                <th style="width: 120px;">Actions</th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody id="judgeTableBody">
                            <!-- Data loaded via AJAX -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="dashboard-footer">
            <p style="margin: 0;">&copy; 2026 LIVERG Gymnastics Scoring System. All rights reserved.</p>
        </footer>
    </main>

    <!-- Add Judge Modal -->
    <div class="modal fade" id="addJudgeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-user-plus"></i> Add Judge</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addJudgeForm">
                        <div class="form-group">
                            <label class="form-label">Judge Name</label>
                            <input type="text" name="judgeName" id="judgeName" class="form-control" placeholder="Enter judge name">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Identity Card</label>
                            <input type="text" name="judgeIC" id="judgeIC" class="form-control" placeholder="Enter IC number">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Place of Duty</label>
                            <input type="text" name="judgePOD" id="judgePOD" class="form-control" placeholder="Enter place of duty">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Team</label>
                            <select name="judgeTeam" id="judgeTeam" class="form-select">
                                <option value="" hidden>Select a Team</option>
                                <% for (Team team : teams) { %>
                                <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                                <% } %>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-modal btn-modal-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-modal btn-modal-primary" onclick="addJudge()">
                        <i class="fas fa-save me-1"></i> Save
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Judge Modal -->
    <div class="modal fade" id="updateJudgeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit"></i> Update Judge</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="updateJudgeForm">
                        <input type="hidden" name="updateJudgeID" id="updateJudgeID">
                        <div class="form-group">
                            <label class="form-label">Judge Name</label>
                            <input type="text" name="updateJudgeName" id="updateJudgeName" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Identity Card</label>
                            <input type="text" name="updateJudgeIC" id="updateJudgeIC" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Place of Duty</label>
                            <input type="text" name="updateJudgePOD" id="updateJudgePOD" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Team</label>
                            <select name="updateJudgeTeam" id="updateJudgeTeam" class="form-select">
                                <option value="" hidden>Select a Team</option>
                                <% for (Team team : teams) { %>
                                <option value="<%= team.getTeamID() %>"><%= team.getTeamName() %></option>
                                <% } %>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-modal btn-modal-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-modal btn-modal-primary" onclick="updateJudge()">
                        <i class="fas fa-save me-1"></i> Update
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarOverlay = document.getElementById('sidebarOverlay');

        if (sidebarToggle) {
            sidebarToggle.addEventListener('click', () => {
                sidebar.classList.toggle('open');
                sidebarOverlay.classList.toggle('open');
            });
        }

        if (sidebarOverlay) {
            sidebarOverlay.addEventListener('click', () => {
                sidebar.classList.remove('open');
                sidebarOverlay.classList.remove('open');
            });
        }

        // SweetAlert2 Config
        const swalConfig = {
            confirmButtonColor: '#00d4aa',
            cancelButtonColor: '#64748b'
        };

        var staffID = $('#staffID').val();
        var allJudges = [];

        function fetchJudgeData() {
            $.ajax({
                type: 'GET',
                url: '../ListJudgeServlet',
                dataType: 'JSON',
                success: function(data) {
                    allJudges = data;
                    renderJudges(data);
                    $('#totalJudges').text(data.length);
                    $('#activeJudges').text(data.length);
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    showEmptyState();
                }
            });
        }

        function renderJudges(data) {
            $('#judgeTableBody').empty();

            if (data.length === 0) {
                showEmptyState();
                return;
            }

            $.each(data, function(index, judge) {
                var actionButtons = staffID === 'null' ?
                    '<td>' +
                    '<div class="action-btns">' +
                    '<button class="btn-action btn-edit" onclick="displayJudge(' + judge.judgeID + ')" title="Edit">' +
                    '<i class="fas fa-edit"></i>' +
                    '</button>' +
                    '<button class="btn-action btn-delete" onclick="deleteJudge(' + judge.judgeID + ')" title="Delete">' +
                    '<i class="fas fa-trash"></i>' +
                    '</button>' +
                    '</div>' +
                    '</td>' : '';

                var row = '<tr>' +
                    '<td><div class="row-number">' + (index + 1) + '</div></td>' +
                    '<td class="judge-name">' + escapeHtml(judge.judgeName) + '</td>' +
                    '<td>' + escapeHtml(judge.judgeNoIc) + '</td>' +
                    '<td>' + escapeHtml(judge.judgePOD) + '</td>' +
                    '<td><span class="team-badge"><i class="fas fa-users"></i> ' + escapeHtml(judge.teamName) + '</span></td>' +
                    actionButtons +
                    '</tr>';

                $('#judgeTableBody').append(row);
            });
        }

        function showEmptyState() {
            var colspan = staffID === 'null' ? 6 : 5;
            $('#judgeTableBody').html(
                '<tr><td colspan="' + colspan + '">' +
                '<div class="empty-state">' +
                '<i class="fas fa-gavel"></i>' +
                '<h4>No Judges Found</h4>' +
                '<p>Add your first judge to get started</p>' +
                '</div>' +
                '</td></tr>'
            );
        }

        function escapeHtml(text) {
            if (!text) return '';
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        // Search functionality
        $('#searchInput').on('input', function() {
            var searchTerm = $(this).val().toLowerCase();

            if (searchTerm === '') {
                renderJudges(allJudges);
                return;
            }

            var filtered = allJudges.filter(function(judge) {
                return judge.judgeName.toLowerCase().includes(searchTerm) ||
                       judge.judgeNoIc.toLowerCase().includes(searchTerm) ||
                       judge.judgePOD.toLowerCase().includes(searchTerm) ||
                       judge.teamName.toLowerCase().includes(searchTerm);
            });

            renderJudges(filtered);
        });

        function addJudge() {
            var judgeName = $("#judgeName").val().trim();
            var judgeIC = $("#judgeIC").val().trim();
            var judgePOD = $("#judgePOD").val().trim();
            var judgeTeam = $("#judgeTeam").val();

            if (!judgeName || !judgeIC || !judgePOD || !judgeTeam) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Missing Fields',
                    text: 'Please fill in all required fields',
                    ...swalConfig
                });
                return;
            }

            $.ajax({
                type: 'POST',
                url: '../AddJudgeServlet',
                data: $("#addJudgeForm").serialize(),
                dataType: 'JSON',
                success: function(response) {
                    if (response[0].msg == 1) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Judge added successfully',
                            ...swalConfig,
                            timer: 2000,
                            showConfirmButton: false
                        });
                        $('#addJudgeForm')[0].reset();
                        bootstrap.Modal.getInstance(document.getElementById('addJudgeModal')).hide();
                        fetchJudgeData();
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to add judge',
                        ...swalConfig
                    });
                }
            });
        }

        function displayJudge(judgeID) {
            $.ajax({
                type: 'GET',
                url: '../DisplayJudgeServlet',
                data: { judgeID: judgeID },
                dataType: 'JSON',
                success: function(judge) {
                    $('#updateJudgeName').val(judge.judgeName);
                    $('#updateJudgeIC').val(judge.judgeNoIc);
                    $('#updateJudgePOD').val(judge.judgePOD);
                    $('#updateJudgeTeam').val(judge.teamID);
                    $('#updateJudgeID').val(judge.judgeID);
                    new bootstrap.Modal(document.getElementById('updateJudgeModal')).show();
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to load judge data',
                        ...swalConfig
                    });
                }
            });
        }

        function updateJudge() {
            $.ajax({
                type: 'POST',
                url: '../UpdateJudgeServlet',
                data: $("#updateJudgeForm").serialize(),
                dataType: 'JSON',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Updated!',
                            text: 'Judge updated successfully',
                            ...swalConfig,
                            timer: 2000,
                            showConfirmButton: false
                        });
                        bootstrap.Modal.getInstance(document.getElementById('updateJudgeModal')).hide();
                        fetchJudgeData();
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to update judge',
                        ...swalConfig
                    });
                }
            });
        }

        function deleteJudge(judgeID) {
            Swal.fire({
                title: 'Delete Judge?',
                text: 'This action cannot be undone',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#64748b',
                confirmButtonText: 'Yes, Delete',
                cancelButtonText: 'Cancel'
            }).then(function(result) {
                if (result.isConfirmed) {
                    $.ajax({
                        type: 'POST',
                        url: '../DeleteJudgeServlet',
                        data: { judgeID: judgeID },
                        success: function(response) {
                            if (response.success) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Deleted!',
                                    text: 'Judge has been removed',
                                    ...swalConfig,
                                    timer: 2000,
                                    showConfirmButton: false
                                });
                                fetchJudgeData();
                            }
                        },
                        error: function() {
                            Swal.fire({
                                icon: 'error',
                                title: 'Cannot Delete',
                                text: 'Please delete associated gymnasts first',
                                ...swalConfig
                            });
                        }
                    });
                }
            });
        }

        $(document).ready(function() {
            fetchJudgeData();
        });
    </script>

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
</body>
</html>
