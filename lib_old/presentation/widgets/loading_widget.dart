part of 'widgets.dart';

// ويدجت تحميل مخصص - يعرض مؤشر تحميل مع رسالة
class LoadingWidget extends StatelessWidget {
  final String message;  // رسالة التحميل - يمكن تخصيصها أو استخدام القيمة الافتراضية
  
  // constructor - رسالة اختيارية مع قيمة افتراضية 'جاري التحميل...'
  const LoadingWidget({super.key, this.message = 'جاري التحميل...'});

  @override
  Widget build(BuildContext context) {
    return Center(  // توسيط المحتوى في منتصف الشاشة
      child: Column(  // ترتيب العناصر عمودياً
        mainAxisAlignment: MainAxisAlignment.center,  // توسيط العناصر عمودياً
        children: [
          const CircularProgressIndicator(),  // دائرة تحميل دائرية متحركة
          const SizedBox(height: 16),  // مسافة فارغة 16 بكسل بين العناصر
          Text(
            message,  // نص رسالة التحميل
            style: const TextStyle(fontSize: 16),  // حجم الخط 16
          ),
        ],
      ),
    );
  }
}

// ويدجت لعدم وجود بيانات - يعرض عندما لا توجد بيانات لعرضها
class EmptyWidget extends StatelessWidget {
  final String message;  // رسالة عدم وجود بيانات
  final IconData icon;   // الأيقونة المعروضة
  
  // constructor - قيم افتراضية للرسالة والأيقونة
  const EmptyWidget({
    super.key,
    this.message = 'لا توجد بيانات',  // القيمة الافتراضية للرسالة
    this.icon = Icons.inbox,          // القيمة الافتراضية للأيقونة (أيقونة صندوق)
  });

  @override
  Widget build(BuildContext context) {
    return Center(  // توسيط المحتوى في منتصف الشاشة
      child: Column(  // ترتيب العناصر عمودياً
        mainAxisAlignment: MainAxisAlignment.center,  // توسيط العناصر عمودياً
        children: [
          Icon(
            icon,         // الأيقونة الممررة أو الافتراضية
            size: 64,     // حجم الأيقونة 64 بكسل
            color: Colors.grey,  // لون رمادي للأيقونة
          ),
          const SizedBox(height: 16),  // مسافة فارغة 16 بكسل بين العناصر
          Text(
            message,  // نص رسالة عدم وجود بيانات
            style: const TextStyle(
              fontSize: 16,        // حجم الخط 16
              color: Colors.grey,  // لون رمادي للنص
            ),
          ),
        ],
      ),
    );
  }
}