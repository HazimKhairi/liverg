<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - LIVERG Scoring System</title>

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

        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label {
            color: var(--accent-cyan);
            transform: scale(0.85) translateY(-0.75rem) translateX(0.15rem);
        }

        .input-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            pointer-events: none;
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

        .login-footer {
            margin-top: 2rem;
            text-align: center;
        }

        .login-footer a {
            color: var(--accent-cyan);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .login-footer a:hover {
            color: var(--primary-color);
            text-decoration: underline;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--gray-200);
        }

        .divider span {
            padding: 0 1rem;
            color: var(--gray-400);
            font-size: 0.875rem;
        }

        .social-login {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid var(--gray-200);
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            color: var(--gray-600);
        }

        .social-btn:hover {
            border-color: var(--accent-cyan);
            color: var(--accent-cyan);
            transform: translateY(-3px);
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

        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: rgba(255,255,255,0.2);
            border-radius: 2rem;
            font-size: 0.875rem;
            margin-top: 1.5rem;
            backdrop-filter: blur(10px);
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

        /* Loading animation */
        .btn-login.loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .btn-login.loading .btn-text {
            visibility: hidden;
        }

        .btn-login.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            border: 2px solid transparent;
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <a href="home.jsp" class="back-home">
        <i class="fas fa-arrow-left"></i> Back to Home
    </a>

    <div class="login-container">
        <div class="login-wrapper">
            <!-- Left Side - Image & Branding -->
            <div class="login-image">
                <div class="login-image-content">
                    <i class="fas fa-medal fa-4x mb-4" style="opacity: 0.9;"></i>
                    <h1>LIVERG</h1>
                    <p>Professional Rhythmic Gymnastics Scoring System. The platform where excellence meets precision.</p>
                    <div class="role-badge">
                        <i class="fas fa-users"></i>
                        Staff, Judges, Admins & Organizations
                    </div>
                </div>
            </div>

            <!-- Right Side - Login Form -->
            <div class="login-form">
                <div class="login-header">
                    <div class="logo">
                        <img src="assets/img/liverg-logo.png" alt="LIVERG"
                             onerror="this.outerHTML='<i class=\'fas fa-medal fa-2x\' style=\'color: var(--accent-cyan);\'></i>'">
                        <span class="logo-text">LIVERG</span>
                    </div>
                    <h2>Welcome Back</h2>
                    <p>Sign in to access the scoring system</p>
                </div>

                <form id="ajaxLogin">
                    <div class="form-floating position-relative">
                        <input type="text" class="form-control" id="username" name="username"
                               placeholder="Username" required autocomplete="off">
                        <label for="username"><i class="fas fa-user me-2"></i>Username</label>
                    </div>

                    <div class="form-floating position-relative">
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="Password" required>
                        <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                        <button type="button" class="btn position-absolute end-0 top-50 translate-middle-y me-2"
                                onclick="togglePassword()" style="border: none; background: none;">
                            <i class="fas fa-eye" id="toggleIcon"></i>
                        </button>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="remember">
                            <label class="form-check-label" for="remember" style="color: var(--gray-600); font-size: 0.9rem;">
                                Remember me
                            </label>
                        </div>
                        <a href="#" style="color: var(--accent-cyan); font-size: 0.9rem; text-decoration: none;">
                            Forgot password?
                        </a>
                    </div>

                    <button type="button" class="btn-login" onclick="login()">
                        <span class="btn-text">
                            <i class="fas fa-sign-in-alt"></i> Sign In
                        </span>
                    </button>
                </form>

                <div class="divider">
                    <span>or continue with</span>
                </div>

                <div class="social-login">
                    <button class="social-btn" title="Sign in with Google">
                        <i class="fab fa-google"></i>
                    </button>
                    <button class="social-btn" title="Sign in with Microsoft">
                        <i class="fab fa-microsoft"></i>
                    </button>
                    <button class="social-btn" title="Sign in with Apple">
                        <i class="fab fa-apple"></i>
                    </button>
                </div>

                <div class="login-footer">
                    <p style="color: var(--gray-500); font-size: 0.9rem;">
                        Need access? <a href="contact.jsp">Contact Administrator</a>
                    </p>
                    <p style="color: var(--gray-400); font-size: 0.8rem; margin-top: 1rem;">
                        <a href="scoring/jury/juryAccess.jsp" style="color: var(--gray-400);">
                            <i class="fas fa-gavel me-1"></i> Jury Access Portal
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');

            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        function login() {
            const btn = document.querySelector('.btn-login');
            btn.classList.add('loading');

            var data = $("#ajaxLogin").serialize();
            $.ajax({
                type: 'POST',
                url: 'LoginServlet',
                data: data,
                dataType: 'JSON',
                success: function(data) {
                    btn.classList.remove('loading');
                    var msg = data[0].msg;

                    if (msg == 1) {
                        Swal.fire({
                            icon: "success",
                            title: "Welcome, Staff!",
                            text: "Redirecting to dashboard...",
                            timer: 1500,
                            timerProgressBar: true,
                            showConfirmButton: false,
                            background: '#fff',
                            iconColor: '#00d4aa'
                        }).then(() => {
                            window.location.href = "registration/dashboard.jsp";
                        });
                    } else if (msg == 2) {
                        Swal.fire({
                            icon: "success",
                            title: "Welcome, Clerk!",
                            text: "Redirecting to dashboard...",
                            timer: 1500,
                            timerProgressBar: true,
                            showConfirmButton: false,
                            background: '#fff',
                            iconColor: '#00d4aa'
                        }).then(() => {
                            window.location.href = "registration/dashboard.jsp";
                        });
                    } else if (msg == 3) {
                        Swal.fire({
                            icon: "success",
                            title: "Welcome, Head Judge!",
                            text: "Redirecting to scoring system...",
                            timer: 1500,
                            timerProgressBar: true,
                            showConfirmButton: false,
                            background: '#fff',
                            iconColor: '#00d4aa'
                        }).then(() => {
                            window.location.href = "Score";
                        });
                    } else if (msg == 4) {
                        Swal.fire({
                            icon: "success",
                            title: "Welcome, Super Admin!",
                            text: "Redirecting to dashboard...",
                            timer: 1500,
                            timerProgressBar: true,
                            showConfirmButton: false,
                            background: '#fff',
                            iconColor: '#00d4aa'
                        }).then(() => {
                            window.location.href = "registration/dashboard.jsp";
                        });
                    } else if (msg == 5) {
                        Swal.fire({
                            icon: "success",
                            title: "Welcome, Organization!",
                            text: "Redirecting to dashboard...",
                            timer: 1500,
                            timerProgressBar: true,
                            showConfirmButton: false,
                            background: '#fff',
                            iconColor: '#00d4aa'
                        }).then(() => {
                            window.location.href = "registration/dashboard.jsp";
                        });
                    } else {
                        Swal.fire({
                            icon: "error",
                            title: "Login Failed",
                            text: "Invalid username or password. Please try again.",
                            confirmButtonColor: '#1a3a5c'
                        });
                    }
                },
                error: function() {
                    btn.classList.remove('loading');
                    Swal.fire({
                        icon: "error",
                        title: "Connection Error",
                        text: "Unable to connect to server. Please try again.",
                        confirmButtonColor: '#1a3a5c'
                    });
                }
            });
        }

        // Enter key to submit
        document.getElementById('password').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                login();
            }
        });

        document.getElementById('username').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.getElementById('password').focus();
            }
        });
    </script>
</body>
</html>
