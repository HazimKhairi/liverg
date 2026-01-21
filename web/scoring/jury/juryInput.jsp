<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<%
    String eventID = request.getParameter("eventID");
    String positionCode = request.getParameter("positionCode");

    if (eventID == null || positionCode == null) {
        response.sendRedirect("juryAccess.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Jury Input - <%= positionCode %> | LIVERG</title>

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

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            -webkit-tap-highlight-color: transparent;
        }

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
        .jury-header {
            background: var(--dark-surface);
            padding: 0.6rem 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--dark-border);
            flex-shrink: 0;
        }

        .position-badge {
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .position-code {
            background: var(--gradient-primary);
            padding: 0.4rem 0.8rem;
            border-radius: 0.4rem;
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1rem;
        }

        .position-name {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        .status-indicator {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.4rem 0.75rem;
            border-radius: 2rem;
            font-size: 0.7rem;
            font-weight: 600;
        }

        .status-indicator.waiting {
            background: rgba(245, 158, 11, 0.2);
            color: var(--warning);
        }

        .status-indicator.scoring {
            background: rgba(239, 68, 68, 0.2);
            color: var(--danger);
        }

        .status-indicator.submitted {
            background: rgba(16, 185, 129, 0.2);
            color: var(--success);
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.4; }
        }

        /* Main Content */
        .jury-main {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 0.75rem;
            overflow: hidden;
        }

        /* Gymnast Card */
        .gymnast-card {
            background: var(--dark-card);
            border: 1px solid var(--dark-border);
            border-radius: 0.75rem;
            padding: 0.75rem 1rem;
            margin-bottom: 0.75rem;
            flex-shrink: 0;
        }

        .gymnast-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .gymnast-number {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--gradient-primary);
            border-radius: 50%;
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .gymnast-info h3 {
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            margin: 0 0 0.15rem 0;
        }

        .gymnast-info .team {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        .apparatus-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            padding: 0.25rem 0.6rem;
            background: rgba(139, 92, 246, 0.2);
            border-radius: 1rem;
            font-size: 0.65rem;
            font-weight: 600;
            color: var(--primary-purple);
            margin-left: auto;
        }

        /* Score Section */
        .score-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 0;
        }

        .score-label {
            font-size: 0.7rem;
            text-transform: uppercase;
            letter-spacing: 0.15em;
            color: var(--text-secondary);
            margin-bottom: 0.25rem;
        }

        .score-display {
            font-family: 'Montserrat', sans-serif;
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.75rem;
        }

        /* Numpad */
        .numpad-container {
            width: 100%;
            max-width: 300px;
        }

        /* Quick Scores */
        .quick-scores {
            display: flex;
            flex-wrap: wrap;
            gap: 0.4rem;
            justify-content: center;
            margin-bottom: 0.6rem;
        }

        .quick-score-btn {
            padding: 0.35rem 0.7rem;
            border: 1px solid var(--dark-border);
            border-radius: 0.4rem;
            background: var(--dark-surface);
            color: var(--text-secondary);
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .quick-score-btn:hover {
            background: var(--dark-card);
            border-color: var(--primary-cyan);
            color: var(--primary-cyan);
        }

        /* Numpad */
        .numpad {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.4rem;
        }

        .numpad-btn {
            aspect-ratio: 1.4;
            border: none;
            border-radius: 0.5rem;
            font-family: 'Montserrat', sans-serif;
            font-size: 1.25rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.1s ease;
            background: var(--dark-card);
            color: var(--text-primary);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .numpad-btn:hover {
            background: var(--dark-surface);
        }

        .numpad-btn:active {
            transform: scale(0.95);
        }

        .numpad-btn.decimal {
            background: rgba(0, 212, 170, 0.2);
            color: var(--primary-cyan);
        }

        .numpad-btn.backspace {
            background: rgba(245, 158, 11, 0.2);
            color: var(--warning);
        }

        /* Submit Section */
        .submit-section {
            padding: 0.6rem 0;
            width: 100%;
            max-width: 300px;
        }

        .btn-submit {
            width: 100%;
            padding: 0.875rem;
            border: none;
            border-radius: 0.5rem;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-submit.ready {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-submit.ready:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 212, 170, 0.4);
        }

        .btn-submit.submitted {
            background: rgba(16, 185, 129, 0.2);
            color: var(--success);
            cursor: default;
        }

        .btn-submit:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none !important;
        }

        .btn-clear {
            width: 100%;
            margin-top: 0.5rem;
            padding: 0.6rem;
            background: transparent;
            border: 1px solid var(--dark-border);
            border-radius: 0.4rem;
            color: var(--text-secondary);
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-clear:hover {
            background: var(--dark-surface);
            border-color: var(--text-secondary);
        }

        /* Overlays */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(10, 10, 26, 0.98);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            z-index: 100;
            padding: 2rem;
        }

        .waiting-icon {
            width: 60px;
            height: 60px;
            border: 3px solid var(--dark-border);
            border-top-color: var(--primary-cyan);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 1rem;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .overlay-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-align: center;
        }

        .overlay-subtitle {
            color: var(--text-secondary);
            text-align: center;
            font-size: 0.85rem;
        }

        .submitted-check {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .submitted-check i {
            font-size: 2.5rem;
            color: white;
        }

        .submitted-score {
            font-family: 'Montserrat', sans-serif;
            font-size: 3rem;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0.5rem 0;
        }

        /* Connection Status */
        .connection-status {
            position: fixed;
            bottom: 0.5rem;
            left: 50%;
            transform: translateX(-50%);
            padding: 0.35rem 0.75rem;
            border-radius: 2rem;
            font-size: 0.65rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .connection-status.connected {
            background: rgba(16, 185, 129, 0.15);
            color: var(--success);
        }

        .connection-status.disconnected {
            background: rgba(239, 68, 68, 0.15);
            color: var(--danger);
        }

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
    <header class="jury-header">
        <div class="position-badge">
            <span class="position-code" id="positionCodeDisplay"><%= positionCode %></span>
            <div class="position-name" id="positionName">Loading...</div>
        </div>
        <div class="status-indicator waiting" id="statusIndicator">
            <span class="status-dot"></span>
            <span id="statusText">Waiting</span>
        </div>
    </header>

    <!-- Main Content -->
    <main class="jury-main">
        <!-- Gymnast Card -->
        <div class="gymnast-card">
            <div class="gymnast-header">
                <span class="gymnast-number" id="gymnastNumber">-</span>
                <div class="gymnast-info">
                    <h3 id="gymnastName">Waiting for gymnast...</h3>
                    <div class="team" id="gymnastTeam">-</div>
                </div>
                <span class="apparatus-badge">
                    <i class="fas fa-circle" style="font-size: 0.4rem;"></i>
                    <span id="apparatusName">-</span>
                </span>
            </div>
        </div>

        <!-- Score Section -->
        <div class="score-section">
            <div class="score-label">Your Score</div>
            <div class="score-display" id="scoreDisplay">0.000</div>

            <div class="numpad-container">
                <!-- Quick Scores -->
                <div class="quick-scores" id="quickScores"></div>

                <!-- Numpad -->
                <div class="numpad">
                    <button class="numpad-btn" onclick="appendDigit('1')">1</button>
                    <button class="numpad-btn" onclick="appendDigit('2')">2</button>
                    <button class="numpad-btn" onclick="appendDigit('3')">3</button>
                    <button class="numpad-btn" onclick="appendDigit('4')">4</button>
                    <button class="numpad-btn" onclick="appendDigit('5')">5</button>
                    <button class="numpad-btn" onclick="appendDigit('6')">6</button>
                    <button class="numpad-btn" onclick="appendDigit('7')">7</button>
                    <button class="numpad-btn" onclick="appendDigit('8')">8</button>
                    <button class="numpad-btn" onclick="appendDigit('9')">9</button>
                    <button class="numpad-btn decimal" onclick="appendDigit('.')">.</button>
                    <button class="numpad-btn" onclick="appendDigit('0')">0</button>
                    <button class="numpad-btn backspace" onclick="backspace()"><i class="fas fa-backspace"></i></button>
                </div>

                <!-- Submit Section -->
                <div class="submit-section">
                    <button class="btn-submit ready" id="submitBtn" onclick="submitScore()" disabled>
                        <i class="fas fa-paper-plane"></i>
                        <span>Submit Score</span>
                    </button>
                    <button class="btn-clear" onclick="clearScore()">
                        <i class="fas fa-undo me-1"></i> Clear
                    </button>
                </div>
            </div>
        </div>
    </main>

    <!-- Waiting Overlay -->
    <div class="overlay" id="waitingOverlay">
        <div class="waiting-icon"></div>
        <div class="overlay-title">Waiting for Next Gymnast</div>
        <div class="overlay-subtitle">The scoring session will begin shortly</div>
    </div>

    <!-- Submitted Overlay -->
    <div class="overlay" id="submittedOverlay" style="display: none;">
        <div class="submitted-check">
            <i class="fas fa-check"></i>
        </div>
        <div class="overlay-title">Score Submitted!</div>
        <div class="submitted-score" id="submittedScoreDisplay">0.000</div>
        <div class="overlay-subtitle">Waiting for other judges...</div>
    </div>

    <!-- Connection Status -->
    <div class="connection-status connected" id="connectionStatus">
        <i class="fas fa-wifi"></i>
        <span>Connected</span>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <script>
        const eventID = '<%= eventID %>';
        const positionCode = '<%= positionCode %>';

        let currentScore = '';
        let sessionID = null;
        let sessionStatus = 'WAITING';
        let isSubmitted = false;
        let pollInterval = null;
        let scoreMin = 0;
        let scoreMax = 10;
        let positionCategory = '';

        // Initialize
        $(document).ready(function() {
            loadPositionInfo();
        });

        function loadPositionInfo() {
            $.ajax({
                type: 'GET',
                url: '../../api/jury/positions',
                data: { eventID: eventID, positionCode: positionCode },
                dataType: 'json',
                success: function(response) {
                    if (response.success && response.position) {
                        const pos = response.position;
                        $('#positionName').text(pos.positionName);
                        scoreMin = pos.scoreMin || 0;
                        scoreMax = pos.scoreMax || 10;
                        positionCategory = pos.category || '';

                        generateQuickScores(pos.category);
                        startPolling();
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Invalid Position',
                            text: 'Unable to load position information',
                            background: '#1a1a3a',
                            color: '#fff',
                            confirmButtonColor: '#00d4aa'
                        }).then(function() {
                            window.location.href = 'juryAccess.jsp';
                        });
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Connection Error',
                        text: 'Failed to load position info',
                        background: '#1a1a3a',
                        color: '#fff',
                        confirmButtonColor: '#00d4aa'
                    });
                    startPolling();
                }
            });
        }

        function generateQuickScores(category) {
            const $container = $('#quickScores');
            $container.empty();

            let quickValues = [];
            if (category === 'A' || category === 'E' || category === 'EXE') {
                quickValues = [7.0, 7.5, 8.0, 8.5, 9.0, 9.5];
            } else if (category === 'DB' || category === 'DA') {
                quickValues = [3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
            } else {
                quickValues = [0.0, 0.1, 0.3, 0.5];
            }

            quickValues.forEach(val => {
                $container.append(`<button class="quick-score-btn" onclick="setQuickScore(${val})">${val.toFixed(1)}</button>`);
            });
        }

        function setQuickScore(val) {
            if (isSubmitted || sessionStatus !== 'SCORING') return;
            currentScore = val.toFixed(3);
            updateScoreDisplay();
            updateSubmitButton();
        }

        function startPolling() {
            fetchSessionState();
            pollInterval = setInterval(fetchSessionState, 2000);
        }

        function fetchSessionState() {
            $.ajax({
                type: 'GET',
                url: '../../api/jury/session',
                data: {
                    action: 'getState',
                    eventID: eventID,
                    positionCode: positionCode
                },
                dataType: 'json',
                success: function(response) {
                    updateConnectionStatus(true);
                    if (response.success) {
                        updateSessionState(response);
                    }
                },
                error: function() {
                    updateConnectionStatus(false);
                }
            });
        }

        function updateSessionState(data) {
            sessionStatus = data.sessionStatus || 'WAITING';
            sessionID = data.sessionID;

            updateStatusIndicator(sessionStatus);

            // Update gymnast info
            if (data.currentGymnast) {
                $('#gymnastNumber').text(data.currentGymnast.startOrder || '-');
                $('#gymnastName').text(data.currentGymnast.name || 'Unknown');
                $('#gymnastTeam').text(data.currentGymnast.team || '-');
                $('#apparatusName').text(data.currentGymnast.apparatus || '-');
            }

            // Handle display states
            if (sessionStatus === 'WAITING' || sessionStatus === 'NO_SESSION') {
                $('#waitingOverlay').show();
                $('#submittedOverlay').hide();
                resetForNewGymnast();
            } else if (sessionStatus === 'SCORING') {
                // Check if already submitted
                if (data.myScore !== null && data.myScore !== undefined) {
                    isSubmitted = true;
                    currentScore = data.myScore.toString();
                    updateScoreDisplay();
                    $('#submittedScoreDisplay').text(parseFloat(data.myScore).toFixed(3));
                    $('#waitingOverlay').hide();
                    $('#submittedOverlay').show();
                } else {
                    $('#waitingOverlay').hide();
                    $('#submittedOverlay').hide();
                    if (!isSubmitted) {
                        updateSubmitButton();
                    }
                }
            } else if (sessionStatus === 'SUBMITTED' || sessionStatus === 'FINALIZED') {
                if (isSubmitted) {
                    $('#waitingOverlay').hide();
                    $('#submittedOverlay').show();
                } else {
                    $('#waitingOverlay').show();
                    $('#submittedOverlay').hide();
                }
            }
        }

        function updateStatusIndicator(status) {
            const $indicator = $('#statusIndicator');
            const $text = $('#statusText');

            $indicator.removeClass('waiting scoring submitted');

            switch(status) {
                case 'WAITING':
                case 'NO_SESSION':
                    $indicator.addClass('waiting');
                    $text.text('Waiting');
                    break;
                case 'SCORING':
                    $indicator.addClass('scoring');
                    $text.text('Live');
                    break;
                case 'SUBMITTED':
                case 'FINALIZED':
                    $indicator.addClass('submitted');
                    $text.text('Done');
                    break;
            }
        }

        function updateConnectionStatus(connected) {
            const $status = $('#connectionStatus');
            if (connected) {
                $status.removeClass('disconnected').addClass('connected')
                    .html('<i class="fas fa-wifi"></i><span>Connected</span>');
            } else {
                $status.removeClass('connected').addClass('disconnected')
                    .html('<i class="fas fa-exclamation-triangle"></i><span>Offline</span>');
            }
        }

        // Score Input
        function appendDigit(digit) {
            if (isSubmitted || sessionStatus !== 'SCORING') return;

            if (digit === '.') {
                if (currentScore.includes('.')) return;
                if (currentScore === '') currentScore = '0';
            }

            // Limit decimals
            if (currentScore.includes('.')) {
                const decimals = currentScore.split('.')[1];
                if (decimals && decimals.length >= 3) return;
            }

            // Limit total
            if (currentScore.replace('.', '').length >= 5) return;

            currentScore += digit;
            updateScoreDisplay();
            updateSubmitButton();
        }

        function backspace() {
            if (isSubmitted || sessionStatus !== 'SCORING') return;
            currentScore = currentScore.slice(0, -1);
            updateScoreDisplay();
            updateSubmitButton();
        }

        function clearScore() {
            if (isSubmitted || sessionStatus !== 'SCORING') return;
            currentScore = '';
            updateScoreDisplay();
            updateSubmitButton();
        }

        function resetForNewGymnast() {
            currentScore = '';
            isSubmitted = false;
            updateScoreDisplay();
            $('#submitBtn').removeClass('submitted').addClass('ready')
                .html('<i class="fas fa-paper-plane"></i><span>Submit Score</span>')
                .prop('disabled', true);
        }

        function updateScoreDisplay() {
            let display = currentScore || '0';
            if (!display.includes('.')) {
                display += '.000';
            } else {
                const parts = display.split('.');
                parts[1] = (parts[1] || '').padEnd(3, '0');
                display = parts.join('.');
            }
            $('#scoreDisplay').text(display);
        }

        function updateSubmitButton() {
            const val = parseFloat(currentScore);
            const hasValidValue = !isNaN(val) && val >= scoreMin && val <= scoreMax;
            $('#submitBtn').prop('disabled', !hasValidValue || isSubmitted);
        }

        function submitScore() {
            if (isSubmitted || !sessionID || sessionStatus !== 'SCORING') return;

            const score = parseFloat(currentScore);
            if (isNaN(score) || score < scoreMin || score > scoreMax) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Invalid Score',
                    text: 'Please enter a valid score between ' + scoreMin + ' and ' + scoreMax,
                    background: '#1a1a3a',
                    color: '#fff',
                    confirmButtonColor: '#00d4aa'
                });
                return;
            }

            $('#submitBtn').prop('disabled', true)
                .html('<i class="fas fa-spinner fa-spin"></i><span>Submitting...</span>');

            $.ajax({
                type: 'POST',
                url: '../../api/jury/session',
                data: {
                    action: 'submitScore',
                    sessionID: sessionID,
                    positionCode: positionCode,
                    scoreValue: score.toFixed(3)
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        isSubmitted = true;
                        $('#submittedScoreDisplay').text(score.toFixed(3));
                        $('#submittedOverlay').show();
                        Swal.fire({
                            icon: 'success',
                            title: 'Score Submitted!',
                            text: score.toFixed(3),
                            timer: 1500,
                            showConfirmButton: false,
                            background: '#1a1a3a',
                            color: '#fff'
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Submit Failed',
                            text: response.error || 'Please try again',
                            background: '#1a1a3a',
                            color: '#fff',
                            confirmButtonColor: '#00d4aa'
                        });
                        $('#submitBtn').prop('disabled', false)
                            .html('<i class="fas fa-paper-plane"></i><span>Submit Score</span>');
                    }
                },
                error: function() {
                    Swal.fire({
                        icon: 'error',
                        title: 'Connection Error',
                        text: 'Please check your connection and try again',
                        background: '#1a1a3a',
                        color: '#fff',
                        confirmButtonColor: '#00d4aa'
                    });
                    $('#submitBtn').prop('disabled', false)
                        .html('<i class="fas fa-paper-plane"></i><span>Submit Score</span>');
                }
            });
        }

        // Prevent zoom on mobile
        document.addEventListener('touchstart', function(e) {
            if (e.touches.length > 1) e.preventDefault();
        }, { passive: false });

        let lastTouchEnd = 0;
        document.addEventListener('touchend', function(e) {
            const now = Date.now();
            if (now - lastTouchEnd <= 300) e.preventDefault();
            lastTouchEnd = now;
        }, false);
    </script>
</body>
</html>
