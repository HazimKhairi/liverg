<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="icon" type="image/png" href="../../assets/img/favicon.png">
    <title>Technical Backend | LIVERG</title>

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

        .page-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .page-info i { color: var(--primary-cyan); }

        /* Main Content */
        .main-content {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr 260px;
            overflow: hidden;
        }

        /* Left Panel */
        .left-panel {
            padding: 1rem 1.5rem;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* Gymnast Card */
        .gymnast-card {
            background: var(--gradient-primary);
            border-radius: 0.75rem;
            padding: 0.75rem 1.25rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            flex-shrink: 0;
        }

        .gymnast-order {
            width: 45px;
            height: 45px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Montserrat', sans-serif;
            font-size: 1.25rem;
            font-weight: 800;
        }

        .gymnast-info h2 {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
            margin: 0;
        }

        .gymnast-info .details {
            font-size: 0.8rem;
            opacity: 0.9;
        }

        /* Scores Table */
        .scores-section {
            flex: 1;
            background: var(--dark-card);
            border-radius: 0.75rem;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .section-header {
            background: var(--dark-surface);
            padding: 0.5rem 1rem;
            font-weight: 600;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-shrink: 0;
        }

        .section-header i { color: var(--primary-cyan); }

        .scores-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 0.5rem;
            padding: 0.75rem;
            flex: 1;
        }

        .score-item {
            background: var(--dark-surface);
            border-radius: 0.5rem;
            padding: 0.6rem;
            text-align: center;
            border: 2px solid transparent;
            cursor: pointer;
            transition: all 0.2s;
        }

        .score-item:hover {
            border-color: var(--primary-cyan);
        }

        .score-item.submitted {
            border-color: var(--success);
            background: rgba(16, 185, 129, 0.1);
        }

        .score-item .code {
            font-weight: 700;
            font-size: 0.7rem;
            margin-bottom: 0.25rem;
        }

        .score-item.cat-db .code, .score-item.cat-da .code { color: var(--primary-purple); }
        .score-item.cat-a .code { color: var(--primary-cyan); }
        .score-item.cat-e .code { color: var(--primary-magenta); }

        .score-item .value {
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
            font-weight: 700;
        }

        /* Final Score */
        .final-section {
            background: var(--dark-card);
            border-radius: 0.75rem;
            padding: 0.75rem;
            margin-top: 0.75rem;
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
            margin-bottom: 0.15rem;
        }

        .final-item .value {
            font-family: 'Montserrat', sans-serif;
            font-size: 1rem;
            font-weight: 700;
        }

        .final-item.total {
            background: var(--gradient-primary);
        }

        .final-item.total .value {
            font-size: 1.25rem;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            margin-top: 0.75rem;
            flex-shrink: 0;
        }

        .btn-action {
            flex: 1;
            padding: 0.6rem;
            border: none;
            border-radius: 0.5rem;
            font-family: 'Inter', sans-serif;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
        }

        .btn-action:disabled {
            background: var(--dark-border) !important;
            color: var(--text-secondary) !important;
            cursor: not-allowed;
        }

        .btn-start { background: var(--gradient-primary); color: white; }
        .btn-force { background: linear-gradient(135deg, var(--warning), #d97706); color: white; }
        .btn-advance { background: linear-gradient(135deg, #3b82f6, #2563eb); color: white; }

        /* Right Sidebar */
        .sidebar {
            background: var(--dark-surface);
            border-left: 1px solid var(--dark-border);
            padding: 0.75rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            overflow: hidden;
        }

        .sidebar-card {
            background: var(--dark-card);
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .sidebar-header {
            background: var(--dark-bg);
            padding: 0.4rem 0.6rem;
            font-weight: 600;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .sidebar-header i { color: var(--primary-cyan); font-size: 0.65rem; }

        .sidebar-body {
            padding: 0.6rem;
        }

        /* Status Info */
        .status-row {
            display: flex;
            justify-content: space-between;
            padding: 0.3rem 0;
            font-size: 0.7rem;
            border-bottom: 1px solid var(--dark-border);
        }

        .status-row:last-child { border-bottom: none; }
        .status-label { color: var(--text-secondary); }
        .status-value { font-weight: 600; }
        .status-value.scoring { color: var(--primary-cyan); }
        .status-value.active { color: var(--success); }

        /* Start List */
        .start-list {
            max-height: 180px;
            overflow-y: auto;
        }

        .list-item {
            display: flex;
            align-items: center;
            padding: 0.35rem 0.5rem;
            border-radius: 0.35rem;
            margin-bottom: 0.25rem;
            background: var(--dark-surface);
            font-size: 0.7rem;
        }

        .list-item.current { background: var(--gradient-primary); }
        .list-item.completed { opacity: 0.5; }

        .list-item .num {
            width: 18px;
            height: 18px;
            background: var(--dark-bg);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.6rem;
            font-weight: 700;
            margin-right: 0.4rem;
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
            font-size: 0.75rem;
        }

        .list-item.current .score { color: white; }

        /* Quick Links */
        .quick-link {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.4rem 0.6rem;
            background: var(--dark-surface);
            border-radius: 0.35rem;
            color: var(--text-primary);
            text-decoration: none;
            font-size: 0.7rem;
            transition: all 0.2s;
            margin-bottom: 0.25rem;
        }

        .quick-link:hover { background: var(--dark-bg); color: var(--primary-cyan); }

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
            <div class="page-info">
                <i class="fas fa-cogs"></i>
                <span>Technical Backend</span>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Left Panel -->
        <div class="left-panel">
            <!-- Gymnast Card -->
            <div class="gymnast-card">
                <div class="gymnast-order" id="gymnastOrder">#-</div>
                <div class="gymnast-info">
                    <h2 id="gymnastName">No Active Session</h2>
                    <div class="details">
                        <span id="teamName">-</span> &bull; <span id="apparatusName">-</span>
                    </div>
                </div>
            </div>

            <!-- Scores Section -->
            <div class="scores-section">
                <div class="section-header">
                    <i class="fas fa-edit"></i>
                    Score Entry (Click to Edit)
                </div>
                <div class="scores-grid" id="scoresGrid">
                    <!-- Populated dynamically -->
                </div>
            </div>

            <!-- Final Score -->
            <div class="final-section">
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
                <button class="btn-action btn-start" id="btnStart">
                    <i class="fas fa-play"></i>
                    Start
                </button>
                <button class="btn-action btn-force" id="btnForce" disabled>
                    <i class="fas fa-check-double"></i>
                    Force Submit
                </button>
                <button class="btn-action btn-advance" id="btnAdvance" disabled>
                    <i class="fas fa-forward"></i>
                    Next
                </button>
            </div>
        </div>

        <!-- Right Sidebar -->
        <div class="sidebar">
            <!-- Session Info -->
            <div class="sidebar-card">
                <div class="sidebar-header">
                    <i class="fas fa-info-circle"></i>
                    Session
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
                    <div class="status-row">
                        <span class="status-label">Event ID</span>
                        <span class="status-value" id="eventID">-</span>
                    </div>
                </div>
            </div>

            <!-- Start List -->
            <div class="sidebar-card" style="flex: 1;">
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
                    Links
                </div>
                <div class="sidebar-body">
                    <a href="#" class="quick-link" id="linkMasterView">
                        <i class="fas fa-tv"></i>
                        Master View
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

            $('#eventID').text(eventID);

            var currentSessionID = null;
            var pollInterval = null;

            // Simplified positions: DB, DA, A1-A4, E1-E4
            var positions = [
                { positionCode: 'DB', positionName: 'Difficulty Body', category: 'DB' },
                { positionCode: 'DA', positionName: 'Difficulty Apparatus', category: 'DA' },
                { positionCode: 'A1', positionName: 'Artistic 1', category: 'A' },
                { positionCode: 'A2', positionName: 'Artistic 2', category: 'A' },
                { positionCode: 'A3', positionName: 'Artistic 3', category: 'A' },
                { positionCode: 'A4', positionName: 'Artistic 4', category: 'A' },
                { positionCode: 'E1', positionName: 'Execution 1', category: 'E' },
                { positionCode: 'E2', positionName: 'Execution 2', category: 'E' },
                { positionCode: 'E3', positionName: 'Execution 3', category: 'E' },
                { positionCode: 'E4', positionName: 'Execution 4', category: 'E' }
            ];

            // Set up quick links
            $('#linkMasterView').attr('href', '../master/masterView.jsp?eventID=' + eventID);
            $('#linkStartList').attr('href', '../startlist/startListManage.jsp?eventID=' + eventID);

            // Initialize score grid
            initScoreGrid();
            loadStartList();
            startPolling();

            function initScoreGrid() {
                var $grid = $('#scoresGrid');
                positions.forEach(function(pos) {
                    var catClass = 'cat-' + pos.category.toLowerCase();
                    $grid.append(
                        '<div class="score-item ' + catClass + '" data-code="' + pos.positionCode + '">' +
                        '<div class="code">' + pos.positionCode + '</div>' +
                        '<div class="value">-</div>' +
                        '</div>'
                    );
                });
            }

            function loadStartList() {
                $.ajax({
                    type: 'GET',
                    url: '../../api/jury/startlist',
                    data: { eventID: eventID },
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
                    $container.html('<div style="text-align:center;color:var(--text-secondary);padding:0.5rem;">No entries</div>');
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
                        if (response.success) {
                            handleSessionState(response);
                        }
                    }
                });
            }

            function handleSessionState(data) {
                var status = data.sessionStatus;
                currentSessionID = data.sessionID;

                if (status === 'NO_SESSION') {
                    $('#gymnastName').text('No Active Session');
                    $('#teamName, #apparatusName').text('-');
                    $('#gymnastOrder').text('#-');
                    $('#sessionStatus').text('No Session');
                    $('#btnStart').prop('disabled', false);
                    $('#btnForce, #btnAdvance').prop('disabled', true);
                    resetScoreCells();
                } else {
                    $('#gymnastName').text(data.gymnastName || '-');
                    $('#teamName').text(data.teamName || '-');
                    $('#apparatusName').text(data.apparatusName || '-');
                    $('#gymnastOrder').text('#' + (data.startOrder || '-'));

                    var $status = $('#sessionStatus');
                    $status.removeClass('active scoring').text(status);
                    if (status === 'SCORING') $status.addClass('scoring');
                    else if (status === 'SUBMITTED') $status.addClass('active');

                    updateScoreCells(data.scores || [], data.submittedPositions || []);

                    var submitted = (data.submittedPositions || []).length;
                    var total = positions.length;
                    $('#submittedCount').text(submitted + ' / ' + total);

                    if (data.finalScore) {
                        $('#scoreD').text(data.finalScore.scoreDTotal ? data.finalScore.scoreDTotal.toFixed(3) : '-');
                        $('#scoreA').text(data.finalScore.scoreArtistic ? data.finalScore.scoreArtistic.toFixed(3) : '-');
                        $('#scoreE').text(data.finalScore.scoreExecution ? data.finalScore.scoreExecution.toFixed(3) : '-');
                        var pen = (data.finalScore.technicalDeduction || 0) + (data.finalScore.lineDeduction || 0) + (data.finalScore.timeDeduction || 0);
                        $('#scorePenalty').text(pen > 0 ? '-' + pen.toFixed(3) : '0.000');
                        $('#scoreFinal').text(data.finalScore.finalScore ? data.finalScore.finalScore.toFixed(3) : '-');
                    }

                    var allSubmitted = submitted === total && total > 0;
                    $('#btnStart').prop('disabled', status !== 'NO_SESSION' && status !== 'WAITING');
                    $('#btnForce').prop('disabled', allSubmitted || status !== 'SCORING');
                    $('#btnAdvance').prop('disabled', status !== 'SUBMITTED' && status !== 'FINALIZED');
                }

                loadStartList();
            }

            function resetScoreCells() {
                $('.score-item').removeClass('submitted').find('.value').text('-');
            }

            function updateScoreCells(scores, submittedPositions) {
                positions.forEach(function(pos) {
                    var $cell = $('.score-item[data-code="' + pos.positionCode + '"]');
                    var isSubmitted = submittedPositions.includes(pos.positionCode);
                    var score = scores.find(s => s.positionCode === pos.positionCode);
                    var value = (score && score.hasScore) ? score.scoreValue.toFixed(3) : '-';

                    $cell.toggleClass('submitted', isSubmitted);
                    $cell.find('.value').text(value);
                });
            }

            // Click to edit score
            $(document).on('click', '.score-item', function() {
                if (!currentSessionID) {
                    Swal.fire({
                        icon: 'warning',
                        title: 'No Session',
                        text: 'Start a session first',
                        background: '#1a1a3a',
                        color: '#fff'
                    });
                    return;
                }

                var $cell = $(this);
                var positionCode = $cell.data('code');
                var currentValue = $cell.find('.value').text();

                Swal.fire({
                    title: 'Enter Score for ' + positionCode,
                    input: 'number',
                    inputValue: currentValue !== '-' ? currentValue : '',
                    inputAttributes: {
                        step: '0.001',
                        min: '0',
                        max: '10'
                    },
                    showCancelButton: true,
                    confirmButtonText: 'Submit',
                    confirmButtonColor: '#00d4aa',
                    cancelButtonColor: '#6b7280',
                    background: '#1a1a3a',
                    color: '#fff',
                    inputValidator: (value) => {
                        if (!value) return 'Please enter a score';
                        if (isNaN(value) || value < 0 || value > 10) return 'Enter a valid score (0-10)';
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        submitScore(positionCode, parseFloat(result.value));
                    }
                });
            });

            function submitScore(positionCode, scoreValue) {
                $.ajax({
                    type: 'POST',
                    url: '../../api/jury/session',
                    data: {
                        action: 'submitScore',
                        eventID: eventID,
                        sessionID: currentSessionID,
                        positionCode: positionCode,
                        scoreValue: scoreValue.toFixed(3)
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Saved',
                                text: positionCode + ': ' + scoreValue.toFixed(3),
                                timer: 1500,
                                showConfirmButton: false,
                                background: '#1a1a3a',
                                color: '#fff'
                            });
                            pollSessionState();
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.error || 'Failed to save',
                                background: '#1a1a3a',
                                color: '#fff'
                            });
                        }
                    }
                });
            }

            // Button handlers
            $('#btnStart').on('click', function() {
                var $btn = $(this);
                $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i>Starting...');

                $.ajax({
                    type: 'POST',
                    url: '../../api/jury/session',
                    data: { action: 'startScoring', eventID: eventID },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Started',
                                timer: 1500,
                                showConfirmButton: false,
                                background: '#1a1a3a',
                                color: '#fff'
                            });
                        }
                        pollSessionState();
                    },
                    complete: function() {
                        $btn.prop('disabled', false).html('<i class="fas fa-play me-1"></i>Start');
                    }
                });
            });

            $('#btnAdvance').on('click', function() {
                var $btn = $(this);
                $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i>Next...');

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
                                    title: 'Complete!',
                                    text: 'All gymnasts scored',
                                    background: '#1a1a3a',
                                    color: '#fff'
                                });
                            }
                        }
                        pollSessionState();
                    },
                    complete: function() {
                        $btn.prop('disabled', false).html('<i class="fas fa-forward me-1"></i>Next');
                    }
                });
            });

            $('#btnForce').on('click', function() {
                Swal.fire({
                    title: 'Force Submit All?',
                    text: 'Missing scores will be set to 0',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#f59e0b',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: 'Yes',
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
                                    timer: 1500,
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
