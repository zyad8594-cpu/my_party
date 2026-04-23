part of 'widgets.dart';

// بطاقة عرض المهمة - ويدجت بدون حالة (Stateless)
class TaskCard extends StatelessWidget {
  final models.TaskModel task;  // المهمة المعروضة - يتم تمريرها من الابناء
  
  // constructor - مطلوب تمرير المهمة عند إنشاء البطاقة
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      // هوامش البطاقة: 8.0 من الأعلى والأسفل
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        // أيقونة على اليسار تعتمد على حالة المهمة
        leading: _getStatusIcon(),
        
        // عنوان البطاقة - عنوان المهمة بخط عريض
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        
        // المحتوى الفرعي للبطاقة
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // محاذاة المحتوى لليسار
          children: [
            // عرض حالة المهمة مكتوبة بالعربية
            Text('الحالة: ${_getStatusText(task.status)}'),
            
            // عرض تاريخ الاستحقاق فقط إذا كان موجوداً (غير null)
            if (task.dueDate != null)
              Text('الاستحقاق: ${_formatDate(task.dueDate!)}'),
            
            // عرض الوصف فقط إذا كان موجوداً (غير null)
            if (task.description != null)
              Text(
                task.description!,
                maxLines: 1,  // سطر واحد فقط
                overflow: TextOverflow.ellipsis,  // إضافة (...) إذا تجاوز النص المساحة
              ),
          ],
        ),
        
        // أيقونة على اليمين تشير لإمكانية الانتقال
        trailing: const Icon(Icons.arrow_forward_ios),
        
        // عند النقر على البطاقة
        onTap: () {
          // الانتقال لصفحة تفاصيل المهمة باستخدام GetX
          // تمرير المهمة كـ arguments ليتم استخدامها في الصفحة التالية
          Get.toNamed('/task/detail', arguments: task);
        },
      ),
    );
  }
  
  // دالة خاصة لاختيار الأيقونة المناسبة بناءً على حالة المهمة
  Widget _getStatusIcon() {
    switch (task.status) {
      case 'completed':  // إذا كانت المهمة مكتملة
        return const Icon(Icons.check_circle, color: Colors.green);  // أيقونة دائرة خضراء بعلامة صح
      case 'in_progress':  // إذا كانت المهمة قيد التنفيذ
        return const Icon(Icons.access_time, color: Colors.orange);  // أيقونة ساعة برتقالية
      default: // pending - الحالة الافتراضية (معلقة)
        return const Icon(Icons.pending, color: Colors.red);  // أيقونة انتظار حمراء
    }
  }
  
  // دالة لتحويل حالة المهمة من الإنجليزية إلى العربية
  String _getStatusText(String status) {
    switch (status) {
      case 'completed':  // مكتملة
        return 'مكتملة';
      case 'in_progress':  // قيد التنفيذ
        return 'قيد التنفيذ';
      default: // pending - معلقة
        return 'معلقة';
    }
  }
  
  // دالة مساعدة لتنسيق التاريخ
  String _formatDate(DateTime date) {
    // تنسيق التاريخ: يوم/شهر/سنة
    return '${date.day}/${date.month}/${date.year}';
  }
}