<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<%@page import="com.connection.DBConnect" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - LIVERG Scoring System</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700;800&display=swap"
        rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Custom Theme -->
    <link rel="stylesheet" href="assets/css/liverg-theme.css">

    <style>
        .page-hero {
            background: #1a3a5c;
            background: linear-gradient(135deg, #1a3a5c 0%, #2d5a8a 100%);
            padding: 4rem 0;
            position: relative;
            overflow: hidden;
            min-height: 250px;
        }

        .page-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 600px;
            height: 600px;
            background: linear-gradient(135deg, rgba(0, 212, 170, 0.2), rgba(233, 30, 140, 0.2));
            border-radius: 50%;
        }

        .breadcrumb-nav a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.875rem;
        }

        .breadcrumb-nav a:hover {
            color: #00d4aa;
        }

        .breadcrumb-nav span {
            color: rgba(255, 255, 255, 0.5);
            margin: 0 0.5rem;
        }

        .event-status-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .status-upcoming {
            background: rgba(16, 185, 129, 0.2);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-ongoing {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .status-completed {
            background: rgba(148, 163, 184, 0.2);
            color: #e2e8f0;
            border: 1px solid rgba(148, 163, 184, 0.3);
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #64748b;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .stat-icon {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #00d4aa;
        }

        .content-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .card-header-styled {
            background: #f8fafc;
            padding: 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header-styled h5 {
            margin: 0;
            color: #1a3a5c;
            font-weight: 600;
        }

        .participant-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .participant-item {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .participant-item:last-child {
            border-bottom: none;
        }

        .avatar-circle {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e2e8f0;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1rem;
        }

        .team-badge {
            background: #f1f5f9;
            color: #475569;
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 600;
        }
    </style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg liverg-navbar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <img src="assets/img/liverg-logo.png" alt="LIVERG" class="brand-logo" style="height: 50px;">
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNav">
                <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="publicEvents.jsp">Competitions</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="publicDashboard.jsp">Live Scores</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="news.jsp">News</a>
                    </li>

                </ul>
                <div class="d-flex gap-2">
                    <a href="login.jsp" class="btn btn-liverg btn-liverg-primary">
                        <i class="fas fa-user-circle"></i> Sign In
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <%
    String eventIdStr = request.getParameter("id");
    if(eventIdStr == null || eventIdStr.isEmpty()) {
        response.sendRedirect("publicEvents.jsp");
        return;
    }

    int eventID = Integer.parseInt(eventIdStr);
    
    // Variables to hold data
    String eventName = "";
    String eventDate = "";
    int totalGymnasts = 0;
    int totalTeams = 0;
    String status = "upcoming";
    String statusLabel = "Upcoming";

    DBConnect db = new DBConnect();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = db.getConnection();
        
        // 1. Get Event Details
        String sqlEvent = "SELECT * FROM event WHERE eventID = ?";
        pstmt = conn.prepareStatement(sqlEvent);
        pstmt.setInt(1, eventID);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            eventName = rs.getString("eventName");
            eventDate = rs.getString("eventDate");
            
             // Create Date objects for status check
            java.time.LocalDate now = java.time.LocalDate.now();
            java.time.LocalDate evtDate = java.time.LocalDate.parse(eventDate);
            
            if (evtDate.isBefore(now)) {
                status = "status-completed";
                statusLabel = "Completed";
            } else if (evtDate.isEqual(now)) {
                status = "status-ongoing";
                statusLabel = "Live Now";
            } else {
                status = "status-upcoming";
                statusLabel = "Upcoming";
            }
        } else {
            // Event not found
            response.sendRedirect("publicEvents.jsp");
            return;
        }
        rs.close();
        pstmt.close();

        // 2. Get Stats
        // Count distinct gymnasts registered for this event
        String sqlGymnasts = "SELECT count(distinct gymnastID) as total FROM gymnast_app WHERE eventID = ?";
        pstmt = conn.prepareStatement(sqlGymnasts);
        pstmt.setInt(1, eventID);
        rs = pstmt.executeQuery();
        if(rs.next()) totalGymnasts = rs.getInt("total");
        rs.close();
        pstmt.close();

        // Count participating teams (based on gymnasts registered)
        String sqlTeams = "SELECT count(distinct g.teamID) as total FROM gymnast_app ga " +
                          "JOIN gymnast g ON ga.gymnastID = g.gymnastID WHERE ga.eventID = ?";
        pstmt = conn.prepareStatement(sqlTeams);
        pstmt.setInt(1, eventID);
        rs = pstmt.executeQuery();
        if(rs.next()) totalTeams = rs.getInt("total");
        rs.close();
        pstmt.close();

    %>

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="container">
            <div class="breadcrumb-nav mb-3">
                <a href="index.jsp">Home</a>
                <span>/</span>
                <a href="publicEvents.jsp">Events</a>
                <span>/</span>
                <span class="text-white"><%= eventName %></span>
            </div>
            
            <div class="row align-items-end">
                <div class="col-lg-8">
                    <span class="event-status-badge <%= status %> mb-3"><%= statusLabel %></span>
                    <h1 class="text-white mb-2"><%= eventName %></h1>
                    <div class="d-flex align-items-center gap-4 text-white-50 mt-2">
                        <div>
                            <i class="fas fa-calendar-alt me-2"></i> <%= eventDate %>
                        </div>
                        <div>
                            <i class="fas fa-map-marker-alt me-2"></i> Venue TBA
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 text-lg-end mt-4 mt-lg-0">
                    <a href="publicDashboard.jsp?event=<%= eventID %>" class="btn btn-lg btn-light text-primary fw-bold shadow-sm">
                        <i class="fas fa-chart-line me-2"></i> View Live Results
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container py-5">
        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-user-friends"></i></div>
                    <div class="stat-value"><%= totalGymnasts %></div>
                    <div class="stat-label">Gymnasts</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-flag"></i></div>
                    <div class="stat-value"><%= totalTeams %></div>
                    <div class="stat-label">Teams</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-ribbon"></i></div>
                    <div class="stat-value">RG</div>
                    <div class="stat-label">Discipline</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-medal"></i></div>
                    <div class="stat-value">FIG</div>
                    <div class="stat-label">Rules</div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left Column: Participating Teams & Info -->
            <div class="col-lg-8">
                <div class="content-card">
                    <div class="card-header-styled">
                        <h5><i class="fas fa-info-circle me-2 text-primary"></i> Event Description</h5>
                    </div>
                    <div class="p-4">
                        <p class="text-secondary mb-0">
                            Welcome to the official page for <strong><%= eventName %></strong>. 
                            This competition features top rhythmic gymnastics talent competing in various categories.
                            Live scores and rankings will be updated in real-time during the event.
                        </p>
                    </div>
                </div>

                <div class="content-card">
                    <div class="card-header-styled">
                        <h5><i class="fas fa-users me-2 text-primary"></i> Registered Gymnasts</h5>
                        <span class="badge bg-primary rounded-pill"><%= totalGymnasts %> Registered</span>
                    </div>
                    <div class="participant-list">
                        <%
                        // Query for gymnasts
                        String sqlGymList = "SELECT DISTINCT g.gymnastName, g.gymnastCategory, t.teamName " +
                                            "FROM gymnast_app ga " +
                                            "JOIN gymnast g ON ga.gymnastID = g.gymnastID " +
                                            "JOIN team t ON g.teamID = t.teamID " +
                                            "WHERE ga.eventID = ? " +
                                            "ORDER BY t.teamName, g.gymnastName LIMIT 50"; // Limit for display
                        pstmt = conn.prepareStatement(sqlGymList);
                        pstmt.setInt(1, eventID);
                        rs = pstmt.executeQuery();
                        boolean hasGymnasts = false;
                        
                        while(rs.next()) {
                            hasGymnasts = true;
                            String gName = rs.getString("gymnastName");
                            String gCat = rs.getString("gymnastCategory");
                            String tName = rs.getString("teamName");
                            String initial = gName.length() > 0 ? gName.substring(0, 1) : "G";
                        %>
                        <div class="participant-item">
                            <div class="avatar-circle"><%= initial %></div>
                            <div class="flex-grow-1">
                                <h6 class="mb-0 text-dark"><%= gName %></h6>
                                <small class="text-muted"><%= tName %></small>
                            </div>
                            <span class="team-badge"><%= gCat %></span>
                        </div>
                        <% } 
                        if(!hasGymnasts) {
                        %>
                        <div class="p-4 text-center text-muted">
                            <i class="fas fa-user-times fa-2x mb-3"></i>
                            <p>No gymnasts registered yet.</p>
                        </div>
                        <% } 
                        rs.close();
                        pstmt.close();
                        %>
                    </div>
                </div>
            </div>

            <!-- Right Column: Participating Teams Widget -->
            <div class="col-lg-4">
                <div class="content-card sticky-top" style="top: 2rem; z-index: 1;">
                    <div class="card-header-styled">
                        <h5><i class="fas fa-flag me-2 text-primary"></i> Participating Teams</h5>
                    </div>
                    <div class="p-0">
                        <%
                        // Query for teams
                        String sqlTeamList = "SELECT DISTINCT t.teamName, count(distinct g.gymnastID) as gymnastCount " +
                                             "FROM gymnast_app ga " +
                                             "JOIN gymnast g ON ga.gymnastID = g.gymnastID " +
                                             "JOIN team t ON g.teamID = t.teamID " +
                                             "WHERE ga.eventID = ? " +
                                             "GROUP BY t.teamID, t.teamName " +
                                             "ORDER BY t.teamName";
                        pstmt = conn.prepareStatement(sqlTeamList);
                        pstmt.setInt(1, eventID);
                        rs = pstmt.executeQuery();
                        boolean hasTeams = false;
                        %>
                        <ul class="list-group list-group-flush">
                        <%
                        while(rs.next()) {
                            hasTeams = true;
                        %>
                            <li class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                                <%= rs.getString("teamName") %>
                                <span class="badge bg-light text-dark rounded-pill border"><%= rs.getInt("gymnastCount") %></span>
                            </li>
                        <% } 
                        if(!hasTeams) { %>
                            <li class="list-group-item text-center text-muted py-4">No teams registered.</li>
                        <% }
                        rs.close();
                        pstmt.close();
                        %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%
    } catch(Exception e) {
        e.printStackTrace();
    %>
        <div class="container py-5 text-center">
            <div class="alert alert-danger">
                <h4>Error Loading Event</h4>
                <p>Sorry, we couldn't load the event details. Please try again later.</p>
                <p class="small"><%= e.getMessage() %></p>
                <a href="publicEvents.jsp" class="btn btn-secondary mt-3">Back to Events</a>
            </div>
        </div>
    <%
    } finally {
        if(conn != null) try { conn.close(); } catch(SQLException e) {}
    }
    %>

    <!-- Footer -->
    <footer class="liverg-footer">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-4">
                    <div class="footer-brand">
                        <h3 class="text-white mb-3">LIVERG</h3>
                        <p>The definitive scoring standard for Rhythmic Gymnastics. Empowering judges, engaging
                            fans, and celebrating athletes.</p>
                    </div>
                    <div class="footer-social">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h5 class="footer-title">Platform</h5>
                    <ul class="footer-links">
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="publicDashboard.jsp">Live Scores</a></li>
                        <li><a href="publicEvents.jsp">Competitions</a></li>
                        <li><a href="#">Results Archive</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-4">
                    <h5 class="footer-title">Organization</h5>
                    <ul class="footer-links">
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Technical Committee</a></li>
                        <li><a href="#">Rules & Regulations</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-4 col-md-4">
                    <h5 class="footer-title">Newsletter</h5>
                    <p class="small text-muted mb-3">Subscribe to get the latest competition updates and news.</p>
                    <form class="d-flex gap-2">
                        <input type="email" class="form-control bg-dark border-secondary text-white"
                            placeholder="Email address">
                        <button class="btn btn-liverg-primary">Subscribe</button>
                    </form>
                </div>
            </div>
            <div class="footer-bottom text-center">
                <p>&copy; 2026 LIVERG Scoring System. All rights reserved. Designed for Excellence.</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
