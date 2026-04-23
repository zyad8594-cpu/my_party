-- ============================================================
-- 5. إنشاء TRIGGERS (المحفزات) – للحفاظ على التكامل وإنشاء السجلات
-- ============================================================
use my_party_pro;
DELIMITER $$


CREATE TRIGGER `trg_events_after_insert`
    AFTER INSERT ON `Users`
    FOR EACH ROW
BEGIN
    DECLARE v_table_name VARCHAR(50) CHARSET utf8mb4;
    SELECT CONCAT(uc_first(fn_role_get_name_by_id(NEW.role_id)), 's') INTO v_table_name;
    
    IF fn_table_exists(v_table_name) THEN
        
    ELSEIF v_table_name = 'supplier' THEN

    ELSE
'trg_events_after_insert()'
    END IF;

    INSERT INTO `Audit_Log` (`table_name`, `action`, `record_id`, `new_data`, `changed_at`)
    VALUES ('Events', 'INSERT', NEW.`event_id`, JSON_OBJECT(
        'client_id', NEW.`client_id`,
        'coordinator_id', NEW.`coordinator_id`,
        'name_event', NEW.`name_event`,
        'event_date', NEW.`event_date`,
        'budget', NEW.`budget`,
        'status', NEW.`status`
    ), NOW());
END$$






-- 5.1 Trigger لتحديث حقل updated_at تلقائياً في جدول Events
CREATE TRIGGER `trg_events_before_update`
    BEFORE UPDATE ON `Events`
    FOR EACH ROW
BEGIN
    SET NEW.`updated_at` = CURRENT_TIMESTAMP;
END$$

-- (يمكن إضافة نفس الـ trigger لباقي الجداول، لكن نكتفي بمثال واحد للاختصار)

-- 5.2 Trigger للتحقق من صحة البيانات قبل إدراج مهمة
CREATE TRIGGER `trg_tasks_before_insert`
    BEFORE INSERT ON `Tasks`
    FOR EACH ROW
BEGIN
    -- التحقق من نوع الإسناد
    IF NEW.`assignment_type` = 'USER' AND NEW.`assigned_user_id` IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'يجب تحديد منسق للمهمة عندما يكون النوع USER.';
    END IF;
    IF NEW.`assignment_type` = 'SUPPLIER' AND NEW.`assigned_supplier_id` IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'يجب تحديد مورد للمهمة عندما يكون النوع SUPPLIER.';
    END IF;
    IF NEW.`assignment_type` NOT IN ('USER', 'SUPPLIER') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'نوع الإسناد غير صحيح.';
    END IF;
    
    -- التحقق من وجود المنسق أو المورد
    IF NEW.`assigned_user_id` IS NOT NULL AND NOT EXISTS(SELECT 1 FROM `Coordinators` WHERE `coordinator_id` = NEW.`assigned_user_id`) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'المنسق المحدد غير موجود.';
    END IF;
    IF NEW.`assigned_supplier_id` IS NOT NULL AND NOT EXISTS(SELECT 1 FROM `Suppliers` WHERE `supplier_id` = NEW.`assigned_supplier_id`) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'المورد المحدد غير موجود.';
    END IF;
    
    -- التحقق من تاريخ البدء لا يتجاوز تاريخ الاستحقاق
    IF NEW.`date_start` IS NOT NULL AND NEW.`date_due` IS NOT NULL AND NEW.`date_start` > NEW.`date_due` THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'تاريخ البدء لا يمكن أن يكون بعد تاريخ الاستحقاق.';
    END IF;
END$$

-- 5.3 Trigger لتسجيل التغييرات في جدول Audit_Log (لجدول Events)
CREATE TRIGGER `trg_events_after_insert`
    AFTER INSERT ON `Events`
    FOR EACH ROW
BEGIN
    INSERT INTO `Audit_Log` (`table_name`, `action`, `record_id`, `new_data`, `changed_at`)
    VALUES ('Events', 'INSERT', NEW.`event_id`, JSON_OBJECT(
        'client_id', NEW.`client_id`,
        'coordinator_id', NEW.`coordinator_id`,
        'name_event', NEW.`name_event`,
        'event_date', NEW.`event_date`,
        'budget', NEW.`budget`,
        'status', NEW.`status`
    ), NOW());
END$$

CREATE TRIGGER `trg_events_after_update`
    AFTER UPDATE ON `Events`
    FOR EACH ROW
BEGIN
    INSERT INTO `Audit_Log` (`table_name`, `action`, `record_id`, `old_data`, `new_data`, `changed_at`)
    VALUES ('Events', 'UPDATE', NEW.`event_id`,
        JSON_OBJECT(
            'client_id', OLD.`client_id`,
            'coordinator_id', OLD.`coordinator_id`,
            'name_event', OLD.`name_event`,
            'event_date', OLD.`event_date`,
            'budget', OLD.`budget`,
            'status', OLD.`status`
        ),
        JSON_OBJECT(
            'client_id', NEW.`client_id`,
            'coordinator_id', NEW.`coordinator_id`,
            'name_event', NEW.`name_event`,
            'event_date', NEW.`event_date`,
            'budget', NEW.`budget`,
            'status', NEW.`status`
        ), NOW());
END$$

-- 5.4 Trigger لإنشاء إشعار تلقائي عند إسناد مهمة جديدة
CREATE TRIGGER `trg_tasks_after_insert`
    AFTER INSERT ON `Tasks`
    FOR EACH ROW
BEGIN
    DECLARE v_title VARCHAR(255);
    DECLARE v_message TEXT;
    
    SET v_title = 'مهمة جديدة';
    SET v_message = CONCAT('تم إسناد مهمة جديدة إليك: ', NEW.`type_task`);
    
    IF NEW.`assignment_type` = 'USER' AND NEW.`assigned_user_id` IS NOT NULL THEN
        INSERT INTO `Notifications` (`user_id`, `task_id`, `type`, `title`, `message`)
        VALUES (NEW.`assigned_user_id`, NEW.`task_id`, 'TASK_ASSIGNED', v_title, v_message);
    ELSEIF NEW.`assignment_type` = 'SUPPLIER' AND NEW.`assigned_supplier_id` IS NOT NULL THEN
        INSERT INTO `Notifications` (`supplier_id`, `task_id`, `type`, `title`, `message`)
        VALUES (NEW.`assigned_supplier_id`, NEW.`task_id`, 'TASK_ASSIGNED', v_title, v_message);
    END IF;
END$$

-- 5.5 Trigger لمنع حذف مستخدم إذا كان مرتبطاً بمنسق أو مورد
CREATE TRIGGER `trg_users_before_delete`
    BEFORE DELETE ON `Users`
    FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM `Coordinators` WHERE `user_id` = OLD.`user_id`) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'لا يمكن حذف مستخدم مرتبط بمنسق. احذف المنسق أولاً.';
    END IF;
    IF EXISTS (SELECT 1 FROM `Suppliers` WHERE `user_id` = OLD.`user_id`) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'لا يمكن حذف مستخدم مرتبط بمورد. احذف المورد أولاً.';
    END IF;
END$$

-- 5.6 Trigger لمنع إضافة تقييم لمهمة لم تكتمل (حماية إضافية)
CREATE TRIGGER `trg_ratings_before_insert`
    BEFORE INSERT ON `Ratings_Task`
    FOR EACH ROW
BEGIN
    DECLARE v_task_status VARCHAR(20);
    SELECT `status` INTO v_task_status FROM `Tasks` WHERE `task_id` = NEW.`task_id`;
    
    IF v_task_status != 'COMPLETED' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'لا يمكن تقييم مهمة غير مكتملة.';
    END IF;
    
    -- منع التقييم المكرر
    IF EXISTS (SELECT 1 FROM `Ratings_Task` WHERE `task_id` = NEW.`task_id`) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'لا يمكن إضافة أكثر من تقييم لنفس المهمة.';
    END IF;
END$$

-- 5.7 Trigger لمنع تعديل أو حذف الإشعارات المقروءة (اختياري)
CREATE TRIGGER `trg_notifications_before_update`
    BEFORE UPDATE ON `Notifications`
    FOR EACH ROW
BEGIN
    IF OLD.`is_read` = TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'لا يمكن تعديل إشعار مقروء.';
    END IF;
END$$

-- 5.8 Trigger للتحقق من صحة تاريخ الدخل (لا يمكن أن يكون في المستقبل)
CREATE TRIGGER `trg_income_before_insert`
    BEFORE INSERT ON `Income`
    FOR EACH ROW
BEGIN
    IF NEW.`payment_date` > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'تاريخ الدفع لا يمكن أن يكون في المستقبل.';
    END IF;
END$$
DELIMITER ;