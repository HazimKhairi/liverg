<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.DBConnect"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events Calendar - LIVERG Scoring System</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <!-- Custom Theme -->
    <link rel="stylesheet" href="assets/css/liverg-theme.css">

    <style>
        .page-hero {
            background: linear-gradient(135deg, #1a3a5c 0%, #2d5a8a 100%);
            padding: 4rem 0;
            position: relative;
            overflow: hidden;
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

        .page-hero h1 {
            color: white;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .page-hero p {
            color: rgba(255,255,255,0.8);
            font-size: 1.1rem;
            position: relative;
        }

        .breadcrumb-nav {
            position: relative;
        }

        .breadcrumb-nav a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            font-size: 0.875rem;
        }

        .breadcrumb-nav a:hover {
            color: #00d4aa;
        }

        .breadcrumb-nav span {
            color: rgba(255,255,255,0.5);
            margin: 0 0.5rem;
        }

        .filter-section {
            background: white;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            margin-top: -3rem;
            position: relative;
            z-index: 10;
        }

        .filter-pills {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .filter-pill {
            padding: 0.5rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 2rem;
            background: white;
            color: #64748b;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-pill:hover {
            border-color: #00d4aa;
            color: #00d4aa;
        }

        .filter-pill.active {
            background: #00d4aa;
            border-color: #00d4aa;
            color: white;
        }

        .events-grid {
            display: grid;
            gap: 1.5rem;
        }

        .event-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: all 0.3s;
            display: flex;
        }

        .event-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .event-date-box {
            background: linear-gradient(135deg, #1a3a5c, #2d5a8a);
            color: white;
            padding: 1.5rem;
            min-width: 100px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .event-date-box .day {
            font-size: 2rem;
            font-weight: 700;
            line-height: 1;
        }

        .event-date-box .month {
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            opacity: 0.9;
        }

        .event-date-box .year {
            font-size: 0.75rem;
            opacity: 0.7;
        }

        .event-content {
            padding: 1.5rem;
            flex: 1;
        }

        .event-discipline {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: rgba(0, 212, 170, 0.1);
            color: #00d4aa;
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 0.75rem;
        }

        .event-discipline.rhythmic { background: rgba(233, 30, 140, 0.1); color: #e91e8c; }
        .event-discipline.artistic { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .event-discipline.aerobic { background: rgba(139, 92, 246, 0.1); color: #8b5cf6; }
        .event-discipline.acrobatic { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }

        .event-content h3 {
            font-size: 1.25rem;
            color: #1a3a5c;
            margin-bottom: 0.5rem;
        }

        .event-content h3 a {
            color: inherit;
            text-decoration: none;
            transition: color 0.2s;
        }

        .event-content h3 a:hover {
            color: #00d4aa;
        }

        .event-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: 0.875rem;
            color: #64748b;
        }

        .event-meta-item {
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .event-meta-item i {
            color: #94a3b8;
        }

        .event-actions {
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 1.5rem;
            gap: 0.75rem;
            border-left: 1px solid #f1f5f9;
        }

        .event-status {
            padding: 0.375rem 0.75rem;
            border-radius: 0.375rem;
            font-size: 0.75rem;
            font-weight: 600;
            text-align: center;
        }

        .event-status.upcoming {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .event-status.ongoing {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .event-status.completed {
            background: rgba(100, 116, 139, 0.1);
            color: #64748b;
        }

        .btn-view-results {
            padding: 0.5rem 1rem;
            background: linear-gradient(135deg, #00d4aa, #1a3a5c);
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            text-align: center;
            transition: all 0.2s;
        }

        .btn-view-results:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 212, 170, 0.3);
        }

        .calendar-view {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 1.5rem;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .calendar-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #1a3a5c;
        }

        .calendar-nav {
            display: flex;
            gap: 0.5rem;
        }

        .calendar-nav button {
            width: 36px;
            height: 36px;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            background: white;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
        }

        .calendar-nav button:hover {
            background: #f1f5f9;
            color: #1a3a5c;
        }

        .no-events {
            text-align: center;
            padding: 4rem 2rem;
        }

        .no-events i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        .no-events h4 {
            color: #64748b;
        }

        .no-events p {
            color: #94a3b8;
        }

        @media (max-width: 768px) {
            .event-card {
                flex-direction: column;
            }

            .event-date-box {
                flex-direction: row;
                gap: 0.5rem;
                padding: 1rem;
            }

            .event-actions {
                flex-direction: row;
                border-left: none;
                border-top: 1px solid #f1f5f9;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="liverg-navbar navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="home.jsp">
                <i class="fas fa-medal fa-lg me-2" style="color: #00d4aa;"></i>
                <div class="brand-text">
                    LIVERG
                    <span>Scoring System</span>
                </div>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="publicEvents.jsp">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="results.jsp">Results</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="publicDashboard.jsp">Live Scores</a>
                    </li>
                </ul>

                <div class="d-flex gap-2">
                    <a href="publicDashboard.jsp" class="btn-liverg btn-liverg-secondary">
                        <i class="fas fa-trophy"></i> Live Scores
                    </a>
                    <a href="index.jsp" class="btn-liverg btn-liverg-primary">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Page Hero -->
    <section class="page-hero">
        <div class="container">
            <div class="breadcrumb-nav mb-3">
                <a href="home.jsp">Home</a>
                <span>/</span>
                <a href="publicEvents.jsp">Events</a>
            </div>
            <h1>Events Calendar</h1>
            <p>Upcoming and past gymnastics competitions</p>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container" style="padding: 2rem 0;">
        <!-- Filters -->
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <div class="filter-pills">
                        <button class="filter-pill active" data-filter="all">All Events</button>
                        <button class="filter-pill" data-filter="upcoming">Upcoming</button>
                        <button class="filter-pill" data-filter="ongoing">Live Now</button>
                        <button class="filter-pill" data-filter="completed">Completed</button>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="input-group mt-3 mt-lg-0">
                        <span class="input-group-text" style="background: #f8fafc; border-color: #e2e8f0;">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Search events..." id="searchEvents"
                               style="border-color: #e2e8f0;">
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <!-- Events List -->
                <div class="events-grid" id="eventsGrid">
                    <%
                        boolean hasEvents = false;
                        try {
                            DBConnect db = new DBConnect();
                            Connection conn = db.getConnection();
                            String sql = "SELECT * FROM EVENT ORDER BY eventDate DESC";
                            PreparedStatement pstmt = conn.prepareStatement(sql);
                            ResultSet rs = pstmt.executeQuery();

                            String[] months = {"", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};

                            while(rs.next()) {
                                hasEvents = true;
                                String eventDate = rs.getString("eventDate");
                                String[] dateParts = eventDate != null ? eventDate.split("-") : new String[]{"2026", "01", "01"};
                                String year = dateParts.length > 0 ? dateParts[0] : "2026";
                                int monthNum = dateParts.length > 1 ? Integer.parseInt(dateParts[1]) : 1;
                                String day = dateParts.length > 2 ? dateParts[2] : "01";
                                String month = months[monthNum];

                                // Determine status
                                String status = "upcoming";
                                String statusText = "Upcoming";
                    %>
                    <div class="event-card" data-status="<%= status %>">
                        <div class="event-date-box">
                            <div class="day"><%= day %></div>
                            <div class="month"><%= month %></div>
                            <div class="year"><%= year %></div>
                        </div>
                        <div class="event-content">
                            <span class="event-discipline rhythmic">Rhythmic Gymnastics</span>
                            <h3><a href="eventDetail.jsp?id=<%= rs.getInt("eventID") %>"><%= rs.getString("eventName") %></a></h3>
                            <div class="event-meta">
                                <div class="event-meta-item">
                                    <i class="fas fa-calendar-alt"></i>
                                    <span><%= eventDate %></span>
                                </div>
                                <div class="event-meta-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span><%= rs.getString("eventVenue") != null ? rs.getString("eventVenue") : "Venue TBA" %></span>
                                </div>
                            </div>
                        </div>
                        <div class="event-actions">
                            <span class="event-status <%= status %>"><%= statusText %></span>
                            <a href="publicDashboard.jsp?event=<%= rs.getInt("eventID") %>" class="btn-view-results">
                                <i class="fas fa-chart-line me-1"></i> View
                            </a>
                        </div>
                    </div>
                    <%
                            }
                            rs.close();
                            pstmt.close();
                            conn.close();
                        } catch(Exception e) {
                            e.printStackTrace();
                        }

                        if (!hasEvents) {
                    %>
                    <div class="no-events">
                        <i class="fas fa-calendar-times"></i>
                        <h4>No Events Found</h4>
                        <p>There are no rhythmic gymnastics events scheduled at the moment. Check back soon!</p>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Mini Calendar -->
                <div class="calendar-view mb-4">
                    <div class="calendar-header">
                        <h4 class="calendar-title">March 2026</h4>
                        <div class="calendar-nav">
                            <button><i class="fas fa-chevron-left"></i></button>
                            <button><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-calendar fa-3x mb-3" style="color: #cbd5e1;"></i>
                        <p>Calendar widget coming soon</p>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="calendar-view">
                    <h4 class="calendar-title mb-3">
                        <i class="fas fa-chart-pie me-2" style="color: #00d4aa;"></i>
                        Quick Stats
                    </h4>
                    <div class="d-flex flex-column gap-3">
                        <div class="d-flex justify-content-between align-items-center p-3" style="background: #f8fafc; border-radius: 0.5rem;">
                            <span class="text-muted">Upcoming Events</span>
                            <span class="fw-bold" style="color: #10b981;">5</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center p-3" style="background: #f8fafc; border-radius: 0.5rem;">
                            <span class="text-muted">Completed Events</span>
                            <span class="fw-bold" style="color: #64748b;">12</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center p-3" style="background: #f8fafc; border-radius: 0.5rem;">
                            <span class="text-muted">Total Gymnasts</span>
                            <span class="fw-bold" style="color: #1a3a5c;">245</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="liverg-footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="footer-brand">
                        <h3 style="color: white; margin-bottom: 1rem;">LIVERG</h3>
                        <p>Professional rhythmic gymnastics scoring system for competitions worldwide.</p>
                        <div class="footer-social mt-3">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3 col-lg-2">
                    <h6 class="footer-title">Quick Links</h6>
                    <ul class="footer-links">
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="publicEvents.jsp">Events</a></li>
                        <li><a href="results.jsp">Results</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 col-lg-2">
                    <h6 class="footer-title">Support</h6>
                    <ul class="footer-links">
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 LIVERG. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Filter functionality
        document.querySelectorAll('.filter-pill').forEach(pill => {
            pill.addEventListener('click', function() {
                document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
                this.classList.add('active');

                const filter = this.dataset.filter;
                document.querySelectorAll('.event-card').forEach(card => {
                    if (filter === 'all' || card.dataset.status === filter) {
                        card.style.display = 'flex';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });

        // Search functionality
        document.getElementById('searchEvents').addEventListener('input', function() {
            const query = this.value.toLowerCase();
            document.querySelectorAll('.event-card').forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(query) ? 'flex' : 'none';
            });
        });
    </script>
</body>
</html>
