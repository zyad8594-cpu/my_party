<?php
require_once 'includes/header.php';
require_once 'config/database.php';
require_once 'includes/sidebar.php';

$search = $_GET['search'] ?? '';

$query = "SELECT s.*, svc.service_name 
          FROM Suppliers s 
          LEFT JOIN Services svc ON s.primary_service_id = svc.service_id 
          WHERE 1=1";

$params = [];
if ($search !== '') {
    $query .= " AND (s.name LIKE ? OR s.email LIKE ? OR svc.service_name LIKE ?)";
    $searchParam = "%$search%";
    $params = [$searchParam, $searchParam, $searchParam];
}

try {
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $suppliers = $stmt->fetchAll();
} catch (Exception $e) {
    try {
        $stmt = $pdo->prepare("SELECT * FROM Suppliers WHERE name LIKE ?");
        $stmt->execute(["%$search%"]);
        $suppliers = $stmt->fetchAll();
    } catch (Exception $e2) {
        $suppliers = [];
    }
}
?>

<div class="dashboard-fade-in">
    <div class="header">
        <div>
            <h1 class="header-title">Suppliers Directory</h1>
            <p style="color: var(--text-secondary);">Manage your partner network and service providers.</p>
        </div>
    </div>

    <div class="table-container">
        <div class="table-header">
            <h2 class="table-title">Partners (<?php echo count($suppliers); ?>)</h2>
            <form method="GET" action="suppliers.php" style="position: relative; display: flex;">
                <i data-lucide="search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); width: 18px; height: 18px;"></i>
                <input type="text" name="search" value="<?php echo htmlspecialchars($search); ?>" placeholder="Search suppliers or services..." class="form-input" style="padding-left: 40px; width: 300px;">
                <button type="submit" style="display: none;">Search</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Supplier Name</th>
                    <th>Primary Service</th>
                    <th>Rating</th>
                    <th>Jobs Done</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($suppliers)): ?>
                <tr><td colspan="6" style="text-align: center; padding: 3rem; color: var(--text-secondary);">No suppliers match your search.</td></tr>
                <?php else: ?>
                    <?php foreach ($suppliers as $s): ?>
                    <tr>
                        <td>
                            <div style="font-weight: 600;"><?php echo htmlspecialchars($s['name'] ?? $s['full_name'] ?? ''); ?></div>
                            <div style="font-size: 0.75rem; color: var(--text-secondary);"><?php echo htmlspecialchars($s['email'] ?? ''); ?></div>
                        </td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                <i data-lucide="briefcase" style="width: 14px; height: 14px; color: var(--primary);"></i>
                                <?php echo htmlspecialchars($s['service_name'] ?? 'N/A'); ?>
                            </div>
                        </td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.25rem; color: #fbbf24;">
                                <i data-lucide="star" style="width: 16px; height: 16px; fill: currentColor;"></i>
                                <span style="font-weight: 600; color: var(--text-primary);"><?php echo htmlspecialchars($s['rating'] ?? '0.0'); ?></span>
                            </div>
                        </td>
                        <td><?php echo htmlspecialchars($s['tasks_completed'] ?? 0); ?></td>
                        <td>
                            <?php if (!empty($s['is_active']) && $s['is_active']): ?>
                                <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--success);">
                                    <i data-lucide="shield-check" style="width: 16px; height: 16px;"></i> 
                                    <span style="font-size: 0.8rem; font-weight: 600;">Verified</span>
                                </div>
                            <?php else: ?>
                                <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-secondary);">
                                    <i data-lucide="shield-alert" style="width: 16px; height: 16px;"></i> 
                                    <span style="font-size: 0.8rem;">Pending</span>
                                </div>
                            <?php endif; ?>
                        </td>
                        <td>
                            <button class="btn" style="background: rgba(255,255,255,0.05); padding: 8px;">
                                <i data-lucide="external-link" style="width: 18px; height: 18px;"></i>
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
