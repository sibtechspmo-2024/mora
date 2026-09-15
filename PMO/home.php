<?php
session_start();
require_once 'db.php';

// Verification ng Session at Role
if (!isset($_SESSION['user_id']) || strtolower($_SESSION['role'] ?? '') !== 'user') {
    if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
        echo json_encode(['status' => 'error', 'message' => 'Unauthorized']);
        exit;
    }
    header("Location: index.php");
    exit;
}

$user_id = intval($_SESSION['user_id']);

// --- AJAX HANDLER PARA SA NOTIFICATIONS (GET) ---
if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['action']) && $_GET['action'] === 'get_notifications') {
    header('Content-Type: application/json');

    $notif_stmt = $conn->prepare("SELECT * FROM notifications WHERE user_id = ? ORDER BY id DESC LIMIT 10");
    $notif_stmt->bind_param("i", $user_id);
    $notif_stmt->execute();
    $notifications = $notif_stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    $unread_stmt = $conn->prepare("SELECT COUNT(*) as unread_count FROM notifications WHERE user_id = ? AND is_read = 0");
    $unread_stmt->bind_param("i", $user_id);
    $unread_stmt->execute();
    $unread_count = $unread_stmt->get_result()->fetch_assoc()['unread_count'] ?? 0;

    echo json_encode([
        'status' => 'success',
        'notifications' => $notifications,
        'unread_count' => $unread_count
    ]);
    exit;
}

// --- AJAX HANDLER PARA SA MARK AS READ (POST) ---
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['mark_read'])) {
    header('Content-Type: application/json');
    $update_notif = $conn->prepare("UPDATE notifications SET is_read = 1 WHERE user_id = ?");
    $update_notif->bind_param("i", $user_id);
    $update_notif->execute();
    echo json_encode(['status' => 'success']);
    exit;
}

// Fetch user data
$user_stmt = $conn->prepare("SELECT fullname FROM users WHERE id = ?");
$user_stmt->bind_param("i", $user_id);
$user_stmt->execute();
$default_fullname = $user_stmt->get_result()->fetch_assoc()['fullname'] ?? '';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SIBTECH - Home Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/user_dashboard.css">
    <link rel="manifest" href="manifest.json">
    <meta name="theme-color" content="#1b4f9c">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
    <link rel="apple-touch-icon" href="icons/icon-192.png">
</head>
<body class="dashboard-body">

<!-- HEADER NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom sticky-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold text-white d-flex align-items-center" href="home.php">
            <img src="logo.jpg" alt="SIBTECH Logo" class="navbar-brand-logo rounded-circle border border-2 border-white shadow-sm">
            <div class="lh-1 ms-2">
                <span class="fs-5 d-block fw-extrabold tracking-tight">SIBTECH PORTAL</span>
                <small class="fw-medium text-white-50" style="font-size: 0.75rem;">Supply & Facility Management System</small>
            </div>
        </a>

        <div class="d-flex align-items-center gap-3 ms-auto">
            <!-- NOTIFICATION DROPDOWN -->
            <div class="dropdown">
                <button class="btn btn-light btn-sm fw-bold position-relative dropdown-toggle rounded-pill px-3 text-dark border-0 shadow-sm" type="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-bell-fill text-primary me-1"></i> Notifications
                    <span id="notification-badge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger d-none">0</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-2" aria-labelledby="notificationDropdown" style="width: 330px; max-height: 400px; overflow-y: auto;" id="notification-list">
                    <li><h6 class="dropdown-header fw-bold text-dark">Notifications</h6></li>
                    <li><hr class="dropdown-divider my-1"></li>
                    <li><span class="dropdown-item text-muted small text-center py-3">Fetching notifications...</span></li>
                </ul>
            </div>

            <!-- USER INFO -->
            <span class="text-white d-none d-md-inline small fw-bold bg-white bg-opacity-10 px-3 py-1.5 rounded-pill border border-white border-opacity-25">
                <i class="bi bi-person-circle me-1"></i><?= htmlspecialchars($default_fullname) ?>
            </span>

            <!-- MY REQUESTS LINK -->
            <a href="request_history.php" class="btn btn-outline-light btn-sm fw-semibold rounded-pill px-3">
                <i class="bi bi-bag-check-fill me-1"></i> My Requests
            </a>

            <!-- LOGOUT BUTTON -->
            <a href="logout.php" class="btn btn-outline-light btn-sm fw-semibold rounded-pill px-3">
                <i class="bi bi-box-arrow-right me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="main-container d-flex align-items-center justify-content-center py-5">
    <div class="container" style="max-width: 1040px;">
        <!-- HOME PAGE 2x2 MAIN GRID -->
        <div class="row g-4 justify-content-center">
            <!-- CARD 1: Request office Supply -->
            <div class="col-12 col-md-6">
                <a href="office_supplies.php?type=office" class="text-decoration-none">
                    <div class="dashboard-tile-card active-blue-border">
                        <div class="tile-icon text-primary mb-3">
                            <i class="bi bi-box-seam"></i>
                        </div>
                        <h4 class="tile-title text-dark fw-bold">Request office Supply</h4>
                        <p class="tile-description text-muted">Requisition for paper, pens, desk accessories and official office supplies.</p>
                    </div>
                </a>
            </div>

            <!-- CARD 2: Request Maintenance Supply -->
            <div class="col-12 col-md-6">
                <a href="maintenance_supplies.php?type=maintenance" class="text-decoration-none">
                    <div class="dashboard-tile-card">
                        <div class="tile-icon text-warning mb-3">
                            <i class="bi bi-tools"></i>
                        </div>
                        <h4 class="tile-title text-dark fw-bold">Request Maintenance Supply</h4>
                        <p class="tile-description text-muted">Requisition for hardware tools, electrical, cleaning, and repair supplies.</p>
                    </div>
                </a>
            </div>

            <!-- CARD 3: Borrow Equipment -->
            <div class="col-12 col-md-6">
                <a href="borrow_items.php" class="text-decoration-none">
                    <div class="dashboard-tile-card">
                        <div class="tile-icon text-info mb-3">
                            <i class="bi bi-laptop"></i>
                        </div>
                        <h4 class="tile-title text-dark fw-bold">Borrow Equipment</h4>
                        <p class="tile-description text-muted">Request borrowing of projectors, sound systems, cables, and electronic devices.</p>
                    </div>
                </a>
            </div>

            <!-- CARD 4: Request Schedule for classrooms and facilities -->
            <div class="col-12 col-md-6">
                <a href="user_schedule.php" class="text-decoration-none">
                    <div class="dashboard-tile-card">
                        <div class="tile-icon text-success mb-3">
                            <i class="bi bi-calendar-event"></i>
                        </div>
                        <h4 class="tile-title text-dark fw-bold">Request Schedule for classrooms and facilities</h4>
                        <p class="tile-description text-muted">Book rooms, view whiteboard event schedules, and request facility reservations.</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
let lastNotifId = 0;
let isInitialized = false;

function requestNotificationPermission() {
    if ("Notification" in window) {
        if (Notification.permission !== "granted" && Notification.permission !== "denied") {
            Notification.requestPermission();
        }
    }
}

function loadNotifications() {
    fetch('home.php?action=get_notifications')
    .then(res => res.json())
    .then(data => {
        if (data.status === 'success') {
            const badge = document.getElementById('notification-badge');
            const list = document.getElementById('notification-list');

            if (data.unread_count > 0) {
                badge.textContent = data.unread_count;
                badge.classList.remove('d-none');
            } else {
                badge.classList.add('d-none');
            }

            if (data.notifications.length > 0) {
                const latest = data.notifications[0];
                if (!isInitialized) {
                    lastNotifId = latest.id;
                    isInitialized = true;
                } else if (latest.id > lastNotifId && latest.is_read == 0) {
                    const msgLower = latest.message.toLowerCase();
                    if (msgLower.includes('approve') || msgLower.includes('aprubado') || msgLower.includes('na-aprubahan')) {
                        if ("Notification" in window && Notification.permission === "granted") {
                            new Notification("Order Approved! 🎉", {
                                body: latest.message,
                                icon: "icons/icon-192.png"
                            });
                        }
                    }
                    lastNotifId = latest.id;
                }
            }

            let html = `<li><h6 class="dropdown-header d-flex justify-content-between align-items-center fw-bold"><span>Notifications</span> <button type="button" class="btn btn-link btn-sm p-0 text-decoration-none small text-primary fw-bold" onclick="markAllAsRead()">Mark all as read</button></h6></li>`;
            html += '<li><hr class="dropdown-divider my-1"></li>';

            if (data.notifications.length === 0) {
                html += '<li><span class="dropdown-item text-muted small text-center py-3">No notifications.</span></li>';
            } else {
                data.notifications.forEach(n => {
                    let bgClass = n.is_read == 0 ? 'bg-light fw-bold' : '';
                    html += `<li><a class="dropdown-item small py-2 border-bottom ${bgClass}" href="#">${n.message}<br><small class="text-muted" style="font-size: 0.7rem;">${n.created_at}</small></a></li>`;
                });
            }
            list.innerHTML = html;
        }
    }).catch(err => console.error('Error fetching notifications:', err));
}

function markAllAsRead() {
    let formData = new FormData();
    formData.append('mark_read', '1');
    fetch('home.php', { method: 'POST', body: formData })
    .then(res => res.json())
    .then(data => {
        if(data.status === 'success') {
            loadNotifications();
        }
    });
}

document.addEventListener('DOMContentLoaded', () => {
    requestNotificationPermission();
    loadNotifications();
    setInterval(loadNotifications, 4000);

    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('sw.js').catch(err => console.log('SW registration failed:', err));
    }
});
</script>
</body>
</html>