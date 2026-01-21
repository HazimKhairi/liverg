<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.registration.bean.*" %>
<%@ page import="com.connection.DBConnect" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    Integer staffID = (Integer) session.getAttribute("staffID");
    Integer clerkID = (Integer) session.getAttribute("clerkID");
    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "User";

    if (userRole == null) {
        response.sendRedirect("../LogoutServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Head Judges - LIVERG Scoring System</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

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

        .sidebar-logo img {
            height: 40px;
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
            color: var(--primary-magenta);
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

        .judge-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .judge-avatar {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, var(--primary-magenta), var(--primary-purple));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1rem;
        }

        .judge-details .name {
            font-weight: 600;
            color: #1a3a5c;
        }

        .judge-details .badge-role {
            display: inline-block;
            padding: 0.2rem 0.6rem;
            background: rgba(233, 30, 140, 0.1);
            color: var(--primary-magenta);
            border-radius: 1rem;
            font-size: 0.65rem;
            font-weight: 600;
            margin-top: 0.25rem;
        }

        .password-cell {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .password-text {
            font-family: 'Courier New', monospace;
            background: #f1f5f9;
            padding: 0.35rem 0.75rem;
            border-radius: 0.375rem;
            font-size: 0.8rem;
            color: #475569;
        }

        .btn-toggle-password {
            width: 32px;
            height: 32px;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 0.375rem;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-toggle-password:hover {
            background: #e2e8f0;
            color: var(--primary-cyan);
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

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-cyan);
            box-shadow: 0 0 0 3px rgba(0, 212, 170, 0.1);
        }

        .input-group {
            display: flex;
        }

        .input-group .form-control {
            border-radius: 0.5rem 0 0 0.5rem;
        }

        .input-group-text {
            padding: 0 1rem;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-left: none;
            border-radius: 0 0.5rem 0.5rem 0;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
        }

        .input-group-text:hover {
            color: var(--primary-cyan);
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
            <a href="headDetails.jsp" class="sidebar-nav-item active">
                <i class="fas fa-user-shield"></i>
                <span>Head Judges</span>
            </a>
            <a href="judgesDetails.jsp" class="sidebar-nav-item">
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
                    <i class="fas fa-user-shield"></i>
                    Head Judges Management
                </h1>
            </div>

            <div class="header-right">
                <div class="header-search">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search head judges...">
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
            <div class="data-card">
                <div class="data-card-header">
                    <h3 class="data-card-title">
                        <i class="fas fa-user-shield"></i>
                        Head Judges List
                    </h3>
                    <input type="hidden" id="staffID" value="<%= staffID %>">
                    <% if (staffID == null) { %>
                    <button class="btn-add" data-bs-toggle="modal" data-bs-target="#addHeadjudgeModal">
                        <i class="fas fa-plus"></i> Add Head Judge
                    </button>
                    <% } %>
                </div>
                <div class="data-card-body">
                    <table class="liverg-table">
                        <thead>
                            <tr>
                                <th style="width: 60px;">#</th>
                                <th>Name</th>
                                <th>Username</th>
                                <th>Password</th>
                                <% if (staffID == null) { %>
                                <th style="width: 120px;">Actions</th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody id="headTableBody">
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

    <!-- Add Head Judge Modal -->
    <div class="modal fade" id="addHeadjudgeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-user-plus"></i> Add Head Judge</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxAddHeadjudge">
                        <div class="form-group">
                            <label class="form-label">Head Judge Name</label>
                            <input type="text" name="name" id="name" class="form-control" placeholder="Enter full name">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" id="username" class="form-control" placeholder="Enter username">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" name="password" id="password" class="form-control" placeholder="Enter password">
                                <span class="input-group-text" onclick="togglePassword('password', this)">
                                    <i class="bi bi-eye"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Confirm password">
                        </div>
                        <input type="hidden" name="userid" value="<%= clerkID != null ? clerkID : 1 %>">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-modal btn-modal-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-modal btn-modal-primary" onclick="addHeadjudge()">
                        <i class="fas fa-save me-1"></i> Save
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Head Judge Modal -->
    <div class="modal fade" id="updateHeadjudgeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit"></i> Update Head Judge</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="ajaxUpdateHeadjudge">
                        <div class="form-group">
                            <label class="form-label">Head Judge Name</label>
                            <input type="text" name="updateName" id="updateName" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <input type="text" name="updateHeadjudgeName" id="updateHeadjudgeName" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <div class="input-group">
                                <input type="password" name="updateHeadjudgePassword" id="updateHeadjudgePassword" class="form-control">
                                <span class="input-group-text" onclick="togglePassword('updateHeadjudgePassword', this)">
                                    <i class="bi bi-eye"></i>
                                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Confirm Password</label>
                            <input type="password" name="updateConfirmPassword" id="updateConfirmPassword" class="form-control">
                        </div>
                        <input type="hidden" name="updateheadjudgeID" id="updateheadjudgeID">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-modal btn-modal-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn-modal btn-modal-primary" onclick="validateAndUpdateHeadjudge()">
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

        // SweetAlert2 Light Theme Config
        const swalConfig = {
            confirmButtonColor: '#00d4aa',
            cancelButtonColor: '#64748b'
        };

        var staffID = $('#staffID').val();
        var allHeadJudges = [];

        function fetchHeadJudgeData() {
            $.ajax({
                type: 'GET',
                url: '../ListHeadJudgeServlet',
                dataType: 'JSON',
                success: function(data) {
                    allHeadJudges = data;
                    renderHeadJudges(data);
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to load data',
                        ...swalConfig
                    });
                }
            });
        }

        function renderHeadJudges(data) {
            $('#headTableBody').empty();

            if (data.length === 0) {
                var colspan = staffID === 'null' ? 5 : 4;
                $('#headTableBody').html(
                    '<tr><td colspan="' + colspan + '">' +
                    '<div class="empty-state">' +
                    '<i class="fas fa-user-slash"></i>' +
                    '<h4>No Head Judges Found</h4>' +
                    '<p>Add your first head judge to get started</p>' +
                    '</div>' +
                    '</td></tr>'
                );
            } else {
                $.each(data, function(index, head) {
                    var row = '<tr>' +
                        '<td><div class="row-number">' + (index + 1) + '</div></td>' +
                        '<td>' +
                        '<div class="judge-info">' +
                        '<div class="judge-avatar">' + head.headName.charAt(0).toUpperCase() + '</div>' +
                        '<div class="judge-details">' +
                        '<div class="name">' + escapeHtml(head.headName) + '</div>' +
                        '<span class="badge-role">Head Judge</span>' +
                        '</div>' +
                        '</div>' +
                        '</td>' +
                        '<td>' + escapeHtml(head.headUsername) + '</td>' +
                        '<td>' +
                        '<div class="password-cell">' +
                        '<span class="password-text password-hidden-' + head.headjudgeID + '">********</span>' +
                        '<span class="password-text password-visible-' + head.headjudgeID + '" style="display:none;">' + escapeHtml(head.headPassword) + '</span>' +
                        '<button class="btn-toggle-password" onclick="togglePasswordView(' + head.headjudgeID + ')">' +
                        '<i class="bi bi-eye" id="icon-' + head.headjudgeID + '"></i>' +
                        '</button>' +
                        '</div>' +
                        '</td>';

                    if (staffID === 'null') {
                        row += '<td>' +
                            '<div class="action-btns">' +
                            '<button class="btn-action btn-edit" onclick="displayHeadjudge(' + head.headjudgeID + ')" title="Edit">' +
                            '<i class="fas fa-edit"></i>' +
                            '</button>' +
                            '<button class="btn-action btn-delete" onclick="deleteHeadJudge(' + head.headjudgeID + ')" title="Delete">' +
                            '<i class="fas fa-trash"></i>' +
                            '</button>' +
                            '</div>' +
                            '</td>';
                    }

                    row += '</tr>';
                    $('#headTableBody').append(row);
                });
            }
        }

        // Search functionality
        $('#searchInput').on('input', function() {
            var searchTerm = $(this).val().toLowerCase();

            if (searchTerm === '') {
                renderHeadJudges(allHeadJudges);
                return;
            }

            var filtered = allHeadJudges.filter(function(head) {
                return head.headName.toLowerCase().includes(searchTerm) ||
                       head.headUsername.toLowerCase().includes(searchTerm);
            });

            renderHeadJudges(filtered);
        });

        function escapeHtml(text) {
            if (!text) return '';
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        function togglePasswordView(id) {
            var hidden = $('.password-hidden-' + id);
            var visible = $('.password-visible-' + id);
            var icon = $('#icon-' + id);

            if (hidden.is(':visible')) {
                hidden.hide();
                visible.show();
                icon.removeClass('bi-eye').addClass('bi-eye-slash');
            } else {
                hidden.show();
                visible.hide();
                icon.removeClass('bi-eye-slash').addClass('bi-eye');
            }
        }

        function togglePassword(fieldId, element) {
            var field = document.getElementById(fieldId);
            var icon = element.querySelector('i');
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('bi-eye');
                icon.classList.add('bi-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('bi-eye-slash');
                icon.classList.add('bi-eye');
            }
        }

        function addHeadjudge() {
            var name = $("#name").val().trim();
            var username = $("#username").val().trim();
            var password = $("#password").val().trim();
            var confirmPassword = $("#confirmPassword").val().trim();

            if (!name || !username || !password || !confirmPassword) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Missing Fields',
                    text: 'Please fill in all required fields',
                    ...swalConfig
                });
                return;
            }

            if (password !== confirmPassword) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Password Mismatch',
                    text: 'Passwords do not match',
                    ...swalConfig
                });
                return;
            }

            $.ajax({
                type: 'POST',
                url: '../AddHeadJudgeServlet',
                data: $("#ajaxAddHeadjudge").serialize(),
                dataType: 'JSON',
                success: function(data) {
                    if (data[0].msg == 1) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Success!',
                            text: 'Head Judge added successfully',
                            ...swalConfig,
                            timer: 2000,
                            showConfirmButton: false
                        });
                        $('#ajaxAddHeadjudge')[0].reset();
                        bootstrap.Modal.getInstance(document.getElementById('addHeadjudgeModal')).hide();
                        fetchHeadJudgeData();
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to add head judge',
                        ...swalConfig
                    });
                }
            });
        }

        function deleteHeadJudge(headjudgeID) {
            Swal.fire({
                title: 'Delete Head Judge?',
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
                        url: '../DeleteHeadJudgeServlet',
                        data: { headjudgeID: headjudgeID },
                        success: function(response) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Deleted!',
                                text: 'Head Judge has been removed',
                                ...swalConfig,
                                timer: 2000,
                                showConfirmButton: false
                            });
                            fetchHeadJudgeData();
                        },
                        error: function() {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Failed to delete head judge',
                                ...swalConfig
                            });
                        }
                    });
                }
            });
        }

        function displayHeadjudge(headjudgeID) {
            $.ajax({
                type: 'GET',
                url: '../DisplayHeadJudgeServlet',
                data: { headjudgeID: headjudgeID },
                dataType: 'JSON',
                success: function(head) {
                    $('#updateName').val(head.headName);
                    $('#updateHeadjudgeName').val(head.headUsername);
                    $('#updateHeadjudgePassword').val(head.headPassword);
                    $('#updateConfirmPassword').val(head.headPassword);
                    $('#updateheadjudgeID').val(head.headjudgeID);
                    new bootstrap.Modal(document.getElementById('updateHeadjudgeModal')).show();
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to load head judge data',
                        ...swalConfig
                    });
                }
            });
        }

        function validateAndUpdateHeadjudge() {
            var password = $("#updateHeadjudgePassword").val().trim();
            var confirmPassword = $("#updateConfirmPassword").val().trim();

            if (password !== confirmPassword) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Password Mismatch',
                    text: 'Passwords do not match',
                    ...swalConfig
                });
                return;
            }

            $.ajax({
                type: 'POST',
                url: '../UpdateHeadJudgeServlet',
                data: $("#ajaxUpdateHeadjudge").serialize(),
                dataType: 'JSON',
                success: function(response) {
                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Updated!',
                            text: 'Head Judge updated successfully',
                            ...swalConfig,
                            timer: 2000,
                            showConfirmButton: false
                        });
                        bootstrap.Modal.getInstance(document.getElementById('updateHeadjudgeModal')).hide();
                        fetchHeadJudgeData();
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Failed to update head judge',
                        ...swalConfig
                    });
                }
            });
        }

        $(document).ready(function() {
            fetchHeadJudgeData();
        });
    </script>
</body>
</html>
