<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.DBConnect"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Scores - LIVERG Scoring System</title>

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
            background: #f0f2f5;
            min-height: 100vh;
        }

        .live-header {
            background: linear-gradient(135deg, #1a3a5c 0%, #2d5a8a 100%);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .live-indicator {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.375rem 0.75rem;
            background: rgba(239, 68, 68, 0.2);
            border-radius: 2rem;
            color: #ef4444;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .live-indicator::before {
            content: '';
            width: 8px;
            height: 8px;
            background: #ef4444;
            border-radius: 50%;
            animation: pulse 1.5s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .event-selector {
            background: white;
            padding: 1rem 2rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .event-select {
            max-width: 400px;
        }

        .event-select select {
            padding: 0.75rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: 0.5rem;
            font-size: 1rem;
            width: 100%;
            cursor: pointer;
            transition: all 0.2s;
        }

        .event-select select:focus {
            outline: none;
            border-color: #00d4aa;
        }

        .main-content {
            padding: 2rem;
        }

        /* Current Gymnast Card */
        .current-gymnast-card {
            background: linear-gradient(135deg, #1a3a5c 0%, #0d2840 100%);
            border-radius: 1rem;
            padding: 2rem;
            color: white;
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .current-gymnast-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 500px;
            height: 500px;
            background: linear-gradient(135deg, rgba(0, 212, 170, 0.2), rgba(233, 30, 140, 0.2));
            border-radius: 50%;
        }

        .gymnast-number {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #00d4aa, #00a88a);
            border-radius: 50%;
            font-size: 1.5rem;
            font-weight: 700;
            margin-right: 1.5rem;
        }

        .gymnast-info h2 {
            color: white;
            font-size: 2rem;
            margin-bottom: 0.25rem;
        }

        .gymnast-info .team-name {
            opacity: 0.8;
            font-size: 1.125rem;
        }

        .apparatus-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: rgba(255,255,255,0.15);
            border-radius: 2rem;
            font-size: 0.875rem;
            margin-top: 1rem;
        }

        .score-display {
            text-align: right;
            position: relative;
        }

        .current-score {
            font-family: 'Montserrat', sans-serif;
            font-size: 5rem;
            font-weight: 800;
            line-height: 1;
            background: linear-gradient(135deg, #00d4aa, #c8e632);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .score-label {
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            opacity: 0.7;
            margin-top: 0.5rem;
        }

        /* Score Breakdown */
        .score-breakdown {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
            position: relative;
        }

        .score-item {
            background: rgba(255,255,255,0.1);
            border-radius: 0.75rem;
            padding: 1rem;
            text-align: center;
        }

        .score-item-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            opacity: 0.7;
            margin-bottom: 0.25rem;
        }

        .score-item-value {
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* Leaderboard */
        .leaderboard-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .leaderboard-header {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .leaderboard-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #1a3a5c;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .leaderboard-body {
            max-height: 600px;
            overflow-y: auto;
        }

        .leaderboard-item {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #f1f5f9;
            transition: all 0.2s;
        }

        .leaderboard-item:hover {
            background: #f8fafc;
        }

        .leaderboard-item.current {
            background: linear-gradient(90deg, rgba(0, 212, 170, 0.1), transparent);
            border-left: 4px solid #00d4aa;
        }

        .leaderboard-item.gold {
            background: linear-gradient(90deg, rgba(255, 215, 0, 0.1), transparent);
        }

        .leaderboard-item.silver {
            background: linear-gradient(90deg, rgba(192, 192, 192, 0.1), transparent);
        }

        .leaderboard-item.bronze {
            background: linear-gradient(90deg, rgba(205, 127, 50, 0.1), transparent);
        }

        .rank {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
            margin-right: 1rem;
            background: #f1f5f9;
            color: #64748b;
        }

        .rank.gold { background: linear-gradient(135deg, #ffd700, #ffed4a); color: #7c5e00; }
        .rank.silver { background: linear-gradient(135deg, #c0c0c0, #e8e8e8); color: #5a5a5a; }
        .rank.bronze { background: linear-gradient(135deg, #cd7f32, #daa06d); color: #5c3a11; }

        .gymnast-details {
            flex: 1;
        }

        .gymnast-details h4 {
            font-size: 0.95rem;
            font-weight: 600;
            color: #1a3a5c;
            margin: 0 0 0.125rem 0;
        }

        .gymnast-details .team {
            font-size: 0.8rem;
            color: #64748b;
        }

        .gymnast-score {
            font-family: 'Montserrat', sans-serif;
            font-size: 1.25rem;
            font-weight: 700;
            color: #1a3a5c;
        }

        .gymnast-score.pending {
            color: #94a3b8;
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Jury Status */
        .jury-status-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: 1.5rem;
        }

        .jury-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(80px, 1fr));
            gap: 0.75rem;
            padding: 1.25rem;
        }

        .jury-item {
            text-align: center;
            padding: 0.75rem;
            background: #f8fafc;
            border-radius: 0.5rem;
        }

        .jury-item.submitted {
            background: rgba(16, 185, 129, 0.1);
        }

        .jury-item.waiting {
            background: rgba(245, 158, 11, 0.1);
        }

        .jury-position {
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            color: #64748b;
            margin-bottom: 0.25rem;
        }

        .jury-score {
            font-size: 1.125rem;
            font-weight: 700;
            color: #1a3a5c;
        }

        .jury-item.submitted .jury-score { color: #10b981; }
        .jury-item.waiting .jury-score { color: #f59e0b; }

        /* Footer */
        .public-footer {
            background: #1a3a5c;
            color: rgba(255,255,255,0.7);
            padding: 2rem;
            margin-top: 2rem;
        }

        /* Waiting State */
        .waiting-state {
            text-align: center;
            padding: 4rem 2rem;
        }

        .waiting-state i {
            font-size: 5rem;
            color: #cbd5e1;
            margin-bottom: 1.5rem;
        }

        .waiting-state h3 {
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        .waiting-state p {
            color: #94a3b8;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .current-gymnast-card .row {
                text-align: center;
            }

            .score-display {
                text-align: center;
                margin-top: 1.5rem;
            }

            .current-score {
                font-size: 3.5rem;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="live-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-3">
                    <a href="home.jsp" class="text-white text-decoration-none d-flex align-items-center gap-2">
                        <i class="fas fa-medal fa-lg" style="color: #00d4aa;"></i>
                        <span class="fw-bold" style="font-family: 'Montserrat', sans-serif;">LIVERG</span>
                    </a>
                    <span class="live-indicator">Live Scores</span>
                </div>
                <div class="d-flex align-items-center gap-3">
                    <a href="home.jsp" class="btn btn-sm" style="background: rgba(255,255,255,0.1); color: white; border-radius: 0.5rem;">
                        <i class="fas fa-home me-1"></i> Home
                    </a>
                    <a href="index.jsp" class="btn btn-sm" style="background: #00d4aa; color: white; border-radius: 0.5rem;">
                        <i class="fas fa-sign-in-alt me-1"></i> Login
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Event Selector -->
    <div class="event-selector">
        <div class="container">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div class="event-select">
                    <select id="eventSelect" onchange="loadEventData()">
                        <option value="">Select an Event</option>
                        <%
                            try {
                                DBConnect db = new DBConnect();
                                Connection conn = db.getConnection();
                                String sql = "SELECT * FROM EVENT ORDER BY eventDate DESC";
                                PreparedStatement pstmt = conn.prepareStatement(sql);
                                ResultSet rs = pstmt.executeQuery();
                                while(rs.next()) {
                        %>
                        <option value="<%= rs.getInt("eventID") %>"><%= rs.getString("eventName") %> - <%= rs.getString("eventDate") %></option>
                        <%
                                }
                                rs.close();
                                pstmt.close();
                                conn.close();
                            } catch(Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                </div>
                <div class="d-flex gap-2">
                    <button class="btn btn-sm" style="background: #f1f5f9; border-radius: 0.5rem;" onclick="refreshData()">
                        <i class="fas fa-sync-alt me-1"></i> Refresh
                    </button>
                    <button class="btn btn-sm" style="background: #f1f5f9; border-radius: 0.5rem;" onclick="toggleFullscreen()">
                        <i class="fas fa-expand me-1"></i> Fullscreen
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <!-- Waiting State (shown when no event selected) -->
            <div id="waitingState" class="waiting-state">
                <i class="fas fa-trophy"></i>
                <h3>Select an Event to View Live Scores</h3>
                <p>Choose an event from the dropdown above to see real-time competition results.</p>
            </div>

            <!-- Live Content (hidden by default) -->
            <div id="liveContent" style="display: none;">
                <div class="row">
                    <div class="col-lg-8">
                        <!-- Current Gymnast -->
                        <div class="current-gymnast-card">
                            <div class="row align-items-center">
                                <div class="col-lg-7">
                                    <div class="d-flex align-items-center flex-wrap">
                                        <div class="gymnast-number" id="currentNumber">1</div>
                                        <div class="gymnast-info">
                                            <h2 id="currentName">Loading...</h2>
                                            <div class="team-name" id="currentTeam">Team Name</div>
                                        </div>
                                    </div>
                                    <div class="apparatus-badge" id="currentApparatus">
                                        <i class="fas fa-circle"></i>
                                        <span>Ball</span>
                                    </div>

                                    <!-- Score Breakdown -->
                                    <div class="score-breakdown">
                                        <div class="score-item">
                                            <div class="score-item-label">Difficulty</div>
                                            <div class="score-item-value" id="dScore">-</div>
                                        </div>
                                        <div class="score-item">
                                            <div class="score-item-label">Artistry</div>
                                            <div class="score-item-value" id="aScore">-</div>
                                        </div>
                                        <div class="score-item">
                                            <div class="score-item-label">Execution</div>
                                            <div class="score-item-value" id="eScore">-</div>
                                        </div>
                                        <div class="score-item">
                                            <div class="score-item-label">Penalty</div>
                                            <div class="score-item-value" id="penalty">-</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-5">
                                    <div class="score-display">
                                        <div class="current-score" id="totalScore">--</div>
                                        <div class="score-label">Total Score</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Jury Status -->
                        <div class="jury-status-card">
                            <div class="leaderboard-header">
                                <h3 class="leaderboard-title">
                                    <i class="fas fa-gavel" style="color: #e91e8c;"></i>
                                    Jury Panel Status
                                </h3>
                                <span class="badge" style="background: #f1f5f9; color: #64748b;" id="juryStatusBadge">
                                    Waiting for scores...
                                </span>
                            </div>
                            <div class="jury-grid" id="juryGrid">
                                <div class="jury-item waiting">
                                    <div class="jury-position">D1</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">D2</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">A1</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">A2</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">E1</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">E2</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">E3</div>
                                    <div class="jury-score">--</div>
                                </div>
                                <div class="jury-item waiting">
                                    <div class="jury-position">E4</div>
                                    <div class="jury-score">--</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <!-- Leaderboard -->
                        <div class="leaderboard-card">
                            <div class="leaderboard-header">
                                <h3 class="leaderboard-title">
                                    <i class="fas fa-trophy" style="color: #f59e0b;"></i>
                                    Leaderboard
                                </h3>
                            </div>
                            <div class="leaderboard-body" id="leaderboardBody">
                                <div class="leaderboard-item gold">
                                    <div class="rank gold">1</div>
                                    <div class="gymnast-details">
                                        <h4>Loading...</h4>
                                        <div class="team">-</div>
                                    </div>
                                    <div class="gymnast-score">--</div>
                                </div>
                                <div class="leaderboard-item silver">
                                    <div class="rank silver">2</div>
                                    <div class="gymnast-details">
                                        <h4>Loading...</h4>
                                        <div class="team">-</div>
                                    </div>
                                    <div class="gymnast-score">--</div>
                                </div>
                                <div class="leaderboard-item bronze">
                                    <div class="rank bronze">3</div>
                                    <div class="gymnast-details">
                                        <h4>Loading...</h4>
                                        <div class="team">-</div>
                                    </div>
                                    <div class="gymnast-score">--</div>
                                </div>
                                <div class="leaderboard-item">
                                    <div class="rank">4</div>
                                    <div class="gymnast-details">
                                        <h4>Loading...</h4>
                                        <div class="team">-</div>
                                    </div>
                                    <div class="gymnast-score pending">Pending</div>
                                </div>
                                <div class="leaderboard-item">
                                    <div class="rank">5</div>
                                    <div class="gymnast-details">
                                        <h4>Loading...</h4>
                                        <div class="team">-</div>
                                    </div>
                                    <div class="gymnast-score pending">Pending</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="public-footer">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="fas fa-medal" style="color: #00d4aa;"></i>
                        <span class="fw-bold" style="font-family: 'Montserrat', sans-serif;">LIVERG</span>
                    </div>
                    <p class="mb-0" style="font-size: 0.875rem;">Professional Rhythmic Gymnastics Scoring System</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0" style="font-size: 0.875rem;">&copy; 2026 LIVERG. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let pollInterval = null;

        function loadEventData() {
            const eventId = document.getElementById('eventSelect').value;

            if (!eventId) {
                document.getElementById('waitingState').style.display = 'block';
                document.getElementById('liveContent').style.display = 'none';
                if (pollInterval) clearInterval(pollInterval);
                return;
            }

            document.getElementById('waitingState').style.display = 'none';
            document.getElementById('liveContent').style.display = 'block';

            // Start polling for live data
            fetchLiveData(eventId);

            if (pollInterval) clearInterval(pollInterval);
            pollInterval = setInterval(() => fetchLiveData(eventId), 3000);
        }

        function fetchLiveData(eventId) {
            // In a real implementation, this would fetch from your API
            // For demo purposes, showing static data
            console.log('Fetching data for event:', eventId);

            // Demo data - replace with actual AJAX calls
            $.ajax({
                url: 'api/jury/session',
                type: 'GET',
                data: { action: 'getState', eventId: eventId },
                dataType: 'json',
                success: function(data) {
                    updateDisplay(data);
                },
                error: function() {
                    // Show demo data if API not available
                    showDemoData();
                }
            });
        }

        function updateDisplay(data) {
            if (data.currentGymnast) {
                document.getElementById('currentName').textContent = data.currentGymnast.name;
                document.getElementById('currentTeam').textContent = data.currentGymnast.team;
                document.getElementById('currentNumber').textContent = data.currentGymnast.startOrder;
            }

            if (data.currentScore) {
                document.getElementById('totalScore').textContent = data.currentScore.total.toFixed(3);
                document.getElementById('dScore').textContent = data.currentScore.d || '-';
                document.getElementById('aScore').textContent = data.currentScore.a || '-';
                document.getElementById('eScore').textContent = data.currentScore.e || '-';
                document.getElementById('penalty').textContent = data.currentScore.penalty || '-';
            }

            if (data.leaderboard) {
                updateLeaderboard(data.leaderboard);
            }

            if (data.juryScores) {
                updateJuryStatus(data.juryScores);
            }
        }

        function showDemoData() {
            // Demo data for visualization
            document.getElementById('currentName').textContent = 'Maria Santos';
            document.getElementById('currentTeam').textContent = 'Team Malaysia';
            document.getElementById('currentNumber').textContent = '7';
            document.getElementById('totalScore').textContent = '23.450';
            document.getElementById('dScore').textContent = '8.200';
            document.getElementById('aScore').textContent = '8.100';
            document.getElementById('eScore').textContent = '7.550';
            document.getElementById('penalty').textContent = '-0.400';
        }

        function updateLeaderboard(leaderboard) {
            const container = document.getElementById('leaderboardBody');
            container.innerHTML = '';

            leaderboard.forEach((item, index) => {
                const rankClass = index === 0 ? 'gold' : index === 1 ? 'silver' : index === 2 ? 'bronze' : '';
                const itemClass = index === 0 ? 'gold' : index === 1 ? 'silver' : index === 2 ? 'bronze' : '';

                container.innerHTML += `
                    <div class="leaderboard-item ${itemClass}">
                        <div class="rank ${rankClass}">${index + 1}</div>
                        <div class="gymnast-details">
                            <h4>${item.name}</h4>
                            <div class="team">${item.team}</div>
                        </div>
                        <div class="gymnast-score ${item.score ? '' : 'pending'}">
                            ${item.score ? item.score.toFixed(3) : 'Pending'}
                        </div>
                    </div>
                `;
            });
        }

        function updateJuryStatus(scores) {
            const container = document.getElementById('juryGrid');
            container.innerHTML = '';

            Object.keys(scores).forEach(position => {
                const score = scores[position];
                const hasScore = score !== null && score !== undefined;

                container.innerHTML += `
                    <div class="jury-item ${hasScore ? 'submitted' : 'waiting'}">
                        <div class="jury-position">${position}</div>
                        <div class="jury-score">${hasScore ? score.toFixed(1) : '--'}</div>
                    </div>
                `;
            });
        }

        function refreshData() {
            const eventId = document.getElementById('eventSelect').value;
            if (eventId) {
                fetchLiveData(eventId);
            }
        }

        function toggleFullscreen() {
            if (!document.fullscreenElement) {
                document.documentElement.requestFullscreen();
            } else {
                document.exitFullscreen();
            }
        }

        // Auto-refresh indicator
        setInterval(() => {
            const indicator = document.querySelector('.live-indicator');
            if (indicator && pollInterval) {
                indicator.style.opacity = indicator.style.opacity === '0.5' ? '1' : '0.5';
            }
        }, 1500);
    </script>
</body>
</html>
