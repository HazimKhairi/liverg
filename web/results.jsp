<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.DBConnect"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Results - LIVERG Rhythmic Gymnastics Scoring System</title>

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

        .results-content {
            padding: 3rem 0;
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

        .event-result-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 1.5rem;
            transition: all 0.3s;
        }

        .event-result-card:hover {
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .event-result-header {
            background: linear-gradient(135deg, #1a3a5c, #2d5a8a);
            color: white;
            padding: 1.25rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .event-result-header h4 {
            color: white;
            margin: 0;
            font-size: 1.125rem;
        }

        .event-badge {
            padding: 0.25rem 0.75rem;
            background: rgba(0, 212, 170, 0.2);
            color: #00d4aa;
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .event-result-body {
            padding: 1.5rem;
        }

        .results-table {
            width: 100%;
            border-collapse: collapse;
        }

        .results-table th {
            background: #f8fafc;
            padding: 0.875rem 1rem;
            font-size: 0.75rem;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 2px solid #e2e8f0;
        }

        .results-table td {
            padding: 1rem;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.875rem;
            color: #334155;
        }

        .results-table tbody tr:hover {
            background: #f8fafc;
        }

        .rank-badge {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 0.875rem;
        }

        .rank-1 {
            background: linear-gradient(135deg, #ffd700, #ffb700);
            color: white;
        }

        .rank-2 {
            background: linear-gradient(135deg, #c0c0c0, #a0a0a0);
            color: white;
        }

        .rank-3 {
            background: linear-gradient(135deg, #cd7f32, #b87333);
            color: white;
        }

        .rank-other {
            background: #f1f5f9;
            color: #64748b;
        }

        .total-score {
            font-weight: 700;
            color: #1a3a5c;
            font-size: 1rem;
        }

        .no-results {
            text-align: center;
            padding: 4rem 2rem;
        }

        .no-results i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        .no-results h4 {
            color: #64748b;
        }

        .no-results p {
            color: #94a3b8;
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
                        <a class="nav-link" href="publicEvents.jsp">Events</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="results.jsp">Results</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="news.jsp">News</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact.jsp">Contact</a>
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
                <a href="results.jsp">Results</a>
            </div>
            <h1>Competition Results</h1>
            <p>View results from rhythmic gymnastics competitions</p>
        </div>
    </section>

    <!-- Results Content -->
    <div class="container results-content">
        <!-- Filter Section -->
        <div class="filter-section">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h5 class="mb-0"><i class="fas fa-trophy me-2" style="color: #00d4aa;"></i>Competition Results</h5>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <span class="input-group-text" style="background: #f8fafc; border-color: #e2e8f0;">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Search events..." id="searchResults"
                               style="border-color: #e2e8f0;">
                    </div>
                </div>
            </div>
        </div>

        <!-- Results List -->
        <div id="resultsContainer">
            <%
                boolean hasResults = false;
                try {
                    DBConnect db = new DBConnect();
                    Connection conn = db.getConnection();

                    // Get completed events with results
                    String sql = "SELECT DISTINCT e.eventID, e.eventName, e.eventDate, e.eventVenue " +
                                "FROM EVENT e " +
                                "INNER JOIN SCORE s ON e.eventID = s.eventID " +
                                "ORDER BY e.eventDate DESC";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    ResultSet rsEvents = pstmt.executeQuery();

                    while(rsEvents.next()) {
                        hasResults = true;
                        int eventId = rsEvents.getInt("eventID");
                        String eventName = rsEvents.getString("eventName");
                        String eventDate = rsEvents.getString("eventDate");
                        String eventVenue = rsEvents.getString("eventVenue");
            %>
            <div class="event-result-card">
                <div class="event-result-header">
                    <div>
                        <h4><%= eventName %></h4>
                        <small><i class="fas fa-calendar-alt me-1"></i><%= eventDate %> |
                        <i class="fas fa-map-marker-alt ms-2 me-1"></i><%= eventVenue != null ? eventVenue : "Venue TBA" %></small>
                    </div>
                    <span class="event-badge">Rhythmic Gymnastics</span>
                </div>
                <div class="event-result-body">
                    <table class="results-table">
                        <thead>
                            <tr>
                                <th style="width: 60px;">Rank</th>
                                <th>Gymnast</th>
                                <th>Team</th>
                                <th>Category</th>
                                <th style="text-align: right;">Total Score</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                // Get scores for this event
                                String scoreSql = "SELECT g.gymnastName, t.teamName, g.gymnastCategory, s.totalScore " +
                                                 "FROM SCORE s " +
                                                 "INNER JOIN GYMNAST g ON s.gymnastID = g.gymnastID " +
                                                 "LEFT JOIN TEAM t ON g.teamID = t.teamID " +
                                                 "WHERE s.eventID = ? " +
                                                 "ORDER BY s.totalScore DESC LIMIT 10";
                                PreparedStatement pstmtScores = conn.prepareStatement(scoreSql);
                                pstmtScores.setInt(1, eventId);
                                ResultSet rsScores = pstmtScores.executeQuery();

                                int rank = 1;
                                while(rsScores.next()) {
                                    String rankClass = rank == 1 ? "rank-1" : rank == 2 ? "rank-2" : rank == 3 ? "rank-3" : "rank-other";
                            %>
                            <tr>
                                <td><span class="rank-badge <%= rankClass %>"><%= rank %></span></td>
                                <td><strong><%= rsScores.getString("gymnastName") %></strong></td>
                                <td><%= rsScores.getString("teamName") != null ? rsScores.getString("teamName") : "-" %></td>
                                <td><%= rsScores.getString("gymnastCategory") %></td>
                                <td style="text-align: right;"><span class="total-score"><%= String.format("%.3f", rsScores.getDouble("totalScore")) %></span></td>
                            </tr>
                            <%
                                    rank++;
                                }
                                rsScores.close();
                                pstmtScores.close();
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <%
                    }
                    rsEvents.close();
                    pstmt.close();
                    conn.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }

                if (!hasResults) {
            %>
            <div class="no-results">
                <i class="fas fa-trophy"></i>
                <h4>No Results Available</h4>
                <p>Competition results will appear here once events are completed.</p>
                <a href="publicEvents.jsp" class="btn-liverg btn-liverg-primary mt-3">
                    <i class="fas fa-calendar me-2"></i>View Upcoming Events
                </a>
            </div>
            <%
                }
            %>
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
                        <li><a href="news.jsp">News</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 col-lg-2">
                    <h6 class="footer-title">Support</h6>
                    <ul class="footer-links">
                        <li><a href="contact.jsp">Contact Us</a></li>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Search functionality
        document.getElementById('searchResults').addEventListener('input', function() {
            const query = this.value.toLowerCase();
            document.querySelectorAll('.event-result-card').forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(query) ? 'block' : 'none';
            });
        });
    </script>
</body>
</html>
