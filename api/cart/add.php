<?php
// Start session
session_start();

// Include database connection
require_once '../../db/db_connect.php';

// Set response type to JSON
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if user is logged in
    if (!isset($_SESSION['user_id'])) {
        echo json_encode(['status' => 'error', 'message' => 'User not logged in.']);
        exit;
    }

    // Get item details from POST request
    $dish_name = trim($_POST['dish_name'] ?? '');
    $price = trim($_POST['price'] ?? '');
    $reel_id = trim($_POST['reel_id'] ?? '');
    $user_id = $_SESSION['user_id'];

    // Validate input
    if (empty($dish_name) || empty($price) || empty($reel_id)) {
        echo json_encode(['status' => 'error', 'message' => 'Invalid item details.']);
        exit;
    }

    try {
        // Make sure reel_id is an integer
        $reel_id = (int)$reel_id;

        // ✅ Check if the reel_id exists in the reels table
        $check = $pdo->prepare("SELECT id FROM reels WHERE id = ?");
        $check->execute([$reel_id]);

        if ($check->rowCount() === 0) {
            echo json_encode(['status' => 'error', 'message' => "Reel ID $reel_id does not exist in reels table."]);
            exit;
        }

        // ✅ Proceed with insert if reel exists
        $stmt = $pdo->prepare("INSERT INTO cart_items (dish_name, price, user_id, reel_id) VALUES (?, ?, ?, ?)");
        $stmt->execute([$dish_name, $price, $user_id, $reel_id]);

        echo json_encode(['status' => 'success', 'message' => 'Item added to cart successfully!']);
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'Failed to add item to cart: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method.']);
}
