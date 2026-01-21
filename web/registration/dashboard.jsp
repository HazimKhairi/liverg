<%@ page import="java.sql.*, java.util.*, java.util.stream.Collectors" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="com.registration.bean.*" %>
<%@ page import="com.connection.DBConnect" %>

<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Clerk> clerks = new ArrayList<>();
    int judgeCount = 0;
    int clerkCount = 0;
    int headCount = 0;
    int gymnastCount = 0;
    int teamCount = 0;
    int eventCount = 0;
    List<Gymnast> gymnasts = new ArrayList<>();
    List<Apparatus> apparatusList = new ArrayList<>();
    List<Team> teams = new ArrayList<>();

    try {
        DBConnect db = new DBConnect();
        con = db.getConnection();
        stmt = con.createStatement();

        // Fetch all clerks
        rs = stmt.executeQuery("SELECT * FROM CLERK LIMIT 1");
        while (rs.next()) {
            Clerk clerk = new Clerk();
            clerk.setClerkID(rs.getInt("clerkID"));
            clerk.setClerkName(rs.getString("clerkName"));
            clerks.add(clerk);
        }
        rs.close();

        // Get judge count
        rs = stmt.executeQuery("SELECT COUNT(JUDGEID) AS judgeCount FROM JUDGE");
        if (rs.next()) {
            judgeCount = rs.getInt("judgeCount");
        }
        rs.close();

        // Get clerk count
        rs = stmt.executeQuery("SELECT COUNT(CLERKID) AS clerkCount FROM CLERK");
        if (rs.next()) {
            clerkCount = rs.getInt("clerkCount");
        }
        rs.close();

        // Get headjudge count
        rs = stmt.executeQuery("SELECT COUNT(HEADJUDGEID) AS headCount FROM HEADJUDGE");
        if (rs.next()) {
            headCount = rs.getInt("headCount");
        }
        rs.close();

        // Get gymnast count
        rs = stmt.executeQuery("SELECT COUNT(GYMNASTID) AS gymnastCount FROM GYMNAST");
        if (rs.next()) {
            gymnastCount = rs.getInt("gymnastCount");
        }
        rs.close();

        // Get team count
        rs = stmt.executeQuery("SELECT COUNT(TEAMID) AS teamCount FROM TEAM");
        if (rs.next()) {
            teamCount = rs.getInt("teamCount");
        }
        rs.close();

        // Get event count
        try {
            rs = stmt.executeQuery("SELECT COUNT(*) AS eventCount FROM EVENT");
            if (rs.next()) {
                eventCount = rs.getInt("eventCount");
            }
            rs.close();
        } catch(Exception e) {
            eventCount = 0;
        }

        // Fetch gymnasts and apparatus details
        rs = stmt.executeQuery("SELECT G.GYMNASTID, G.GYMNASTIC, G.GYMNASTNAME, G.GYMNASTSCHOOL, G.GYMNASTCATEGORY, GROUP_CONCAT(A.APPARATUSNAME ORDER BY A.APPARATUSNAME SEPARATOR ', ') AS APPARATUS_LIST, T.TEAMNAME FROM GYMNAST G JOIN GYMNAST_APP GA ON G.GYMNASTID = GA.GYMNASTID JOIN APPARATUS A ON GA.APPARATUSID = A.APPARATUSID JOIN TEAM T ON G.TEAMID = T.TEAMID GROUP BY G.GYMNASTID, G.GYMNASTNAME");
        while (rs.next()) {
            Gymnast gymnast = new Gymnast();
            gymnast.setGymnastID(rs.getInt("GYMNASTID"));
            gymnast.setGymnastIC(rs.getString("GYMNASTIC"));
            gymnast.setGymnastName(rs.getString("GYMNASTNAME"));
            gymnast.setGymnastSchool(rs.getString("GYMNASTSCHOOL"));
            gymnast.setGymnastCategory(rs.getString("GYMNASTCATEGORY"));
            gymnasts.add(gymnast);

            Apparatus apparatus = new Apparatus();
            apparatus.setApparatusName(rs.getString("APPARATUS_LIST"));
            apparatusList.add(apparatus);

            Team team = new Team();
            team.setTeamName(rs.getString("TEAMNAME"));
            teams.add(team);
        }
        rs.close();
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

    Map<String, List<Gymnast>> gymnastsByTeam = gymnasts.stream().collect(Collectors.groupingBy(g -> {
        int index = gymnasts.indexOf(g);
        return teams.get(index).getTeamName();
    }));

    String userRole = (String) session.getAttribute("userRole");
    if (userRole == null) {
        response.sendRedirect("../LogoutServlet");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    if (userName == null) userName = "User";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - LIVERG Scoring System</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">

    <!-- Custom Theme -->
    <link rel="stylesheet" href="../assets/css/liverg-theme.css">

    <style>
        :root {
            --sidebar-width: 280px;
            --header-height: 70px;
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

        .header-notification {
            position: relative;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #f1f5f9;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
        }

        .header-notification:hover {
            background: #e2e8f0;
            color: #1a3a5c;
        }

        .notification-badge {
            position: absolute;
            top: -2px;
            right: -2px;
            width: 18px;
            height: 18px;
            background: #e91e8c;
            color: white;
            font-size: 0.65rem;
            font-weight: 600;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
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

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #1a3a5c 0%, #2d5a8a 100%);
            border-radius: 1rem;
            padding: 2rem;
            color: white;
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 400px;
            height: 400px;
            background: linear-gradient(135deg, rgba(0, 212, 170, 0.3), rgba(233, 30, 140, 0.3));
            border-radius: 50%;
        }

        .welcome-banner h2 {
            color: white;
            font-size: 1.75rem;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .welcome-banner p {
            opacity: 0.9;
            position: relative;
            max-width: 500px;
        }

        .welcome-banner .quick-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            position: relative;
        }

        .quick-action-btn {
            padding: 0.625rem 1.25rem;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 0.5rem;
            color: white;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .quick-action-btn:hover {
            background: rgba(255,255,255,0.25);
            color: white;
        }

        .quick-action-btn.primary {
            background: #00d4aa;
            border-color: #00d4aa;
        }

        .quick-action-btn.primary:hover {
            background: #00c49a;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
        }

        .stat-card.cyan::before { background: #00d4aa; }
        .stat-card.magenta::before { background: #e91e8c; }
        .stat-card.purple::before { background: #8b5cf6; }
        .stat-card.yellow::before { background: #f59e0b; }
        .stat-card.blue::before { background: #3b82f6; }
        .stat-card.green::before { background: #10b981; }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .stat-card-title {
            font-size: 0.875rem;
            font-weight: 500;
            color: #64748b;
            margin: 0;
        }

        .stat-card-icon {
            width: 48px;
            height: 48px;
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .stat-card.cyan .stat-card-icon { background: rgba(0, 212, 170, 0.1); color: #00d4aa; }
        .stat-card.magenta .stat-card-icon { background: rgba(233, 30, 140, 0.1); color: #e91e8c; }
        .stat-card.purple .stat-card-icon { background: rgba(139, 92, 246, 0.1); color: #8b5cf6; }
        .stat-card.yellow .stat-card-icon { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-card.blue .stat-card-icon { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .stat-card.green .stat-card-icon { background: rgba(16, 185, 129, 0.1); color: #10b981; }

        .stat-card-value {
            font-size: 2rem;
            font-weight: 700;
            color: #1a3a5c;
            line-height: 1;
            margin-bottom: 0.25rem;
        }

        .stat-card-change {
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .stat-card-change.positive { color: #10b981; }
        .stat-card-change.negative { color: #ef4444; }

        /* Data Table Card */
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

        .data-card-body {
            padding: 1.5rem;
        }

        /* Custom Table Styles */
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

        .team-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: linear-gradient(135deg, #1a3a5c, #2d5a8a);
            color: white;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .category-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: rgba(0, 212, 170, 0.1);
            color: #00d4aa;
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .apparatus-list {
            font-size: 0.8rem;
            color: #64748b;
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

            .welcome-banner {
                padding: 1.5rem;
            }

            .welcome-banner .quick-actions {
                flex-direction: column;
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
            <a href="dashboard.jsp" class="sidebar-nav-item active">
                <i class="fas fa-th-large"></i>
                <span>Dashboard</span>
            </a>

            <% if (userRole.equals("superadmin") || userRole.equals("staff")) { %>
            <div class="sidebar-section">
                <div class="sidebar-section-title">Management</div>
            </div>
            <a href="headDetails.jsp" class="sidebar-nav-item">
                <i class="fas fa-user-tie"></i>
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
                <h1 class="page-title">Dashboard</h1>
            </div>

            <div class="header-right">
                <div class="header-search">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>

                <div class="header-notification">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
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
            <!-- Welcome Banner -->
            <div class="welcome-banner">
                <h2>Welcome back, <%= userName %>!</h2>
                <p>Here's what's happening with your gymnastics scoring system today. Monitor competitions, manage teams, and track scores all in one place.</p>
                <div class="quick-actions">
                    <a href="eventDetails.jsp" class="quick-action-btn primary">
                        <i class="fas fa-plus"></i> New Event
                    </a>
                    <a href="../scoring/listEvent.jsp" class="quick-action-btn">
                        <i class="fas fa-play"></i> Start Scoring
                    </a>
                    <a href="../home.jsp" class="quick-action-btn">
                        <i class="fas fa-globe"></i> View Public Site
                    </a>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card cyan">
                    <div class="stat-card-header">
                        <div>
                            <p class="stat-card-title">Total Clerks</p>
                            <div class="stat-card-value"><%= clerkCount %></div>
                            <div class="stat-card-change positive">
                                <i class="fas fa-arrow-up"></i> Active users
                            </div>
                        </div>
                        <div class="stat-card-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card magenta">
                    <div class="stat-card-header">
                        <div>
                            <p class="stat-card-title">Head Judges</p>
                            <div class="stat-card-value"><%= headCount %></div>
                            <div class="stat-card-change positive">
                                <i class="fas fa-check-circle"></i> Registered
                            </div>
                        </div>
                        <div class="stat-card-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card purple">
                    <div class="stat-card-header">
                        <div>
                            <p class="stat-card-title">Panel Judges</p>
                            <div class="stat-card-value"><%= judgeCount %></div>
                            <div class="stat-card-change positive">
                                <i class="fas fa-gavel"></i> Available
                            </div>
                        </div>
                        <div class="stat-card-icon">
                            <i class="fas fa-gavel"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card yellow">
                    <div class="stat-card-header">
                        <div>
                            <p class="stat-card-title">Gymnasts</p>
                            <div class="stat-card-value"><%= gymnastCount %></div>
                            <div class="stat-card-change positive">
                                <i class="fas fa-running"></i> Registered
                            </div>
                        </div>
                        <div class="stat-card-icon">
                            <i class="fas fa-running"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card blue">
                    <div class="stat-card-header">
                        <div>
                            <p class="stat-card-title">Teams</p>
                            <div class="stat-card-value"><%= teamCount %></div>
                            <div class="stat-card-change positive">
                                <i class="fas fa-users"></i> Participating
                            </div>
                        </div>
                        <div class="stat-card-icon">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                </div>

                <div class="stat-card green">
                    <div class="stat-card-header">
                        <div>
                            <p class="stat-card-title">Events</p>
                            <div class="stat-card-value"><%= eventCount %></div>
                            <div class="stat-card-change positive">
                                <i class="fas fa-calendar"></i> Scheduled
                            </div>
                        </div>
                        <div class="stat-card-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Team Data Table -->
            <div class="data-card">
                <div class="data-card-header">
                    <h3 class="data-card-title">
                        <i class="fas fa-users" style="color: #00d4aa;"></i>
                        Team & Gymnast Overview
                    </h3>
                    <a href="gymnastDetails.jsp" class="btn btn-sm" style="background: linear-gradient(135deg, #00d4aa, #1a3a5c); color: white; border-radius: 0.5rem;">
                        <i class="fas fa-plus me-1"></i> Add Gymnast
                    </a>
                </div>
                <div class="data-card-body">
                    <% if (gymnastsByTeam.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h4>No Data Available</h4>
                        <p>Start by adding teams and gymnasts to see them here.</p>
                        <a href="teamDetails.jsp" class="btn mt-3" style="background: linear-gradient(135deg, #00d4aa, #1a3a5c); color: white;">
                            <i class="fas fa-plus me-2"></i> Add Team
                        </a>
                    </div>
                    <% } else { %>
                    <div class="table-responsive">
                        <table class="liverg-table" id="gymnastTable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Team / Gymnast</th>
                                    <th>IC Number</th>
                                    <th>School</th>
                                    <th>Category / Apparatus</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                int globalRowCount = 1;
                                for (Map.Entry<String, List<Gymnast>> entry : gymnastsByTeam.entrySet()) {
                                %>
                                <tr>
                                    <td colspan="5">
                                        <span class="team-badge">
                                            <i class="fas fa-users"></i>
                                            <%= entry.getKey() %>
                                            <span style="opacity: 0.7; font-weight: 400;">(<%= entry.getValue().size() %> gymnasts)</span>
                                        </span>
                                    </td>
                                </tr>
                                <%
                                for (Gymnast gymnast : entry.getValue()) {
                                    int index = gymnasts.indexOf(gymnast);
                                    Apparatus apparatus = apparatusList.get(index);
                                %>
                                <tr>
                                    <td><%= globalRowCount++ %></td>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                                            <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, #e91e8c, #8b5cf6); display: flex; align-items: center; justify-content: center; color: white; font-weight: 600; font-size: 0.875rem;">
                                                <%= gymnast.getGymnastName().substring(0, 1).toUpperCase() %>
                                            </div>
                                            <div>
                                                <div style="font-weight: 600; color: #1a3a5c;"><%= gymnast.getGymnastName() %></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><%= gymnast.getGymnastIC() %></td>
                                    <td><%= gymnast.getGymnastSchool() %></td>
                                    <td>
                                        <span class="category-badge"><%= gymnast.getGymnastCategory() %></span>
                                        <div class="apparatus-list mt-1"><%= apparatus.getApparatusName() %></div>
                                    </td>
                                </tr>
                                <% } %>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer style="padding: 1.5rem 2rem; text-align: center; color: #64748b; font-size: 0.875rem; border-top: 1px solid #e2e8f0; background: white;">
            <p style="margin: 0;">&copy; 2026 LIVERG Gymnastics Scoring System. All rights reserved.</p>
        </footer>
    </main>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>

    <script>
        // Sidebar Toggle
        const sidebar = document.getElementById('sidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        const sidebarOverlay = document.getElementById('sidebarOverlay');

        sidebarToggle.addEventListener('click', () => {
            sidebar.classList.toggle('open');
            sidebarOverlay.classList.toggle('open');
        });

        sidebarOverlay.addEventListener('click', () => {
            sidebar.classList.remove('open');
            sidebarOverlay.classList.remove('open');
        });

        // Initialize DataTable if table exists
        $(document).ready(function() {
            if ($('#gymnastTable tbody tr').length > 0) {
                // Don't initialize DataTable if using team grouping
                // $('#gymnastTable').DataTable();
            }
        });
    </script>
</body>
</html>
