<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="icon" type="image/png" href="../../assets/img/favicon.png">
    <title>Head Jury Panel | LIVERG</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Montserrat:wght@600;700;800;900&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- SweetAlert2 -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

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

        /* Header - Compact */
        .header {
            background: var(--dark-surface);
            padding: 0.75rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--dark-border);
            flex-shrink: 0;
        }

        .brand {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 1.25rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .event-info {
            font-size: 0.85rem;
            color: var(--text-secondary);
        }

        .event-info strong {
            color: var(--text-primary);
        }

        .connection-badge {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.4rem 0.8rem;
            border-radius: 2rem;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .connection-badge.online {
            background: rgba(16, 185, 129, 0.2);
            color: var(--success);
        }

        .connection-badge .dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.4; }
        }

        /* Main Content - Fills remaining space */
        .main-content {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 280px;
            gap: 0;
            overflow: hidden;
        }

        /* Left Panel */
        .scoring-panel {
            padding: 1rem 1.5rem;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* Gymnast Card - Compact */
        .gymnast-card {
            background: var(--gradient-primary);
            border-radius: 1rem;
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            flex-shrink: 0;
        }

        .gymnast-order {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Montserrat', sans-serif;
            font-size: 1.5rem;
            font-weight: 800;
        }

        .gymnast-info h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.25rem;
            font-weight: 700;
            margin: 0;
        }

        .gymnast-info .team {
            font-size: 0.85rem;
            opacity: 0.9;
        }

        .apparatus-badge {
            margin-left: auto;
            background: rgba(255, 255, 255, 0.2);
            padding: 0.4rem 1rem;
            border-radius: 2rem;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-pill {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.4rem 1rem;
            border-radius: 2rem;
            font-size: 0.75rem;
            font-weight: 600;
            background: rgba(0, 0, 0, 0.3);
        }

        .status-pill .dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
        }

        .status-pill.scoring .dot { background: var(--warning); animation: pulse 1s infinite; }
        .status-pill.submitted .dot { background: var(--success); }

        /* Scores Grid - Compact */
        .scores-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            overflow: hidden;
        }

        .panel-section {
            background: var(--dark-card);
            border-radius: 0.75rem;
            overflow: hidden;
        }

        .panel-header {
            background: var(--dark-surface);
            padding: 0.5rem 1rem;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .panel-header i { color: var(--primary-cyan); }

        .scores-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(70px, 1fr));
            gap: 0.5rem;
            padding: 0.75rem;
        }

        .score-cell {
            background: var(--dark-surface);
            border-radius: 0.5rem;
            padding: 0.5rem;
            text-align: center;
            border: 2px solid transparent;
            transition: all 0.2s;
        }

        .score-cell.pending { border-style: dashed; border-color: var(--dark-border); }
        .score-cell.submitted { border-color: var(--success); background: rgba(16, 185, 129, 0.1); }

        .score-cell .code {
            font-weight: 700;
            font-size: 0.7rem;
            margin-bottom: 0.2rem;
        }

        .score-cell.pending .code { color: var(--text-secondary); }
        .score-cell.submitted .code { color: var(--success); }

        .score-cell .value {
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
            font-weight: 700;
        }

        /* Category colors */
        .cat-db .code, .cat-da .code { color: var(--primary-purple) !important; }
        .cat-a .code { color: var(--primary-cyan) !important; }
        .cat-e .code { color: var(--primary-magenta) !important; }

        /* Final Score - Compact */
        .final-score-section {
            background: var(--dark-card);
            border-radius: 0.75rem;
            padding: 0.75rem;
            flex-shrink: 0;
        }

        .final-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 0.5rem;
        }

        .final-item {
            background: var(--dark-surface);
            border-radius: 0.5rem;
            padding: 0.5rem;
            text-align: center;
        }

        .final-item label {
            font-size: 0.6rem;
            color: var(--text-secondary);
            text-transform: uppercase;
            display: block;
            margin-bottom: 0.2rem;
        }

        .final-item .value {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
        }

        .final-item.total {
            background: var(--gradient-primary);
        }

        .final-item.total .value {
            font-size: 1.5rem;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.75rem;
            margin-top: 0.75rem;
            flex-shrink: 0;
        }

        .btn-action {
            flex: 1;
            padding: 0.75rem;
            border: none;
            border-radius: 0.5rem;
            font-family: 'Inter', sans-serif;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-action:disabled {
            background: var(--dark-border) !important;
            color: var(--text-secondary) !important;
            cursor: not-allowed;
        }

        .btn-start { background: var(--gradient-primary); color: white; }
        .btn-force { background: linear-gradient(135deg, var(--warning), #d97706); color: white; }
        .btn-advance { background: linear-gradient(135deg, #3b82f6, #2563eb); color: white; }

        /* Right Sidebar - Compact */
        .sidebar {
            background: var(--dark-surface);
            border-left: 1px solid var(--dark-border);
            padding: 1rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            overflow: hidden;
        }

        .sidebar-card {
            background: var(--dark-card);
            border-radius: 0.75rem;
            overflow: hidden;
        }

        .sidebar-header {
            background: var(--dark-bg);
            padding: 0.5rem 0.75rem;
            font-weight: 600;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .sidebar-header i { color: var(--primary-cyan); font-size: 0.7rem; }

        .sidebar-body {
            padding: 0.75rem;
        }

        /* Status Info */
        .status-row {
            display: flex;
            justify-content: space-between;
            padding: 0.4rem 0;
            font-size: 0.75rem;
            border-bottom: 1px solid var(--dark-border);
        }

        .status-row:last-child { border-bottom: none; }
        .status-label { color: var(--text-secondary); }
        .status-value { font-weight: 600; }
        .status-value.scoring { color: var(--primary-cyan); }
        .status-value.active { color: var(--success); }

        /* Progress */
        .progress-bar-bg {
            height: 6px;
            background: var(--dark-surface);
            border-radius: 3px;
            margin-top: 0.5rem;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            background: var(--gradient-primary);
            border-radius: 3px;
            transition: width 0.3s;
        }

        /* Start List - Compact */
        .start-list {
            flex: 1;
            overflow-y: auto;
            max-height: 200px;
        }

        .list-item {
            display: flex;
            align-items: center;
            padding: 0.4rem 0.5rem;
            border-radius: 0.4rem;
            margin-bottom: 0.3rem;
            background: var(--dark-surface);
            font-size: 0.75rem;
        }

        .list-item.current { background: var(--gradient-primary); }
        .list-item.completed { opacity: 0.5; }

        .list-item .num {
            width: 20px;
            height: 20px;
            background: var(--dark-bg);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.65rem;
            font-weight: 700;
            margin-right: 0.5rem;
        }

        .list-item.current .num { background: rgba(255,255,255,0.2); }

        .list-item .name {
            flex: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .list-item .score {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            color: var(--primary-cyan);
        }

        .list-item.current .score { color: white; }

        /* Quick Links */
        .quick-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 0.75rem;
            background: var(--dark-surface);
            border-radius: 0.4rem;
            color: var(--text-primary);
            text-decoration: none;
            font-size: 0.75rem;
            transition: all 0.2s;
            margin-bottom: 0.3rem;
        }

        .quick-link:hover { background: var(--dark-bg); color: var(--primary-cyan); }

        /* No Session State */
        .no-session {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .no-session-icon {
            width: 80px;
            height: 80px;
            background: var(--dark-card);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .no-session-icon i {
            font-size: 2rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .no-session h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
        }

        .no-session p {
            color: var(--text-secondary);
            font-size: 0.85rem;
            margin-bottom: 1.5rem;
        }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 4px; }
        ::-webkit-scrollbar-track { background: var(--dark-bg); }
        ::-webkit-scrollbar-thumb { background: var(--dark-border); border-radius: 2px; }

        /* Responsive */
        @media (max-width: 900px) {
            .main-content { grid-template-columns: 1fr; }
            .sidebar { display: none; }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div style="display: flex; align-items: center; gap: 1rem;">
            <div class="brand">LIVERG</div>
            <div class="event-info">
                <span>Head Jury Panel</span> &bull;
                <strong id="eventName">Loading...</strong>
            </div>
        </div>
        <div class="connection-badge online" id="connectionBadge">
            <span class="dot"></span>
            <span>Live</span>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Left Panel -->
        <div class="scoring-panel">
            <!-- No Session State -->
            <div id="noSessionSection" class="no-session">
                <div class="no-session-icon">
                    <i class="fas fa-gavel"></i>
                </div>
                <h2>No Active Session</h2>
                <p>Start the scoring session to begin evaluating gymnasts</p>
                <button class="btn-action btn-start" id="btnStartFirst" style="width: auto; padding: 0.75rem 2rem;">
                    <i class="fas fa-play"></i>
                    Start Scoring
                </button>
            </div>

            <!-- Active Session -->
            <div id="activeSession" style="display: none; flex: 1; display: flex; flex-direction: column;">
                <!-- Current Gymnast -->
                <div class="gymnast-card">
                    <div class="gymnast-order" id="gymnastOrder">#1</div>
                    <div class="gymnast-info">
                        <h2 id="gymnastName">-</h2>
                        <div class="team" id="teamName">-</div>
                    </div>
                    <div class="apparatus-badge" id="apparatusBadge">
                        <i class="fas fa-circle-dot me-1"></i>
                        <span id="apparatusName">-</span>
                    </div>
                    <div class="status-pill scoring" id="statusPill">
                        <span class="dot"></span>
                        <span id="statusPillText">Scoring</span>
                    </div>
                </div>

                <!-- Scores Container -->
                <div class="scores-container">
                    <!-- Difficulty Panel -->
                    <div class="panel-section">
                        <div class="panel-header">
                            <i class="fas fa-star"></i>Difficulty (D)
                        </div>
                        <div class="scores-grid" id="difficultyGrid"></div>
                    </div>

                    <!-- Artistic Panel -->
                    <div class="panel-section">
                        <div class="panel-header">
                            <i class="fas fa-palette"></i>Artistic (A)
                        </div>
                        <div class="scores-grid" id="artisticGrid"></div>
                    </div>

                    <!-- Execution Panel -->
                    <div class="panel-section">
                        <div class="panel-header">
                            <i class="fas fa-check-double"></i>Execution (E)
                        </div>
                        <div class="scores-grid" id="executionGrid"></div>
                    </div>
                </div>

                <!-- Final Score -->
                <div class="final-score-section" id="finalScoreSection">
                    <div class="final-grid">
                        <div class="final-item">
                            <label>Difficulty</label>
                            <div class="value" id="scoreD">-</div>
                        </div>
                        <div class="final-item">
                            <label>Artistic</label>
                            <div class="value" id="scoreA">-</div>
                        </div>
                        <div class="final-item">
                            <label>Execution</label>
                            <div class="value" id="scoreE">-</div>
                        </div>
                        <div class="final-item">
                            <label>Penalty</label>
                            <div class="value" id="scorePenalty">-</div>
                        </div>
                        <div class="final-item total">
                            <label>Final</label>
                            <div class="value" id="scoreFinal">-</div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <button class="btn-action btn-force" id="btnForceSubmit" disabled>
                        <i class="fas fa-check-double"></i>
                        Force Submit
                    </button>
                    <button class="btn-action btn-advance" id="btnAdvance" disabled>
                        <i class="fas fa-forward"></i>
                        Next Gymnast
                    </button>
                </div>
            </div>
        </div>

        <!-- Right Sidebar -->
        <div class="sidebar">
            <!-- Session Status -->
            <div class="sidebar-card">
                <div class="sidebar-header">
                    <i class="fas fa-info-circle"></i>
                    Session Status
                </div>
                <div class="sidebar-body">
                    <div class="status-row">
                        <span class="status-label">Status</span>
                        <span class="status-value" id="sessionStatus">-</span>
                    </div>
                    <div class="status-row">
                        <span class="status-label">Submitted</span>
                        <span class="status-value" id="submittedCount">0 / 0</span>
                    </div>
                    <div class="progress-bar-bg">
                        <div class="progress-bar-fill" id="progressBar" style="width: 0%"></div>
                    </div>
                </div>
            </div>

            <!-- Start List -->
            <div class="sidebar-card" style="flex: 1; display: flex; flex-direction: column;">
                <div class="sidebar-header">
                    <i class="fas fa-list-ol"></i>
                    Start List
                </div>
                <div class="sidebar-body start-list" id="startListContainer"></div>
            </div>

            <!-- Quick Links -->
            <div class="sidebar-card">
                <div class="sidebar-header">
                    <i class="fas fa-link"></i>
                    Quick Links
                </div>
                <div class="sidebar-body">
                    <a href="#" class="quick-link" id="linkTechBackend">
                        <i class="fas fa-cogs"></i>
                        Technical Backend
                    </a>
                    <a href="#" class="quick-link" id="linkStartList">
                        <i class="fas fa-random"></i>
                        Manage Start List
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function() {
            var urlParams = new URLSearchParams(window.location.search);
            var eventID = urlParams.get('eventID');
            var filterDay = urlParams.get('day');
            var filterBatch = urlParams.get('batch');
            var filterCategory = urlParams.get('category');
            var filterSchool = urlParams.get('school');
            var filterApparatus = urlParams.get('apparatusID');

            if (!eventID) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'No event ID provided',
                    background: '#1a1a3a',
                    color: '#fff'
                });
                return;
            }

            var currentSessionID = null;
            var pollInterval = null;

            // Simplified positions: DB, DA, A1-A4, E1-E4
            var positions = [
                { positionCode: 'DB', positionName: 'Difficulty Body', category: 'DB', panelNumber: 1 },
                { positionCode: 'DA', positionName: 'Difficulty Apparatus', category: 'DA', panelNumber: 1 },
                { positionCode: 'A1', positionName: 'Artistic 1', category: 'A', panelNumber: 1 },
                { positionCode: 'A2', positionName: 'Artistic 2', category: 'A', panelNumber: 1 },
                { positionCode: 'A3', positionName: 'Artistic 3', category: 'A', panelNumber: 1 },
                { positionCode: 'A4', positionName: 'Artistic 4', category: 'A', panelNumber: 1 },
                { positionCode: 'E1', positionName: 'Execution 1', category: 'E', panelNumber: 1 },
                { positionCode: 'E2', positionName: 'Execution 2', category: 'E', panelNumber: 1 },
                { positionCode: 'E3', positionName: 'Execution 3', category: 'E', panelNumber: 1 },
                { positionCode: 'E4', positionName: 'Execution 4', category: 'E', panelNumber: 1 }
            ];

            // Set up quick links
            $('#linkTechBackend').attr('href', '../backend/techBackend.jsp?eventID=' + eventID);
            $('#linkStartList').attr('href', '../startlist/startListManage.jsp?eventID=' + eventID);

            // Initialize grids
            initScoreGrids();

            // Load event info
            loadEventInfo();
            loadStartList();
            startPolling();

            function initScoreGrids() {
                var diffGrid = $('#difficultyGrid');
                var artGrid = $('#artisticGrid');
                var exeGrid = $('#executionGrid');

                positions.forEach(function(pos) {
                    var catClass = 'cat-' + pos.category.toLowerCase();
                    var cell = '<div class="score-cell pending ' + catClass + '" data-code="' + pos.positionCode + '">' +
                        '<div class="code">' + pos.positionCode + '</div>' +
                        '<div class="value">-</div></div>';

                    if (pos.category === 'DB' || pos.category === 'DA') {
                        diffGrid.append(cell);
                    } else if (pos.category === 'A') {
                        artGrid.append(cell);
                    } else if (pos.category === 'E') {
                        exeGrid.append(cell);
                    }
                });
            }

            function loadEventInfo() {
                $.ajax({
                    type: 'GET',
                    url: '../../api/jury/event',
                    data: { action: 'getInfo', eventID: eventID },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#eventName').text(response.eventName);
                        }
                    }
                });
            }

            function loadStartList() {
                var data = { eventID: eventID };
                if (filterDay) data.day = filterDay;
                if (filterBatch) data.batch = filterBatch;
                if (filterCategory) data.category = filterCategory;
                if (filterSchool) data.school = filterSchool;
                if (filterApparatus) data.apparatusID = filterApparatus;

                $.ajax({
                    type: 'GET',
                    url: '../../api/jury/startlist',
                    data: data,
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            renderStartList(response.entries);
                        }
                    }
                });
            }

            function renderStartList(entries) {
                var $container = $('#startListContainer');
                $container.empty();

                if (entries.length === 0) {
                    $container.html('<div style="text-align:center;color:var(--text-secondary);padding:1rem;">No entries</div>');
                    return;
                }

                entries.forEach(function(entry, index) {
                    var cls = '';
                    if (entry.isCurrent) cls = 'current';
                    else if (entry.isCompleted) cls = 'completed';

                    $container.append(
                        '<div class="list-item ' + cls + '">' +
                        '<div class="num">' + (index + 1) + '</div>' +
                        '<div class="name">' + entry.gymnastName + '</div>' +
                        '<div class="score">' + (entry.finalScore ? entry.finalScore.toFixed(3) : '-') + '</div>' +
                        '</div>'
                    );
                });
            }

            function startPolling() {
                pollSessionState();
                pollInterval = setInterval(pollSessionState, 1500);
            }

            function pollSessionState() {
                $.ajax({
                    type: 'GET',
                    url: '../../api/jury/session',
                    data: { action: 'getState', eventID: eventID },
                    dataType: 'json',
                    success: function(response) {
                        updateConnectionStatus(true);
                        if (response.success) {
                            handleSessionState(response);
                        }
                    },
                    error: function() {
                        updateConnectionStatus(false);
                    }
                });
            }

            function handleSessionState(data) {
                var status = data.sessionStatus;

                if (status === 'NO_SESSION') {
                    $('#noSessionSection').show();
                    $('#activeSession').hide();
                    currentSessionID = null;
                } else {
                    $('#noSessionSection').hide();
                    $('#activeSession').show().css('display', 'flex');
                    currentSessionID = data.sessionID;

                    // Update gymnast info
                    $('#gymnastOrder').text('#' + (data.startOrder || 1));
                    $('#gymnastName').text(data.gymnastName || '-');
                    $('#teamName').text(data.teamName || '-');
                    $('#apparatusName').text(data.apparatusName || '-');

                    // Update status
                    updateStatusDisplay(status);

                    // Update score cells
                    updateScoreCells(data.scores || [], data.submittedPositions || []);

                    // Update progress
                    var submitted = (data.submittedPositions || []).length;
                    var total = positions.length;
                    $('#submittedCount').text(submitted + ' / ' + total);
                    $('#progressBar').css('width', (submitted / total * 100) + '%');

                    // Update final score
                    if (data.finalScore) {
                        $('#scoreD').text(data.finalScore.scoreDTotal ? data.finalScore.scoreDTotal.toFixed(3) : '-');
                        $('#scoreA').text(data.finalScore.scoreArtistic ? data.finalScore.scoreArtistic.toFixed(3) : '-');
                        $('#scoreE').text(data.finalScore.scoreExecution ? data.finalScore.scoreExecution.toFixed(3) : '-');
                        var pen = (data.finalScore.technicalDeduction || 0) + (data.finalScore.lineDeduction || 0) + (data.finalScore.timeDeduction || 0);
                        $('#scorePenalty').text(pen > 0 ? '-' + pen.toFixed(3) : '0.000');
                        $('#scoreFinal').text(data.finalScore.finalScore ? data.finalScore.finalScore.toFixed(3) : '-');
                    }

                    // Update buttons
                    var allSubmitted = submitted === total && total > 0;
                    $('#btnForceSubmit').prop('disabled', allSubmitted || status !== 'SCORING');
                    $('#btnAdvance').prop('disabled', status !== 'SUBMITTED' && status !== 'FINALIZED');
                }

                loadStartList();
            }

            function updateStatusDisplay(status) {
                var $pill = $('#statusPill');
                var $text = $('#statusPillText');
                var $sessionStatus = $('#sessionStatus');

                $pill.removeClass('scoring submitted');
                $sessionStatus.removeClass('scoring active');

                if (status === 'SCORING') {
                    $pill.addClass('scoring');
                    $text.text('Scoring');
                    $sessionStatus.addClass('scoring').text('Scoring');
                } else if (status === 'SUBMITTED') {
                    $pill.addClass('submitted');
                    $text.text('Submitted');
                    $sessionStatus.addClass('active').text('Submitted');
                } else {
                    $text.text(status);
                    $sessionStatus.text(status);
                }
            }

            function updateScoreCells(scores, submittedPositions) {
                positions.forEach(function(pos) {
                    var $cell = $('.score-cell[data-code="' + pos.positionCode + '"]');
                    var isSubmitted = submittedPositions.includes(pos.positionCode);
                    var score = scores.find(s => s.positionCode === pos.positionCode);
                    var value = (score && score.hasScore) ? score.scoreValue.toFixed(3) : '-';

                    $cell.removeClass('pending submitted').addClass(isSubmitted ? 'submitted' : 'pending');
                    $cell.find('.value').text(value);
                });
            }

            function updateConnectionStatus(online) {
                var $badge = $('#connectionBadge');
                if (online) {
                    $badge.removeClass('offline').addClass('online');
                    $badge.html('<span class="dot"></span><span>Live</span>');
                } else {
                    $badge.removeClass('online').addClass('offline');
                    $badge.html('<span class="dot"></span><span>Offline</span>');
                }
            }

            // Start scoring
            $('#btnStartFirst').on('click', function() {
                var $btn = $(this);
                $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Starting...');

                $.ajax({
                    type: 'POST',
                    url: '../../api/jury/session',
                    data: { action: 'startScoring', eventID: eventID },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Session Started',
                                text: 'Scoring session is now active',
                                timer: 2000,
                                showConfirmButton: false,
                                background: '#1a1a3a',
                                color: '#fff'
                            });
                            pollSessionState();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.error || 'Failed to start session',
                                background: '#1a1a3a',
                                color: '#fff'
                            });
                        }
                        $btn.prop('disabled', false).html('<i class="fas fa-play me-2"></i>Start Scoring');
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Network Error',
                            text: 'Could not connect to server',
                            background: '#1a1a3a',
                            color: '#fff'
                        });
                        $btn.prop('disabled', false).html('<i class="fas fa-play me-2"></i>Start Scoring');
                    }
                });
            });

            // Advance gymnast
            $('#btnAdvance').on('click', function() {
                var $btn = $(this);
                $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Advancing...');

                $.ajax({
                    type: 'POST',
                    url: '../../api/jury/session',
                    data: { action: 'advanceGymnast', eventID: eventID },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            if (response.competitionComplete) {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Competition Complete!',
                                    text: 'All gymnasts have been scored',
                                    background: '#1a1a3a',
                                    color: '#fff'
                                });
                            } else {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Next Gymnast',
                                    text: 'Advancing to next gymnast',
                                    timer: 1500,
                                    showConfirmButton: false,
                                    background: '#1a1a3a',
                                    color: '#fff'
                                });
                            }
                            pollSessionState();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.error || 'Failed to advance',
                                background: '#1a1a3a',
                                color: '#fff'
                            });
                        }
                        $btn.prop('disabled', false).html('<i class="fas fa-forward me-2"></i>Next Gymnast');
                    },
                    error: function() {
                        Swal.fire({
                            icon: 'error',
                            title: 'Network Error',
                            text: 'Could not connect to server',
                            background: '#1a1a3a',
                            color: '#fff'
                        });
                        $btn.prop('disabled', false).html('<i class="fas fa-forward me-2"></i>Next Gymnast');
                    }
                });
            });

            // Force submit
            $('#btnForceSubmit').on('click', function() {
                Swal.fire({
                    title: 'Force Submit All?',
                    text: 'Missing scores will be set to 0. This should only be used if juries are unavailable.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#f59e0b',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: 'Yes, Force Submit',
                    background: '#1a1a3a',
                    color: '#fff'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: 'POST',
                            url: '../../api/jury/session',
                            data: { action: 'forceSubmitAll', eventID: eventID, sessionID: currentSessionID },
                            dataType: 'json',
                            success: function() {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Submitted',
                                    text: 'All scores have been force submitted',
                                    timer: 2000,
                                    showConfirmButton: false,
                                    background: '#1a1a3a',
                                    color: '#fff'
                                });
                                pollSessionState();
                            }
                        });
                    }
                });
            });

            $(window).on('beforeunload', function() {
                if (pollInterval) clearInterval(pollInterval);
            });
        });
    </script>
</body>
</html>
