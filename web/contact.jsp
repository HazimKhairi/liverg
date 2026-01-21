<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - LIVERG Rhythmic Gymnastics Scoring System</title>

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

        .contact-content {
            padding: 3rem 0;
        }

        .contact-card {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            height: 100%;
            text-align: center;
            transition: all 0.3s;
        }

        .contact-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .contact-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: rgba(0, 212, 170, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }

        .contact-icon i {
            font-size: 1.75rem;
            color: #00d4aa;
        }

        .contact-card h4 {
            color: #1a3a5c;
            margin-bottom: 0.75rem;
            font-size: 1.125rem;
        }

        .contact-card p {
            color: #64748b;
            font-size: 0.875rem;
            margin-bottom: 0;
        }

        .contact-form-section {
            background: #f8fafc;
            padding: 3rem 0;
        }

        .contact-form {
            background: white;
            border-radius: 1rem;
            padding: 2.5rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }

        .contact-form h3 {
            color: #1a3a5c;
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 500;
            color: #1a3a5c;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: #00d4aa;
            box-shadow: 0 0 0 3px rgba(0, 212, 170, 0.1);
        }

        textarea.form-control {
            min-height: 150px;
        }

        .btn-submit {
            background: #00d4aa;
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: 2rem;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-submit:hover {
            background: #00b894;
            transform: translateY(-2px);
            color: white;
        }

        .contact-info-side {
            padding-left: 2rem;
        }

        .contact-info-side h3 {
            color: #1a3a5c;
            margin-bottom: 1.5rem;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .info-item-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: rgba(0, 212, 170, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .info-item-icon i {
            color: #00d4aa;
        }

        .info-item-content h5 {
            color: #1a3a5c;
            font-size: 1rem;
            margin-bottom: 0.25rem;
        }

        .info-item-content p {
            color: #64748b;
            font-size: 0.875rem;
            margin: 0;
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
                        <a class="nav-link" href="news.jsp">News</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="contact.jsp">Contact</a>
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
                <a href="contact.jsp">Contact</a>
            </div>
            <h1>Contact Us</h1>
            <p>Get in touch with the LIVERG team</p>
        </div>
    </section>

    <!-- Contact Cards -->
    <section class="contact-content">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h4>Email Us</h4>
                        <p>info@liverg.com</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <h4>Call Us</h4>
                        <p>+60 12-345 6789</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <h4>Visit Us</h4>
                        <p>Kuala Lumpur, Malaysia</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Form Section -->
    <section class="contact-form-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <div class="contact-form">
                        <h3><i class="fas fa-paper-plane me-2" style="color: #00d4aa;"></i>Send us a Message</h3>
                        <form id="contactForm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" placeholder="Enter your name" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control" placeholder="Enter your email" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Subject</label>
                                <input type="text" class="form-control" placeholder="Enter subject">
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Message</label>
                                <textarea class="form-control" placeholder="Enter your message" required></textarea>
                            </div>
                            <button type="submit" class="btn-submit">
                                <i class="fas fa-paper-plane me-2"></i>Send Message
                            </button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="contact-info-side">
                        <h3>Contact Information</h3>
                        <div class="info-item">
                            <div class="info-item-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="info-item-content">
                                <h5>Operating Hours</h5>
                                <p>Monday - Friday: 9:00 AM - 6:00 PM</p>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-item-icon">
                                <i class="fas fa-headset"></i>
                            </div>
                            <div class="info-item-content">
                                <h5>Technical Support</h5>
                                <p>Available during competition events</p>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-item-icon">
                                <i class="fas fa-globe"></i>
                            </div>
                            <div class="info-item-content">
                                <h5>Follow Us</h5>
                                <div class="d-flex gap-2 mt-2">
                                    <a href="#" class="btn btn-sm" style="background: #f0f9ff; color: #1a3a5c;">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a href="#" class="btn btn-sm" style="background: #f0f9ff; color: #1a3a5c;">
                                        <i class="fab fa-twitter"></i>
                                    </a>
                                    <a href="#" class="btn btn-sm" style="background: #f0f9ff; color: #1a3a5c;">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            e.preventDefault();
            Swal.fire({
                icon: 'success',
                title: 'Message Sent!',
                text: 'Thank you for contacting us. We will get back to you soon.',
                confirmButtonColor: '#00d4aa'
            });
            this.reset();
        });
    </script>
</body>
</html>
