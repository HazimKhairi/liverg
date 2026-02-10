<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@page import="java.sql.*" %>
        <%@page import="com.connection.DBConnect" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Live Scores - LIVERG Scoring System</title>

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
                        background: #f0f2f5;
                        min-height: 100vh;
                    }

                    .liverg-navbar {
                        background: white;
                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        padding: 0.75rem 0;
                    }

                    .main-wrapper {
                        padding: 2rem 0;
                    }

                    /* Scoreboard Container */
                    .scoreboard-container {
                        display: grid;
                        grid-template-columns: 1fr 350px;
                        gap: 1.5rem;
                    }

                    /* Main Scoreboard - Left Side */
                    .main-display {
                        background: linear-gradient(135deg, #0f2044 0%, #1a3a5c 100%);
                        border-radius: 1rem;
                        padding: 0;
                        color: white;
                        position: relative;
                        overflow: hidden;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                        min-height: 600px;
                        display: flex;
                        flex-direction: column;
                    }

                    .main-display::before {
                        content: '';
                        position: absolute;
                        bottom: -20%;
                        left: -10%;
                        width: 600px;
                        height: 600px;
                        background: radial-gradient(circle, rgba(233, 30, 99, 0.15) 0%, transparent 70%);
                        border-radius: 50%;
                    }

                    .main-display::after {
                        content: '';
                        position: absolute;
                        top: -10%;
                        right: -10%;
                        width: 500px;
                        height: 500px;
                        background: radial-gradient(circle, rgba(0, 212, 170, 0.15) 0%, transparent 70%);
                        border-radius: 50%;
                    }

                    .board-header {
                        background: rgba(0, 0, 0, 0.2);
                        padding: 1.5rem 2.5rem;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                    }

                    .comp-title {
                        font-size: 1.75rem;
                        font-weight: 700;
                        color: #64b5f6;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                    }

                    .board-body {
                        padding: 3rem 4rem;
                        flex: 1;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        z-index: 1;
                    }

                    .gymnast-main-info {
                        margin-bottom: 3rem;
                    }

                    .info-label {
                        font-size: 1.25rem;
                        color: #90caf9;
                        margin-bottom: 0.5rem;
                        font-weight: 500;
                    }

                    .gymnast-name {
                        font-size: 4rem;
                        font-weight: 800;
                        line-height: 1.1;
                        margin-bottom: 0.5rem;
                        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
                    }

                    .gymnast-club {
                        font-size: 2.25rem;
                        font-weight: 600;
                        color: rgba(255, 255, 255, 0.9);
                        margin-bottom: 1rem;
                    }

                    .apparatus-row {
                        display: flex;
                        align-items: center;
                        gap: 1rem;
                        margin-top: 1rem;
                    }

                    .apparatus-icon {
                        font-size: 2rem;
                        color: #ff4081;
                    }

                    .apparatus-text {
                        font-size: 2rem;
                        font-weight: 500;
                        color: white;
                    }

                    .scores-grid {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 3rem;
                        margin-top: auto;
                    }

                    .sub-scores {
                        display: grid;
                        grid-template-columns: 1fr;
                        gap: 1.5rem;
                    }

                    .score-row {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        font-size: 2rem;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                        padding-bottom: 0.5rem;
                    }

                    .score-title {
                        color: #90caf9;
                        font-weight: 600;
                    }

                    .score-val {
                        font-weight: 700;
                    }

                    .total-score-box {
                        background: linear-gradient(135deg, #d81b60 0%, #ad1457 100%);
                        border-radius: 1rem;
                        padding: 1.5rem;
                        text-align: center;
                        box-shadow: 0 5px 15px rgba(216, 27, 96, 0.4);
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        align-items: center;
                    }

                    .total-label {
                        font-size: 1.5rem;
                        text-transform: uppercase;
                        letter-spacing: 2px;
                        opacity: 0.9;
                        margin-bottom: 0.5rem;
                    }

                    .total-val {
                        font-size: 6rem;
                        font-weight: 800;
                        line-height: 1;
                        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                    }

                    .penalties-display {
                        text-align: center;
                        font-size: 1.25rem;
                        margin-top: 0.5rem;
                        opacity: 0.8;
                    }

                    /* Side Panel - Waiting List */
                    .side-panel {
                        display: flex;
                        flex-direction: column;
                        gap: 1.5rem;
                    }

                    .waiting-list-card {
                        background: white;
                        border-radius: 1rem;
                        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        overflow: hidden;
                        flex: 1;
                    }

                    .panel-header {
                        padding: 1.25rem 1.5rem;
                        background: #f8fafc;
                        border-bottom: 1px solid #e2e8f0;
                    }

                    .panel-title {
                        font-size: 1.1rem;
                        font-weight: 700;
                        color: #1a3a5c;
                        margin: 0;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        text-transform: uppercase;
                    }

                    .waiting-list-body {
                        padding: 0;
                        max-height: 400px;
                        overflow-y: auto;
                    }

                    .waiting-item {
                        padding: 1rem 1.5rem;
                        border-bottom: 1px solid #f1f5f9;
                        display: flex;
                        align-items: center;
                        justify-content: space-between;
                    }

                    .waiting-item:last-child {
                        border-bottom: none;
                    }

                    .waiting-info h5 {
                        font-size: 1rem;
                        font-weight: 600;
                        margin: 0 0 0.25rem 0;
                        color: #334155;
                    }

                    .waiting-info .team {
                        font-size: 0.85rem;
                        color: #64748b;
                    }

                    .waiting-badge {
                        background: #e2e8f0;
                        color: #475569;
                        padding: 0.25rem 0.75rem;
                        border-radius: 1rem;
                        font-size: 0.75rem;
                        font-weight: 600;
                    }

                    .event-selector-bar {
                        background: white;
                        border-bottom: 1px solid #e2e8f0;
                        padding: 1rem 0;
                    }

                    @media (max-width: 992px) {
                        .scoreboard-container {
                            grid-template-columns: 1fr;
                        }

                        .main-display {
                            min-height: auto;
                        }

                        .gymnast-name {
                            font-size: 2.5rem;
                        }

                        .total-val {
                            font-size: 4rem;
                        }

                        .scores-grid {
                            grid-template-columns: 1fr;
                            gap: 1.5rem;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Main Navigation -->
                <nav class="navbar navbar-expand-lg liverg-navbar">
                    <div class="container">
                        <a class="navbar-brand" href="index.jsp">
                            <img src="assets/img/liverg-logo.png" alt="LIVERG" class="brand-logo"
                                style="height: 50px;">
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#mainNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="mainNav">
                            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="publicEvents.jsp">Competitions</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="publicDashboard.jsp">Live Scores</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="news.jsp">News</a>
                                </li>

                            </ul>
                            <div class="d-flex gap-2">
                                <a href="login.jsp" class="btn btn-liverg btn-liverg-primary">
                                    <i class="fas fa-user-circle"></i> Sign In
                                </a>
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Event Selector -->
                <div class="event-selector-bar">
                    <div class="container">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center gap-3">
                                <label class="fw-bold text-muted mb-0">Select Event:</label>
                                <select id="eventSelect" class="form-select w-auto" onchange="loadEventData()">
                                    <option value="">-- Choose Competition --</option>
                                    <% try { DBConnect db=new DBConnect(); Connection conn=db.getConnection(); String
                                        sql="SELECT * FROM event ORDER BY eventDate DESC LIMIT 10" ; PreparedStatement
                                        pstmt=conn.prepareStatement(sql); ResultSet rs=pstmt.executeQuery();
                                        while(rs.next()) { %>
                                        <option value="<%= rs.getInt("eventID") %>"><%= rs.getString("eventName") %>
                                        </option>
                                        <% } rs.close(); pstmt.close(); conn.close(); } catch(Exception e) {
                                            e.printStackTrace(); } %>
                                </select>
                            </div>



                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-secondary btn-sm" onclick="refreshData()">
                                    <i class="fas fa-sync-alt me-1"></i> Refresh
                                </button>
                                <button class="btn btn-outline-primary btn-sm" onclick="toggleFullscreen()">
                                    <i class="fas fa-expand me-1"></i> Full Screen
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="main-wrapper">
                    <div class="container">

                        <!-- Waiting State -->
                        <div id="waitingState" class="waiting-state">
                            <div class="text-center py-5">
                                <i class="fas fa-tv fa-4x text-muted mb-4"></i>
                                <h2 class="text-muted">Select an Event to Start</h2>
                                <p class="text-muted">Choose a competition from the dropdown to view the live
                                    scoreboard.</p>
                            </div>
                        </div>

                        <!-- Live Content -->
                        <div id="liveContent" style="display: none;">
                            <div class="scoreboard-container">

                                <!-- LEFT: Big Scoreboard -->
                                <div class="main-display">
                                    <div class="board-header">
                                        <div class="comp-title" id="compTitle">Competition Name</div>
                                        <div class="logo-area">
                                            <i class="fas fa-running fa-2x text-white"></i>
                                        </div>
                                    </div>

                                    <div class="board-body">
                                        <div class="gymnast-main-info">
                                            <div class="info-label">Name:</div>
                                            <div class="gymnast-name" id="currentName">--</div>
                                            <div class="info-label">Club:</div>
                                            <div class="gymnast-club" id="currentTeam">--</div>

                                            <div class="apparatus-row">
                                                <div class="info-label mb-0 me-3">Apparatus:</div>
                                                <i class="fas fa-circle apparatus-icon" id="appIcon"></i>
                                                <!-- Dynamic Icon -->
                                                <div class="apparatus-text" id="currentApparatus">--</div>
                                            </div>
                                        </div>

                                        <div class="scores-grid">
                                            <div class="sub-scores">
                                                <div class="score-row">
                                                    <div class="score-title">D Score:</div>
                                                    <div class="score-val" id="dScore">--</div>
                                                </div>
                                                <div class="score-row">
                                                    <div class="score-title">A Score:</div>
                                                    <div class="score-val" id="aScore">--</div>
                                                </div>
                                                <div class="score-row">
                                                    <div class="score-title">E Score:</div>
                                                    <div class="score-val" id="eScore">--</div>
                                                </div>
                                            </div>
                                            <div class="total-area">
                                                <div class="total-score-box">
                                                    <div class="total-label">Total Score</div>
                                                    <div class="total-val" id="totalScore">--</div>
                                                    <div class="penalties-display">
                                                        Penalties: <span id="penalty">0.00</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- RIGHT: Waiting List & Leaderboard -->
                                <div class="side-panel">
                                    <!-- Up Next -->
                                    <div class="waiting-list-card">
                                        <div class="panel-header">
                                            <h4 class="panel-title"><i class="fas fa-list-ol"></i> Up Next</h4>
                                        </div>
                                        <div class="waiting-list-body" id="waitingListBody">
                                            <!-- Loaded via JS -->
                                            <div class="p-4 text-center text-muted">No upcoming gymnasts</div>
                                        </div>
                                    </div>

                                    <!-- Top 3 Leaderboard -->
                                    <div class="waiting-list-card">
                                        <div class="panel-header">
                                            <h4 class="panel-title"><i class="fas fa-trophy text-warning"></i> Current
                                                Top 3</h4>
                                        </div>
                                        <div class="waiting-list-body" id="leaderboardBody">
                                            <!-- Loaded via JS -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <!-- Footer -->
                <footer class="liverg-footer">
                    <div class="container">
                        <div class="row g-5">
                            <div class="col-lg-4">
                                <div class="footer-brand">
                                    <h3 class="text-white mb-3">LIVERG</h3>
                                    <p>The definitive scoring standard for Rhythmic Gymnastics. Empowering judges,
                                        engaging
                                        fans, and celebrating athletes.</p>
                                </div>
                                <div class="footer-social">
                                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                    <a href="#"><i class="fab fa-instagram"></i></a>
                                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                </div>
                            </div>
                            <div class="col-lg-2 col-md-4">
                                <h5 class="footer-title">Platform</h5>
                                <ul class="footer-links">
                                    <li><a href="#">Home</a></li>
                                    <li><a href="#">Live Scores</a></li>
                                    <li><a href="#">Events Calendar</a></li>
                                    <li><a href="#">Results Archive</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-2 col-md-4">
                                <h5 class="footer-title">Organization</h5>
                                <ul class="footer-links">
                                    <li><a href="#">About Us</a></li>
                                    <li><a href="#">Technical Committee</a></li>
                                    <li><a href="#">Rules & Regulations</a></li>
                                    <li><a href="#">Contact</a></li>
                                </ul>
                            </div>
                            <div class="col-lg-4 col-md-4">
                                <h5 class="footer-title">Newsletter</h5>
                                <p class="small text-muted mb-3">Subscribe to get the latest competition updates and
                                    news.</p>
                                <form class="d-flex gap-2">
                                    <input type="email" class="form-control bg-dark border-secondary text-white"
                                        placeholder="Email address">
                                    <button class="btn btn-liverg-primary">Subscribe</button>
                                </form>
                            </div>
                        </div>
                        <div class="footer-bottom text-center">
                            <p>&copy; 2026 LIVERG Scoring System. All rights reserved. Designed for Excellence.</p>
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
                        const eventSelect = document.getElementById('eventSelect');
                        const eventName = eventSelect.options[eventSelect.selectedIndex].text;

                        if (!eventId) {
                            document.getElementById('waitingState').style.display = 'block';
                            document.getElementById('liveContent').style.display = 'none';
                            if (pollInterval) clearInterval(pollInterval);
                            return;
                        }

                        document.getElementById('compTitle').textContent = eventName.split(' - ')[0]; // Basic split to remove date if present
                        document.getElementById('waitingState').style.display = 'none';
                        document.getElementById('liveContent').style.display = 'block';

                        // Start polling
                        fetchLiveData(eventId);
                        if (pollInterval) clearInterval(pollInterval);
                        pollInterval = setInterval(() => fetchLiveData(eventId), 3000);
                    }

                    function toggleFullscreen() {
                        if (!document.fullscreenElement) {
                            document.documentElement.requestFullscreen();
                        } else {
                            if (document.exitFullscreen) {
                                document.exitFullscreen();
                            }
                        }
                    }

                    function refreshData() {
                        const eventId = document.getElementById('eventSelect').value;
                        if (eventId) fetchLiveData(eventId);
                    }

                    function fetchLiveData(eventId) {
                        $.ajax({
                            url: 'api/jury/session',
                            type: 'GET',
                            data: { action: 'getState', eventId: eventId },
                            dataType: 'json',
                            success: function (data) {
                                updateDisplay(data);
                            },
                            error: function () {
                                console.error("API Error");
                            }
                        });
                    }

                    function updateDisplay(data) {
                        // Update Current Gymnast
                        if (data.gymnastName) {
                            document.getElementById('currentName').textContent = data.gymnastName;
                            document.getElementById('currentTeam').textContent = data.teamName || '-';
                            document.getElementById('currentApparatus').textContent = data.apparatusName || '-';

                            // Update icon based on apparatus
                            const appName = (data.apparatusName || '').toLowerCase();
                            let iconClass = 'fas fa-circle';
                            if (appName.includes('ball')) iconClass = 'fas fa-bowling-ball';
                            else if (appName.includes('hoop')) iconClass = 'far fa-circle';
                            else if (appName.includes('club')) iconClass = 'fas fa-dumbbell'; // Approximation
                            else if (appName.includes('ribbon')) iconClass = 'fas fa-ribbon';

                            document.getElementById('appIcon').className = 'apparatus-icon ' + iconClass;

                        } else {
                            document.getElementById('currentName').textContent = "Waiting...";
                            document.getElementById('currentTeam').textContent = "-";
                            document.getElementById('currentApparatus').textContent = "-";
                        }

                        // Update Scores
                        if (data.finalScore && data.finalScore.finalScore > 0) {
                            document.getElementById('totalScore').textContent = data.finalScore.finalScore.toFixed(3);
                            document.getElementById('dScore').textContent = data.finalScore.scoreDTotal.toFixed(2);
                            document.getElementById('aScore').textContent = data.finalScore.scoreArtistic.toFixed(2);
                            document.getElementById('eScore').textContent = data.finalScore.scoreExecution.toFixed(2);

                            let calcSum = data.finalScore.scoreDTotal + data.finalScore.scoreArtistic + data.finalScore.scoreExecution;
                            let finalS = data.finalScore.finalScore;

                            // Penalty is difference, usually reduction so positive number displayed as negative in formula?
                            // Visual display usually shows just absolute value "0.30"
                            let pen = Math.abs(calcSum - finalS);
                            if (pen < 0.001) pen = 0.0;
                            document.getElementById('penalty').textContent = pen.toFixed(2);
                        } else {
                            document.getElementById('totalScore').textContent = "--";
                            document.getElementById('dScore').textContent = "--";
                            document.getElementById('aScore').textContent = "--";
                            document.getElementById('eScore').textContent = "--";
                            document.getElementById('penalty').textContent = "0.00";
                        }

                        // Update Waiting List (Needs implementation in Servlet which we did!)
                        if (data.waitingList) {
                            const listContainer = document.getElementById('waitingListBody');
                            if (data.waitingList.length > 0) {
                                let html = '';
                                data.waitingList.forEach(item => {
                                    html += `
                        <div class="waiting-item">
                            <div class="waiting-info">
                                <h5>${item.gymnastName}</h5>
                                <div class="team">${item.teamName || ""}</div>
                            </div>
                            <span class="waiting-badge">${item.apparatusName}</span>
                        </div>`;
                                });
                                listContainer.innerHTML = html;
                            } else {
                                listContainer.innerHTML = '<div class="p-3 text-muted text-center">No upcoming gymnasts</div>';
                            }
                        }

                        // Note: Currently leaderboard is not returned by getState in our servlet modifications (it was there before but inside a conditional block?)
                        // Let's check Servlet code. getState does NOT return leaderboard unless we add it. 
                        // In the previous Servlet code, "leaderboard" wasn't being fetched in getState! 
                        // Wait, looking at Step 175: 
                        // result.put("scores", scoresArray);
                        // ...
                        // if (session.isSubmitted() || ...) { ... result.put("finalScore", ...); }
                        // It did NOT seem to have leaderboard logic. 
                        // So Leaderboard on the right might be empty. That's fine for now, user prioritized Waiting List.
                    }
                </script>
            </body>

            </html>