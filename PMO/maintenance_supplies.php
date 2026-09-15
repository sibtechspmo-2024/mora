<?php
session_start();
require_once 'db.php';

if (!isset($_SESSION['user_id']) || strtolower($_SESSION['role'] ?? '') !== 'user') {
    header("Location: index.php");
    exit;
}

$user_id = intval($_SESSION['user_id']);

// AJAX Handler para sa Maintenance Request
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['request_supply'])) {
    header('Content-Type: application/json');

    $requisitioner_name = trim($_POST['requisitioner_name'] ?? '');
    $department = trim($_POST['department'] ?? '');
    $purpose = trim($_POST['purpose'] ?? '');
    $date_needed = $_POST['date_needed'] ?? null;
    $item_ids = $_POST['item_id'] ?? [];
    $quantities = $_POST['quantity'] ?? [];

    if (!empty($item_ids) && is_array($item_ids)) {
        $request_group_id = 'MNT-' . date('YmdHis') . '-' . rand(100, 999);
        $stmt = $conn->prepare("INSERT INTO maintenance_requests (request_group_id, user_id, requisitioner_name, department, item_id, quantity, purpose, date_needed) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        $check_stock_stmt = $conn->prepare("SELECT actual_stocks, item_name FROM maintenance_items WHERE id = ?");

        $inserted_count = 0;
        $conn->begin_transaction();

        try {
            foreach ($item_ids as $index => $item_id) {
                $item_id = intval($item_id);
                $qty = intval($quantities[$index] ?? 0);

                if ($item_id > 0 && $qty > 0) {
                    $check_stock_stmt->bind_param("i", $item_id);
                    $check_stock_stmt->execute();
                    $chk_res = $check_stock_stmt->get_result()->fetch_assoc();

                    if (!$chk_res || $chk_res['actual_stocks'] < $qty) {
                        $iname = $chk_res['item_name'] ?? 'Selected Item';
                        throw new Exception("Kulang ang available stock para sa item na: " . $iname);
                    }

                    $stmt->bind_param("sississs", $request_group_id, $user_id, $requisitioner_name, $department, $item_id, $qty, $purpose, $date_needed);
                    $stmt->execute();
                    $inserted_count++;
                }
            }

            if ($inserted_count > 0) {
                $conn->commit();
                echo json_encode(['status' => 'success', 'message' => "Matagumpay na naisumite ang iyong Maintenance Request ($request_group_id)!"]);
                exit;
            } else {
                throw new Exception("Walang valid na item na naisumite.");
            }
        } catch (Exception $e) {
            $conn->rollback();
            echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
            exit;
        }
    }
    echo json_encode(['status' => 'error', 'message' => 'Pumili ng hindi bababa sa isang item.']);
    exit;
}

$maint_items = $conn->query("SELECT * FROM maintenance_items WHERE actual_stocks > 0 ORDER BY item_name ASC")->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maintenance Supplies Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/user_dashboard.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-warning text-dark sticky-top">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold text-dark d-flex align-items-center" href="user_dashboard.php">
            <img src="logo.jpg" alt="SIBTECH Logo" class="navbar-brand-logo rounded-circle border border-2 border-dark shadow-sm">
            <div class="lh-1 ms-1">
                <span class="fs-5 d-block fw-extrabold tracking-tight">MAINTENANCE SUPPLIES STORE</span>
            </div>
        </a>
        <div class="d-flex align-items-center gap-2">
            <a href="office_supplies.php" class="btn btn-outline-dark btn-sm rounded-pill px-3"><i class="bi bi-box-seam me-1"></i> Switch to Office Supplies</a>
            <a href="home.php" class="btn btn-dark btn-sm rounded-pill px-3"><i class="bi bi-house me-1"></i> Home</a>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 py-4">
    <div id="alert-box" class="alert d-none shadow-sm rounded-3"></div>

    <div class="hero-banner bg-warning bg-opacity-10 border border-warning">
        <div class="row align-items-center">
            <div class="col-lg-7 mb-3 mb-lg-0">
                <span class="badge bg-warning text-dark fw-extrabold mb-2 px-3 py-1 rounded-pill text-uppercase">Maintenance Portal</span>
                <h2 class="mb-2 text-dark">Select Maintenance Supplies</h2>
            </div>
            <div class="col-lg-5">
                <div class="input-group hero-search-box">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search item name..." onkeyup="filterItems()">
                    <button class="btn btn-warning text-dark" type="button"><i class="bi bi-search me-1"></i> Search</button>
                </div>
            </div>
        </div>
    </div>

    <form id="requestForm">
        <input type="hidden" name="request_supply" value="1">
        <div class="row g-4 mt-2">
            <div class="col-lg-8">
                <div id="maint-grid" class="row g-3">
                    <?php if(empty($maint_items)): ?>
                        <div class="col-12 text-center py-5 bg-white rounded-3 border">
                            <i class="bi bi-tools fs-1 text-muted d-block mb-2"></i>
                            <h6 class="fw-bold text-dark mb-0">NO available maintenance supply.</h6>
                        </div>
                    <?php endif; ?>
                    <?php foreach($maint_items as $item): ?>
                        <div class="col-sm-6 col-md-4 product-item" data-name="<?= strtolower(htmlspecialchars($item['item_name'])) ?>">
                            <div class="product-card">
                                <div class="img-wrapper">
                                    <span class="product-badge-stock bg-success text-white"><i class="bi bi-box-fill me-1"></i>Stock: <?= $item['actual_stocks'] ?></span>
                                    <?php if(!empty($item['image']) && file_exists('uploads/' . $item['image'])): ?>
                                        <img src="uploads/<?= htmlspecialchars($item['image']) ?>" class="product-img" alt="<?= htmlspecialchars($item['item_name']) ?>">
                                    <?php else: ?>
                                        <div class="text-secondary text-center py-3">
                                            <i class="bi bi-wrench fs-1 d-block opacity-50"></i>
                                            <span class="small text-muted fw-semibold">No Image Available</span>
                                        </div>
                                    <?php endif; ?>
                                </div>
                                <div class="card-body">
                                    <div class="product-title" title="<?= htmlspecialchars($item['item_name']) ?>"><?= htmlspecialchars($item['item_name']) ?></div>
                                    <div class="product-unit mb-3">Unit: <span class="badge bg-light text-dark border ms-1 fw-bold"><?= htmlspecialchars($item['unit']) ?></span></div>
                                    <button type="button" class="btn btn-warning text-dark w-100 fw-bold py-2" onclick="addToCart(<?= $item['id'] ?>, '<?= htmlspecialchars(addslashes($item['item_name'])) ?>', '<?= htmlspecialchars($item['unit']) ?>', <?= $item['actual_stocks'] ?>)">
                                        <i class="bi bi-cart-plus-fill me-1"></i> Add to Request
                                    </button>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>

            <!-- CART SECTION -->
            <div class="col-lg-4">
                <div class="card cart-card">
                    <div class="cart-header bg-warning text-dark d-flex justify-content-between align-items-center p-3">
                        <h5 class="mb-0 fw-bold"><i class="bi bi-cart3 me-2"></i>Maintenance Request Cart</h5>
                        <span class="badge bg-dark text-white rounded-pill fw-extrabold fs-6 shadow-sm" id="cart-count">0 items</span>
                    </div>
                    <div class="card-body p-4">
                        <div id="cart-list" class="cart-items-container mb-4" style="max-height: 320px; overflow-y: auto;">
                            <p class="text-center text-muted my-4 small" id="empty-cart-msg">
                                <i class="bi bi-cart-x fs-2 d-block text-secondary mb-1"></i> No selected supply
                            </p>
                        </div>
                        <button type="button" id="submitBtn" class="btn btn-warning text-dark w-100 fw-bold shadow-sm py-2" onclick="goToCheckoutPage()" disabled>
                            <i class="bi bi-arrow-right-circle-fill me-1"></i> Proceed to Checkout
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
let cart = {};

document.addEventListener("DOMContentLoaded", function() {
    loadCartFromStorage();
});

function loadCartFromStorage() {
    try {
        const stored = localStorage.getItem('sibtech_cart');
        if (stored) {
            const parsed = JSON.parse(stored);
            if (parsed && typeof parsed === 'object') {
                cart = parsed;
            }
        }
    } catch(e) {
        cart = {};
    }
    renderCart();
}

function filterItems() {
    const query = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('.product-item').forEach(item => {
        item.classList.toggle('d-none', !item.getAttribute('data-name').includes(query));
    });
}

function addToCart(id, name, unit, maxStock) {
    if (cart[id]) {
        if (cart[id].qty < maxStock) cart[id].qty++;
        else alert(`Mataas sa available stock (${maxStock}) ang iyong ii-order.`);
    } else {
        cart[id] = { id, name, unit, qty: 1, maxStock };
    }
    renderCart();
}

function updateQty(id, change) {
    if (cart[id]) {
        let newQty = cart[id].qty + change;
        if (newQty <= 0) delete cart[id];
        else if (newQty > cart[id].maxStock) alert(`Mataas sa available stock (${cart[id].maxStock}) ang iyong ii-order.`);
        else cart[id].qty = newQty;
    }
    renderCart();
}

function removeFromCart(id) {
    delete cart[id];
    renderCart();
}

function renderCart() {
    const cartList = document.getElementById('cart-list');
    const submitBtn = document.getElementById('submitBtn');
    const keys = Object.keys(cart);
    document.getElementById('cart-count').textContent = `${keys.length} items`;
    localStorage.setItem('sibtech_cart', JSON.stringify(cart));

    if (keys.length === 0) {
        cartList.innerHTML = `<p class="text-center text-muted my-4 small"><i class="bi bi-cart-x fs-2 d-block text-secondary mb-1"></i>No selected supply.</p>`;
        submitBtn.disabled = true;
        return;
    }

    submitBtn.disabled = false;
    let html = '';
    keys.forEach(id => {
        const item = cart[id];
        html += `
            <div class="cart-item d-flex align-items-center justify-content-between mb-2">
                <input type="hidden" name="item_id[]" value="${item.id}">
                <div class="me-2 text-truncate" style="max-width: 140px;">
                    <span class="cart-item-title d-block text-truncate">${item.name}</span>
                    <small class="text-muted fw-semibold">${item.unit}</small>
                </div>
                <div class="d-flex align-items-center gap-1">
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateQty(${item.id}, -1)">-</button>
                    <input type="number" name="quantity[]" value="${item.qty}" class="form-control form-control-sm text-center p-0 fw-bold border" style="width: 38px;" readonly>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="updateQty(${item.id}, 1)">+</button>
                    <button type="button" class="btn btn-sm btn-link text-danger p-0 ms-1" onclick="removeFromCart(${item.id})"><i class="bi bi-trash-fill fs-6"></i></button>
                </div>
            </div>`;
    });
    cartList.innerHTML = html;
}

function goToCheckoutPage() {
    window.location.href = 'place_order.php?type=maintenance';
}
</script>
</body>
</html>