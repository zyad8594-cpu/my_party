<?php
require_once 'includes/header.php';
require_once 'config/database.php';
require_once 'includes/sidebar.php';

$search = $_GET['search'] ?? '';
$statusFilter = $_GET['status'] ?? 'All';

$query = "SELECT e.name_event as event_name, e.event_date, e.budget, e.status, 
                 c.full_name as coordinator_name, cl.name as client_name 
          FROM Events e 
          LEFT JOIN Coordinators c ON e.coordinator_id = c.coordinator_id 
          LEFT JOIN Clients cl ON e.client_id = cl.client_id 
          WHERE 1=1";

$params = [];

if ($search !== '') {
    $query .= " AND (e.name_event LIKE ? OR c.full_name LIKE ?)";
    $searchParam = "%$search%";
    $params[] = $searchParam;
    $params[] = $searchParam;
}

if ($statusFilter !== 'All') {
    $query .= " AND e.status = ?";
    $params[] = $statusFilter;
}

$query .= " ORDER BY e.created_at DESC";

try {
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $events = $stmt->fetchAll();
} catch (Exception $e) {
    try {
        $stmt = $pdo->prepare("SELECT name_event as event_name, event_date, budget, status FROM Events ORDER BY created_at DESC");
        $stmt->execute();
        $events = $stmt->fetchAll();
    } catch(Exception $ex) {
        $events = [];
        $error = "Failed to load events.";
    }
}

?>

<div class="dashboard-fade-in">
    <div class="header">
        <div>
            <h1 class="header-title">Events Management</h1>
            <p style="color: var(--text-secondary);">View and manage all events across the platform.</p>
        </div>
        <button class="btn btn-primary">
            <i data-lucide="download" style="width: 18px; height: 18px;"></i> Export Report
        </button>
    </div>

    <div class="table-container">
        <div class="table-header" style="flex-direction: column; align-items: stretch; gap: 1rem;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 class="table-title">System Events (<?php echo count($events); ?>)</h2>
                
                <form method="GET" action="events.php" style="display: flex; gap: 0.75rem;">
                    <div style="position: relative;">
                        <i data-lucide="search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); width: 18px; height: 18px;"></i>
                        <input type="text" name="search" value="<?php echo htmlspecialchars($search); ?>" placeholder="Search events..." class="form-input" style="padding-left: 40px; width: 250px;">
                    </div>
                    <select name="status" class="form-input" style="width: 150px;" onchange="this.form.submit()">
                        <option value="All" <?php echo $statusFilter == 'All' ? 'selected' : ''; ?>>All Status</option>
                        <option value="PENDING" <?php echo $statusFilter == 'PENDING' ? 'selected' : ''; ?>>Pending</option>
                        <option value="IN_PROGRESS" <?php echo $statusFilter == 'IN_PROGRESS' ? 'selected' : ''; ?>>In Progress</option>
                        <option value="COMPLETED" <?php echo $statusFilter == 'COMPLETED' ? 'selected' : ''; ?>>Completed</option>
                        <option value="CANCELLED" <?php echo $statusFilter == 'CANCELLED' ? 'selected' : ''; ?>>Cancelled</option>
                    </select>
                </form>
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Event Details</th>
                    <th>Coordinator</th>
                    <th>Client</th>
                    <th>Budget</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php if (isset($error)): ?>
                <tr><td colspan="6" style="text-align: center; color: red;"><?php echo $error; ?></td></tr>
                <?php elseif (empty($events)): ?>
                <tr><td colspan="6" style="text-align: center; padding: 3rem; color: var(--text-secondary);">No events match your search.</td></tr>
                <?php else: ?>
                    <?php foreach ($events as $ev): ?>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center; gap: 1rem;">
                                <div class="stat-icon blue" style="width: 40px; height: 40px; margin-bottom: 0; padding: 10px;">
                                    <i data-lucide="calendar-days" style="width: 20px; height: 20px;"></i>
                                </div>
                                <div>
                                    <div style="font-weight: 600;"><?php echo htmlspecialchars($ev['event_name'] ?? ''); ?></div>
                                    <div style="font-size: 0.75rem; color: var(--text-secondary);">
                                        <?php echo htmlspecialchars(date('m/d/Y', strtotime($ev['event_date'] ?? 'now'))); ?>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td><?php echo htmlspecialchars($ev['coordinator_name'] ?? 'Not assigned'); ?></td>
                        <td><?php echo htmlspecialchars($ev['client_name'] ?? 'N/A'); ?></td>
                        <td style="font-weight: 500;">$<?php echo number_format($ev['budget'] ?? 0); ?></td>
                        <td>
                            <span class="badge <?php echo strtolower($ev['status'] ?? ''); ?>">
                                <?php echo htmlspecialchars($ev['status'] ?? ''); ?>
                            </span>
                        </td>
                        <td>
                            <button class="btn" style="background: rgba(255,255,255,0.05); padding: 8px;">
                                <i data-lucide="eye" style="width: 18px; height: 18px;"></i>
                            </button>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require_once 'includes/footer.php'; ?>
