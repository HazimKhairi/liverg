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
            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Montserrat:wght@600;700;800;900&display=swap"
                rel="stylesheet">
            <!-- Font Awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
            <!-- SweetAlert2 -->
            <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet">

            <style>
                :root {
                    --primary-cyan: #00d4aa;
                    --primary-magenta: #e91e8c;
                    --primary-purple: #8b5cf6;
                    --primary-blue: #1a3a5c;
                    --bg-main: #f0f2f5;
                    --bg-white: #ffffff;
                    --bg-light: #f8fafc;
                    --border-color: #e2e8f0;
                    --text-primary: #1a3a5c;
                    --text-secondary: #64748b;
                    --text-muted: #94a3b8;
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

                html,
                body {
                    height: 100vh;
                    overflow: hidden;
                }

                body {
                    font-family: 'Inter', sans-serif;
                    background: var(--bg-main);
                    color: var(--text-primary);
                    display: flex;
                    flex-direction: column;
                }

                /* Header */
                .header {
                    background: var(--bg-white);
                    padding: 0.75rem 1.5rem;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    border-bottom: 1px solid var(--border-color);
                    flex-shrink: 0;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .brand {
                    font-family: 'Montserrat', sans-serif;
                    font-weight: 800;
                    font-size: 1.25rem;
                    color: var(--text-primary);
                }

                .page-info {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    font-size: 0.9rem;
                    font-weight: 600;
                    color: var(--text-secondary);
                }

                .page-info i {
                    color: var(--primary-cyan);
                }

                /* Main Content */
                .main-content {
                    flex: 1;
                    display: grid;
                    grid-template-columns: 1fr 280px;
                    gap: 0;
                    overflow: hidden;
                }

                /* Left Panel */
                .left-panel {
                    padding: 1rem 1.5rem;
                    display: flex;
                    flex-direction: column;
                    overflow: hidden;
                    background: var(--bg-main);
                }

                /* Gymnast Card */
                .gymnast-card {
                    background: var(--bg-white);
                    border-radius: 1rem;
                    padding: 1rem 1.5rem;
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                    margin-bottom: 1rem;
                    flex-shrink: 0;
                    border: 1px solid var(--border-color);
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .gymnast-order {
                    width: 50px;
                    height: 50px;
                    background: var(--primary-cyan);
                    color: white;
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
                    color: var(--text-primary);
                }

                .gymnast-info .details {
                    font-size: 0.85rem;
                    color: var(--text-secondary);
                }

                /* Scores Table */
                .scores-section {
                    flex: 1;
                    background: var(--bg-white);
                    border-radius: 0.75rem;
                    overflow: hidden;
                    display: flex;
                    flex-direction: column;
                    border: 1px solid var(--border-color);
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
                }

                .section-header {
                    background: var(--bg-light);
                    padding: 0.5rem 1rem;
                    font-weight: 600;
                    font-size: 0.75rem;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    flex-shrink: 0;
                    border-bottom: 1px solid var(--border-color);
                    color: var(--text-secondary);
                }

                .section-header i {
                    color: var(--primary-cyan);
                }

                .scores-grid {
                    display: grid;
                    grid-template-columns: repeat(5, 1fr);
                    gap: 0.5rem;
                    padding: 0.75rem;
                    flex: 1;
                    overflow-y: auto;
                }

                .score-item {
                    background: var(--bg-white);
                    border-radius: 0.5rem;
                    padding: 0.6rem;
                    text-align: center;
                    border: 1px solid var(--border-color);
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .score-item:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                    border-color: var(--primary-cyan);
                }

                .score-item.submitted {
                    border-color: var(--success);
                    background: rgba(16, 185, 129, 0.05);
                }

                .score-item .code {
                    font-weight: 700;
                    font-size: 0.7rem;
                    margin-bottom: 0.25rem;
                    color: var(--text-secondary);
                }

                .score-item.cat-db .code,
                .score-item.cat-da .code {
                    color: var(--primary-purple);
                }

                .score-item.cat-a .code {
                    color: var(--primary-cyan);
                }

                .score-item.cat-e .code {
                    color: var(--primary-magenta);
                }

                .score-item .value {
                    font-family: 'Montserrat', sans-serif;
                    font-size: 1rem;
                    font-weight: 700;
                    color: var(--text-primary);
                }

                /* Final Score */
                .final-section {
                    background: var(--bg-white);
                    border-radius: 0.75rem;
                    padding: 0.75rem;
                    margin-top: 0.75rem;
                    flex-shrink: 0;
                    border: 1px solid var(--border-color);
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
                }

                .final-grid {
                    display: grid;
                    grid-template-columns: repeat(5, 1fr);
                    gap: 0.5rem;
                }

                .final-item {
                    background: var(--bg-light);
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
                    font-size: 1.1rem;
                    font-weight: 700;
                    color: var(--text-primary);
                }

                .final-item.total {
                    background: var(--primary-cyan);
                    color: white;
                }

                .final-item.total label {
                    color: rgba(255, 255, 255, 0.8);
                }

                .final-item.total .value {
                    color: white;
                    font-size: 1.25rem;
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
                    background: var(--bg-light) !important;
                    color: var(--text-muted) !important;
                    cursor: not-allowed;
                    border: 1px solid var(--border-color);
                }

                .btn-start {
                    background: var(--primary-cyan);
                    color: white;
                }

                .btn-start:hover {
                    background: #00bfa0;
                }

                .btn-force {
                    background: var(--warning);
                    color: white;
                }

                .btn-force:hover {
                    background: #d97706;
                }

                .btn-advance {
                    background: var(--primary-blue);
                    color: white;
                }

                .btn-advance:hover {
                    background: #1e40af;
                }

                /* Right Sidebar */
                .sidebar {
                    background: var(--bg-white);
                    border-left: 1px solid var(--border-color);
                    padding: 1rem;
                    display: flex;
                    flex-direction: column;
                    gap: 0.75rem;
                    overflow: hidden;
                    box-shadow: -1px 0 5px rgba(0, 0, 0, 0.02);
                }

                .sidebar-card {
                    background: var(--bg-white);
                    border-radius: 0.75rem;
                    overflow: hidden;
                    border: 1px solid var(--border-color);
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .sidebar-header {
                    background: var(--bg-light);
                    padding: 0.5rem 0.75rem;
                    font-weight: 600;
                    font-size: 0.75rem;
                    display: flex;
                    align-items: center;
                    gap: 0.4rem;
                    color: var(--text-primary);
                    border-bottom: 1px solid var(--border-color);
                }

                .sidebar-header i {
                    color: var(--primary-cyan);
                    font-size: 0.7rem;
                }

                .sidebar-body {
                    padding: 0.75rem;
                }

                /* Status Info */
                .status-row {
                    display: flex;
                    justify-content: space-between;
                    padding: 0.4rem 0;
                    font-size: 0.75rem;
                    border-bottom: 1px solid var(--border-color);
                }

                .status-row:last-child {
                    border-bottom: none;
                }

                .status-label {
                    color: var(--text-secondary);
                }

                .status-value {
                    font-weight: 600;
                    color: var(--text-primary);
                }

                .status-value.scoring {
                    color: var(--warning);
                }

                .status-value.active {
                    color: var(--success);
                }

                /* Start List */
                .start-list {
                    flex: 1;
                    overflow-y: auto;
                    max-height: 200px;
                }

                .list-item {
                    display: flex;
                    align-items: center;
                    padding: 0.5rem 0.75rem;
                    border-radius: 0.5rem;
                    margin-bottom: 0.5rem;
                    background: var(--bg-light);
                    font-size: 0.8rem;
                    border: 1px solid transparent;
                    transition: all 0.2s;
                    color: var(--text-primary);
                }

                .list-item:hover {
                    border-color: var(--primary-cyan);
                    background: rgba(0, 212, 170, 0.05);
                }

                .list-item.current {
                    background: var(--primary-cyan);
                    color: white;
                    border-color: var(--primary-cyan);
                    box-shadow: 0 4px 12px rgba(0, 212, 170, 0.2);
                }

                .list-item.completed {
                    opacity: 0.7;
                    background: var(--bg-main);
                }

                .list-item .num {
                    width: 24px;
                    height: 24px;
                    background: var(--primary-blue);
                    color: white;
                    border-radius: 0.4rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 0.7rem;
                    font-weight: 700;
                    margin-right: 0.75rem;
                }

                .list-item.current .num {
                    background: rgba(255, 255, 255, 0.2);
                    color: white;
                }

                .list-item .name {
                    flex: 1;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    font-weight: 500;
                }

                .list-item .score {
                    font-family: 'Montserrat', sans-serif;
                    font-weight: 700;
                    color: var(--success);
                    font-size: 0.85rem;
                }

                .list-item.current .score {
                    color: white;
                }

                /* Quick Links */
                .quick-link {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    padding: 0.75rem 1rem;
                    background: var(--bg-light);
                    border-radius: 0.5rem;
                    color: var(--text-primary);
                    text-decoration: none;
                    transition: all 0.2s ease;
                    margin-bottom: 0.5rem;
                    font-size: 0.85rem;
                    font-weight: 500;
                    border: 1px solid var(--border-color);
                }

                .quick-link:hover {
                    background: var(--primary-cyan);
                    color: white;
                    transform: translateY(-1px);
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    border-color: var(--primary-cyan);
                }

                /* Scrollbar */
                ::-webkit-scrollbar {
                    width: 6px;
                }

                ::-webkit-scrollbar-track {
                    background: var(--bg-main);
                }

                ::-webkit-scrollbar-thumb {
                    background: var(--text-muted);
                    border-radius: 3px;
                }

                /* Responsive */
                @media (max-width: 900px) {
                    .main-content {
                        grid-template-columns: 1fr;
                    }

                    .sidebar {
                        display: none;
                    }
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
                        <div class="status-pill scoring" id="statusPill" style="display: none; margin-left: auto;">
                            <!-- Optional status pill if needed to match perfectly -->
                        </div>
                    </div>

                    <!-- Scores Section -->
                    <div class="scores-container"
                        style="flex: 1; display: flex; flex-direction: column; gap: 0.75rem; overflow: hidden; margin-bottom: 0.75rem;">

                        <!-- Difficulty Panel -->
                        <div class="panel-section"
                            style="background: var(--bg-white); border-radius: 0.75rem; overflow: hidden; border: 1px solid var(--border-color);">
                            <div class="section-header">
                                <i class="fas fa-star"></i>Difficulty (D)
                            </div>
                            <div class="scores-grid" id="difficultyGrid"
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(70px, 1fr)); gap: 0.5rem; padding: 0.75rem;">
                                <!-- Populated dynamically -->
                            </div>
                        </div>

                        <!-- Artistic Panel -->
                        <div class="panel-section"
                            style="background: var(--bg-white); border-radius: 0.75rem; overflow: hidden; border: 1px solid var(--border-color);">
                            <div class="section-header">
                                <i class="fas fa-palette"></i>Artistic (A)
                            </div>
                            <div class="scores-grid" id="artisticGrid"
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(70px, 1fr)); gap: 0.5rem; padding: 0.75rem;">
                                <!-- Populated dynamically -->
                            </div>
                        </div>

                        <!-- Execution Panel -->
                        <div class="panel-section"
                            style="background: var(--bg-white); border-radius: 0.75rem; overflow: hidden; border: 1px solid var(--border-color);">
                            <div class="section-header">
                                <i class="fas fa-check-double"></i>Execution (E)
                            </div>
                            <div class="scores-grid" id="executionGrid"
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(70px, 1fr)); gap: 0.5rem; padding: 0.75rem;">
                                <!-- Populated dynamically -->
                            </div>
                        </div>

                        <!-- Penalty Panel -->
                        <div class="panel-section"
                            style="background: var(--bg-white); border-radius: 0.75rem; overflow: hidden; border: 1px solid var(--border-color);">
                            <div class="section-header">
                                <i class="fas fa-exclamation-triangle"></i>Penalty
                            </div>
                            <div class="scores-grid" id="penaltyGrid"
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(70px, 1fr)); gap: 0.5rem; padding: 0.75rem;">
                                <!-- Populated dynamically -->
                            </div>
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
                $(document).ready(function () {
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
                        { positionCode: 'DB1', positionName: 'Difficulty Body', category: 'DB' },
                        { positionCode: 'DA1', positionName: 'Difficulty Apparatus', category: 'DA' },
                        { positionCode: 'A1', positionName: 'Artistic 1', category: 'A' },
                        { positionCode: 'A2', positionName: 'Artistic 2', category: 'A' },
                        { positionCode: 'A3', positionName: 'Artistic 3', category: 'A' },
                        { positionCode: 'A4', positionName: 'Artistic 4', category: 'A' },
                        { positionCode: 'E1', positionName: 'Execution 1', category: 'E' },
                        { positionCode: 'E2', positionName: 'Execution 2', category: 'E' },
                        { positionCode: 'E3', positionName: 'Execution 3', category: 'E' },
                        { positionCode: 'E4', positionName: 'Execution 4', category: 'E' },
                        { positionCode: 'L1', positionName: 'Line Penalty', category: 'LINE' },
                        { positionCode: 'T1', positionName: 'Time Penalty', category: 'TIME' },
                        { positionCode: 'RJ', positionName: 'Technical Penalty', category: 'RJ' }
                    ];

                    // Set up quick links
                    $('#linkMasterView').attr('href', '../master/masterView.jsp?eventID=' + eventID);
                    $('#linkStartList').attr('href', '../startlist/startListManage.jsp?eventID=' + eventID);

                    // Initialize score grid
                    initScoreGrid();
                    loadStartList();
                    startPolling();

                    function initScoreGrid() {
                        var $dGrid = $('#difficultyGrid');
                        var $aGrid = $('#artisticGrid');
                        var $eGrid = $('#executionGrid');
                        var $pGrid = $('#penaltyGrid');

                        positions.forEach(function (pos) {
                            var catClass = 'cat-' + pos.category.toLowerCase();
                            var $targetGrid;

                            // Determine which grid to append to based on category (DB/DA -> Difficulty, A -> Artistic, E -> Execution)
                            if (pos.category === 'DB' || pos.category === 'DA') {
                                $targetGrid = $dGrid;
                            } else if (pos.category === 'A') {
                                $targetGrid = $aGrid;
                            } else if (pos.category === 'E') {
                                $targetGrid = $eGrid;
                            } else if (pos.category === 'LINE' || pos.category === 'TIME' || pos.category === 'RJ') {
                                $targetGrid = $pGrid;
                            } else {
                                // Fallback or handle other categories if any
                                $targetGrid = $dGrid;
                            }

                            $targetGrid.append(
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
                            success: function (response) {
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

                        entries.forEach(function (entry, index) {
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
                            success: function (response) {
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

                            // ALWAYS calculate preview based on available scores
                            calculateAndDisplayPreview(data.scores || []);

                            var submitted = (data.submittedPositions || []).length;
                            var total = positions.length;
                            $('#submittedCount').text(submitted + ' / ' + total);

                            // If server has a final score (submitted/finalized), overwrite with official values
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
                            $('#btnForce').prop('disabled', status !== 'SCORING');
                            $('#btnAdvance').prop('disabled', status !== 'SUBMITTED' && status !== 'FINALIZED');
                        }

                        loadStartList();
                    }

                    function calculateAndDisplayPreview(scores) {
                        // Extract values by category
                        var dbScores = getScoresByCategory(scores, 'DB');
                        var daScores = getScoresByCategory(scores, 'DA');
                        var aScores = getScoresByCategory(scores, 'A');
                        var eScores = getScoresByCategory(scores, 'E');
                        var penaltyScores = [
                            ...getScoresByCategory(scores, 'LINE'),
                            ...getScoresByCategory(scores, 'TIME'),
                            ...getScoresByCategory(scores, 'RJ')
                        ];

                        // Calculate D
                        var dbAvg = calculateAverage(dbScores);
                        var daAvg = calculateAverage(daScores);
                        var dTotal = dbAvg + daAvg;

                        // Calculate A (Median)
                        var aMedian = calculateMedian(aScores);

                        // Calculate E (Trimmed Median)
                        var eMedian = calculateTrimmedMedian(eScores);

                        // Calculate Penalty
                        var penaltyTotal = penaltyScores.reduce((a, b) => a + b, 0);

                        // Calculate Final
                        // Base Score = D + (10 - E) + (10 - A)
                        // Note: E and A are deductions from 10 in the final formula representation usually, 
                        // but here A and E inputs are usually 0-10. 
                        // Wait, standard RG: E is deduction? Or E is score out of 10?
                        // FinalScoreDAO: baseScore = dTotal + (10 - eMedian) + (10 - aMedian);
                        // This implies eMedian and aMedian are DEDUCTIONS?
                        // Let's check JudgePositionTypeDAO. 
                        // Usually Artistic and Execution are given as scores out of 10.
                        // If they are scores out of 10 (e.g. 7.5), then (10 - 7.5) = 2.5 deduction?
                        // OR if they are DEDUCTIONS (e.g. 2.5), then (10 - 2.5) = 7.5 score.
                        // Looking at Score.java data (e.g. scoreE1 = 2.50), it seems they are DEDUCTIONS.
                        // Let's assume the DAO logic is correct: Final = D + (10-E_deduction) + (10-A_deduction) - Penalty?
                        // NO. Re-reading DAO:
                        // finalScore.setScoreArtistic(aMedian); -> save the calculated median
                        // double baseScore = dTotal + (10 - eMedian) + (10 - aMedian);
                        // This formula adds (10-deduction). So if input is 2.0 (deduction), result is 8.0 (score).

                        // IF the inputs are SCORES (e.g. 8.0), then (10-8.0) would be 2.0 (deduction??). 
                        // This formula is weird if inputs are scores.
                        // Let's assume inputs are deduced points (Deduction system). 
                        // RG 2022-2024 Code: E is deduction (sum of mistakes). A is deduction.
                        // So correct formula: Final = D + (10 - A) + (10 - E) - Penalties.

                        var baseScore = dTotal + (10 - eMedian) + (10 - aMedian);

                        // Rounding to 2 decimal places before subtract penalty (matching Java logic roughly)
                        baseScore = Math.round(baseScore * 100) / 100;

                        var finalScore = baseScore - penaltyTotal;
                        if (finalScore < 0) finalScore = 0;

                        // Display if we have at least some data (or just display 0s)
                        // Only update if server didn't provide official final score (handled in caller)
                        if (!$('#sessionStatus').hasClass('active')) { // only if not submitted/finalized logic handled above
                            $('#scoreD').text(dTotal.toFixed(3));
                            $('#scoreA').text(aMedian.toFixed(3)); // This is the deduction median probably? Or the score?
                            // DAO saves 'aMedian' as 'scoreArtistic'. And display usually shows the SCORE not deduction.
                            // But the DAO saves the MEDIAN directly.
                            // Let's display the calculated component.
                            // If DAO logic is `base = D + (10-E) + (10-A)`, currently these are deductions.
                            // Usually on scoreboard we show the net score for A and E? Or the deduction?
                            // The DAO `finalScoreObj` returns `scoreArtistic`. 
                            // Let's stick to displaying the variable values we calculated, which are the aggregates.
                            // If the inputs are deductions, we display deductions.

                            $('#scoreD').text(dTotal.toFixed(3));
                            $('#scoreA').text(aMedian.toFixed(3));
                            $('#scoreE').text(eMedian.toFixed(3));
                            $('#scorePenalty').text(penaltyTotal > 0 ? '-' + penaltyTotal.toFixed(3) : '0.000');
                            $('#scoreFinal').text(finalScore.toFixed(3));
                        }
                    }

                    function getScoresByCategory(scores, category) {
                        return scores.filter(s => s.category === category && s.hasScore)
                            .map(s => s.scoreValue);
                    }

                    function calculateAverage(values) {
                        if (!values || values.length === 0) return 0;
                        var sum = values.reduce((a, b) => a + b, 0);
                        return sum / values.length;
                    }

                    function calculateMedian(values) {
                        if (!values || values.length === 0) return 0;
                        values.sort((a, b) => a - b);
                        var mid = Math.floor(values.length / 2);
                        if (values.length % 2 === 0) {
                            return (values[mid - 1] + values[mid]) / 2.0;
                        }
                        return values[mid];
                    }

                    function calculateTrimmedMedian(values) {
                        if (!values || values.length === 0) return 0;
                        if (values.length < 4) return calculateMedian(values);

                        values.sort((a, b) => a - b);
                        // Remove min and max (first and last)
                        var trimmed = values.slice(1, values.length - 1);
                        return calculateMedian(trimmed);
                    }

                    function resetScoreCells() {
                        $('.score-item').removeClass('submitted').find('.value').text('-');
                    }

                    function updateScoreCells(scores, submittedPositions) {
                        positions.forEach(function (pos) {
                            var $cell = $('.score-item[data-code="' + pos.positionCode + '"]');
                            var isSubmitted = submittedPositions.includes(pos.positionCode);
                            var score = scores.find(s => s.positionCode === pos.positionCode);
                            var value = (score && score.hasScore) ? score.scoreValue.toFixed(3) : '-';

                            $cell.toggleClass('submitted', isSubmitted);
                            $cell.find('.value').text(value);
                        });
                    }

                    // Click to edit score
                    $(document).on('click', '.score-item', function () {
                        if (!currentSessionID) {
                            Swal.fire({
                                icon: 'warning',
                                title: 'No Session',
                                text: 'Start a session first',
                                text: 'Start a session first'
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
                            confirmButtonColor: '#00d4aa',
                            cancelButtonColor: '#6b7280',
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
                            success: function (response) {
                                if (response.success) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Saved',
                                        text: positionCode + ': ' + scoreValue.toFixed(3),
                                        timer: 1500,
                                        showConfirmButton: false,
                                        showConfirmButton: false
                                    });
                                    pollSessionState();
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error',
                                        text: response.error || 'Failed to save',
                                        text: response.error || 'Failed to save'
                                    });
                                }
                            }
                        });
                    }

                    // Button handlers
                    $('#btnStart').on('click', function () {
                        var $btn = $(this);
                        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i>Starting...');

                        $.ajax({
                            type: 'POST',
                            url: '../../api/jury/session',
                            data: { action: 'startScoring', eventID: eventID },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Started',
                                        timer: 1500,
                                        showConfirmButton: false,
                                        showConfirmButton: false
                                    });
                                }
                                pollSessionState();
                            },
                            complete: function () {
                                $btn.prop('disabled', false).html('<i class="fas fa-play me-1"></i>Start');
                            }
                        });
                    });

                    $('#btnAdvance').on('click', function () {
                        var $btn = $(this);
                        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i>Next...');

                        $.ajax({
                            type: 'POST',
                            url: '../../api/jury/session',
                            data: { action: 'advanceGymnast', eventID: eventID },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    if (response.competitionComplete) {
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Complete!',
                                            text: 'All gymnasts scored',
                                            text: 'All gymnasts scored'
                                        });
                                    }
                                }
                                pollSessionState();
                            },
                            complete: function () {
                                $btn.prop('disabled', false).html('<i class="fas fa-forward me-1"></i>Next');
                            }
                        });
                    });

                    $('#btnForce').on('click', function () {
                        Swal.fire({
                            title: 'Force Submit All?',
                            text: 'Missing scores will be set to 0',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#f59e0b',
                            cancelButtonColor: '#6b7280',
                            confirmButtonText: 'Yes',
                            confirmButtonText: 'Yes'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $.ajax({
                                    type: 'POST',
                                    url: '../../api/jury/session',
                                    data: { action: 'forceSubmitAll', eventID: eventID, sessionID: currentSessionID },
                                    dataType: 'json',
                                    success: function () {
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

                    $(window).on('beforeunload', function () {
                        if (pollInterval) clearInterval(pollInterval);
                    });
                });
            </script>
        </body>

        </html>