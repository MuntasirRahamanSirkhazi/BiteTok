<?php
// Database configuration
$host = 'localhost';           // Or 127.0.0.1
$db   = 'bitetok';          // Replace with your actual database name
$user = 'root';                // Default for XAMPP
$pass = '';                    // Default password for root in XAMPP
$charset = 'utf8mb4';          // Supports emojis and special characters

// Data Source Name
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

// PDO options
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,   // Throws exceptions
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,         // Returns associative arrays
    PDO::ATTR_EMULATE_PREPARES   => false,                    // Uses native prepares
];

// Create the PDO connection
try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    // Uncomment this line if you want to confirm connection
    // echo "✅ Connected to DB successfully.";
} catch (PDOException $e) {
    // Return error to client
    http_response_code(500);
    echo json_encode(['error' => '❌ DB Connection Failed: ' . $e->getMessage()]);
    exit;
}
?>
