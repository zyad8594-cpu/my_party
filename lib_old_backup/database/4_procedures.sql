-- ============================================================
-- 4. إنشاء STORED PROCEDURES (الإجراءات المخزنة) – العمليات الرئيسية
-- ============================================================
use my_party_pro;
DELIMITER $$

-- 4.1 إجراء تسجيل الدخول والتحقق من المستخدم
CREATE PROCEDURE `sp_user_login`(
    IN `p_email` VARCHAR(100) CHARSET utf8mb4, 
    IN `p_password` VARCHAR(255) CHARSET utf8mb4
)
BEGIN
    DECLARE v_user_id INT;
    DECLARE v_password_hash VARCHAR(255);
    
    -- البحث عن المستخدم
    SELECT `user_id`, `password` INTO v_user_id, v_password_hash
    FROM `Users` 
    WHERE `email` = p_email AND `is_active` = TRUE;
    
    -- التحقق من كلمة المرور (يفترض استخدام hashing)
    IF v_user_id IS NOT NULL AND v_password_hash = p_password THEN
        -- إرجاع بيانات المستخدم
        SELECT u.`user_id`, u.`email`, u.`role_id`, r.`role_name`,
               COALESCE(coord.`coordinator_id`, supp.`supplier_id`) AS `profile_id`,
               CASE WHEN coord.`coordinator_id` IS NOT NULL THEN 'coordinator'
                    WHEN supp.`supplier_id` IS NOT NULL THEN 'supplier'
                    ELSE 'admin' END AS `user_type`
        FROM `Users` u
        JOIN `Roles` r ON u.`role_id` = r.`role_id`
        LEFT JOIN `Coordinators` coord ON u.`user_id` = coord.`user_id`
        LEFT JOIN `Suppliers` supp ON u.`user_id` = supp.`user_id`
        WHERE u.`user_id` = v_user_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
    END IF;
END$$


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_user_coordinator`(
    IN `p_email` VARCHAR(100) CHARSET utf8mb4, 
    IN `p_password` VARCHAR(255) CHARSET utf8mb4, 
    IN `p_full_name` VARCHAR(100) CHARSET utf8mb4, 
    IN `p_phone_number` VARCHAR(20) CHARSET utf8mb4, 
    IN `p_role_name` VARCHAR(50) CHARSET utf8mb4, 
    IN `p_is_active` BOOLEAN
) DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER 
BEGIN
    DECLARE v_role_id INT;
    DECLARE v_user_id INT;

    SET v_role_id = fn_get_role_id_by_role_name(p_role_name);
    
    INSERT INTO `Users`(`email`, `password`, `role_id`, `is_active`) 
    VALUES(p_email, p_password, v_role_id, p_is_active); 

    SET v_user_id = LAST_INSERT_ID();

    INSERT INTO `Coordinators`(`user_id`, `full_name`, `phone_number`) 
    VALUES(v_user_id, p_full_name, p_phone_number); 
END$$


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_role_permissions`(
    IN `p_role_name` VARCHAR(50) CHARSET utf8mb4, 
    IN `p_permissions_names_json` JSON
) DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER 
BEGIN
    DECLARE v_role_id INT;
    DECLARE v_counter INT DEFAULT 0;
    DECLARE v_total INT DEFAULT 0;
    DECLARE v_permission_id INT;
    DECLARE v_permission_name VARCHAR(100) CHARSET utf8mb4;

    SET v_role_id = fn_role_get_id_by_name(p_role_name);
    IF v_role_id IS NOT NULL AND v_role_id > 0 AND p_permissions_names_json IS NOT NULL THEN
        SET v_total = JSON_LENGTH(p_permissions_names_json);
        WHILE v_counter < v_total DO
            SET v_permission_name = JSON_UNQUOTE(
                JSON_EXTRACT(
                    p_permissions_names_json, 
                    CONCAT('$[', v_counter, ']')
                )
            );
            SET v_permission_id = fn_permission_get_id_by_name(v_permission_name);

            IF v_permission_id IS NOT NULL AND v_permission_id > 0 AND NOT fn_role_has_permission(p_role_name, v_permission_name) THEN 
                INSERT IGNORE INTO `Role_Permissions` (`role_id`, `permission_id`)
                    VALUES (v_role_id, v_permission_id);
            END IF;
            SET v_counter = v_counter + 1;
        END WHILE;
    END IF;
END$$

CREATE PROCEDURE `sp_get_table_columns`(
    IN `p_table_name` VARCHAR(255) CHARSET utf8mb4,
    IN `p_database_name` VARCHAR(255) CHARSET utf8mb4
)
BEGIN 
    SELECT 
        `COLUMN_NAME`, `DATA_TYPE`, `IS_NULLABLE`, `COLUMN_DEFAULT`
    FROM information_schema.columns
    WHERE `table_schema` = p_database_name 
    AND `table_name` = p_table_name
    AND `IS_NULLABLE` = 'NO' 
    AND `COLUMN_DEFAULT` IS NULL 
    AND `EXTRA` != 'auto_increment' 
    ORDER BY `ORDINAL_POSITION`;
END$$





-- 4.2 إجراء إنشاء حدث جديد مع مهامه (باستخدام JSON)
CREATE PROCEDURE `sp_create_event_full`(
    IN `p_client_id` INT,
    IN `p_coordinator_id` INT,
    IN `p_name_event` VARCHAR(100) CHARSET utf8mb4,
    IN `p_description` TEXT,
    IN `p_event_date` DATE,
    IN `p_location` VARCHAR(255) CHARSET utf8mb4,
    IN `p_budget` DECIMAL(10,2),
    IN `p_status` ENUM('not_started','in_progress','completed','cancelled') CHARSET utf8mb4,
    IN `p_tasks_json` JSON  -- مصفوفة من المهام: [{"type_task":"...","assignment_type":"...", ...}]
)
BEGIN
    DECLARE v_event_id INT;
    DECLARE v_counter INT DEFAULT 0;
    DECLARE v_total INT;
    DECLARE v_task JSON;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- إدراج الحدث
    INSERT INTO `Events` (`client_id`, `coordinator_id`, `name_event`, `description`, 
                          `event_date`, `location`, `budget`, `status`)
    VALUES (p_client_id, p_coordinator_id, p_name_event, p_description,
            p_event_date, p_location, p_budget, p_status);
    SET v_event_id = LAST_INSERT_ID();
    
    -- إدراج المهام إذا وجدت
    IF p_tasks_json IS NOT NULL THEN
        SET v_total = JSON_LENGTH(p_tasks_json);
        WHILE v_counter < v_total DO
            SET v_task = JSON_EXTRACT(p_tasks_json, CONCAT('$[', v_counter, ']'));
            
            INSERT INTO `Tasks` (
                `event_id`, `assignment_type`, `assigned_user_id`, `assigned_supplier_id`,
                `type_task`, `description`, `cost`, `status`, `notes`, `url_image`,
                `date_start`, `date_due`, `reminder_type`, `reminder_value`, `reminder_unit`
            ) VALUES (
                v_event_id,
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.assignment_type')),
                JSON_EXTRACT(v_task, '$.assigned_user_id'),
                JSON_EXTRACT(v_task, '$.assigned_supplier_id'),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.type_task')),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.description')),
                IFNULL(JSON_EXTRACT(v_task, '$.cost'), 0),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.status')),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.notes')),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.url_image')),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.date_start')),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.date_due')),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.reminder_type')),
                JSON_EXTRACT(v_task, '$.reminder_value'),
                JSON_UNQUOTE(JSON_EXTRACT(v_task, '$.reminder_unit'))
            );
            
            SET v_counter = v_counter + 1;
        END WHILE;
    END IF;
    
    COMMIT;
    
    -- إرجاع معرف الحدث
    SELECT v_event_id AS `event_id`;
END$$

-- 4.3 إجراء تحديث حالة مهمة مع إنشاء إشعار تلقائي
CREATE PROCEDURE `sp_update_task_status`(
    IN `p_task_id` INT,
    IN `p_new_status` ENUM('PENDING','IN_PROGRESS','UNDER_REVIEW','COMPLETED','CANCELLED') CHARSET utf8mb4,
    IN `p_notes` TEXT CHARSET utf8mb4
)
BEGIN
    DECLARE v_old_status VARCHAR(20);
    DECLARE v_assigned_user INT;
    DECLARE v_assigned_supplier INT;
    DECLARE v_event_id INT;
    
    SELECT `status`, `assigned_user_id`, `assigned_supplier_id`, `event_id`
    INTO v_old_status, v_assigned_user, v_assigned_supplier, v_event_id
    FROM `Tasks` WHERE `task_id` = p_task_id;
    
    -- تحديث المهمة
    UPDATE `Tasks`
    SET `status` = p_new_status,
        `notes` = IF(p_notes IS NOT NULL, CONCAT(`notes`, '\n', p_notes), `notes`),
        `date_completion` = IF(p_new_status = 'COMPLETED', NOW(), `date_completion`),
        `completion_at` = IF(p_new_status = 'COMPLETED', NOW(), `completion_at`)
    WHERE `task_id` = p_task_id;
    
    -- إنشاء إشعار حسب الحالة الجديدة
    IF p_new_status = 'COMPLETED' THEN
        -- إشعار للمنسق
        INSERT INTO `Notifications` (`user_id`, `supplier_id`, `task_id`, `type`, `title`, `message`)
        SELECT e.`coordinator_id`, NULL, p_task_id, 'TASK_COMPLETED', 'تم إكمال مهمة',
               CONCAT('المهمة ', t.`type_task`, ' في حدث ', e.`name_event`, ' قد اكتملت.')
        FROM `Tasks` t
        JOIN `Events` e ON t.`event_id` = e.`event_id`
        WHERE t.`task_id` = p_task_id;
        
    ELSEIF p_new_status = 'CANCELLED' THEN
        -- إشعار للمنسق
        INSERT INTO `Notifications` (`user_id`, `supplier_id`, `task_id`, `type`, `title`, `message`)
        SELECT e.`coordinator_id`, NULL, p_task_id, 'TASK_CANCELLED', 'تم إلغاء مهمة',
               CONCAT('المهمة ', t.`type_task`, ' في حدث ', e.`name_event`, ' تم إلغاؤها.')
        FROM `Tasks` t
        JOIN `Events` e ON t.`event_id` = e.`event_id`
        WHERE t.`task_id` = p_task_id;
    END IF;
    
END$$

-- 4.4 إجراء إضافة تقييم لمهمة مع التحقق
CREATE PROCEDURE `sp_add_task_rating`(
    IN `p_task_id` INT,
    IN `p_coordinator_id` INT,
    IN `p_value_rating` INT,
    IN `p_comment` TEXT CHARSET utf8mb4
)
BEGIN
    -- التحقق من اكتمال المهمة
    IF NOT EXISTS(SELECT 1 FROM `Tasks` WHERE `task_id` = p_task_id AND `status` = 'COMPLETED') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'لا يمكن تقييم مهمة غير مكتملة.';
    END IF;
    
    -- التحقق من أن المنسق هو المسؤول عن حدث المهمة
    IF NOT EXISTS(
        SELECT 1 FROM `Tasks` t
        JOIN `Events` e ON t.`event_id` = e.`event_id`
        WHERE t.`task_id` = p_task_id AND e.`coordinator_id` = p_coordinator_id
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ليس لديك صلاحية تقييم هذه المهمة.';
    END IF;
    
    -- إدراج التقييم
    INSERT INTO `Ratings_Task` (`task_id`, `coordinator_id`, `value_rating`, `comment`)
    VALUES (p_task_id, p_coordinator_id, p_value_rating, p_comment);
    
    -- إشعار للمورد بالتقييم الجديد
    INSERT INTO `Notifications` (`supplier_id`, `task_id`, `type`, `title`, `message`)
    SELECT t.`assigned_supplier_id`, p_task_id, 'NEW_RATING', 'تقييم جديد',
           CONCAT('تم تقييم مهمتك بـ ', p_value_rating, ' نجوم.')
    FROM `Tasks` t
    WHERE t.`task_id` = p_task_id AND t.`assigned_supplier_id` IS NOT NULL;
    
END$$

-- 4.5 إجراء إنشاء إشعارات تذكير للمهام القريبة
CREATE PROCEDURE `sp_generate_reminders`()
BEGIN
    -- إشعارات للمهام التي تاريخ استحقاقها خلال 3 أيام ولم تكتمل
    INSERT INTO `Notifications` (`user_id`, `supplier_id`, `task_id`, `type`, `title`, `message`)
    SELECT 
        CASE WHEN t.`assignment_type` = 'USER' THEN t.`assigned_user_id` ELSE NULL END,
        CASE WHEN t.`assignment_type` = 'SUPPLIER' THEN t.`assigned_supplier_id` ELSE NULL END,
        t.`task_id`,
        'TASK_REMINDER',
        'تذكير بمهمة',
        CONCAT('مهمة "', t.`type_task`, '" مستحقة في ', t.`date_due`)
    FROM `Tasks` t
    WHERE t.`status` NOT IN ('COMPLETED', 'CANCELLED')
      AND t.`date_due` BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 DAY)
      AND NOT EXISTS (
          SELECT 1 FROM `Notifications` n
          WHERE n.`task_id` = t.`task_id` AND n.`type` = 'TASK_REMINDER' AND DATE(n.`created_at`) = CURDATE()
      );
END$$

-- 4.6 إجراء تقرير مالي لفترة زمنية
CREATE PROCEDURE `sp_financial_report`(
    IN `p_start_date` DATE,
    IN `p_end_date` DATE
)
BEGIN
    -- إجمالي الدخل حسب الحدث في الفترة
    SELECT 
        e.`event_id`,
        e.`name_event`,
        e.`event_date`,
        IFNULL(SUM(i.`amount`), 0) AS `total_income`,
        IFNULL(SUM(t.`cost`), 0) AS `total_expenses`,
        IFNULL(SUM(i.`amount`), 0) - IFNULL(SUM(t.`cost`), 0) AS `profit`
    FROM `Events` e
    LEFT JOIN `Income` i ON e.`event_id` = i.`event_id` AND i.`payment_date` BETWEEN p_start_date AND p_end_date
    LEFT JOIN `Tasks` t ON e.`event_id` = t.`event_id` AND t.`date_completion` BETWEEN p_start_date AND p_end_date
    WHERE e.`event_date` BETWEEN p_start_date AND p_end_date
    GROUP BY e.`event_id`;
    
    -- إجمالي عام
    SELECT 
        IFNULL(SUM(i.`amount`), 0) AS `grand_total_income`,
        IFNULL(SUM(t.`cost`), 0) AS `grand_total_expenses`,
        IFNULL(SUM(i.`amount`), 0) - IFNULL(SUM(t.`cost`), 0) AS `grand_profit`
    FROM `Events` e
    LEFT JOIN `Income` i ON e.`event_id` = i.`event_id` AND i.`payment_date` BETWEEN p_start_date AND p_end_date
    LEFT JOIN `Tasks` t ON e.`event_id` = t.`event_id` AND t.`date_completion` BETWEEN p_start_date AND p_end_date
    WHERE e.`event_date` BETWEEN p_start_date AND p_end_date;
END$$

-- 4.7 إجراء إعادة تعيين كلمة المرور (تحديث)
CREATE PROCEDURE `sp_change_password`(
    IN `p_user_id` INT,
    IN `p_old_password` VARCHAR(255) CHARSET utf8mb4,
    IN `p_new_password` VARCHAR(255) CHARSET utf8mb4
)
BEGIN
    DECLARE v_current_password VARCHAR(255);
    
    SELECT `password` INTO v_current_password
    FROM `Users` WHERE `user_id` = p_user_id;
    
    IF v_current_password = p_old_password THEN
        UPDATE `Users` SET `password` = p_new_password, `updated_at` = NOW()
        WHERE `user_id` = p_user_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'كلمة المرور القديمة غير صحيحة.';
    END IF;
END$$

-- 4.8 إجراء إلغاء حدث (مع تحديث حالة المهام المرتبطة)
CREATE PROCEDURE `sp_cancel_event`(
    IN `p_event_id` INT,
    IN `p_reason` TEXT CHARSET utf8mb4
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    START TRANSACTION;
    
    -- تحديث حالة الحدث
    UPDATE `Events` SET `status` = 'cancelled', `description` = CONCAT(`description`, '\nالإلغاء: ', p_reason)
    WHERE `event_id` = p_event_id;
    
    -- إلغاء جميع المهام غير المنجزة
    UPDATE `Tasks` SET `status` = 'CANCELLED', `notes` = CONCAT(`notes`, '\nألغيت بسبب إلغاء الحدث: ', p_reason)
    WHERE `event_id` = p_event_id AND `status` NOT IN ('COMPLETED', 'CANCELLED');
    
    -- إشعار للمنسق
    INSERT INTO `Notifications` (`user_id`, `task_id`, `type`, `title`, `message`)
    SELECT e.`coordinator_id`, NULL, 'EVENT_CANCELLED', 'تم إلغاء حدث',
           CONCAT('الحدث ', e.`name_event`, ' تم إلغاؤه. السبب: ', p_reason)
    FROM `Events` e
    WHERE e.`event_id` = p_event_id;
    
    COMMIT;
END$$


DELIMITER ;