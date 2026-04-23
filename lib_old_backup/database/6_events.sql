-- ============================================================
-- 6. إنشاء EVENT (حدث مجدول) لتنفيذ التذكيرات بشكل دوري
-- ============================================================
-- تأكد من تمكين جدولة الأحداث: SET GLOBAL event_scheduler = ON;
use my_party_pro;
CREATE EVENT IF NOT EXISTS `event_generate_reminders`
        ON SCHEDULE EVERY 1 DAY
        STARTS CURRENT_DATE + INTERVAL 1 DAY
    DO CALL sp_generate_reminders();