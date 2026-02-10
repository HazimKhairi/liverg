<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News - LIVERG Rhythmic Gymnastics Scoring System</title>

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
            body {
                background-color: #ffffff;
                font-family: 'Inter', sans-serif;
            }

            /* Navbar Override to match the clean look if needed, but keeping standard for consistency */
            .liverg-navbar {
                box-shadow: none;
                border-bottom: 1px solid #e2e8f0;
            }

            /* Hero Section */
            .news-hero {
                background: linear-gradient(135deg, #1a3a5c 0%, #2d5a8a 100%);
                padding: 4rem 0;
                color: white;
                text-align: left;
                position: relative;
                overflow: hidden;
            }

            .news-hero::before {
                content: '';
                position: absolute;
                top: -50%;
                right: -20%;
                width: 600px;
                height: 600px;
                background: linear-gradient(135deg, rgba(0, 212, 170, 0.2), rgba(233, 30, 140, 0.2));
                border-radius: 50%;
            }

            .news-hero h1 {
                font-family: 'Montserrat', sans-serif;
                font-weight: 800;
                font-size: 3.5rem;
                margin: 0;
                text-transform: uppercase;
                position: relative;
                color: white;
            }

            /* Filter Bar */
            .filter-bar {
                background-color: #f3f4f6;
                padding: 1.5rem 0;
                border-bottom: 1px solid #e5e7eb;
            }

            .current-year {
                font-family: 'Montserrat', sans-serif;
                font-size: 2rem;
                font-weight: 800;
                color: #333;
                margin: 0;
            }

            .filter-controls .btn-filter {
                background-color: transparent;
                border: 1px solid #9ca3af;
                color: #4b5563;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                padding: 0.5rem 1.5rem;
                border-radius: 4px;
                transition: all 0.2s;
            }

            .filter-controls .btn-filter:hover {
                background-color: #e5e7eb;
                color: black;
            }

            .dropdown-toggle::after {
                margin-left: 0.5em;
            }

            .view-toggle {
                font-size: 1.5rem;
                color: #6b7280;
                cursor: pointer;
                margin-left: 1rem;
            }

            /* News Grid */
            .news-grid {
                padding: 3rem 0;
            }

            .news-card {
                border: 1px solid #e5e7eb;
                border-radius: 4px;
                overflow: hidden;
                height: 100%;
                transition: transform 0.2s, box-shadow 0.2s;
                background: white;
            }

            .news-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }

            .news-img-wrapper {
                height: 240px;
                overflow: hidden;
                position: relative;
            }

            .news-img-wrapper img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s;
            }

            .news-card:hover .news-img-wrapper img {
                transform: scale(1.05);
            }

            .news-body {
                padding: 1.5rem;
                text-align: center;
            }

            .news-title {
                font-family: 'Montserrat', sans-serif;
                font-size: 1.1rem;
                font-weight: 800;
                color: #111;
                margin-bottom: 0.75rem;
                line-height: 1.4;
            }

            .news-date {
                font-size: 0.75rem;
                color: #6b7280;
                margin-bottom: 1rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .news-excerpt {
                font-size: 0.9rem;
                color: #4b5563;
                line-height: 1.6;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            /* Custom Dropdown Style */
            .year-select {
                background-color: #888;
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                border-radius: 0;
                display: flex;
                align-items: center;
                justify-content: space-between;
                min-width: 160px;
            }

            .year-select:hover {
                background-color: #666;
                color: white;
            }

            .filter-btn-outline {
                border: 1px solid #999;
                color: #666;
                background: transparent;
                padding: 0.5rem 1.5rem;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.85rem;
                border-radius: 4px;
                border-radius: 4px;
            }

            .filter-btn-outline:hover {
                border-color: #333;
                color: #333;
            }
        </style>
    </head>

    <body>
        <!-- Main Navigation -->
        <nav class="navbar navbar-expand-lg liverg-navbar">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <img src="assets/img/liverg-logo.png" alt="LIVERG" class="brand-logo"
                        style="height: 50px;">
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
                            <a class="nav-link" href="publicEvents.jsp">Competitions</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="publicDashboard.jsp">Live Scores</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="news.jsp">News</a>
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

        <!-- News Header -->
        <section class="news-hero">
            <div class="container">
                <h1>News</h1>
            </div>
        </section>

        <!-- Filter Bar -->
        <section class="filter-bar">
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="current-year">2026</h2>
                    <div class="d-flex align-items-center gap-3">
                        <div class="dropdown">
                            <button class="btn year-select dropdown-toggle" type="button" data-bs-toggle="dropdown"
                                aria-expanded="false">
                                Select a Year
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#">2026</a></li>
                                <li><a class="dropdown-item" href="#">2025</a></li>
                                <li><a class="dropdown-item" href="#">2024</a></li>
                            </ul>
                        </div>

                        <button class="btn filter-btn-outline">
                            Filter
                        </button>

                        <div class="view-toggle">
                            <i class="fas fa-list-ul"></i>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- News Grid -->
        <section class="news-grid">
            <div class="container">
                <div class="row g-4">

                    <!-- News Item 1 -->
                    <div class="col-md-4">
                        <div class="news-card">
                            <div class="news-img-wrapper">
                                <img src="assets/img/news/news-1.png" alt="Rhythmic Gymnastics Competition">
                            </div>
                            <div class="news-body">
                                <h3 class="news-title">Olympians And World Champions Set To Take Stage At 2026 American
                                    Cup</h3>
                                <div class="news-date">January 30, 2026</div>
                                <p class="news-excerpt">
                                    More than 12 Olympians and 23 World Championship athletes make up the international
                                    rosters expected to compete March 7 at the 2026 American Cup.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- News Item 2 -->
                    <div class="col-md-4">
                        <div class="news-card">
                            <div class="news-img-wrapper">
                                <img src="assets/img/news/news-2.png" alt="Creator Program">
                            </div>
                            <div class="news-body">
                                <h3 class="news-title">Gymnastics Creator Program Launches Second Season</h3>
                                <div class="news-date">January 29, 2026</div>
                                <p class="news-excerpt">
                                    The organization launched the second edition of the Creator Program today, designed
                                    to give current and former gymnasts an opportunity to expand their experience.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- News Item 3 -->
                    <div class="col-md-4">
                        <div class="news-card">
                            <div class="news-img-wrapper">
                                <img src="assets/img/news/news-3.png" alt="Judging Panel">
                            </div>
                            <div class="news-body">
                                <h3 class="news-title">Statement On The Swiss Federal Supreme Court Decision</h3>
                                <div class="news-date">January 29, 2026</div>
                                <p class="news-excerpt">
                                    We are pleased the Swiss Federal Supreme Court recognized the flaws in the initial
                                    process and that the case can now be heard inclusive of all relevant evidence.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- News Item 4 -->
                    <div class="col-md-4">
                        <div class="news-card">
                            <div class="news-img-wrapper">
                                <img src="https://images.unsplash.com/photo-1574680096141-1cddd32e04ca?q=80&w=2669&auto=format&fit=crop"
                                    alt="Gymnastics">
                            </div>
                            <div class="news-body">
                                <h3 class="news-title">Junior National Team Training Camp Concludes in Texas</h3>
                                <div class="news-date">January 25, 2026</div>
                                <p class="news-excerpt">
                                    The first National Team training camp of the year concluded successfully with 24
                                    junior athletes participating in rigorous evaluations.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- News Item 5 -->
                    <div class="col-md-4">
                        <div class="news-card">
                            <div class="news-img-wrapper">
                                <img src="https://plus.unsplash.com/premium_photo-1661601662704-adc715f5d342?q=80&w=2670&auto=format&fit=crop"
                                    alt="Gymnastics">
                            </div>
                            <div class="news-body">
                                <h3 class="news-title">New Scoring System Guidelines Released for 2026-2028 Cycle</h3>
                                <div class="news-date">January 20, 2026</div>
                                <p class="news-excerpt">
                                    The technical committee has released the updated Code of Points, emphasizing
                                    artistry and execution for the upcoming Olympic cycle.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- News Item 6 -->
                    <div class="col-md-4">
                        <div class="news-card">
                            <div class="news-img-wrapper">
                                <img src="https://images.unsplash.com/photo-1499245131599-4d6cbdb86f56?q=80&w=2670&auto=format&fit=crop"
                                    alt="Gymnastics">
                            </div>
                            <div class="news-body">
                                <h3 class="news-title">Regional Qualifiers Dates Announced</h3>
                                <div class="news-date">January 15, 2026</div>
                                <p class="news-excerpt">
                                    Locations and dates for all six regional qualifying events have been confirmed.
                                    Registration opens next week for all eligible clubs.
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <!-- Footer -->
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
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <h5 class="footer-title">Platform</h5>
                        <ul class="footer-links">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">Live Scores</a></li>
                            <li><a href="#">Events Calendar</a></li>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>