<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.DBConnect"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="LIVERG - Professional Rhythmic Gymnastics Scoring System for competitions worldwide">
    <title>LIVERG - Rhythmic Gymnastics Scoring System</title>

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
        /* Page-specific styles */
        .hero-slider {
            position: relative;
        }

        .hero-slide {
            min-height: 600px;
            display: flex;
            align-items: center;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .hero-slide::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(26, 58, 92, 0.95) 0%, rgba(26, 58, 92, 0.7) 50%, transparent 100%);
        }

        .quick-links {
            background: var(--white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl);
            margin-top: -60px;
            position: relative;
            z-index: 10;
        }

        .quick-link-item {
            padding: 2rem;
            text-align: center;
            border-right: 1px solid var(--gray-100);
            transition: all var(--transition-fast);
        }

        .quick-link-item:last-child {
            border-right: none;
        }

        .quick-link-item:hover {
            background: var(--gray-50);
        }

        .quick-link-item i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--accent-cyan), var(--accent-magenta));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .quick-link-item h5 {
            margin-bottom: 0.5rem;
        }

        .quick-link-item p {
            font-size: 0.875rem;
            color: var(--gray-500);
            margin: 0;
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }

        .featured-news-slider {
            background: var(--primary-dark);
            position: relative;
            overflow: hidden;
        }

        .news-slide-content {
            position: relative;
            z-index: 1;
            padding: 4rem 0;
        }

        .news-indicator {
            display: flex;
            gap: 0.5rem;
            margin-top: 1.5rem;
        }

        .news-indicator span {
            width: 30px;
            height: 4px;
            background: rgba(255,255,255,0.3);
            border-radius: 2px;
            cursor: pointer;
            transition: all var(--transition-fast);
        }

        .news-indicator span.active {
            background: var(--accent-magenta);
            width: 50px;
        }
    </style>
</head>
<body>
    <!-- Top Bar -->
    <div class="liverg-topbar">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex gap-4">
                    <a href="#"><i class="fas fa-shield-alt me-1"></i> Integrity</a>
                    <a href="#"><i class="fas fa-balance-scale me-1"></i> Governance</a>
                    <a href="#"><i class="fas fa-heartbeat me-1"></i> Medical</a>
                    <a href="#"><i class="fas fa-user-shield me-1"></i> Safeguarding</a>
                </div>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Navigation -->
    <nav class="liverg-navbar navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="home.jsp">
                <img src="assets/img/liverg-logo.png" alt="LIVERG" class="brand-logo" onerror="this.style.display='none'">
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
                        <a class="nav-link active" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Calendar</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#upcoming-events">Upcoming Events</a></li>
                            <li><a class="dropdown-item" href="publicEvents.jsp">All Events</a></li>
                            <li><a class="dropdown-item" href="results.jsp">Results</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Rhythmic Gymnastics</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#news">News</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">About</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="about.jsp">About LIVERG</a></li>
                            <li><a class="dropdown-item" href="contact.jsp">Contact Us</a></li>
                            <li><a class="dropdown-item" href="#partners">Partners</a></li>
                        </ul>
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

    <!-- Hero Section -->
    <section class="hero-slider">
        <div class="hero-slide" style="background-image: url('registration/assets/img/curved-images/sport10.jpg');">
            <div class="container position-relative">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="liverg-hero-content animate-fade-in-up">
                            <span class="liverg-badge liverg-badge-primary mb-3">Professional Scoring System</span>
                            <h1>LIVERG Rhythmic Gymnastics Scoring System</h1>
                            <p>The ultimate professional scoring platform for rhythmic gymnastics competitions. Real-time scoring, live results, and comprehensive event management.</p>
                            <div class="d-flex gap-3 flex-wrap">
                                <a href="publicDashboard.jsp" class="btn-liverg btn-liverg-primary">
                                    <i class="fas fa-play-circle"></i> View Live Scores
                                </a>
                                <a href="#features" class="btn-liverg btn-liverg-outline" style="border-color: white; color: white;">
                                    <i class="fas fa-info-circle"></i> Learn More
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Links -->
    <div class="container">
        <div class="quick-links">
            <div class="row g-0">
                <div class="col-md-3">
                    <a href="publicEvents.jsp" class="quick-link-item d-block text-decoration-none">
                        <i class="fas fa-calendar-alt"></i>
                        <h5>Events Calendar</h5>
                        <p>View upcoming competitions</p>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="publicDashboard.jsp" class="quick-link-item d-block text-decoration-none">
                        <i class="fas fa-chart-line"></i>
                        <h5>Live Scores</h5>
                        <p>Real-time competition results</p>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="results.jsp" class="quick-link-item d-block text-decoration-none">
                        <i class="fas fa-medal"></i>
                        <h5>Results</h5>
                        <p>View past competition results</p>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="index.jsp" class="quick-link-item d-block text-decoration-none">
                        <i class="fas fa-user-circle"></i>
                        <h5>Judge Portal</h5>
                        <p>Access for officials</p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Featured News Slider -->
    <section class="featured-news-slider mt-5" id="news">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-5">
                    <div class="news-slide-content text-white">
                        <span class="liverg-badge" style="background: rgba(233,30,140,0.2); color: #e91e8c;">Latest News</span>
                        <h2 class="mt-3 text-white" style="font-size: 2.5rem; line-height: 1.2;">
                            Welcome to LIVERG Scoring System
                        </h2>
                        <p class="mt-3" style="opacity: 0.9; font-size: 1.1rem;">
                            Professional rhythmic gymnastics scoring made simple. Our platform provides real-time scoring,
                            comprehensive judge management, and seamless event organization.
                        </p>
                        <a href="news.jsp" class="btn-liverg btn-liverg-primary mt-3">
                            Read More <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                        <div class="news-indicator">
                            <span class="active"></span>
                            <span></span>
                            <span></span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <img src="registration/assets/img/curved-images/sport10.jpg" alt="Gymnastics"
                         class="img-fluid rounded-4 shadow-lg" style="max-height: 400px; width: 100%; object-fit: cover;">
                </div>
            </div>
        </div>
    </section>

    <!-- Upcoming Events Section -->
    <section class="liverg-section liverg-calendar" id="upcoming-events">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="calendar-sidebar">
                        <span class="text-uppercase fw-bold" style="color: var(--primary-dark); letter-spacing: 0.1em;">Upcoming</span>
                        <h3 class="mt-2">Rhythmic Gymnastics Events</h3>
                        <p class="text-dark mb-4">Competition Schedule</p>
                        <div class="discipline-filter">
                            <span class="discipline-tag active">Rhythmic Gymnastics</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <ul class="event-list">
                        <%
                            try {
                                DBConnect db = new DBConnect();
                                Connection conn = db.getConnection();
                                String sql = "SELECT * FROM EVENT WHERE eventDate >= CURDATE() ORDER BY eventDate ASC LIMIT 5";
                                PreparedStatement pstmt = conn.prepareStatement(sql);
                                ResultSet rs = pstmt.executeQuery();

                                boolean hasEvents = false;
                                while(rs.next()) {
                                    hasEvents = true;
                        %>
                        <li class="event-item">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h4><%= rs.getString("eventName") %></h4>
                                    <p class="event-date"><%= rs.getString("eventDate") %></p>
                                    <p class="event-location"><i class="fas fa-map-marker-alt me-1"></i> <%= rs.getString("eventVenue") != null ? rs.getString("eventVenue") : "Venue TBA" %></p>
                                </div>
                                <span class="event-discipline">Rhythmic Gymnastics</span>
                            </div>
                        </li>
                        <%
                                }

                                if(!hasEvents) {
                        %>
                        <li class="event-item">
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <h5>No Upcoming Events</h5>
                                <p class="text-muted">Check back soon for new rhythmic gymnastics competitions</p>
                            </div>
                        </li>
                        <%
                                }

                                rs.close();
                                pstmt.close();
                                conn.close();
                            } catch(Exception e) {
                                e.printStackTrace();
                        %>
                        <li class="event-item">
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                <h5>No Events Available</h5>
                                <p class="text-muted">Please check back later for upcoming competitions</p>
                            </div>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                    <div class="text-center mt-4">
                        <a href="publicEvents.jsp" class="btn-liverg btn-liverg-primary">
                            View All Events <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="liverg-section" id="features">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Why Choose Us</span>
                <h2 class="section-title">Powerful Features</h2>
                <p class="section-subtitle">Everything you need to run professional gymnastics competitions</p>
            </div>

            <div class="row g-4">
                <div class="col-md-6 col-lg-3">
                    <div class="liverg-card h-100 text-center p-4">
                        <div class="feature-icon mx-auto" style="background: linear-gradient(135deg, rgba(0,212,170,0.1), rgba(0,212,170,0.2));">
                            <i class="fas fa-bolt" style="color: var(--accent-cyan);"></i>
                        </div>
                        <h5>Real-Time Scoring</h5>
                        <p class="text-muted">Instant score updates with live broadcasting to all connected devices</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="liverg-card h-100 text-center p-4">
                        <div class="feature-icon mx-auto" style="background: linear-gradient(135deg, rgba(233,30,140,0.1), rgba(233,30,140,0.2));">
                            <i class="fas fa-users" style="color: var(--accent-magenta);"></i>
                        </div>
                        <h5>Multi-Judge Panel</h5>
                        <p class="text-muted">Support for complete jury panels with individual scoring screens</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="liverg-card h-100 text-center p-4">
                        <div class="feature-icon mx-auto" style="background: linear-gradient(135deg, rgba(139,92,246,0.1), rgba(139,92,246,0.2));">
                            <i class="fas fa-chart-bar" style="color: var(--accent-purple);"></i>
                        </div>
                        <h5>Advanced Analytics</h5>
                        <p class="text-muted">Comprehensive statistics and performance tracking</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3">
                    <div class="liverg-card h-100 text-center p-4">
                        <div class="feature-icon mx-auto" style="background: linear-gradient(135deg, rgba(200,230,50,0.1), rgba(200,230,50,0.3));">
                            <i class="fas fa-cloud" style="color: #9ab000;"></i>
                        </div>
                        <h5>Cloud Based</h5>
                        <p class="text-muted">Access from anywhere with secure cloud storage</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="liverg-stats">
        <div class="container">
            <div class="row">
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Events Managed</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">10K+</div>
                        <div class="stat-label">Gymnasts Scored</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Countries</div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">99.9%</div>
                        <div class="stat-label">Uptime</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- News Grid Section -->
    <section class="liverg-section liverg-news">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Stay Updated</span>
                <h2 class="section-title">Latest News</h2>
                <p class="section-subtitle">News and updates from the world of gymnastics</p>
            </div>

            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="news-featured">
                        <img src="registration/assets/img/curved-images/sport10.jpg" alt="News">
                        <div class="news-featured-content">
                            <span class="liverg-badge" style="background: var(--accent-magenta); color: white;">Featured</span>
                            <h3 class="mt-2">LIVERG System Now Available for International Events</h3>
                            <p>Our scoring system has been approved for use in international gymnastics competitions...</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="news-card">
                                <div class="news-card-image">
                                    <img src="registration/assets/img/curved-images/sport10.jpg" alt="News">
                                </div>
                                <div class="news-card-body">
                                    <span class="news-card-date">January 15, 2026</span>
                                    <h4>New Scoring Features Released</h4>
                                    <p>Enhanced jury panel management with real-time synchronization...</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="news-card">
                                <div class="news-card-image">
                                    <img src="registration/assets/img/curved-images/sport10.jpg" alt="News">
                                </div>
                                <div class="news-card-body">
                                    <span class="news-card-date">January 10, 2026</span>
                                    <h4>Partnership Announcement</h4>
                                    <p>LIVERG partners with national gymnastics federations...</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="news-card">
                                <div class="news-card-body">
                                    <span class="news-card-date">January 5, 2026</span>
                                    <h4>System Update: Enhanced Performance</h4>
                                    <p>Major performance improvements for large-scale competitions with hundreds of participants...</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="text-center mt-5">
                <a href="news.jsp" class="btn-liverg btn-liverg-outline">
                    View All News <i class="fas fa-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Partners Section -->
    <section class="liverg-section liverg-partners" id="partners">
        <div class="container">
            <div class="section-header">
                <span class="section-label">Our Partners</span>
                <h2 class="section-title">Trusted By</h2>
                <p class="section-subtitle">Leading gymnastics organizations worldwide</p>
            </div>

            <div class="row g-4">
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="partner-logo">
                        <img src="assets/img/partners/partner1.png" alt="Partner"
                             onerror="this.parentElement.innerHTML='<span style=color:var(--gray-400)>Partner Logo</span>'">
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="partner-logo">
                        <img src="assets/img/partners/partner2.png" alt="Partner"
                             onerror="this.parentElement.innerHTML='<span style=color:var(--gray-400)>Partner Logo</span>'">
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="partner-logo">
                        <img src="assets/img/partners/partner3.png" alt="Partner"
                             onerror="this.parentElement.innerHTML='<span style=color:var(--gray-400)>Partner Logo</span>'">
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="partner-logo">
                        <img src="assets/img/partners/partner4.png" alt="Partner"
                             onerror="this.parentElement.innerHTML='<span style=color:var(--gray-400)>Partner Logo</span>'">
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="partner-logo">
                        <img src="assets/img/partners/partner5.png" alt="Partner"
                             onerror="this.parentElement.innerHTML='<span style=color:var(--gray-400)>Partner Logo</span>'">
                    </div>
                </div>
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="partner-logo">
                        <img src="assets/img/partners/partner6.png" alt="Partner"
                             onerror="this.parentElement.innerHTML='<span style=color:var(--gray-400)>Partner Logo</span>'">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action -->
    <section class="liverg-section" style="background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));">
        <div class="container text-center">
            <h2 class="text-white mb-3">Ready to Get Started?</h2>
            <p class="text-white mb-4" style="opacity: 0.9; max-width: 600px; margin: 0 auto;">
                Join hundreds of gymnastics organizations using LIVERG for professional competition scoring.
            </p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="contact.jsp" class="btn-liverg btn-liverg-primary">
                    <i class="fas fa-envelope"></i> Contact Us
                </a>
                <a href="index.jsp" class="btn-liverg" style="background: white; color: var(--primary-color);">
                    <i class="fas fa-sign-in-alt"></i> Login to Portal
                </a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="liverg-footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="footer-brand">
                        <img src="assets/img/liverg-logo-white.png" alt="LIVERG"
                             onerror="this.outerHTML='<h3 style=color:white;margin-bottom:1rem>LIVERG</h3>'">
                        <p>Professional rhythmic gymnastics scoring system for competitions worldwide. Trusted by national and international federations.</p>
                        <div class="footer-social mt-3">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-youtube"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
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
                    <h6 class="footer-title">Discipline</h6>
                    <ul class="footer-links">
                        <li><a href="#">Rhythmic Gymnastics</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 col-lg-2">
                    <h6 class="footer-title">Support</h6>
                    <ul class="footer-links">
                        <li><a href="contact.jsp">Contact Us</a></li>
                        <li><a href="#">Documentation</a></li>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Training</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 col-lg-2">
                    <h6 class="footer-title">Legal</h6>
                    <ul class="footer-links">
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Use</a></li>
                        <li><a href="#">Cookie Policy</a></li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p>&copy; 2026 LIVERG Scoring System. All rights reserved.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p>Designed for Excellence in Gymnastics</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom Scripts -->
    <script>
        // Discipline filter functionality
        document.querySelectorAll('.discipline-tag').forEach(tag => {
            tag.addEventListener('click', function() {
                document.querySelectorAll('.discipline-tag').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // News slider indicators
        document.querySelectorAll('.news-indicator span').forEach((indicator, index) => {
            indicator.addEventListener('click', function() {
                document.querySelectorAll('.news-indicator span').forEach(i => i.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            });
        });
    </script>
</body>
</html>
