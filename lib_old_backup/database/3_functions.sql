-- ============================================================
-- 3. إنشاء FUNCTIONS (الدوال) – عمليات حسابية ومنطقية متقدمة
-- ============================================================
use my_party_pro;
DELIMITER $$

CREATE FUNCTION `fn_role_get_name_by_id`(`p_role_id` INT)
RETURNS VARCHAR(50) CHARSET utf8mb4 
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE ret VARCHAR(50) CHARSET utf8mb4;
    SELECT `role_name` INTO ret FROM `Roles` WHERE `role_id` = p_role_id;
    RETURN ret;
END$$

CREATE FUNCTION `fn_role_get_id_by_name`(`p_role_name` VARCHAR(50) CHARSET utf8mb4)
RETURNS INT 
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE ret INT;
    SELECT `role_id` INTO ret FROM `Roles` WHERE `role_name` = p_role_name;
    RETURN ret;
END$$

CREATE FUNCTION `fn_role_has_permission`(`p_role_name` VARCHAR(50) CHARSET utf8mb4, `p_permission_name` VARCHAR(100) CHARSET utf8mb4) 
RETURNS BOOLEAN
DETERMINISTIC READS SQL DATA SQL SECURITY DEFINER
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*) INTO v_count
    FROM `Role_Permissions` rp
    JOIN `Roles` r ON rp.`role_id` = r.`role_id`
    JOIN `Permissions` p ON rp.`permission_id` = p.`permission_id`
    WHERE r.`role_name` = p_role_name AND p.`permission_name` = p_permission_name;
    RETURN v_count > 0;
END$$

CREATE FUNCTION `fn_permission_get_id_by_name`(`p_permission_name` VARCHAR(100) CHARSET utf8mb4)
RETURNS INT 
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE ret INT;
    SELECT `permission_id` INTO ret FROM `Permissions` WHERE `permission_name` = p_permission_name;
    RETURN ret;
END$$

CREATE FUNCTION `fn_permission_get_name_by_id`(`p_permission_id` INT)
RETURNS VARCHAR(50) CHARSET utf8mb4 
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE ret VARCHAR(50) CHARSET utf8mb4;
    SELECT `permission_name` INTO ret FROM `Permissions` WHERE `permission_id` = p_permission_id;
    RETURN ret;
END$$

CREATE FUNCTION `fn_table_exists`(`p_table_name` VARCHAR(255) CHARSET utf8mb4) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE table_count INT;
    
    SELECT COUNT(*) INTO table_count
        FROM information_schema.tables 
        WHERE `table_schema` = DATABASE() -- يبحث في قاعدة البيانات الحالية
        AND `table_name` = p_table_name;
    
    RETURN table_count > 0;
END$$

CREATE FUNCTION `uc_first`(`str` VARCHAR(255) CHARSET utf8mb4) 
RETURNS VARCHAR(255) CHARSET utf8mb4
DETERMINISTIC
BEGIN
    RETURN CONCAT(UPPER(LEFT(str, 1)), LOWER(SUBSTRING(str, 2)));
END$$







-- 3.1 دالة لحساب إجمالي الدخل لحدث
CREATE FUNCTION `fn_event_total_income`(`p_event_id` INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT IFNULL(SUM(`amount`), 0) INTO v_total
    FROM `Income` WHERE `event_id` = p_event_id;
    RETURN v_total;
END$$

-- 3.2 دالة لحساب إجمالي مصروفات حدث
CREATE FUNCTION `fn_event_total_expenses`(`p_event_id` INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);
    SELECT IFNULL(SUM(`cost`), 0) INTO v_total
    FROM `Tasks` WHERE `event_id` = p_event_id;
    RETURN v_total;
END$$

-- 3.3 دالة لحساب صافي الربح لحدث
CREATE FUNCTION `fn_event_net_profit`(`p_event_id` INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
    RETURN fn_event_total_income(p_event_id) - fn_event_total_expenses(p_event_id);
END$$

-- 3.4 دالة للتحقق من وجود صلاحية لمستخدم (بناءً على role_id)
CREATE FUNCTION `fn_user_has_permission`(`p_user_id` INT, `p_permission_name` VARCHAR(100) CHARSET utf8mb4) 
RETURNS BOOLEAN
DETERMINISTIC READS SQL DATA SQL SECURITY DEFINER
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM `Users` u
    JOIN `Role_Permissions` rp ON u.`role_id` = rp.`role_id`
    JOIN `Permissions` p ON rp.`permission_id` = p.`permission_id`
    WHERE u.`user_id` = p_user_id AND p.`permission_name` = p_permission_name;
    RETURN v_count > 0;
END$$

-- 3.5 دالة لحساب متوسط التقييم لمورد معين
CREATE FUNCTION `fn_supplier_avg_rating`(p_supplier_id INT) 
RETURNS DECIMAL(3,2)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_avg DECIMAL(3,2);
    SELECT ROUND(AVG(r.`value_rating`), 2) INTO v_avg
    FROM `Ratings_Task` r
    JOIN `Tasks` t ON r.`task_id` = t.`task_id`
    WHERE t.`assigned_supplier_id` = p_supplier_id;
    RETURN IFNULL(v_avg, 0);
END$$

-- 3.6 دالة لحساب عدد المهام المتأخرة لحدث
CREATE FUNCTION `fn_event_overdue_tasks`(p_event_id INT) 
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE v_count INT;
    SELECT COUNT(*) INTO v_count
    FROM `Tasks`
    WHERE `event_id` = p_event_id 
      AND `status` NOT IN ('COMPLETED', 'CANCELLED')
      AND `date_due` < CURDATE();
    RETURN v_count;
END$$

DELIMITER ;