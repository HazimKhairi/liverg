<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jury Access | LIVERG</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --primary-cyan: #00d4aa;
            --primary-magenta: #e91e8c;
            --primary-purple: #8b5cf6;
            --dark-bg: #0a0a1a;
            --dark-surface: #12122a;
            --dark-card: #1a1a3a;
            --dark-border: #2a2a4a;
            --text-primary: #ffffff;
            --text-secondary: #a0a0c0;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --gradient-primary: linear-gradient(135deg, var(--primary-cyan), var(--primary-magenta));
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        html, body {
            height: 100vh;
            overflow: hidden;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--dark-bg);
            color: var(--text-primary);
            display: flex;
            flex-direction: column;
        }

        /* Header */
        .page-header {
            background: var(--dark-surface);
            border-bottom: 1px solid var(--dark-border);
            padding: 0.75rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        .header-link {
            color: var(--text-secondary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.85rem;
            transition: color 0.2s;
        }

        .header-link:hover { color: var(--primary-cyan); }

        /* Main Container */
        .main-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
            overflow: hidden;
        }

        /* Access Card */
        .access-card {
            background: var(--dark-card);
            border-radius: 1rem;
            border: 1px solid var(--dark-border);
            padding: 2rem;
            max-width: 420px;
            width: 100%;
            position: relative;
            overflow: hidden;
        }

        .access-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
        }

        /* Logo Section */
        .logo-section {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .logo-icon {
            width: 70px;
            height: 70px;
            background: var(--gradient-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
        }

        .logo-icon i {
            font-size: 1.75rem;
            color: white;
        }

        .logo-section h1 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 0.25rem;
        }

        .logo-section .subtitle {
            color: var(--text-secondary);
            font-size: 0.85rem;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 1rem;
        }

        .form-label {
            display: block;
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-bottom: 0.4rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .form-label i { margin-right: 0.3rem; }

        .input-group {
            display: flex;
        }

        .form-control {
            flex: 1;
            padding: 0.75rem 1rem;
            border: 2px solid var(--dark-border);
            border-radius: 0.5rem 0 0 0.5rem;
            background: var(--dark-surface);
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
            font-size: 0.9rem;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-cyan);
        }

        .form-control::placeholder { color: var(--text-secondary); }

        .verify-btn {
            padding: 0 1rem;
            border: 2px solid var(--dark-border);
            border-left: none;
            border-radius: 0 0.5rem 0.5rem 0;
            background: var(--dark-surface);
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.2s;
        }

        .verify-btn:hover { color: var(--primary-cyan); }
        .verify-btn.verified { color: var(--success); }

        .form-select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--dark-border);
            border-radius: 0.5rem;
            background: var(--dark-surface);
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
            font-size: 0.9rem;
            cursor: pointer;
        }

        .form-select:focus {
            outline: none;
            border-color: var(--primary-cyan);
        }

        .form-select option {
            background: var(--dark-surface);
            color: var(--text-primary);
        }

        /* Event Info Card */
        .event-info-card {
            background: rgba(0, 212, 170, 0.1);
            border: 1px solid rgba(0, 212, 170, 0.2);
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            display: none;
        }

        .event-info-card .event-label {
            font-size: 0.65rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-secondary);
            margin-bottom: 0.2rem;
        }

        .event-info-card .event-value {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.9rem;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            padding: 0.2rem 0.6rem;
            border-radius: 1rem;
            font-size: 0.7rem;
            font-weight: 600;
        }

        .status-badge.active {
            background: rgba(16, 185, 129, 0.2);
            color: var(--success);
        }

        .status-badge.manual {
            background: rgba(245, 158, 11, 0.2);
            color: var(--warning);
        }

        /* Position Legend */
        .position-legend {
            display: flex;
            flex-wrap: wrap;
            gap: 0.4rem;
            margin-top: 0.5rem;
        }

        .position-tag {
            display: inline-flex;
            align-items: center;
            padding: 0.15rem 0.5rem;
            border-radius: 1rem;
            font-size: 0.6rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .tag-db { background: rgba(59, 130, 246, 0.15); color: #3b82f6; }
        .tag-da { background: rgba(139, 92, 246, 0.15); color: var(--primary-purple); }
        .tag-a { background: rgba(233, 30, 140, 0.15); color: var(--primary-magenta); }
        .tag-e { background: rgba(16, 185, 129, 0.15); color: var(--success); }

        /* Submit Button */
        .btn-access {
            width: 100%;
            padding: 0.875rem;
            border: none;
            border-radius: 0.5rem;
            background: var(--gradient-primary);
            color: white;
            font-family: 'Inter', sans-serif;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-access:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 212, 170, 0.3);
        }

        .btn-access:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        /* Footer Links */
        .access-footer {
            text-align: center;
            margin-top: 1.25rem;
            padding-top: 1.25rem;
            border-top: 1px solid var(--dark-border);
        }

        .access-footer a {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 0.8rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            margin: 0 0.75rem;
            transition: color 0.2s;
        }

        .access-footer a:hover { color: var(--primary-cyan); }

        /* SweetAlert Custom */
        .swal2-popup {
            background: var(--dark-card) !important;
            border: 1px solid var(--dark-border) !important;
            border-radius: 0.75rem !important;
        }
        .swal2-title, .swal2-html-container { color: var(--text-primary) !important; }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="page-header">
        <a href="../../home.jsp" class="header-link">
            <i class="fas fa-arrow-left"></i>
            <span>Back to Home</span>
        </a>
        <a href="../../index.jsp" class="header-link">
            <i class="fas fa-sign-in-alt"></i>
            <span>Admin Login</span>
        </a>
    </header>

    <!-- Main Content -->
    <div class="main-container">
        <div class="access-card">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-gavel"></i>
                </div>
                <h1>Jury Access Portal</h1>
                <p class="subtitle">Enter event code and select your position</p>
            </div>

            <form id="juryAccessForm">
                <!-- Event Code -->
                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-key"></i> Event Access Code
                    </label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="eventCode" name="eventCode"
                               placeholder="Enter your event code" required autocomplete="off">
                        <button type="button" class="verify-btn" id="verifyCodeBtn">
                            <i class="fas fa-check-circle"></i>
                        </button>
                    </div>
                </div>

                <!-- Event Info (shown after verification) -->
                <div class="event-info-card" id="eventInfoSection">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="event-label">Event</div>
                            <div class="event-value" id="eventName">-</div>
                        </div>
                        <span class="status-badge active" id="eventStatus">
                            <i class="fas fa-circle" style="font-size: 0.4rem;"></i>
                            Active
                        </span>
                    </div>
                </div>

                <!-- Position Selection -->
                <div class="form-group" id="positionSection" style="display: none;">
                    <label class="form-label">
                        <i class="fas fa-user-tag"></i> Select Your Position
                    </label>
                    <select class="form-select" id="positionCode" name="positionCode" required>
                        <option value="" selected disabled>Choose your jury position...</option>
                    </select>
                    <div class="position-legend">
                        <span class="position-tag tag-db">DB - Difficulty Body</span>
                        <span class="position-tag tag-da">DA - Difficulty Apparatus</span>
                        <span class="position-tag tag-a">A1-A4 - Artistic</span>
                        <span class="position-tag tag-e">E1-E4 - Execution</span>
                    </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-access" id="submitBtn" disabled>
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Enter Jury Screen</span>
                </button>
            </form>

            <div class="access-footer">
                <a href="../master/masterView.jsp">
                    <i class="fas fa-crown"></i> Head Jury
                </a>
                <a href="../backend/techBackend.jsp">
                    <i class="fas fa-cog"></i> Tech Backend
                </a>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script>
        $(document).ready(function() {
            var validatedEventID = null;
            var positions = [];

            // Verify code button click
            $('#verifyCodeBtn').on('click', function() {
                var code = $('#eventCode').val().trim();
                if (code.length > 0) {
                    validateEventCode(code);
                }
            });

            // Validate on Enter key
            $('#eventCode').on('keypress', function(e) {
                if (e.which === 13) {
                    e.preventDefault();
                    var code = $(this).val().trim();
                    if (code.length > 0) {
                        validateEventCode(code);
                    }
                }
            });

            function validateEventCode(code) {
                $('#verifyCodeBtn').html('<i class="fas fa-spinner fa-spin"></i>');

                $.ajax({
                    type: 'GET',
                    url: '../../api/jury/event',
                    data: { action: 'validateCode', code: code },
                    dataType: 'json',
                    success: function(response) {
                        $('#verifyCodeBtn').html('<i class="fas fa-check-circle"></i>');

                        if (response.success) {
                            validatedEventID = response.eventID;
                            $('#eventName').text(response.eventName);

                            if (response.hasJuryScreen) {
                                $('#eventStatus').removeClass('manual').addClass('active')
                                    .html('<i class="fas fa-circle" style="font-size: 0.4rem;"></i> Active');
                            } else {
                                $('#eventStatus').removeClass('active').addClass('manual')
                                    .html('<i class="fas fa-keyboard" style="font-size: 0.4rem;"></i> Manual');
                            }

                            $('#eventInfoSection').slideDown();
                            $('#eventCode').css('border-color', 'var(--success)');
                            $('#verifyCodeBtn').addClass('verified');

                            loadPositions(response.eventID);
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Invalid Code',
                                text: response.error || 'Event code not found',
                                background: '#1a1a3a',
                                color: '#fff',
                                confirmButtonColor: '#00d4aa'
                            });
                            resetForm();
                        }
                    },
                    error: function() {
                        $('#verifyCodeBtn').html('<i class="fas fa-check-circle"></i>');
                        Swal.fire({
                            icon: 'error',
                            title: 'Connection Error',
                            text: 'Unable to validate event code. Please try again.',
                            background: '#1a1a3a',
                            color: '#fff',
                            confirmButtonColor: '#00d4aa'
                        });
                        resetForm();
                    }
                });
            }

            function loadPositions(eventID) {
                $.ajax({
                    type: 'GET',
                    url: '../../api/jury/positions',
                    data: { eventID: eventID },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            positions = response.positions;
                            populatePositions(positions);
                            $('#positionSection').slideDown();
                            updateSubmitButton();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Unable to load jury positions',
                                background: '#1a1a3a',
                                color: '#fff',
                                confirmButtonColor: '#00d4aa'
                            });
                        }
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Unable to load jury positions',
                            background: '#1a1a3a',
                            color: '#fff',
                            confirmButtonColor: '#00d4aa'
                        });
                    }
                });
            }

            function populatePositions(positions) {
                var $select = $('#positionCode');
                $select.find('option:not(:first)').remove();

                // Simplified positions: DB, DA, A1-A4, E1-E4
                var panel1 = positions.filter(p => p.panelNumber === 1);

                if (panel1.length > 0) {
                    panel1.forEach(function(pos) {
                        $select.append('<option value="' + pos.positionCode + '">' +
                            pos.positionCode + ' - ' + pos.positionName + '</option>');
                    });
                } else {
                    // Fallback: Add default positions
                    var defaultPositions = [
                        { code: 'DB', name: 'Difficulty Body' },
                        { code: 'DA', name: 'Difficulty Apparatus' },
                        { code: 'A1', name: 'Artistic 1' },
                        { code: 'A2', name: 'Artistic 2' },
                        { code: 'A3', name: 'Artistic 3' },
                        { code: 'A4', name: 'Artistic 4' },
                        { code: 'E1', name: 'Execution 1' },
                        { code: 'E2', name: 'Execution 2' },
                        { code: 'E3', name: 'Execution 3' },
                        { code: 'E4', name: 'Execution 4' }
                    ];
                    defaultPositions.forEach(function(pos) {
                        $select.append('<option value="' + pos.code + '">' +
                            pos.code + ' - ' + pos.name + '</option>');
                    });
                }
            }

            function resetForm() {
                validatedEventID = null;
                $('#positionSection').slideUp();
                $('#eventInfoSection').slideUp();
                $('#eventCode').css('border-color', 'var(--dark-border)');
                $('#verifyCodeBtn').removeClass('verified');
                updateSubmitButton();
            }

            function updateSubmitButton() {
                var positionSelected = $('#positionCode').val();
                $('#submitBtn').prop('disabled', !(validatedEventID && positionSelected));
            }

            // Position change handler
            $('#positionCode').on('change', function() {
                updateSubmitButton();
            });

            // Form submission
            $('#juryAccessForm').on('submit', function(e) {
                e.preventDefault();

                if (!validatedEventID) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Validation Required',
                        text: 'Please enter a valid event code',
                        background: '#1a1a3a',
                        color: '#fff',
                        confirmButtonColor: '#00d4aa'
                    });
                    return;
                }

                var positionCode = $('#positionCode').val();
                if (!positionCode) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Position Required',
                        text: 'Please select your jury position',
                        background: '#1a1a3a',
                        color: '#fff',
                        confirmButtonColor: '#00d4aa'
                    });
                    return;
                }

                // Show loading state
                $('#submitBtn').prop('disabled', true)
                    .html('<i class="fas fa-spinner fa-spin"></i> Entering...');

                // Redirect to jury input screen
                setTimeout(function() {
                    window.location.href = 'juryInput.jsp?eventID=' + validatedEventID +
                        '&positionCode=' + encodeURIComponent(positionCode);
                }, 500);
            });
        });
    </script>
</body>
</html>
