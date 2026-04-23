<?php
require_once 'includes/header.php';
require_once 'config/database.php';
require_once 'includes/sidebar.php';

// Fetch stats using direct PDO queries
try {
    $totalEvents = $pdo->query('SELECT COUNT(*) FROM Events')->fetchColumn() ?: 0;
    
    // For completed tasks we assume a Tasks table exists. Fallback if it doesn't.
    try {
        $completedTasks = $pdo->query("SELECT COUNT(*) FROM Tasks WHERE status = 'COMPLETED'")->fetchColumn() ?: 0;
    } catch (Exception $e) { $completedTasks = 0; }
    
    $totalCoordinators = $pdo->query('SELECT COUNT(*) FROM Coordinators')->fetchColumn() ?: 0;
    $totalRevenue = $pdo->query('SELECT SUM(budget) FROM Events')->fetchColumn() ?: 0;

    // Fetch recent events
    try {
        $stmt = $pdo->query("SELECT e.name_event as event_name, e.event_date, e.budget, e.status, 
                                    c.full_name as coordinator_name 
                             FROM Events e 
                             LEFT JOIN Coordinators c ON e.coordinator_id = c.coordinator_id 
                             ORDER BY e.created_at DESC LIMIT 5");
        $recentEvents = $stmt->fetchAll();
    } catch (Exception $e) {
        $stmt = $pdo->query("SELECT name_event as event_name, event_date, budget, status FROM Events ORDER BY event_id DESC LIMIT 5");
        $recentEvents = $stmt->fetchAll();
    }

} catch (PDOException $e) {
    die("Error fetching dashboard data: " . $e->getMessage());
}

$adminName = $_SESSION['admin_email'] ?? 'Administrator';
$adminInitial = strtoupper(substr($adminName, 0, 1));
?>

<div class="dashboard-fade-in">
    <div class="header">
        <div>
            <h1 class="header-title">Welcome back, Administrator</h1>
            <p style="color: var(--text-secondary); margin-top: 0.25rem;">Here's what's happening with your platform today.</p>
        </div>
        <div class="user-profile">
            <div class="avatar"><?php echo htmlspecialchars($adminInitial); ?></div>
            <span>Administrator</span>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon blue">
                <i data-lucide="calendar-days" style="width: 24px; height: 24px;"></i>
            </div>
            <div class="stat-value"><?php echo number_format($totalEvents); ?></div>
            <div class="stat-label">Total Events</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon green">
                <i data-lucide="check-square" style="width: 24px; height: 24px;"></i>
            </div>
            <div class="stat-value"><?php echo number_format($completedTasks); ?></div>
            <div class="stat-label">Tasks Completed</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon pink">
                <i data-lucide="users" style="width: 24px; height: 24px;"></i>
            </div>
            <div class="stat-value"><?php echo number_format($totalCoordinators); ?></div>
            <div class="stat-label">Coordinators</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon orange">
                <i data-lucide="dollar-sign" style="width: 24px; height: 24px;"></i>
            </div>
            <div class="stat-value">$<?php echo number_format($totalRevenue); ?></div>
            <div class="stat-label">Total Revenue</div>
        </div>
    </div>

    <div class="table-container">
        <div class="table-header">
            <h2 class="table-title">Recent Events</h2>
            <a href="events.php" class="btn btn-primary" style="text-decoration: none;">
                View All <i data-lucide="arrow-right" style="width: 16px; height: 16px;"></i>
            </a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Event Name</th>
                    <th>Date</th>
                    <th>Coordinator</th>
                    <th>Status</th>
                    <th>Budget</th>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($recentEvents)): ?>
                <tr>
                    <td colspan="5" style="text-align: center; padding: 3rem; color: var(--text-secondary);">
                        No recent events found.
                    </td>
                </tr>
                <?php else: ?>
                    <?php foreach ($recentEvents as $ev): ?>
                    <tr>
                        <td style="font-weight: 600;"><?php echo htmlspecialchars($ev['event_name'] ?? 'Unnamed Event'); ?></td>
                        <td><?php echo htmlspecialchars(date('m/d/Y', strtotime($ev['event_date']))); ?></td>
                        <td><?php echo htmlspecialchars($ev['coordinator_name'] ?? 'Unassigned'); ?></td>
                        <td>
                            <span class="badge <?php echo strtolower($ev['status'] ?? ''); ?>">
                                <?php echo htmlspecialchars($ev['status'] ?? 'Unknown'); ?>
                            </span>
                        </td>
                        <td>$<?php echo number_format($ev['budget'] ?? 0); ?></td>
                    </tr>
                    <?php endforeach; ?>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require_once 'includes/footer.php'; ?>
