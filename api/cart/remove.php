<?php
session_start();
require_once '../../db/db_connect.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
  echo json_encode(['status' => 'error', 'message' => 'User not logged in.']);
  exit;
}

if (!isset($_POST['item_id'])) {
  echo json_encode(['status' => 'error', 'message' => 'Missing item_id']);
  exit;
}

$user_id = $_SESSION['user_id'];
$item_id = $_POST['item_id'];

try {
  $stmt = $pdo->prepare("DELETE FROM cart_items WHERE id = ? AND user_id = ?");
  $stmt->execute([$item_id, $user_id]);

  if ($stmt->rowCount() > 0) {
    echo json_encode(['status' => 'success', 'message' => 'Item removed from cart']);
  } else {
    echo json_encode(['status' => 'error', 'message' => 'Item not found or unauthorized']);
  }
} catch (PDOException $e) {
  echo json_encode(['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()]);
}
