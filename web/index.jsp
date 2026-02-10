<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>LIVERG - Official Rhythmic Gymnastics Scoring System</title>

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@500;600;700;800&display=swap"
            rel="stylesheet">

        <!-- Bootstrap 5 (Grid Only preference, but full is fine) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <!-- Custom Theme -->
        <link rel="stylesheet" href="assets/css/liverg-theme.css">

        <style>
            /* Custom Overrides for Index specific needs */
            .hero-section-custom {
                /* Fallback */
                background: linear-gradient(rgba(13, 40, 64, 0.4), rgba(13, 40, 64, 0.6)), url('assets/img/hero_malaysia_v2.png') no-repeat center center/cover;
                height: 85vh;
                display: flex;
                align-items: center;
                position: relative;
            }

            .cta-card-icon {
                width: 80px;
                height: 80px;
                background: rgba(0, 212, 170, 0.1);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1.5rem;
                color: var(--accent-cyan);
                font-size: 2rem;
                transition: all 0.3s;
            }

            .liverg-card:hover .cta-card-icon {
                background: var(--accent-cyan);
                color: white;
                transform: scale(1.1);
            }
        </style>
    </head>

    <body>

        <!-- Top Bar -->
        <div class="liverg-topbar">
            <div class="container d-flex justify-content-between align-items-center">
                <div class="d-none d-md-block">
                    <span class="me-3"><i class="fas fa-envelope me-2"></i> info@liverg-scoring.com</span>
                    <span><i class="fas fa-phone-alt me-2"></i> +60 3-8994 4800</span>
                </div>
                <div class="social-links ms-auto">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>
        </div>

        <!-- Main Navigation -->
        <nav class="navbar navbar-expand-lg liverg-navbar">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="assets/img/liverg-logo.png" alt="LIVERG" class="brand-logo"
                        style="height: 50px;">
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="mainNav">
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="publicEvents.jsp">Competitions</a>
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

        <!-- Hero Section -->
        <header class="hero-section-custom">
            <div class="container position-relative z-2">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <h5 class="text-uppercase text-white mb-3" style="letter-spacing: 2px; font-weight: 600;">
                            Official Scoring Partner</h5>
                        <h1 class="display-3 fw-bold text-white mb-4">Precision in Every Move,<br> excellence in <span
                                class="text-gradient"
                                style="background: linear-gradient(90deg, #00d4aa, #fff); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Every
                                Score</span></h1>
                        <p class="lead text-white-50 mb-5 w-75">
                            The most advanced digital scoring platform for Rhythmic Gymnastics in Malaysia. Real-time
                            accuracy, comprehensive analytics, and seamless event management.
                        </p>
                        <div class="d-flex gap-3 flex-wrap">
                            <a href="publicEvents.jsp" class="btn btn-liverg btn-liverg-primary btn-lg px-5">
                                <i class="fas fa-calendar-alt"></i> View Events
                            </a>
                            <a href="publicDashboard.jsp" class="btn btn-liverg btn-light btn-lg px-5"
                                style="border-radius: 50px;">
                                <i class="fas fa-chart-bar text-primary"></i> Live Scores
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- Stats Section -->
        <section class="liverg-stats">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <div class="stat-number">150+</div>
                            <div class="stat-label">Events Managed</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <div class="stat-number">2.5k</div>
                            <div class="stat-label">Athletes</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <div class="stat-number">99.9%</div>
                            <div class="stat-label">Uptime</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <div class="stat-number">10k+</div>
                            <div class="stat-label">Scores Processed</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Main CTA Section (Commercial Feature) -->
        <section class="liverg-section bg-white" id="features">
            <div class="container">
                <div class="section-header">
                    <span class="section-label">Explore The Platform</span>
                    <h2 class="section-title">Everything You Need</h2>
                    <p class="section-subtitle">Whether you are a fan, an athlete, or an official, LIVERG connects you
                        to the heartbeat of the competition.</p>
                </div>

                <div class="row g-4">
                    <!-- Card 1: Events -->
                    <div class="col-lg-4 col-md-6">
                        <div class="liverg-card h-100 p-4 text-center">
                            <div class="cta-card-icon mx-auto">
                                <i class="fas fa-trophy"></i>
                            </div>
                            <h3>Championships</h3>
                            <p class="text-muted mb-4">Browse upcoming national and international rhythmic gymnastics
                                events happening in Malaysia.</p>
                            <a href="publicEvents.jsp"
                                class="btn btn-liverg btn-liverg-outline w-100 justify-content-center">Browse Events</a>
                        </div>
                    </div>

                    <!-- Card 2: Player Rankings/Scores -->
                    <div class="col-lg-4 col-md-6">
                        <div class="liverg-card h-100 p-4 text-center"
                            style="border: 2px solid var(--accent-cyan); transform: scale(1.05);">
                            <div class="position-absolute top-0 end-0 bg-success text-white px-3 py-1"
                                style="border-bottom-left-radius: 10px; font-size: 0.8rem; font-weight: bold;">LIVE
                            </div>
                            <div class="cta-card-icon mx-auto">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <h3>Live Scoring</h3>
                            <p class="text-muted mb-4">Access real-time scores, judges' breakdowns, and final rankings
                                as the action happens.</p>
                            <a href="publicDashboard.jsp"
                                class="btn btn-liverg btn-liverg-primary w-100 justify-content-center">View
                                Standings</a>
                        </div>
                    </div>

                    <!-- Card 3: Athlete Profiles -->
                    <div class="col-lg-4 col-md-6">
                        <div class="liverg-card h-100 p-4 text-center">
                            <div class="cta-card-icon mx-auto">
                                <i class="fas fa-running"></i>
                            </div>
                            <h3>Athlete Profiles</h3>
                            <p class="text-muted mb-4">Discover rising stars and seasoned professionals. Track their
                                performance history.</p>
                            <a href="#" class="btn btn-liverg btn-liverg-outline w-100 justify-content-center">Search
                                Athletes</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Partners / Organized By -->
        <section class="liverg-partners py-5">
            <div class="container">
                <div class="text-center mb-4">
                    <span class="text-uppercase fw-bold text-muted" style="letter-spacing: 2px;">Supported By</span>
                </div>
                <div class="row justify-content-center align-items-center g-5">
                    <div class="col-6 col-md-3 text-center">
                        <img src="assets/img/kbs.png" alt="KBS" class="img-fluid opacity-75" style="max-height: 80px; transition: all 0.3s;">
                    </div>
                    <div class="col-6 col-md-3 text-center">
                         <img src="assets/img/mfg.png" alt="MFG" class="img-fluid opacity-75" style="max-height: 80px; transition: all 0.3s;">
                    </div>
                </div>
            </div>
        </section>

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
        <script>
            // Navbar scroll effect
            window.addEventListener('scroll', function () {
                if (window.scrollY > 50) {
                    document.querySelector('.liverg-navbar').classList.add('shadow-md');
                } else {
                    document.querySelector('.liverg-navbar').classList.remove('shadow-md');
                }
            });
        </script>
    </body>

    </html>