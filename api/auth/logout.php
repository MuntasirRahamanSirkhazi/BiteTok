<?php
// filepath: c:\xampp\htdocs\bitetok\api\auth\logout.php

// Start the session
session_start();

// Destroy the session
session_unset();
session_destroy();

// Redirect to the index page
header("Location: /bitetok/frontend/index.html");
exit;
?>