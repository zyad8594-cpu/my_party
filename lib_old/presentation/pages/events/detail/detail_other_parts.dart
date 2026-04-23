part of 'detail_page.dart';

extension on DetailEvent
{

  
  PreferredSizeWidget _appBar()
  {
    return widgets.AppBar(
        title: event.name,
        actions: controllers.Auth.userAuth().role == "coordinator"?[
          // قائمة الخيارات
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => _buildMenuItems(),
          ),
        ]:[],
        bottom: TabBar(
            tabs: [
              Tab(text: 'المهام'),
              Tab(text: 'الأعضاء'),
              Tab(text: 'التفاصيل'),
            ],
          ),
      );
  }
  // بناء عناصر القائمة
  List<PopupMenuItem<String>> _buildMenuItems() 
  {
    final isOwner = controllers.Auth.userAuth().id == event.userId;
    final isCoordinator = controllers.Auth.userAuth().role == 'coordinator';

    final items = <PopupMenuItem<String>>[];

    if (isOwner || isCoordinator) {
      items.add(const PopupMenuItem(value: 'edit', child: Text('تعديل')));
      items.add(const PopupMenuItem(value: 'delete', child: Text('حذف')));
    }

    // items.add(const PopupMenuItem(value: 'share', child: Text('مشاركة')));

    return items;
  }

  // معالجة إجراءات القائمة
  void _handleMenuAction(String action) {
    switch (action) {
      case 'edit':
        _editEvent();
        break;
      case 'delete':
        _deleteEvent();
        break;
      case 'share':
        _shareEvent();
        break;
    }
  }

  // تعديل الحدث
  void _editEvent() {
    Get.toNamed(routes.Names.EVENTS_CREATE, arguments: event);
  }

  // حذف الحدث
  void _deleteEvent() {
    Get.defaultDialog(
      title: 'تأكيد الحذف',
      middleText: 'هل أنت متأكد من حذف هذا الحدث؟',
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final success = await controller.deleteEvent(event.id);
        if (success) 
        {
          Get.offAllNamed(routes.Names.EVENTS_INDEX); // العودة للصفحة السابقة
        }
      },
    );
  }

  // مشاركة الحدث
  void _shareEvent() {
    Get.snackbar('مشاركة', 'تم نسخ رابط الحدث');
  }
  







  /* Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('الكل', 'all'),
            const SizedBox(width: 8),
            _buildFilterChip('معلقة', 'pending'),
            const SizedBox(width: 8),
            _buildFilterChip('قيد التنفيذ', 'in_progress'),
            const SizedBox(width: 8),
            _buildFilterChip('مكتملة', 'completed'),
          ],
        ),
      ),
    );
  }
  Widget _buildFilterChip(String label, String value) {
    return Obx(()=>FilterChip(
        label: Text(label),
        onSelected: (selected) {},
      ),
    );
  } */
}