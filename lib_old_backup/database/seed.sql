SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `Tasks`;
TRUNCATE TABLE `Events`;
TRUNCATE TABLE `Clients`;
TRUNCATE TABLE `Supplier_Services`;
TRUNCATE TABLE `Services`;
TRUNCATE TABLE `Suppliers`;
TRUNCATE TABLE `Coordinators`;
TRUNCATE TABLE `Users`;
TRUNCATE TABLE `Roles`;
SET FOREIGN_KEY_CHECKS = 1;

INSERT IGNORE INTO `Roles` (`role_id`, `role_name`) VALUES
(1, 'admin'),
(2, 'coordinator'),
(3, 'supplier');

INSERT INTO `Users` (`user_id`, `email`, `password`, `role_id`, `is_active`) VALUES
(1, 'admin@myparty.com', '$2b$10$P.CSA9PnjIQ5fG7T4ELjG.cj20NEZKi/jc7zcEVjQh7XlJyVz2oZy', 1, 1),
(2, 'ahmed@coordinator.com', '$2b$10$P.CSA9PnjIQ5fG7T4ELjG.cj20NEZKi/jc7zcEVjQh7XlJyVz2oZy', 2, 1),
(3, 'sara@coordinator.com', '$2b$10$P.CSA9PnjIQ5fG7T4ELjG.cj20NEZKi/jc7zcEVjQh7XlJyVz2oZy', 2, 1),
(4, 'flowers@supplier.com', '$2b$10$P.CSA9PnjIQ5fG7T4ELjG.cj20NEZKi/jc7zcEVjQh7XlJyVz2oZy', 3, 1),
(5, 'lighting@supplier.com', '$2b$10$P.CSA9PnjIQ5fG7T4ELjG.cj20NEZKi/jc7zcEVjQh7XlJyVz2oZy', 3, 1),
(6, 'venue@supplier.com', '$2b$10$P.CSA9PnjIQ5fG7T4ELjG.cj20NEZKi/jc7zcEVjQh7XlJyVz2oZy', 3, 1);

INSERT INTO `Coordinators` (`coordinator_id`, `user_id`, `full_name`, `phone_number`) VALUES
(1, 2, 'أحمد المنسق', '0511111111'),
(2, 3, 'سارة المنسقة', '0522222222');

INSERT INTO `Suppliers` (`supplier_id`, `user_id`, `name`, `phone`, `address`, `notes`) VALUES
(1, 4, 'مؤسسة الزهور', '0533333333', 'الرياض', 'متخصصون في الزهور الطبيعية'),
(2, 5, 'شركة الصوتيات', '0544444444', 'جدة', 'أحدث الأجهزة الصوتية'),
(3, 6, 'فندق الريتز', '0555555555', 'الدمام', 'قاعات فخمة للمناسبات');

INSERT INTO `Services` (`service_id`, `service_name`, `description`) VALUES
(1, 'تنسيق ورود الطاولات', 'تنسيق ورد طبيعي فاخر للطاولات'),
(2, 'كوشة العروس', 'تصميم وتنفيذ كوشة بتصميم حديث'),
(3, 'نظام صوتي متكامل', 'سماعات ومايكات ومكسر دي جي'),
(4, 'قاعة احتفالات (500 شخص)', 'قاعة مجهزة بالكامل مع العشاء'),
(5, 'تصوير فيديو وفوتوغرافي', 'تغطية كاملة للمناسبة مع ألبوم');

INSERT INTO `Supplier_Services` (`supplier_id`, `service_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 1);

INSERT INTO `Clients` (`client_id`, `full_name`, `phone_number`, `email`, `address`) VALUES
(1, 'خالد العتيبي', '0566666666', 'khaled@test.com', 'الرياض'),
(2, 'محمد سعد', '0577777777', 'mohammed@test.com', 'جدة');

INSERT INTO `Events` (`event_id`, `client_id`, `coordinator_id`, `name_event`, `description`, `event_date`, `location`, `budget`, `status`) VALUES
(1, 1, 1, 'حفل زفاف خالد ولطيفة', 'حفل زفاف كبير لكبار الشخصيات', '2024-06-15', 'قاعة الريتز - الرياض', 80000.00, 'in_progress'),
(2, 2, 2, 'مؤتمر التقنية السنوي', 'مؤتمر تقني لشركات واعدة', '2024-07-10', 'مركز المعارض', 150000.00, 'not_started'),
(3, 1, 1, 'حفلة تخرج دفعة 2024', 'حفلة تخرج لـ 50 شخص', '2024-05-20', 'استراحة الدرعية', 15000.00, 'completed');

INSERT INTO `Tasks` (`task_id`, `event_id`, `assignment_type`, `assigned_user_id`, `assigned_supplier_id`, `type_task`, `description`, `cost`, `status`, `notes`) VALUES
(1, 1, 'SUPPLIER', NULL, 3, 'حجز قاعة الزفاف وتشمل الضيافة', 'تم الدفع بالكامل', 50000.00, 'COMPLETED', ''),
(2, 1, 'SUPPLIER', NULL, 1, 'تنفيذ الكوشة وتجهيزها', 'في مرحلة التصنيع', 4800.00, 'IN_PROGRESS', ''),
(3, 1, 'SUPPLIER', NULL, 2, 'تجهيز الصوتيات والإضاءة', 'التركيب يوم الزفاف عصراً', 2500.00, 'PENDING', ''),
(4, 2, 'SUPPLIER', NULL, 2, 'تجهيز مسرح المؤتمر', 'يحتاجون 10 مايكروفونات لاسلكية', 5000.00, 'PENDING', ''),
(5, 3, 'SUPPLIER', NULL, 1, 'تنسيق طاولات التخرج', 'تم التسليم بنجاح وتصوير المكان', 2000.00, 'COMPLETED', '');

