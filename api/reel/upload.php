<?php
// filepath: c:\xampp\htdocs\bitetok\api\reel\upload.php

// Include database connection
require_once '../../db/db_connect.php';

// Set response type to JSON
header("Content-Type: application/json");

// Check if request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Validate input
    $dish_name = trim($_POST['dish_name']);
    $media_type = trim($_POST['media_type']);
    $price = trim($_POST['price']);
    $description = trim($_POST['description']);
    $location = trim($_POST['location']);
    $media = $_FILES['media'];

    if (empty($dish_name) || empty($media_type) || empty($price) || empty($description) || empty($location) || empty($media)) {
        echo json_encode(['status' => 'error', 'message' => 'All fields are required.']);
        exit;
    }

    // Handle media upload
    $uploadDir = '../../uploads/';
    $mediaName = time() . '_' . basename($media['name']);
    $uploadPath = $uploadDir . $mediaName;

    if (!move_uploaded_file($media['tmp_name'], $uploadPath)) {
        echo json_encode(['status' => 'error', 'message' => 'Failed to upload media.']);
        exit;
    }

    try {
        // Insert reel data into the database
        $stmt = $pdo->prepare("INSERT INTO reels (dish_name, media_type, media_url, price, description, location, created_by) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$dish_name, $media_type, $mediaName, $price, $description, $location, $_SESSION['user_id']]);

        echo json_encode(['status' => 'success', 'message' => 'Media uploaded successfully!']);
    } catch (PDOException $e) {
        echo json_encode(['status' => 'error', 'message' => 'Failed to upload media: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method.']);
}
?>