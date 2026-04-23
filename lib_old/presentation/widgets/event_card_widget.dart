part of 'widgets.dart';

// بطاقة عرض الحدث - ويدجت بدون حالة (Stateless)
class EventCard extends StatelessWidget {
  final models.EventModel event;  // الحدث المعروض - يتم تمريره من الابناء
  
  // constructor - مطلوب تمرير الحدث عند إنشاء البطاقة
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      // هوامش البطاقة: 8.0 من الأعلى والأسفل
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        // أيقونة على اليسار تمثل الحدث باللون الأزرق
        leading: const Icon(Icons.event, color: Colors.blue),
        
        // عنوان البطاقة - اسم الحدث بخط عريض
        title: Text(
          event.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        
        // المحتوى الفرعي للبطاقة
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,  // محاذاة المحتوى لليسار
          children: [
            // سطر لعرض تاريخ البدء
            Text('يبدأ: ${_formatDate(event.startDate)}'),
            
            // عرض تاريخ الانتهاء فقط إذا كان موجوداً (غير null)
            if (event.endDate != null)
              Text('ينتهي: ${_formatDate(event.endDate!)}'),
            
            // عرض الوصف فقط إذا كان موجوداً (غير null)
            if (event.description != null)
              Text(
                event.description!,
                maxLines: 1,  // سطر واحد فقط
                overflow: TextOverflow.ellipsis,  // إضافة (...) إذا تجاوز النص المساحة
              ),
          ],
        ),
        
        // أيقونة على اليمين تشير لإمكانية الانتقال
        trailing: const Icon(Icons.arrow_forward_ios),
        
        // عند النقر على البطاقة
        onTap: () {
          // الانتقال لصفحة تفاصيل الحدث باستخدام GetX
          // تمرير الحدث كـ arguments ليتم استخدامه في الصفحة التالية
          Get.toNamed(routes.Names.EVENTS_DATAIL, arguments: event);
        },
      ),
    );
  }
  
  // دالة مساعدة خاصة بالكلاس (تبدأ بشرطة سفلية)
  // وظيفتها: تنسيق تاريخ DateTime إلى نص مقروء
  String _formatDate(DateTime date) {
    // تنسيق التاريخ: يوم/شهر/سنة
    return '${date.day}/${date.month}/${date.year}';
  }
}