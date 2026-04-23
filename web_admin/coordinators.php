<?php
require_once 'includes/header.php';
require_once 'config/database.php';
require_once 'includes/sidebar.php';

$search = $_GET['search'] ?? '';

$query = "SELECT c.*, 
          (SELECT COUNT(*) FROM Events WHERE coordinator_id = c.coordinator_id) as events_count 
          FROM Coordinators c WHERE 1=1";
$params = [];

if ($search !== '') {
    $query .= " AND (c.full_name LIKE ? OR c.email LIKE ? OR c.phone_number LIKE ?)";
    $searchParam = "%$search%";
    $params = [$searchParam, $searchParam, $searchParam];
}

try {
    $stmt = $pdo->prepare($query);
    $stmt->execute($params);
    $coordinators = $stmt->fetchAll();
} catch (Exception $e) {
    try {
        $stmt = $pdo->prepare("SELECT * FROM Coordinators WHERE full_name LIKE ?");
        $stmt->execute(["%$search%"]);
        $coordinators = $stmt->fetchAll();
    } catch (Exception $e2) {
        $coordinators = [];
    }
}
?>

<div class="dashboard-fade-in">
    <div class="header">
        <div>
            <h1 class="header-title">Platform Coordinators</h1>
            <p style="color: var(--text-secondary);">Manage internal team members and event planners.</p>
        </div>
    </div>

    <div class="table-container">
        <div class="table-header">
            <h2 class="table-title">Coordinators (<?php echo count($coordinators); ?>)</h2>
            <form method="GET" action="coordinators.php" style="position: relative; display: flex;">
                <i data-lucide="search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); width: 18px; height: 18px;"></i>
                <input type="text" name="search" value="<?php echo htmlspecialchars($search); ?>" placeholder="Search coordinators..." class="form-input" style="padding-left: 40px; width: 300px;">
                <button type="submit" style="display: none;">Search</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Contact Info</th>
                    <th>Join Date</th>
                    <th>Events Managed</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($coordinators)): ?>
                <tr><td colspan="5" style="text-align: center; padding: 3rem; color: var(--text-secondary);">No coordinators match your search.</td></tr>
                <?php else: ?>
                    <?php foreach ($coordinators as $c): ?>
                    <?php 
                        $displayName = $c['full_name'] ?? $c['name'] ?? 'Coordinator';
                        $initial = strtoupper(substr($displayName, 0, 1));
                    ?>
                    <tr>
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.75rem;">
                                <div class="avatar" style="width: 32px; height: 32px; font-size: 0.9rem; flex-shrink: 0; display: flex; align-items: center; justify-content: center; background: var(--primary-light); color: var(--primary); border-radius: 50%; font-weight: bold;">
                                    <?php echo htmlspecialchars($initial); ?>
                                </div>
                                <div style="font-weight: 600;"><?php echo htmlspecialchars($displayName); ?></div>
                            </div>
                        </td>
                        <td>
                            <div style="display: flex; flex-direction: column; gap: 0.25rem;">
                                <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.8rem; color: var(--text-secondary);">
                                    <i data-lucide="mail" style="width: 12px; height: 12px;"></i> <?php echo htmlspecialchars($c['email'] ?? 'N/A'); ?>
                                </div>
                                <div style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.8rem; color: var(--text-secondary);">
                                    <i data-lucide="phone" style="width: 12px; height: 12px;"></i> <?php echo htmlspecialchars($c['phone_number'] ?? $c['phone'] ?? 'N/A'); ?>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.5rem;">
                                <i data-lucide="calendar" style="width: 14px; height: 14px;"></i>
                                <?php echo htmlspecialchars(date('m/d/Y', strtotime($c['created_at'] ?? 'now'))); ?>
                            </div>
                        </td>
                        <td>
                            <div class="badge in_progress" style="width: fit-content;">
                                <?php echo htmlspecialchars($c['events_count'] ?? 0); ?> Events
                            </div>
                        </td>
                        <td>
                            <button class="btn" style="background: rgba(255,255,255,0.05); padding: 8px;">
                                <i data-lucide="edit-2" style="width: 18px; height: 18px;"></i>
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
