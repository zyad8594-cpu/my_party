-- ============================================================
-- 2. إنشاء VIEWS (المشاهدات) – تقارير شاملة
-- ============================================================
use my_party_pro;
-- 2.1 عرض تفاصيل الأحداث مع الربح والمصروفات والتقدم
CREATE OR REPLACE VIEW `v_events_detailed` AS
SELECT 
    e.`event_id`,
    e.`name_event` AS `event_name`,
    e.`description`,
    e.`event_date`,
    e.`location`,
    e.`budget` AS `planned_budget`,
    e.`status` AS `event_status`,
    c.`full_name` AS `client_name`,
    c.`phone_number` AS `client_phone`,
    coord.`full_name` AS `coordinator_name`,
    coord.`phone_number` AS `coordinator_phone`,
    COALESCE(SUM(DISTINCT inc.`amount`), 0) AS `total_income`,
    COALESCE(SUM(DISTINCT t.`cost`), 0) AS `total_expenses`,
    COALESCE(SUM(DISTINCT inc.`amount`), 0) - COALESCE(SUM(DISTINCT t.`cost`), 0) AS `net_profit`,
    COUNT(DISTINCT t.`task_id`) AS `total_tasks`,
    SUM(CASE WHEN t.`status` = 'COMPLETED' THEN 1 ELSE 0 END) AS `completed_tasks`,
    CONCAT(ROUND(100 * SUM(CASE WHEN t.`status` = 'COMPLETED' THEN 1 ELSE 0 END) / NULLIF(COUNT(t.`task_id`), 0), 2), '%') AS `completion_percentage`
FROM `Events` e
LEFT JOIN `Clients` c ON e.`client_id` = c.`client_id`
LEFT JOIN `Coordinators` coord ON e.`coordinator_id` = coord.`coordinator_id`
LEFT JOIN `Income` inc ON e.`event_id` = inc.`event_id`
LEFT JOIN `Tasks` t ON e.`event_id` = t.`event_id`
GROUP BY e.`event_id`;

-- 2.2 عرض المهام مع معلومات الجهة المنفذة وتقييمها
CREATE OR REPLACE VIEW `v_tasks_full` AS
SELECT 
    t.`task_id`,
    t.`event_id`,
    e.`name_event` AS `event_name`,
    t.`assignment_type`,
    CASE 
        WHEN t.`assignment_type` = 'USER' THEN coord.`full_name`
        WHEN t.`assignment_type` = 'SUPPLIER' THEN s.`name`
    END AS `assignee_name`,
    t.`type_task`,
    t.`description`,
    t.`cost`,
    t.`status`,
    t.`date_start`,
    t.`date_due`,
    t.`date_completion`,
    t.`notes`,
    t.`url_image`,
    r.`value_rating` AS `rating_value`,
    r.`comment` AS `rating_comment`
FROM `Tasks` t
LEFT JOIN `Events` e ON t.`event_id` = e.`event_id`
LEFT JOIN `Coordinators` coord ON t.`assigned_user_id` = coord.`coordinator_id`
LEFT JOIN `Suppliers` s ON t.`assigned_supplier_id` = s.`supplier_id`
LEFT JOIN `Ratings_Task` r ON t.`task_id` = r.`task_id`;

-- 2.3 عرض تقييمات الموردين (متوسط التقييم، عدد المهام المنفذة)
CREATE OR REPLACE VIEW `v_supplier_performance` AS
SELECT 
    s.`supplier_id`,
    s.`name` AS `supplier_name`,
    sv.`service_name`,
    COUNT(DISTINCT t.`task_id`) AS `tasks_completed`,
    ROUND(AVG(r.`value_rating`), 2) AS `avg_rating`,
    COUNT(r.`rating_id`) AS `total_ratings`
FROM `Suppliers` s
LEFT JOIN `Services` sv ON s.`service_id` = sv.`service_id`
LEFT JOIN `Tasks` t ON s.`supplier_id` = t.`assigned_supplier_id` AND t.`status` = 'COMPLETED'
LEFT JOIN `Ratings_Task` r ON t.`task_id` = r.`task_id`
GROUP BY s.`supplier_id`;

-- 2.4 عرض أداء المنسقين (عدد الأحداث التي يديرونها، المهام المنجزة)
CREATE OR REPLACE VIEW `v_coordinator_performance` AS
SELECT 
    coord.`coordinator_id`,
    coord.`full_name` AS `coordinator_name`,
    COUNT(DISTINCT e.`event_id`) AS `events_managed`,
    COUNT(DISTINCT t.`task_id`) AS `total_tasks_assigned`,
    SUM(CASE WHEN t.`status` = 'COMPLETED' THEN 1 ELSE 0 END) AS `tasks_completed`,
    ROUND(AVG(r.`value_rating`), 2) AS `avg_rating_given`
FROM `Coordinators` coord
LEFT JOIN `Events` e ON coord.`coordinator_id` = e.`coordinator_id`
LEFT JOIN `Tasks` t ON e.`event_id` = t.`event_id`
LEFT JOIN `Ratings_Task` r ON coord.`coordinator_id` = r.`coordinator_id`
GROUP BY coord.`coordinator_id`;

-- 2.5 عرض الإشعارات مع تفاصيل المستلم
CREATE OR REPLACE VIEW `v_notifications` AS
SELECT 
    n.`notification_id`,
    n.`task_id`,
    t.`type_task` AS `task_type`,
    n.`type` AS `notification_type`,
    n.`title`,
    n.`message`,
    n.`is_read`,
    n.`created_at`,
    CASE 
        WHEN n.`user_id` IS NOT NULL THEN 'Coordinator'
        WHEN n.`supplier_id` IS NOT NULL THEN 'Supplier'
    END AS `recipient_type`,
    COALESCE(coord.`full_name`, s.`name`) AS `recipient_name`
FROM `Notifications` n
LEFT JOIN `Tasks` t ON n.`task_id` = t.`task_id`
LEFT JOIN `Coordinators` coord ON n.`user_id` = coord.`user_id`
LEFT JOIN `Suppliers` s ON n.`supplier_id` = s.`supplier_id`;