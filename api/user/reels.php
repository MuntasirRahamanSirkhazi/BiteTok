<?php
header('Content-Type: application/json');

// 1. DB connect
$conn = new mysqli("localhost", "root", "", "bitetok");
if ($conn->connect_error) {
  echo json_encode(["status" => "error", "message" => "Database connection failed"]);
  exit;
}

// 2. Fetch data
$sql = "SELECT * FROM reels ORDER BY created_at DESC";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
  $reels = [];
  while ($row = $result->fetch_assoc()) {
    $reels[] = $row;
  }
  echo json_encode(["status" => "success", "data" => $reels]);
} else {
  echo json_encode(["status" => "error", "message" => "No reels found"]);
}

$conn->close();
?>
