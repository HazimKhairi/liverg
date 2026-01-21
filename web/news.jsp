<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News - LIVERG Rhythmic Gymnastics Scoring System</title>

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

        .news-content {
            padding: 3rem 0;
        }

        .news-card {
            background: white;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            transition: all 0.3s;
            height: 100%;
        }

        .news-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .news-card-image {
            height: 200px;
            overflow: hidden;
        }

        .news-card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s;
        }

        .news-card:hover .news-card-image img {
            transform: scale(1.05);
        }

        .news-card-body {
            padding: 1.5rem;
        }

        .news-card-date {
            font-size: 0.75rem;
            color: #00d4aa;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 0.5rem;
        }

        .news-card-title {
            font-size: 1.125rem;
            color: #1a3a5c;
            margin-bottom: 0.75rem;
            font-weight: 600;
        }

        .news-card-excerpt {
            font-size: 0.875rem;
            color: #64748b;
            line-height: 1.6;
        }

        .news-empty {
            text-align: center;
            padding: 4rem 2rem;
        }

        .news-empty i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
        }

        .news-empty h4 {
            color: #64748b;
        }

        .news-empty p {
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
                        <a class="nav-link" href="results.jsp">Results</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="news.jsp">News</a>
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
                <a href="news.jsp">News</a>
            </div>
            <h1>News</h1>
            <p>Latest updates from LIVERG Rhythmic Gymnastics Scoring System</p>
        </div>
    </section>

    <!-- News Content -->
    <section class="news-content">
        <div class="container">
            <div class="news-empty">
                <i class="fas fa-newspaper"></i>
                <h4>No News Available</h4>
                <p>Check back soon for the latest updates on rhythmic gymnastics events and system features.</p>
                <a href="home.jsp" class="btn-liverg btn-liverg-primary mt-3">
                    <i class="fas fa-home me-2"></i>Back to Home
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
</body>
</html>
