<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password - LIVERG Scoring System</title>

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
                min-height: 100vh;
                background: linear-gradient(135deg, #0d2840 0%, #1a3a5c 50%, #2d5a8a 100%);
            }

            .login-container {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
            }

            .login-wrapper {
                display: flex;
                width: 100%;
                max-width: 1000px;
                background: white;
                border-radius: 1.5rem;
                overflow: hidden;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            }

            .login-image {
                flex: 1;
                background: linear-gradient(135deg, rgba(0, 212, 170, 0.9), rgba(233, 30, 140, 0.9)),
                    url('registration/assets/img/curved-images/sport10.jpg');
                background-size: cover;
                background-position: center;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 3rem;
                text-align: center;
                position: relative;
                min-height: 500px;
            }

            .login-image::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/><circle cx="50" cy="50" r="30" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/><circle cx="50" cy="50" r="20" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></svg>');
                background-size: 200px;
                opacity: 0.3;
            }

            .login-image-content {
                position: relative;
                z-index: 1;
                color: white;
            }

            .login-image h1 {
                font-family: 'Montserrat', sans-serif;
                font-weight: 800;
                font-size: 2.5rem;
                margin-bottom: 1rem;
                color: white;
            }

            .login-image p {
                font-size: 1.1rem;
                opacity: 0.95;
                max-width: 350px;
                margin: 0 auto;
                line-height: 1.6;
            }

            .login-form {
                flex: 1;
                padding: 3rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-header {
                margin-bottom: 2rem;
            }

            .login-header .logo {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-bottom: 1.5rem;
            }

            .login-header .logo img {
                height: 45px;
            }

            .login-header .logo-text {
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                font-size: 1.5rem;
                color: var(--primary-color);
            }

            .login-header h2 {
                font-size: 1.75rem;
                color: var(--gray-800);
                margin-bottom: 0.5rem;
            }

            .login-header p {
                color: var(--gray-500);
                font-size: 0.95rem;
            }

            .form-floating {
                margin-bottom: 1.25rem;
            }

            .form-floating .form-control {
                border: 2px solid var(--gray-200);
                border-radius: 0.75rem;
                height: 3.5rem;
                padding: 1rem 1rem;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .form-floating .form-control:focus {
                border-color: var(--accent-cyan);
                box-shadow: 0 0 0 4px rgba(0, 212, 170, 0.1);
            }

            .form-floating label {
                padding: 1rem;
                color: var(--gray-500);
            }

            .form-floating>.form-control:focus~label,
            .form-floating>.form-control:not(:placeholder-shown)~label {
                color: var(--accent-cyan);
                transform: scale(0.85) translateY(-0.75rem) translateX(0.15rem);
            }

            .btn-login {
                width: 100%;
                padding: 1rem;
                font-size: 1rem;
                font-weight: 600;
                border: none;
                border-radius: 0.75rem;
                background: linear-gradient(135deg, var(--accent-cyan), var(--primary-light));
                color: white;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 20px rgba(0, 212, 170, 0.3);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            .back-home {
                position: absolute;
                top: 1.5rem;
                left: 1.5rem;
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 500;
                transition: all 0.3s;
                z-index: 10;
            }

            .back-home:hover {
                color: var(--accent-cyan);
            }

            .back-to-login {
                display: block;
                text-align: center;
                margin-top: 1.5rem;
                color: var(--gray-600);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s;
            }

            .back-to-login:hover {
                color: var(--accent-cyan);
            }

            @media (max-width: 768px) {
                .login-wrapper {
                    flex-direction: column;
                }

                .login-image {
                    min-height: 250px;
                    padding: 2rem;
                }

                .login-image h1 {
                    font-size: 1.75rem;
                }

                .login-form {
                    padding: 2rem;
                }
            }
        </style>
    </head>

    <body>
        <a href="index.jsp" class="back-home">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>

        <div class="login-container">
            <div class="login-wrapper">
                <!-- Left Side - Image & Branding -->
                <div class="login-image">
                    <div class="login-image-content">
                        <i class="fas fa-shield-alt fa-4x mb-4" style="opacity: 0.9;"></i>
                        <h1>Security</h1>
                        <p>Protecting your account and data is our top priority. Reset your password securely.</p>
                    </div>
                </div>

                <!-- Right Side - Password Reset Form -->
                <div class="login-form">
                    <div class="login-header">
                        <div class="logo">
                            <img src="assets/img/liverg-logo.png" alt="LIVERG" style="height: 50px;">
                        </div>
                        <h2>Forgot Password?</h2>
                        <p>Enter your email address to reset your password.</p>
                    </div>

                    <form id="forgotPasswordForm" onsubmit="handleReset(event)">
                        <div class="form-floating position-relative">
                            <input type="email" class="form-control" id="email" name="email"
                                placeholder="name@example.com" required>
                            <label for="email"><i class="fas fa-envelope me-2"></i>Email Address</label>
                        </div>

                        <button type="submit" class="btn-login mt-4">
                            <span class="btn-text">
                                <i class="fas fa-paper-plane"></i> Send Reset Link
                            </span>
                        </button>
                    </form>

                    <a href="login.jsp" class="back-to-login">
                        <i class="fas fa-arrow-left me-2"></i>Back to Login
                    </a>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            function handleReset(e) {
                e.preventDefault();
                const email = document.getElementById('email').value;
                const btn = document.querySelector('.btn-login');

                // Validate email format
                if (!email || !email.includes('@')) {
                    Swal.fire({
                        icon: "error",
                        title: "Invalid Email",
                        text: "Please enter a valid email address.",
                        confirmButtonColor: '#1a3a5c'
                    });
                    return;
                }

                // Simulate loading
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Sending...';
                btn.disabled = true;

                // Mock server request (Replace with actual backend call)
                setTimeout(() => {
                    btn.innerHTML = '<i class="fas fa-check me-2"></i>Sent!';
                    btn.classList.remove('btn-login');
                    btn.classList.add('btn', 'btn-success', 'w-100', 'py-3', 'fw-bold');

                    Swal.fire({
                        icon: "success",
                        title: "Reset Link Sent",
                        text: "If an account exists with this email, you will receive a password reset link shortly.",
                        confirmButtonColor: '#00d4aa'
                    }).then(() => {
                        // Optional: redirect to login
                        // window.location.href = "login.jsp";
                    });
                }, 1500);
            }
        </script>
    </body>

    </html>