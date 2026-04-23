-- ============================================================
-- 7. إنشاء الفهارس (Indexes) لتحسين الأداء
-- ============================================================
use my_party_pro;
CREATE INDEX idx_tasks_event_id ON `Tasks`(`event_id`);
CREATE INDEX idx_tasks_assigned_user ON `Tasks`(`assigned_user_id`);
CREATE INDEX idx_tasks_assigned_supplier ON `Tasks`(`assigned_supplier_id`);
CREATE INDEX idx_notifications_user ON `Notifications`(`user_id`, `is_read`);
CREATE INDEX idx_notifications_supplier ON `Notifications`(`supplier_id`, `is_read`);
CREATE INDEX idx_income_event_id ON `Income`(`event_id`);
CREATE INDEX idx_ratings_task_id ON `Ratings_Task`(`task_id`);
