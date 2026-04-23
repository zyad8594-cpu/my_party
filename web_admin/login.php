<?php
session_start();
require_once 'config/database.php';

// If already logged in, redirect
if (isset($_SESSION['admin_id'])) {
    header("Location: index.php");
    exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    if (empty($email) || empty($password)) {
        $error = 'Email and password are required.';
    } else {
        $stmt = $pdo->prepare('SELECT * FROM Users WHERE email = ? AND is_active = TRUE');
        $stmt->execute([$email]);
        $user = $stmt->fetch();

        if ($user && password_verify($password, $user['password'])) {
            $roleStmt = $pdo->prepare('SELECT role_name FROM Roles WHERE role_id = ?');
            $roleStmt->execute([$user['role_id']]);
            $role = $roleStmt->fetch();

            if ($role && $role['role_name'] === 'admin') {
                $_SESSION['admin_id'] = $user['user_id'];
                $_SESSION['admin_email'] = $user['email'];
                header("Location: index.php");
                exit;
            } else {
                $error = 'Access denied. Only administrators are allowed.';
            }
        } else {
            $error = 'Invalid email or password.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Party Pro - Login</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="login-page" style="height: 100vh; display: flex; align-items: center; justify-content: center; background: var(--background)">
        <div class="stat-card" style="width: 400px; padding: 2rem">
            <div style="text-align: center; margin-bottom: 2rem">
                <i data-lucide="layout-dashboard" style="color: var(--primary); width: 48px; height: 48px; display: inline-block;"></i>
                <h2 style="color: var(--text); margin-top: 1rem">My Party Pro</h2>
                <p style="color: var(--text-muted)">Sign in to continue</p>
            </div>

            <form method="POST" action="login.php" style="display: flex; flex-direction: column; gap: 1rem">
                <?php if ($error): ?>
                <div style="color: #ff4d4f; background: rgba(255, 77, 79, 0.1); padding: 0.8rem; border-radius: 4px; text-align: center">
                    <?php echo htmlspecialchars($error); ?>
                </div>
                <?php endif; ?>

                <div class="form-group">
                    <label style="display: block; margin-bottom: 0.5rem; color: var(--text)">Email</label>
                    <input type="email" name="email" class="form-control" required style="width: 100%" value="<?php echo htmlspecialchars($_POST['email'] ?? ''); ?>">
                </div>
                <div class="form-group">
                    <label style="display: block; margin-bottom: 0.5rem; color: var(--text)">Password</label>
                    <input type="password" name="password" class="form-control" required style="width: 100%">
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem">
                    Sign In
                </button>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            lucide.createIcons();
        });
    </script>
</body>
</html>
