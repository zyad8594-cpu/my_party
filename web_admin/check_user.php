<?php
require_once 'config/database.php';
$email = 'admin@myparty.com';
$stmt = $pdo->prepare('SELECT * FROM Users WHERE email = ?');
$stmt->execute([$email]);
$user = $stmt->fetch();
if ($user) {
    echo "User found: " . $user['email'] . " | Role ID: " . $user['role_id'] . "\n";
    // Also check role name
    $roleStmt = $pdo->prepare('SELECT role_name FROM Roles WHERE role_id = ?');
    $roleStmt->execute([$user['role_id']]);
    $role = $roleStmt->fetch();
    echo "Role: " . ($role['role_name'] ?? 'N/A') . "\n";
} else {
    echo "User NOT found.\n";
}
?>
