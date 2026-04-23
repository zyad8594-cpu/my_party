<?php
// includes/sidebar.php
$current_page = basename($_SERVER['PHP_SELF']);
?>
<div class="sidebar">
    <div class="sidebar-logo" style="display: flex; align-items: center; gap: 0.75rem; font-size: 1.25rem; font-weight: 700; color: var(--text); padding: 0 0.5rem; margin-bottom: 2rem;">
        <i data-lucide="layout-dashboard" style="color: var(--primary); width: 28px; height: 28px;"></i>
        <span>My Party Pro</span>
    </div>

    <div class="nav-links" style="display: flex; flex-direction: column; gap: 0.5rem;">
        <a href="index.php" class="nav-item <?php echo $current_page == 'index.php' ? 'active' : ''; ?>">
            <i data-lucide="layout-dashboard" style="width: 20px; height: 20px;"></i>
            Dashboard
        </a>
        <a href="events.php" class="nav-item <?php echo $current_page == 'events.php' ? 'active' : ''; ?>">
            <i data-lucide="calendar-days" style="width: 20px; height: 20px;"></i>
            Events
        </a>
        <a href="coordinators.php" class="nav-item <?php echo $current_page == 'coordinators.php' ? 'active' : ''; ?>">
            <i data-lucide="users" style="width: 20px; height: 20px;"></i>
            Coordinators
        </a>
        <a href="suppliers.php" class="nav-item <?php echo $current_page == 'suppliers.php' ? 'active' : ''; ?>">
            <i data-lucide="briefcase" style="width: 20px; height: 20px;"></i>
            Suppliers
        </a>
    </div>

    <div style="margin-top: auto">
        <a href="logout.php" class="nav-item" style="width: 100%; background: transparent; border: none; cursor: pointer; text-align: left; color: inherit; font-size: inherit; display: flex; align-items: center; gap: 0.75rem; padding: 0.75rem 1rem; border-radius: 8px; text-decoration: none;">
            <i data-lucide="log-out" style="width: 20px; height: 20px;"></i>
            Logout
        </a>
    </div>
</div>
