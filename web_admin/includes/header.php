<?php
session_start();

$current_page = basename($_SERVER['PHP_SELF']);
if (!isset($_SESSION['admin_id']) && $current_page !== 'login.php') {
    header("Location: login.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Party Pro - Admin</title>
    <link rel="stylesheet" href="assets/css/style.css">
    
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div id="root">
        <div class="app-container">
