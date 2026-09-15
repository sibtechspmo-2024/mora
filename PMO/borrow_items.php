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

// POST Handler para sa Borrow Request
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit_borrow_request'])) {
    header('Content-Type: application/json');

    try {
        $requisitioner_name = trim($_POST['requisitioner_name'] ?? '');
        $department = trim($_POST['department'] ?? '');
        $purpose = trim($_POST['purpose'] ?? '');
        $borrow_date = $_POST['borrow_date'] ?? date('Y-m-d', strtotime('+5 days'));
        $expected_return_date = $_POST['expected_return_date'] ?? date('Y-m-d', strtotime('+8 days'));
        $scheduled_time = trim($_POST['scheduled_time'] ?? '09:00 AM - 10:00 AM');

        $min_allowed_date = date('Y-m-d', strtotime('+5 days'));
        if (strtotime($borrow_date) < strtotime($min_allowed_date)) {
            throw new Exception("Bawal mag-request kung mas mababa sa 5 araw bago ang petsa ng paghiram. Mangyaring pumili ng petsa na hindi bababa sa 5 araw mula ngayon ($min_allowed_date).");
        }

        $item_ids = $_POST['item_id'] ?? [];
        $item_names = $_POST['item_name'] ?? [];
        $quantities = $_POST['quantity'] ?? [];

        if (empty($requisitioner_name) || empty($department)) {
            throw new Exception("Mangyaring punan ang iyong buong pangalan at departamento.");
        }

        if (empty($item_names) || !is_array($item_names)) {
            throw new Exception("Mangyaring maglagay ng hihiraming item.");
        }

        $request_group_id = 'BRW-' . date('YmdHis') . '-' . rand(100, 999);
        $inserted_count = 0;

        $stmt = $conn->prepare("INSERT INTO borrow_requests (request_group_id, user_id, requisitioner_name, department, item_id, item_name, quantity, borrow_date, expected_return_date, scheduled_time, purpose) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        foreach ($item_names as $idx => $iname) {
            $iname = trim($iname);
            $iid = intval($item_ids[$idx] ?? 0);
            $qty = intval($quantities[$idx] ?? 1);

            if (!empty($iname) && $qty > 0) {
                $stmt->bind_param("sissisissss", $request_group_id, $user_id, $requisitioner_name, $department, $iid, $iname, $qty, $borrow_date, $expected_return_date, $scheduled_time, $purpose);
                $stmt->execute();
                $inserted_count++;
            }
        }

        if ($inserted_count > 0) {
            echo json_encode([
                'status' => 'success',
                'message' => "Matagumpay na naipasa ang iyong borrow request ($request_group_id)!",
                'group_id' => $request_group_id
            ]);
            exit;
        } else {
            throw new Exception("Maglagay ng kahit isang valid na item na hihiramin.");
        }

    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        exit;
    }
}

// Fetch default fullname
$user_stmt = $conn->prepare("SELECT fullname FROM users WHERE id = ?");
$user_stmt->bind_param("i", $user_id);
$user_stmt->execute();
$default_fullname = $user_stmt->get_result()->fetch_assoc()['fullname'] ?? '';

// Fetch Office / Equipment Items with pictures
$catalog_items = $conn->query("SELECT * FROM items WHERE actual_stocks > 0 ORDER BY item_name ASC")->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borrow Equipment & Items - SIBTECH</title>
    <!-- Pure Bootstrap 5 CSS & Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="manifest" href="manifest.json">
    <meta name="theme-color" content="#0d6efd">
</head>
<body class="bg-light">

<!-- Navbar Pure Bootstrap -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary sticky-top shadow-sm">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold text-white d-flex align-items-center" href="home.php">
            <img src="logo.jpg" alt="SIBTECH Logo" class="rounded-circle border border-2 border-white me-2" style="width: 38px; height: 38px; object-fit: cover;">
            <span>SIBTECH BORROW PORTAL</span>
        </a>
        <div class="d-flex align-items-center gap-2">
            <a href="home.php" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-house-door-fill me-1"></i> Home
            </a>
            <a href="request_history.php" class="btn btn-outline-light btn-sm rounded-pill px-3">
                <i class="bi bi-clock-history me-1"></i> My Requests
            </a>
            <a href="logout.php" class="btn btn-light text-primary btn-sm fw-bold rounded-pill px-3 ms-2">
                <i class="bi bi-box-arrow-right me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 py-4">
    <div id="alert-box" class="alert d-none shadow-sm rounded-3 mb-4"></div>

    <!-- Header Banner -->
    <div class="card border-0 shadow-sm rounded-4 mb-4 bg-primary text-white">
        <div class="card-body p-4">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                <div>
                    <h3 class="fw-bold mb-1"><i class="bi bi-hand-holding-box me-2"></i>Borrow Equipment / Supplies</h3>
                    <p class="mb-0 text-white-50">Pumili ng gamit mula sa office supplies catalog o mag-dagdag ng sariling hihiraming gamit.</p>
                </div>
                <div>
                    <span class="badge bg-warning text-dark fw-bold px-3 py-2 fs-6 rounded-pill">
                        <i class="bi bi-shield-lock-fill me-1"></i> Official Borrower Requisition
                    </span>
                </div>
            </div>
        </div>
    </div>

    <form id="borrowForm">
        <input type="hidden" name="submit_borrow_request" value="1">

        <div class="row g-4">
            <!-- Borrower Information & Selected Borrow Items -->
            <div class="col-lg-7">
                <div class="card border-0 shadow-sm rounded-4 mb-4">
                    <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                        <h5 class="fw-bold text-dark mb-0"><i class="bi bi-person-vcard text-primary me-2"></i>Borrower Details</h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark">Requisitioner Full Name</label>
                                <input type="text" name="requisitioner_name" class="form-control fw-semibold" value="<?= htmlspecialchars($default_fullname) ?>" required placeholder="Buong Pangalan">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold text-dark">Department / Office</label>
                                <input type="text" name="department" class="form-control fw-semibold" required placeholder="e.g. SPMO, HR, IT, Faculty">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Borrow Start Date (At least 5 days in advance)</label>
                                <input type="date" name="borrow_date" class="form-control fw-semibold" value="<?= date('Y-m-d', strtotime('+5 days')) ?>" min="<?= date('Y-m-d', strtotime('+5 days')) ?>" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Expected Return Date</label>
                                <input type="date" name="expected_return_date" class="form-control fw-semibold" value="<?= date('Y-m-d', strtotime('+8 days')) ?>" min="<?= date('Y-m-d', strtotime('+5 days')) ?>" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold text-dark">Preferred Time Slot</label>
                                <select name="scheduled_time" class="form-select fw-semibold" required>
                                    <option value="08:00 AM - 09:00 AM">08:00 AM - 09:00 AM</option>
                                    <option value="09:00 AM - 10:00 AM" selected>09:00 AM - 10:00 AM</option>
                                    <option value="10:00 AM - 11:00 AM">10:00 AM - 11:00 AM</option>
                                    <option value="11:00 AM - 12:00 PM">11:00 AM - 12:00 PM</option>
                                    <option value="01:00 PM - 02:00 PM">01:00 PM - 02:00 PM</option>
                                    <option value="02:00 PM - 03:00 PM">02:00 PM - 03:00 PM</option>
                                    <option value="03:00 PM - 04:00 PM">03:00 PM - 04:00 PM</option>
                                    <option value="04:00 PM - 05:00 PM">04:00 PM - 05:00 PM</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-semibold text-dark">Purpose of Borrowing</label>
                                <input type="text" name="purpose" class="form-control fw-semibold" required placeholder="e.g. Event setup, Class presentation, Maintenance project">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Selected Items List Card -->
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-header bg-white border-0 pt-4 px-4 pb-0 d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold text-dark mb-0"><i class="bi bi-list-check text-primary me-2"></i>Mga Hihiraming Items / Kagamitan</h5>
                        <button type="button" class="btn btn-outline-primary btn-sm rounded-pill fw-bold px-3" onclick="addCustomRow()">
                            <i class="bi bi-plus-circle me-1"></i> Manual Input Item
                        </button>
                    </div>
                    <div class="card-body p-4">
                        <div class="table-responsive rounded-3 border mb-3">
                            <table class="table table-hover align-middle mb-0" id="borrowItemsTable">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width: 70px;">Picture</th>
                                        <th>Item / Equipment Description</th>
                                        <th style="width: 140px;">Quantity</th>
                                        <th class="text-end" style="width: 80px;">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="borrow-items-tbody">
                                    <!-- Items will be dynamically added here -->
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-between align-items-center pt-2">
                            <a href="home.php" class="btn btn-outline-secondary rounded-pill px-4 fw-bold">
                                <i class="bi bi-arrow-left me-1"></i> Bumalik sa Home
                            </a>
                            <button type="submit" id="submitBtn" class="btn btn-primary btn-lg rounded-pill px-5 fw-bold shadow-sm" disabled>
                                <i class="bi bi-send-fill me-2"></i> Submit Borrow Request
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Catalog Section with Pictures -->
            <div class="col-lg-5">
                <div class="card border-0 shadow-sm rounded-4 sticky-top" style="top: 80px;">
                    <div class="card-header bg-white border-0 pt-4 px-4 pb-0">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-boxes text-primary me-2"></i>Available Supplies & Equipment</h5>
                            <span class="badge bg-primary rounded-pill"><?= count($catalog_items) ?> available</span>
                        </div>
                        <div class="input-group my-2">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" id="catalogSearch" class="form-control bg-light border-start-0" placeholder="Maghanap ng gamit..." onkeyup="filterCatalog()">
                        </div>
                    </div>
                    <div class="card-body p-4" style="max-height: 540px; overflow-y: auto;">
                        <div class="row g-3" id="catalogGrid">
                            <?php if(empty($catalog_items)): ?>
                                <div class="col-12 text-center py-4 text-muted">
                                    <i class="bi bi-box-seam fs-2 d-block mb-2"></i>
                                    Walang available na supplies sa inventory.
                                </div>
                            <?php endif; ?>

                            <?php foreach($catalog_items as $item): ?>
                                <?php
                                $img_src = (!empty($item['image']) && file_exists('uploads/' . $item['image']))
                                    ? 'uploads/' . htmlspecialchars($item['image'])
                                    : '';
                                ?>
                                <div class="col-sm-6 catalog-card-item" data-name="<?= strtolower(htmlspecialchars($item['item_name'])) ?>">
                                    <div class="card h-100 border rounded-3 overflow-hidden shadow-sm">
                                        <div class="position-relative bg-light text-center py-2" style="height: 120px; display: flex; align-items: center; justify-content: center;">
                                            <?php if($img_src): ?>
                                                <img src="<?= $img_src ?>" alt="<?= htmlspecialchars($item['item_name']) ?>" class="img-fluid mh-100 p-1" style="object-fit: contain;">
                                            <?php else: ?>
                                                <div class="text-secondary opacity-50">
                                                    <i class="bi bi-box fs-1 d-block"></i>
                                                    <small class="fw-bold">No Image</small>
                                                </div>
                                            <?php endif; ?>
                                            <span class="position-absolute top-0 end-0 m-2 badge bg-success text-white">Stock: <?= $item['actual_stocks'] ?></span>
                                        </div>
                                        <div class="card-body p-3 d-flex flex-column justify-content-between">
                                            <div>
                                                <h6 class="fw-bold text-dark mb-1 text-truncate" title="<?= htmlspecialchars($item['item_name']) ?>"><?= htmlspecialchars($item['item_name']) ?></h6>
                                                <small class="text-muted d-block mb-2">Unit: <span class="badge bg-light text-dark border"><?= htmlspecialchars($item['unit']) ?></span></small>
                                            </div>
                                            <button type="button" class="btn btn-outline-primary btn-sm rounded-pill w-100 fw-bold" onclick="addCatalogItem(<?= $item['id'] ?>, '<?= htmlspecialchars(addslashes($item['item_name'])) ?>', '<?= $img_src ?>', <?= $item['actual_stocks'] ?>)">
                                                <i class="bi bi-plus-lg me-1"></i> Add to Request
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
let selectedBorrowItems = {};

function filterCatalog() {
    const q = document.getElementById('catalogSearch').value.toLowerCase();
    document.querySelectorAll('.catalog-card-item').forEach(el => {
        const name = el.getAttribute('data-name') || '';
        el.classList.toggle('d-none', !name.includes(q));
    });
}

function addCatalogItem(id, name, imgSrc, maxStock) {
    if (selectedBorrowItems[id]) {
        if (selectedBorrowItems[id].qty < maxStock) {
            selectedBorrowItems[id].qty++;
        } else {
            alert(`Mataas sa available stock (${maxStock}) ang iyong ii-order.`);
        }
    } else {
        selectedBorrowItems[id] = {
            id: id,
            name: name,
            imgSrc: imgSrc,
            qty: 1,
            maxStock: maxStock,
            isCustom: false
        };
    }
    renderTable();
}

function addCustomRow() {
    const customId = 'custom_' + Date.now();
    selectedBorrowItems[customId] = {
        id: 0,
        name: '',
        imgSrc: '',
        qty: 1,
        maxStock: 999,
        isCustom: true,
        tempKey: customId
    };
    renderTable();
}

function updateCustomName(key, val) {
    if (selectedBorrowItems[key]) {
        selectedBorrowItems[key].name = val;
    }
    checkSubmitState();
}

function updateItemQty(key, val) {
    val = parseInt(val) || 1;
    if (selectedBorrowItems[key]) {
        if (!selectedBorrowItems[key].isCustom && val > selectedBorrowItems[key].maxStock) {
            alert(`Ang maximum available stock ay ${selectedBorrowItems[key].maxStock}`);
            val = selectedBorrowItems[key].maxStock;
        }
        selectedBorrowItems[key].qty = val;
    }
    renderTable();
}

function removeBorrowItem(key) {
    delete selectedBorrowItems[key];
    renderTable();
}

function checkSubmitState() {
    const submitBtn = document.getElementById('submitBtn');
    const keys = Object.keys(selectedBorrowItems);
    let valid = false;

    if (keys.length > 0) {
        for (let k of keys) {
            if (selectedBorrowItems[k].name && selectedBorrowItems[k].name.trim() !== '' && selectedBorrowItems[k].qty > 0) {
                valid = true;
                break;
            }
        }
    }
    submitBtn.disabled = !valid;
}

function renderTable() {
    const tbody = document.getElementById('borrow-items-tbody');
    const keys = Object.keys(selectedBorrowItems);

    if (keys.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="4" class="text-center text-muted py-4">
                    <i class="bi bi-basket fs-3 d-block text-secondary mb-1"></i>
                    Walang hihiraming item na nakapili. Pumili mula sa available supplies sa kanan o mag-input ng manual item.
                </td>
            </tr>`;
        checkSubmitState();
        return;
    }

    let html = '';
    keys.forEach(key => {
        const item = selectedBorrowItems[key];
        const imgTd = item.imgSrc
            ? `<img src="${item.imgSrc}" alt="${item.name}" class="rounded border" style="width: 45px; height: 45px; object-fit: contain;">`
            : `<div class="bg-light rounded border text-muted d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;"><i class="bi bi-box fs-5 opacity-50"></i></div>`;

        if (item.isCustom) {
            html += `
                <tr>
                    <td>${imgTd}</td>
                    <td>
                        <input type="hidden" name="item_id[]" value="0">
                        <input type="text" name="item_name[]" class="form-control fw-semibold" value="${item.name}" placeholder="i-type ang pangalan ng gamit (e.g. Projector, Sound System)" oninput="updateCustomName('${key}', this.value)" required>
                    </td>
                    <td>
                        <input type="number" name="quantity[]" value="${item.qty}" min="1" class="form-control text-center fw-bold" onchange="updateItemQty('${key}', this.value)" required>
                    </td>
                    <td class="text-end">
                        <button type="button" class="btn btn-outline-danger btn-sm rounded-pill px-3" onclick="removeBorrowItem('${key}')">
                            <i class="bi bi-trash-fill"></i>
                        </button>
                    </td>
                </tr>`;
        } else {
            html += `
                <tr>
                    <td>${imgTd}</td>
                    <td>
                        <input type="hidden" name="item_id[]" value="${item.id}">
                        <input type="hidden" name="item_name[]" value="${item.name}">
                        <span class="fw-bold text-dark d-block">${item.name}</span>
                        <small class="text-muted">Stock: ${item.maxStock}</small>
                    </td>
                    <td>
                        <input type="number" name="quantity[]" value="${item.qty}" min="1" max="${item.maxStock}" class="form-control text-center fw-bold" onchange="updateItemQty('${key}', this.value)" required>
                    </td>
                    <td class="text-end">
                        <button type="button" class="btn btn-outline-danger btn-sm rounded-pill px-3" onclick="removeBorrowItem('${key}')">
                            <i class="bi bi-trash-fill"></i>
                        </button>
                    </td>
                </tr>`;
        }
    });

    tbody.innerHTML = html;
    checkSubmitState();
}

document.getElementById('borrowForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const alertBox = document.getElementById('alert-box');

    fetch('borrow_items.php', { method: 'POST', body: new FormData(this) })
    .then(res => res.json())
    .then(data => {
        if(data.status === 'success') {
            alertBox.className = 'alert alert-success shadow-sm rounded-3 fw-bold';
            alertBox.textContent = data.message;
            alertBox.classList.remove('d-none');
            selectedBorrowItems = {};
            renderTable();
            this.reset();
            setTimeout(() => {
                window.location.href = 'request_history.php';
            }, 1500);
        } else {
            alertBox.className = 'alert alert-danger shadow-sm rounded-3 fw-bold';
            alertBox.textContent = data.message;
            alertBox.classList.remove('d-none');
        }
    });
});
</script>
</body>
</html>