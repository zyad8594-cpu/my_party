part of 'index_page.dart';

extension on IndexEvent
{
  PreferredSizeWidget _appBar(){
    return widgets.AppBar(
      title: 'جميع الأحداث',
      actions: <Widget>[
        // زر تحديث القائمة
        IconButton
        (
          onPressed: () {
            controller.updateFilter(onRefresh: true);
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  // قائمة الأحداث
  List<Widget> _buildListEvents() 
  {
    return [
      Expanded(
        child: Obx(() 
        {
          // _applyFilter(controller.filterSerch.value);
          if (controller.isLoading.value) 
          {
            return const widgets.LoadingWidget(message: 'جاري تحميل الأحداث...');
          }
          else if (controller.listEvents.isEmpty) 
          {
            return const widgets.EmptyWidget(message: 'لا توجد أحداث حالياً', icon: Icons.event_note,);
          }
            
          return RefreshIndicator
          (
            onRefresh: () => controller.updateFilter(onRefresh: true), // سحب للتحديث
            child: ListView.builder(
              itemCount: controller.listEvents.length,
              itemBuilder: (context, index) 
              {
                final event = controller.listEvents[index];
                return widgets.EventCard(event: event);
              },
            ),
          );
        }),
      ),
    ];
  }

  // زر الإضافة العائم (يظهر فقط للمنسقين)
  Widget _buildFloatingButton() 
  {
    return Obx(() 
    {
      
      if (controllers.Auth.userAuth().role == 'coordinator') 
      {
        return FloatingActionButton
        (
          onPressed: () =>Get.toNamed(routes.Names.EVENTS_CREATE),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, color: Colors.white),
        );
      }
      return const SizedBox.shrink(); // إخفاء الزر إذا لم يكن منسق
    });
  }

  // شريط البحث والتصفية
  List<Widget> _buildSearchFilterBar() 
  {
    return [
      Row(
        children: 
        [
          // حقل البحث
          Expanded
          (
            child: TextField
            (
              decoration: InputDecoration
              (
                hintText: 'ابحث عن حدث...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder
                (
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
      
              onChanged: (value) 
              {
                controller.filedSerch.value = value;
                controller.updateFilter();
              },
            ),
          ),
          const SizedBox(width: 8),
          
          // زر التصفية
          PopupMenuButton<String>
          (
            icon: const Icon(Icons.filter_list),
            onSelected: (value) 
            {
              controller.updateFilter(filter: value, userId: controllers.Auth.userAuth().id, onRefresh: true);
            },
      
            itemBuilder: (context) => 
            [
              const PopupMenuItem(value: 'all', child: Text('جميع الأحداث')),
              const PopupMenuItem(value: 'my_events', child: Text('أحداثي فقط')),
              const PopupMenuItem(value: 'upcoming', child: Text('القادمة')),
              const PopupMenuItem(value: 'past', child: Text('الماضية')),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
    ]
    ;
  }

  
}