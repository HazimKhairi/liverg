<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@page import="java.util.*" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <link rel="icon" type="image/png" href="../../assets/img/favicon.png">
            <title>Start List Management | LIVERG</title>

            <!-- Bootstrap 5 -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Google Fonts -->
            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Montserrat:wght@600;700;800&display=swap"
                rel="stylesheet">
            <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <!-- Select2 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
                .page-header {
                    background: var(--bg-white);
                    border-bottom: 1px solid var(--border-color);
                    padding: 0.75rem 1.5rem;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    flex-shrink: 0;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .header-left {
                    display: flex;
                    align-items: center;
                    gap: 1rem;
                }

                .brand {
                    font-family: 'Montserrat', sans-serif;
                    font-weight: 800;
                    font-size: 1.25rem;
                }

                .brand .live {
                    color: var(--primary-cyan);
                }

                .brand .rg {
                    color: var(--primary-magenta);
                }

                .page-title {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    font-size: 0.95rem;
                    font-weight: 600;
                    color: var(--text-primary);
                    padding-left: 1rem;
                    border-left: 2px solid var(--border-color);
                }

                .page-title i {
                    color: var(--primary-cyan);
                }

                .header-actions {
                    display: flex;
                    gap: 0.5rem;
                }

                .btn-action {
                    padding: 0.5rem 1rem;
                    border: none;
                    border-radius: 0.5rem;
                    font-family: 'Inter', sans-serif;
                    font-size: 0.8rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    display: flex;
                    align-items: center;
                    gap: 0.4rem;
                }

                .btn-action:hover:not(:disabled) {
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                }

                .btn-primary-action {
                    background: var(--primary-cyan);
                    color: white;
                }

                .btn-success-action {
                    background: var(--success);
                    color: white;
                }

                .btn-warning-action {
                    background: var(--warning);
                    color: white;
                }

                .btn-secondary-action {
                    background: var(--bg-light);
                    color: var(--text-primary);
                    border: 1px solid var(--border-color);
                }

                .btn-secondary-action:hover {
                    background: var(--border-color);
                }

                /* Main Container */
                .main-container {
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                    padding: 1rem 1.5rem;
                    min-height: 0;
                    overflow: hidden;
                }

                /* Filters Section */
                .filters-section {
                    background: var(--bg-white);
                    border-radius: 0.75rem;
                    padding: 1rem 1.25rem;
                    margin-bottom: 1rem;
                    border: 1px solid var(--border-color);
                    flex-shrink: 0;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .filters-row {
                    display: flex;
                    gap: 1rem;
                    align-items: flex-end;
                }

                .filter-group {
                    flex: 1;
                    min-width: 120px;
                }

                .filter-group label {
                    display: block;
                    font-size: 0.7rem;
                    color: var(--text-secondary);
                    margin-bottom: 0.4rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.03em;
                }

                .filter-group select {
                    width: 100%;
                    padding: 0.5rem 0.75rem;
                    border: 1px solid var(--border-color);
                    border-radius: 0.5rem;
                    background: var(--bg-white);
                    color: var(--text-primary);
                    font-family: 'Inter', sans-serif;
                    font-size: 0.85rem;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .filter-group select:focus {
                    outline: none;
                    border-color: var(--primary-cyan);
                    box-shadow: 0 0 0 3px rgba(0, 212, 170, 0.1);
                }

                /* Main Content Grid */
                .main-content {
                    flex: 1;
                    display: grid;
                    grid-template-columns: 1fr 300px;
                    gap: 1rem;
                    min-height: 0;
                    overflow: hidden;
                }

                /* Card Styles */
                .card {
                    background: var(--bg-white);
                    border-radius: 0.75rem;
                    border: 1px solid var(--border-color);
                    display: flex;
                    flex-direction: column;
                    overflow: hidden;
                    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                }

                .card-header {
                    background: var(--bg-light);
                    padding: 0.875rem 1.25rem;
                    font-weight: 600;
                    font-size: 0.9rem;
                    color: var(--text-primary);
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    border-bottom: 1px solid var(--border-color);
                    flex-shrink: 0;
                }

                .card-header i {
                    color: var(--primary-cyan);
                    margin-right: 0.5rem;
                }

                .card-header .badge {
                    background: var(--primary-cyan);
                    color: white;
                    padding: 0.25rem 0.75rem;
                    border-radius: 1rem;
                    font-size: 0.75rem;
                    font-weight: 600;
                }

                .card-body {
                    padding: 1rem;
                    flex: 1;
                    overflow-y: auto;
                    min-height: 0;
                }

                /* Start List */
                .start-list {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                }

                .start-list-item {
                    display: flex;
                    align-items: center;
                    padding: 0.75rem 1rem;
                    background: var(--bg-light);
                    border-radius: 0.5rem;
                    margin-bottom: 0.5rem;
                    cursor: grab;
                    transition: all 0.2s ease;
                    border: 1px solid transparent;
                }

                .start-list-item:hover {
                    border-color: var(--primary-cyan);
                    background: rgba(0, 212, 170, 0.05);
                }

                .start-list-item.sortable-ghost {
                    opacity: 0.4;
                    background: var(--primary-cyan);
                }

                .start-list-item.sortable-chosen {
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                    border-color: var(--primary-cyan);
                }

                .start-list-item.scored {
                    background: rgba(16, 185, 129, 0.1);
                    border-color: rgba(16, 185, 129, 0.3);
                }

                .drag-handle {
                    cursor: grab;
                    color: var(--text-muted);
                    margin-right: 0.75rem;
                    opacity: 0.5;
                    transition: opacity 0.2s;
                    font-size: 0.9rem;
                }

                .start-list-item:hover .drag-handle {
                    opacity: 1;
                }

                .item-order {
                    width: 32px;
                    height: 32px;
                    background: var(--primary-cyan);
                    color: white;
                    border-radius: 0.4rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-family: 'Montserrat', sans-serif;
                    font-weight: 700;
                    font-size: 0.85rem;
                    margin-right: 0.75rem;
                    flex-shrink: 0;
                }

                .item-info {
                    flex: 1;
                    min-width: 0;
                }

                .item-name {
                    font-weight: 600;
                    font-size: 0.9rem;
                    color: var(--text-primary);
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .item-details {
                    font-size: 0.75rem;
                    color: var(--text-secondary);
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    flex-wrap: wrap;
                    margin-top: 0.25rem;
                }

                .item-apparatus {
                    background: rgba(139, 92, 246, 0.15);
                    color: var(--primary-purple);
                    padding: 0.15rem 0.5rem;
                    border-radius: 1rem;
                    font-size: 0.7rem;
                    font-weight: 600;
                }

                .item-score {
                    font-family: 'Montserrat', sans-serif;
                    font-size: 1rem;
                    font-weight: 700;
                    color: var(--success);
                    margin-right: 0.75rem;
                    min-width: 55px;
                    text-align: right;
                }

                .item-score.pending {
                    color: var(--text-muted);
                }

                .item-actions {
                    display: flex;
                    gap: 0.4rem;
                }

                .btn-icon {
                    width: 30px;
                    height: 30px;
                    border: none;
                    border-radius: 0.4rem;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.2s ease;
                    font-size: 0.8rem;
                }

                .btn-icon-delete {
                    background: rgba(239, 68, 68, 0.1);
                    color: var(--danger);
                }

                .btn-icon-delete:hover:not(:disabled) {
                    background: var(--danger);
                    color: white;
                }

                .btn-icon:disabled {
                    opacity: 0.3;
                    cursor: not-allowed;
                }

                /* Empty State */
                .empty-state {
                    text-align: center;
                    padding: 3rem 1rem;
                    color: var(--text-secondary);
                }

                .empty-state i {
                    font-size: 3rem;
                    margin-bottom: 1rem;
                    color: var(--text-muted);
                }

                .empty-state p {
                    margin: 0.3rem 0;
                    font-size: 0.9rem;
                }

                /* Sidebar */
                .sidebar {
                    display: flex;
                    flex-direction: column;
                    gap: 1rem;
                    min-height: 0;
                    overflow: hidden;
                }

                .sidebar .card {
                    flex-shrink: 0;
                }

                .sidebar .card:last-child {
                    flex: 1;
                    min-height: 0;
                }

                /* Stats Grid */
                .stats-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 0.75rem;
                }

                .stat-item {
                    background: var(--bg-light);
                    border-radius: 0.5rem;
                    padding: 0.75rem;
                    text-align: center;
                    border: 1px solid var(--border-color);
                }

                .stat-value {
                    font-family: 'Montserrat', sans-serif;
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--primary-cyan);
                }

                .stat-label {
                    font-size: 0.7rem;
                    color: var(--text-secondary);
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    margin-top: 0.25rem;
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
                    border-color: var(--primary-cyan);
                }

                .quick-link:hover i {
                    color: white;
                }

                .quick-link:last-child {
                    margin-bottom: 0;
                }

                .quick-link i {
                    width: 18px;
                    text-align: center;
                    font-size: 0.85rem;
                    color: var(--primary-cyan);
                }

                /* Custom Scrollbar */
                ::-webkit-scrollbar {
                    width: 6px;
                }

                ::-webkit-scrollbar-track {
                    background: var(--bg-light);
                }

                ::-webkit-scrollbar-thumb {
                    background: var(--border-color);
                    border-radius: 3px;
                }

                ::-webkit-scrollbar-thumb:hover {
                    background: var(--text-muted);
                }

                /* Responsive */
                @media (max-width: 992px) {
                    .main-content {
                        grid-template-columns: 1fr;
                    }

                    .sidebar {
                        display: none;
                    }
                }

                @media (max-width: 768px) {
                    .filters-row {
                        flex-wrap: wrap;
                    }

                    .filter-group {
                        min-width: calc(50% - 0.5rem);
                    }

                    .header-actions {
                        flex-wrap: wrap;
                    }
                }

                /* SweetAlert Custom Form Styles */
                .swal-add-form { text-align: left; }
                .swal-header { display: flex; align-items: center; gap: 12px; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #f1f5f9; }
                .swal-header-icon { width: 48px; height: 48px; background: linear-gradient(135deg, #00d4aa 0%, #00b894 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px; box-shadow: 0 4px 12px rgba(0, 212, 170, 0.3); }
                .swal-header-text h3 { margin: 0; font-size: 18px; font-weight: 700; color: #1e293b; }
                .swal-header-text p { margin: 4px 0 0; font-size: 13px; color: #64748b; }
                .swal-form-group { margin-bottom: 16px; }
                .swal-form-group:last-child { margin-bottom: 0; }
                .swal-form-label { display: flex; align-items: center; gap: 8px; font-size: 12px; font-weight: 600; color: #475569; margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
                .swal-form-label i { color: #00d4aa; font-size: 14px; width: 16px; text-align: center; }
                .swal-form-select, .swal-form-input { width: 100%; padding: 12px 14px; border: 2px solid #e2e8f0; border-radius: 10px; font-size: 14px; color: #1e293b; background: #f8fafc; transition: all 0.2s ease; }
                .swal-form-select { cursor: pointer; appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2364748b' d='M6 8L1 3h10z'/%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 14px center; }
                .swal-form-select:hover, .swal-form-input:hover { border-color: #cbd5e1; background-color: #ffffff; }
                .swal-form-select:focus, .swal-form-input:focus { outline: none; border-color: #00d4aa; background-color: #ffffff; box-shadow: 0 0 0 4px rgba(0, 212, 170, 0.1); }
                .swal-form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
                .swal-divider { height: 1px; background: #e2e8f0; margin: 24px 0; position: relative; }
                .swal-divider-text { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: #fff; padding: 0 10px; color: #64748b; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }
                
                /* Select2 Custom Styling to match Inputs */
                .select2-container { width: 100% !important; text-align: left; }
                .select2-container .select2-selection--single { height: 46px; border: 2px solid #e2e8f0; border-radius: 10px; background: #f8fafc; transition: all 0.2s ease; box-sizing: border-box; }
                .select2-container--default .select2-selection--single .select2-selection__rendered { line-height: 42px; padding-left: 14px; color: #1e293b; font-size: 14px; }
                .select2-container--default .select2-selection--single .select2-selection__arrow { height: 44px; right: 8px; }
                
                /* Select2 Hover State */
                .select2-container--default .select2-selection--single:hover { border-color: #cbd5e1; background-color: #ffffff; }
                
                /* Select2 Focus/Open State */
                .select2-container--open .select2-selection--single, 
                .select2-container--focus .select2-selection--single { border-color: #00d4aa !important; background-color: #ffffff !important; box-shadow: 0 0 0 4px rgba(0, 212, 170, 0.1); outline: none; }
                
                /* Dropdown Styling */
                .select2-dropdown { border: 1px solid #e2e8f0; border-radius: 10px; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); overflow: hidden; z-index: 9999; }
                .select2-results__option { padding: 8px 14px; font-size: 14px; }
                .select2-container--default .select2-results__option--highlighted[aria-selected] { background-color: #00d4aa; }
                .select2-search--dropdown .select2-search__field { border-radius: 6px; border: 1px solid #e2e8f0; padding: 6px 10px; }
                .select2-search--dropdown .select2-search__field:focus { border-color: #00d4aa; outline: none; }
            </style>
        </head>

        <body>
            <!-- Header -->
            <header class="page-header">
                <div class="header-left">
                    <div class="brand"><span class="live">LIVE</span><span class="rg">RG</span></div>
                    <div class="page-title">
                        <i class="fas fa-list-ol"></i>
                        Start List Management
                    </div>
                </div>
                <div class="header-actions">
                    <button class="btn-action btn-secondary-action" id="btnBack">
                        <i class="fas fa-arrow-left"></i>
                        Back
                    </button>
                    <button class="btn-action btn-warning-action" id="btnRandomize">
                        <i class="fas fa-random"></i>
                        Randomize
                    </button>
                    <button class="btn-action btn-primary-action" id="btnAddGymnast">
                        <i class="fas fa-plus"></i>
                        Add
                    </button>
                    <button class="btn-action btn-success-action" id="btnSaveOrder">
                        <i class="fas fa-save"></i>
                        Save
                    </button>
                </div>
            </header>

            <!-- Main Container -->
            <div class="main-container">
                <!-- Filters -->
                <div class="filters-section">
                    <div class="filters-row">
                        <div class="filter-group">
                            <label>Day</label>
                            <select id="filterDay">
                                <option value="0">All Days</option>
                                <option value="1">Day 1</option>
                                <option value="2">Day 2</option>
                                <option value="3">Day 3</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>Batch</label>
                            <select id="filterBatch">
                                <option value="0">All Batches</option>
                                <option value="1">Batch 1</option>
                                <option value="2">Batch 2</option>
                                <option value="3">Batch 3</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>Category</label>
                            <select id="filterCategory">
                                <option value="">All Categories</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>School</label>
                            <select id="filterSchool">
                                <option value="">All Schools</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>Apparatus</label>
                            <select id="filterApparatus">
                                <option value="0">All Apparatus</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <!-- Start List Card -->
                    <div class="card">
                        <div class="card-header">
                            <span><i class="fas fa-users"></i>Start Order</span>
                            <span class="badge" id="totalCount">0 entries</span>
                        </div>
                        <div class="card-body">
                            <div id="startListContainer">
                                <div class="empty-state">
                                    <i class="fas fa-clipboard-list"></i>
                                    <p>No entries in start list</p>
                                    <p>Add gymnasts to create the start order</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Sidebar -->
                    <div class="sidebar">
                        <!-- Statistics -->
                        <div class="card">
                            <div class="card-header">
                                <span><i class="fas fa-chart-bar"></i>Statistics</span>
                            </div>
                            <div class="card-body">
                                <div class="stats-grid">
                                    <div class="stat-item">
                                        <div class="stat-value" id="statTotal">0</div>
                                        <div class="stat-label">Total</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-value" id="statScored">0</div>
                                        <div class="stat-label">Scored</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-value" id="statPending">0</div>
                                        <div class="stat-label">Pending</div>
                                    </div>
                                    <div class="stat-item">
                                        <div class="stat-value" id="statBatches">0</div>
                                        <div class="stat-label">Batches</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Links -->
                        <div class="card">
                            <div class="card-header">
                                <span><i class="fas fa-link"></i>Quick Links</span>
                            </div>
                            <div class="card-body">
                                <a href="#" class="quick-link" id="linkBackend">
                                    <i class="fas fa-cogs"></i>
                                    Technical Backend
                                </a>
                                <a href="#" class="quick-link" id="linkMaster">
                                    <i class="fas fa-tv"></i>
                                    Master View
                                </a>
                                <a href="../jury/juryAccess.jsp" class="quick-link">
                                    <i class="fas fa-gavel"></i>
                                    Jury Access
                                </a>
                                <a href="../../registration/eventDetails.jsp" class="quick-link">
                                    <i class="fas fa-calendar-alt"></i>
                                    Back to Events
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
            <script>
                $(document).ready(function () {
                    var urlParams = new URLSearchParams(window.location.search);
                    var eventID = urlParams.get('eventID');

                    if (!eventID) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'No event ID provided',
                            confirmButtonColor: '#00d4aa'
                        }).then(function () {
                            window.history.back();
                        });
                        return;
                    }

                    var sortable = null;
                    var entries = [];
                    var gymnasts = [];
                    var allGymnasts = [];
                    var apparatus = [];
                    var teams = [];

                    // Set up quick links
                    $('#linkBackend').attr('href', '../backend/techBackend.jsp?eventID=' + eventID);
                    $('#linkMaster').attr('href', '../master/masterView.jsp?eventID=' + eventID);

                    // Back button
                    $('#btnBack').on('click', function () {
                        window.location.href = '../../registration/eventDetails.jsp';
                    });

                    // Load initial data
                    loadStartList();
                    loadGymnasts();
                    loadAllGymnasts();
                    loadApparatus();
                    loadTeams();

                    function loadStartList() {
                        $.ajax({
                            type: 'GET',
                            url: '../../api/jury/startlist',
                            data: {
                                eventID: eventID,
                                day: $('#filterDay').val(),
                                batch: $('#filterBatch').val(),
                                category: $('#filterCategory').val(),
                                school: $('#filterSchool').val(),
                                apparatusID: $('#filterApparatus').val()
                            },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    entries = response.entries;
                                    renderStartList();
                                    updateStats();
                                }
                            }
                        });
                    }

                    function loadGymnasts() {
                        $.ajax({
                            type: 'GET',
                            url: '../../api/jury/gymnasts',
                            data: { eventID: eventID },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    gymnasts = response.gymnasts;
                                    populateCategories();
                                    populateSchools();
                                }
                            }
                        });
                    }

                    function loadAllGymnasts() {
                        return $.ajax({
                            type: 'GET',
                            url: '../../api/jury/gymnasts',
                            data: { scope: 'all' },
                            dataType: 'json',
                            cache: false,
                            success: function (response) {
                                if (response.success) {
                                    allGymnasts = response.gymnasts;
                                }
                            }
                        });
                    }

                    function loadApparatus() {
                        $.ajax({
                            type: 'GET',
                            url: '../../api/jury/apparatus',
                            data: { eventID: eventID, scope: 'all' },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    apparatus = response.apparatus;
                                    populateApparatus();
                                }
                            }
                        });
                    }

                    function loadTeams() {
                        $.ajax({
                            type: 'GET',
                            url: '../../api/jury/teams',
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    teams = response.teams;
                                }
                            }
                        });
                    }

                    function populateCategories() {
                        var categories = [...new Set(gymnasts.map(g => g.category))];
                        var $select = $('#filterCategory');
                        $select.find('option:gt(0)').remove();
                        categories.forEach(function (cat) {
                            if (cat) {
                                $select.append('<option value="' + cat + '">' + cat + '</option>');
                            }
                        });
                    }

                    function populateSchools() {
                        var schools = [...new Set(gymnasts.map(g => g.school))];
                        var $select = $('#filterSchool');
                        $select.find('option:gt(0)').remove();
                        schools.forEach(function (sch) {
                            if (sch) {
                                $select.append('<option value="' + sch + '">' + sch + '</option>');
                            }
                        });
                    }

                    function populateApparatus() {
                        var $filter = $('#filterApparatus');
                        $filter.find('option:gt(0)').remove();
                        apparatus.forEach(function (app) {
                            $filter.append('<option value="' + app.apparatusID + '">' + app.apparatusName + '</option>');
                        });
                    }

                    function renderStartList() {
                        var $container = $('#startListContainer');

                        if (entries.length === 0) {
                            $container.html(
                                '<div class="empty-state">' +
                                '<i class="fas fa-clipboard-list"></i>' +
                                '<p>No entries in start list</p>' +
                                '<p>Add gymnasts to create the start order</p>' +
                                '</div>'
                            );
                            return;
                        }

                        var html = '<ul class="start-list" id="sortableList">';

                        entries.forEach(function (entry, index) {
                            var scoredClass = entry.isScored ? 'scored' : '';
                            var scoreClass = entry.finalScore ? '' : 'pending';
                            var scoreDisplay = entry.finalScore ? entry.finalScore.toFixed(3) : '-';

                            html += '<li class="start-list-item ' + scoredClass + '" data-id="' + entry.startListID + '">' +
                                '<i class="fas fa-grip-vertical drag-handle"></i>' +
                                '<div class="item-order">' + (index + 1) + '</div>' +
                                '<div class="item-info">' +
                                '<div class="item-name">' + entry.gymnastName + '</div>' +
                                '<div class="item-details">' +
                                '<span class="item-apparatus">' + entry.apparatusName + '</span>' +
                                '<span>' + entry.teamName + '</span>' +
                                '<span>Day ' + entry.competitionDay + ' | Batch ' + entry.batchNumber + '</span>' +
                                '</div>' +
                                '</div>' +
                                '<div class="item-score ' + scoreClass + '">' + scoreDisplay + '</div>' +
                                '<div class="item-actions">' +
                                '<button class="btn-icon btn-icon-delete" onclick="removeEntry(' + entry.startListID + ')" ' +
                                (entry.isScored ? 'disabled' : '') + '>' +
                                '<i class="fas fa-trash"></i>' +
                                '</button>' +
                                '</div>' +
                                '</li>';
                        });

                        html += '</ul>';
                        $container.html(html);

                        initSortable();
                    }

                    function initSortable() {
                        var el = document.getElementById('sortableList');
                        if (el) {
                            if (sortable) {
                                sortable.destroy();
                            }
                            sortable = new Sortable(el, {
                                handle: '.drag-handle',
                                animation: 150,
                                ghostClass: 'sortable-ghost',
                                chosenClass: 'sortable-chosen',
                                filter: '.scored',
                                onEnd: function (evt) {
                                    updateOrderNumbers();
                                }
                            });
                        }
                    }

                    function updateOrderNumbers() {
                        $('#sortableList .start-list-item').each(function (index) {
                            $(this).find('.item-order').text(index + 1);
                        });
                    }

                    function updateStats() {
                        var total = entries.length;
                        var scored = entries.filter(e => e.isScored).length;
                        var pending = total - scored;
                        var batches = [...new Set(entries.map(e => e.batchNumber))].length;

                        $('#statTotal').text(total);
                        $('#statScored').text(scored);
                        $('#statPending').text(pending);
                        $('#statBatches').text(batches);
                        $('#totalCount').text(total + ' entries');
                    }

                    // Filter change handlers
                    $('#filterDay, #filterBatch, #filterCategory, #filterSchool, #filterApparatus').on('change', function () {
                        loadStartList();
                    });

                    // Randomize button
                    $('#btnRandomize').on('click', function () {
                        Swal.fire({
                            title: 'Randomize Order?',
                            text: 'This will shuffle unscored entries within each batch.',
                            icon: 'question',
                            showCancelButton: true,
                            confirmButtonColor: '#f59e0b',
                            cancelButtonColor: '#64748b',
                            confirmButtonText: 'Yes, Randomize',
                            cancelButtonText: 'Cancel'
                        }).then(function (result) {
                            if (result.isConfirmed) {
                                var $btn = $('#btnRandomize');
                                $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> ...');

                                $.ajax({
                                    type: 'POST',
                                    url: '../../api/jury/startlist',
                                    data: { action: 'randomize', eventID: eventID },
                                    dataType: 'json',
                                    success: function (response) {
                                        if (response.success) {
                                            Swal.fire({
                                                icon: 'success',
                                                title: 'Randomized!',
                                                text: 'Start order has been randomized.',
                                                timer: 1500,
                                                showConfirmButton: false
                                            });
                                            loadStartList();
                                        } else {
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Error',
                                                text: response.error || 'Failed to randomize',
                                                confirmButtonColor: '#00d4aa'
                                            });
                                        }
                                    },
                                    complete: function () {
                                        $btn.prop('disabled', false).html('<i class="fas fa-random"></i> Randomize');
                                    }
                                });
                            }
                        });
                    });

                    // Save order button
                    $('#btnSaveOrder').on('click', function () {
                        var newOrder = [];
                        $('#sortableList .start-list-item').each(function (index) {
                            newOrder.push({
                                startListID: $(this).data('id'),
                                startOrder: index + 1
                            });
                        });

                        var $btn = $(this);
                        $btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> ...');

                        $.ajax({
                            type: 'POST',
                            url: '../../api/jury/startlist',
                            data: {
                                action: 'updateOrder',
                                eventID: eventID,
                                order: JSON.stringify(newOrder)
                            },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Saved!',
                                        text: 'Start order has been saved.',
                                        timer: 1500,
                                        showConfirmButton: false
                                    });
                                    loadStartList();
                                    loadApparatus();
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error',
                                        text: response.error || 'Failed to save order',
                                        confirmButtonColor: '#00d4aa'
                                    });
                                }
                            },
                            complete: function () {
                                $btn.prop('disabled', false).html('<i class="fas fa-save"></i> Save');
                            }
                        });
                    });

                    // Add gymnast button
                    $('#btnAddGymnast').on('click', function () {
                        openAddGymnastModal();
                    });

                    function openAddGymnastModal(prefillData = {}) {
                        Swal.fire({
                            title: '',
                            html:
                                '<div class="swal-add-form">' +
                                '<div class="swal-header">' +
                                '<div class="swal-header-icon"><i class="fas fa-user-plus"></i></div>' +
                                '<div class="swal-header-text">' +
                                '<h3>Add Gymnast to Start List</h3>' +
                                '<p>Search existing database or create new</p>' +
                                '</div>' +
                                '</div>' +
                                
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-medal"></i>Apparatus</label>' +
                                '<select id="swalApparatus" class="swal-form-select">' +
                                '<option value="">Select apparatus...</option>' +
                                apparatus.map(function (a) { return '<option value="' + a.apparatusID + '" ' + (prefillData.apparatusID == a.apparatusID ? 'selected' : '') + '>' + a.apparatusName + '</option>'; }).join('') +
                                '</select>' +
                                '</div>' +
                                '<div class="swal-form-row">' +
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-calendar-day"></i>Day</label>' +
                                '<select id="swalDay" class="swal-form-select">' +
                                '<option value="1" ' + (prefillData.day == "1" ? 'selected' : '') + '>Day 1</option>' +
                                '<option value="2" ' + (prefillData.day == "2" ? 'selected' : '') + '>Day 2</option>' +
                                '<option value="3" ' + (prefillData.day == "3" ? 'selected' : '') + '>Day 3</option>' +
                                '</select>' +
                                '</div>' +
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-layer-group"></i>Batch</label>' +
                                '<select id="swalBatch" class="swal-form-select">' +
                                '<option value="1" ' + (prefillData.batch == "1" ? 'selected' : '') + '>Batch 1</option>' +
                                '<option value="2" ' + (prefillData.batch == "2" ? 'selected' : '') + '>Batch 2</option>' +
                                '<option value="3" ' + (prefillData.batch == "3" ? 'selected' : '') + '>Batch 3</option>' +
                                '</select>' +
                                '</div>' +
                                '</div>' +
                                '<div class="swal-divider"><span class="swal-divider-text">Gymnast Details</span></div>' +
                                
                                // Existing Gymnast Section
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-search"></i>Select Existing Gymnast</label>' +
                                '<select id="swalGymnastSelect" class="swal-form-select">' +
                                '<option value="">Search for a gymnast...</option>' +
                                allGymnasts.map(function (g) { return '<option value="' + g.gymnastID + '">' + g.gymnastName + ' (' + (g.teamName || 'No Team') + ')</option>'; }).join('') +
                                '</select>' +
                                '</div>' +
                                '</div>',
                            showCancelButton: true,
                            confirmButtonColor: '#00d4aa',
                            cancelButtonColor: '#64748b',
                            confirmButtonText: '<i class="fas fa-plus" style="margin-right: 6px;"></i>Add to Start List',
                            cancelButtonText: 'Cancel',
                            width: 550,
                            didOpen: function() {
                                // Initialize Select2 for Apparatus
                                $('#swalApparatus').select2({
                                    dropdownParent: Swal.getContainer(),
                                    placeholder: 'Select or type apparatus...',
                                    width: '100%',
                                    tags: true
                                });

                                // Initialize Select2 for Gymnast Search
                                $('#swalGymnastSelect').select2({
                                    dropdownParent: Swal.getContainer(),
                                    placeholder: 'Search for a gymnast...',
                                    allowClear: true,
                                    width: '100%',
                                    language: {
                                        noResults: function() {
                                            return "No results found. <a href='#' id='btnCreateNewFromSearch' style='color:#00d4aa; font-weight:600; cursor:pointer;'>Create New</a>";
                                        }
                                    },
                                    escapeMarkup: function(markup) {
                                        return markup;
                                    }
                                });

                                // Pre-select gymnast if provided
                                if (prefillData.gymnastID) {
                                    if ($('#swalGymnastSelect').find("option[value='" + prefillData.gymnastID + "']").length) {
                                        $('#swalGymnastSelect').val(prefillData.gymnastID).trigger('change');
                                    } else if (prefillData.gymnastName) {
                                        // Fallback if option not found (e.g. not loaded yet)
                                        var newOption = new Option(prefillData.gymnastName + ' (New)', prefillData.gymnastID, true, true);
                                        $('#swalGymnastSelect').append(newOption).trigger('change');
                                    }
                                }

                                var currentSearchTerm = '';

                                function showCreateNew() {
                                    // Save current state
                                    var context = {
                                        apparatusID: $('#swalApparatus').val(),
                                        day: $('#swalDay').val(),
                                        batch: $('#swalBatch').val()
                                    };
                                    
                                    // Open Create New Modal
                                    openCreateNewGymnastModal(currentSearchTerm, context);
                                }

                                // Handle "Create New" click
                                $(document).off('mousedown', '#btnCreateNewFromSearch').on('mousedown', '#btnCreateNewFromSearch', function(e) {
                                    e.preventDefault();
                                    // Try to grab value one last time just in case
                                    var val = $('.select2-container--open .select2-search__field').val();
                                    if(val) currentSearchTerm = val;
                                    
                                    showCreateNew();
                                });

                                // Handle Search Input & Enter Key
                                $('#swalGymnastSelect').on('select2:open', function() {
                                    var $search = $('.select2-container--open .select2-search__field');
                                    
                                    // Capture search term as user types
                                    $search.off('input.capture').on('input.capture', function() {
                                        currentSearchTerm = $(this).val();
                                    });

                                    // Handle Enter key
                                    $search.off('keydown.createNew').on('keydown.createNew', function(e) {
                                        if (e.key === 'Enter') {
                                            // Only trigger if "Create New" link is visible (meaning no results)
                                            if ($('#btnCreateNewFromSearch').length > 0) {
                                                e.preventDefault();
                                                e.stopPropagation();
                                                showCreateNew();
                                            }
                                        }
                                    });
                                });
                            },
                            preConfirm: function () {
                                var apparatusID = document.getElementById('swalApparatus').value;
                                var day = document.getElementById('swalDay').value;
                                var batch = document.getElementById('swalBatch').value;

                                if (!apparatusID) {
                                    Swal.showValidationMessage('Please select an apparatus');
                                    return false;
                                }

                                var gymnastID = $('#swalGymnastSelect').val();
                                
                                if (gymnastID) {
                                    return {
                                        gymnastID: gymnastID,
                                        apparatusID: apparatusID,
                                        day: day,
                                        batch: batch
                                    };
                                } else {
                                    Swal.showValidationMessage('Please select a gymnast');
                                    return false;
                                }
                            }
                        }).then(function (result) {
                            if (result.isConfirmed) {
                                var data = result.value;
                                addGymnastToStartList(data.gymnastID, data.apparatusID, data.day, data.batch);
                            }
                        });
                    }

                    function openCreateNewGymnastModal(name, context) {
                        // Extract unique categories and schools from allGymnasts
                        var uniqueCategories = [...new Set(allGymnasts.map(function(g) { return g.category; }))].filter(Boolean).sort();
                        var uniqueSchools = [...new Set(allGymnasts.map(function(g) { return g.school; }))].filter(Boolean).sort();

                        Swal.fire({
                            title: '',
                            html:
                                '<div class="swal-add-form">' +
                                '<div class="swal-header">' +
                                '<div class="swal-header-icon"><i class="fas fa-user-plus"></i></div>' +
                                '<div class="swal-header-text">' +
                                '<h3>Create New Gymnast</h3>' +
                                '<p>Enter details for new gymnast</p>' +
                                '</div>' +
                                '</div>' +
                                
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-user-tag"></i>Name</label>' +
                                '<input id="swalName" class="swal-form-input" placeholder="Gymnast Name" value="' + (name || '') + '">' +
                                '</div>' +
                                '<div class="swal-form-row">' +
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-id-card"></i>IC / ID</label>' +
                                '<input id="swalIC" class="swal-form-input" placeholder="IC Number">' +
                                '</div>' +
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-users"></i>Team</label>' +
                                '<select id="swalTeam" class="swal-form-select">' +
                                '<option value="">Select or type team...</option>' +
                                teams.map(function (t) { return '<option value="' + t.teamID + '">' + t.teamName + '</option>'; }).join('') +
                                '</select>' +
                                '</div>' +
                                '</div>' +
                                '<div class="swal-form-row">' +
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-tag"></i>Category</label>' +
                                '<select id="swalCategory" class="swal-form-select">' +
                                '<option value="">Select or type category...</option>' +
                                uniqueCategories.map(function(c) { return '<option value="' + c + '">' + c + '</option>'; }).join('') +
                                '</select>' +
                                '</div>' +
                                '<div class="swal-form-group">' +
                                '<label class="swal-form-label"><i class="fas fa-school"></i>School</label>' +
                                '<select id="swalSchool" class="swal-form-select">' +
                                '<option value="">Select or type school...</option>' +
                                uniqueSchools.map(function(s) { return '<option value="' + s + '">' + s + '</option>'; }).join('') +
                                '</select>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                            showCancelButton: true,
                            confirmButtonColor: '#00d4aa',
                            cancelButtonColor: '#64748b',
                            confirmButtonText: '<i class="fas fa-save" style="margin-right: 6px;"></i>Create Gymnast',
                            cancelButtonText: 'Back',
                            width: 550,
                            didOpen: function() {
                                // Initialize Select2 for Team (with tags)
                                $('#swalTeam').select2({
                                    dropdownParent: Swal.getContainer(),
                                    placeholder: 'Select or type team...',
                                    width: '100%',
                                    tags: true
                                });

                                // Initialize Select2 for Category (with tags)
                                $('#swalCategory').select2({
                                    dropdownParent: Swal.getContainer(),
                                    placeholder: 'Select or type category...',
                                    width: '100%',
                                    tags: true
                                });

                                // Initialize Select2 for School (with tags)
                                $('#swalSchool').select2({
                                    dropdownParent: Swal.getContainer(),
                                    placeholder: 'Select or type school...',
                                    width: '100%',
                                    tags: true
                                });
                                
                                setTimeout(function() {
                                    $('#swalName').focus();
                                }, 200);
                            },
                            preConfirm: function () {
                                var name = document.getElementById('swalName').value;
                                var ic = document.getElementById('swalIC').value;
                                var team = $('#swalTeam').val();
                                var category = $('#swalCategory').val();
                                var school = $('#swalSchool').val();

                                if (!name || !ic || !team || !category) {
                                    Swal.showValidationMessage('Please fill in all required fields');
                                    return false;
                                }

                                return {
                                    name: name,
                                    ic: ic,
                                    team: team,
                                    category: category,
                                    school: school
                                };
                            }
                        }).then(function (result) {
                            if (result.isConfirmed) {
                                var data = result.value;
                                
                                // Create gymnast
                                $.ajax({
                                    type: 'POST',
                                    url: '../../api/jury/gymnasts',
                                    data: {
                                        gymnastName: data.name,
                                        gymnastIC: data.ic,
                                        teamID: data.team,
                                        gymnastCategory: data.category,
                                        gymnastSchool: data.school,
                                        eventID: eventID,
                                        apparatusID: context.apparatusID // Just for API compatibility, not used for linking here
                                    },
                                    dataType: 'json',
                                    success: function(response) {
                                        if (response.success) {
                                            // Refresh data
                                            loadGymnasts();
                                            loadTeams(); // Reload teams in case a new one was created
                                            
                                            loadAllGymnasts().then(function() {
                                                // Re-open original modal with new gymnast selected
                                                context.gymnastID = response.gymnastID;
                                                context.gymnastName = data.name; // Pass name for fallback
                                                openAddGymnastModal(context);
                                            });
                                        } else {
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Error',
                                                text: response.error || 'Failed to create gymnast'
                                            });
                                        }
                                    },
                                    error: function() {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Error',
                                            text: 'Server error creating gymnast'
                                        });
                                    }
                                });
                            } else if (result.dismiss === Swal.DismissReason.cancel) {
                                // Go back to original modal
                                openAddGymnastModal(context);
                            }
                        });
                    }

                    function addGymnastToStartList(gymnastID, apparatusID, day, batch) {
                        $.ajax({
                            type: 'POST',
                            url: '../../api/jury/startlist',
                            data: {
                                action: 'add',
                                eventID: eventID,
                                apparatusID: apparatusID,
                                batchNumber: batch,
                                competitionDay: day,
                                gymnastIDs: JSON.stringify([parseInt(gymnastID)])
                            },
                            dataType: 'json',
                            success: function (response) {
                                if (response.success) {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Added!',
                                        text: 'Gymnast added to start list.',
                                        timer: 1500,
                                        showConfirmButton: false
                                    });
                                    loadStartList();
                                    loadApparatus();
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Error',
                                        text: response.error || 'Failed to add gymnast to start list',
                                        confirmButtonColor: '#00d4aa'
                                    });
                                }
                            }
                        });
                    }

                    // Remove entry
                    window.removeEntry = function (startListID) {
                        Swal.fire({
                            title: 'Remove Entry?',
                            text: 'This gymnast will be removed from the start list.',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#ef4444',
                            cancelButtonColor: '#64748b',
                            confirmButtonText: 'Yes, Remove',
                            cancelButtonText: 'Cancel'
                        }).then(function (result) {
                            if (result.isConfirmed) {
                                $.ajax({
                                    type: 'POST',
                                    url: '../../api/jury/startlist',
                                    data: {
                                        action: 'remove',
                                        eventID: eventID,
                                        startListID: startListID
                                    },
                                    dataType: 'json',
                                    success: function (response) {
                                        if (response.success) {
                                            Swal.fire({
                                                icon: 'success',
                                                title: 'Removed!',
                                                text: 'Entry has been removed.',
                                                timer: 1500,
                                                showConfirmButton: false
                                            });
                                            loadStartList();
                                        } else {
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Error',
                                                text: response.error || 'Failed to remove entry',
                                                confirmButtonColor: '#00d4aa'
                                            });
                                        }
                                    }
                                });
                            }
                        });
                    };
                });
            </script>
        </body>

        </html>