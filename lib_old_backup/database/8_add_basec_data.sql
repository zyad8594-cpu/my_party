-- ============================================================
-- 8. إدراج البيانات الأساسية (الأدوار، الصلاحيات، إلخ)
-- ============================================================
use my_party_pro;
-- إدراج الأدوار الأساسية
INSERT IGNORE INTO `Roles` (`role_name`) VALUES 
    ('admin'), ('coordinator'), ('supplier');

-- إدراج الصلاحيات الأساسية
INSERT IGNORE INTO `Permissions` (`permission_name`) VALUES 
    ('create_event'), ('edit_event'), ('delete_event'), 
    ('assign_task'), ('rate_task'), ('view_reports');

-- ربط الصلاحيات بالأدوار (مثال: admin يملك كل الصلاحيات)
INSERT IGNORE INTO `Role_Permissions` (`role_id`, `permission_id`)
    SELECT r.`role_id`, p.`permission_id`
    FROM `Roles` r CROSS JOIN `Permissions` p
    WHERE r.`role_name` = 'admin';

-- إضافة مستخدم admin افتراضي (كلمة المرور: admin123، يمكن تغييرها لاحقاً)
-- ملاحظة: في الإنتاج يجب استخدام hashing آمن مثل bcrypt وليس نص عادي.
INSERT IGNORE INTO `Users` (`email`, `password`, `role_id`, `is_active`)
    SELECT 'admin@myparty.com', 'admin123', `role_id`, TRUE
    FROM `Roles` WHERE `role_name` = 'admin';

-- ============================================================
-- نهاية ملف SQL
-- ============================================================
