part of 'index_page.dart';

extension on IndexTask{
  // شريط التصفية
   Widget _buildFilterBar() {
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

  // شريط التصفية
  Widget _buildFilterChip(String label, String value) {
    return Obx(()=>FilterChip(
        label: Text(label),
        selected: controller.currentFilter.value == value,
        onSelected: (selected) => controller.updateCurrentFilter(value),
      ),
    );
  }

  // قائمة المهام
  Widget _listTasks()
  {
    return Expanded(
      child: Obx(() {
        // controller.fetchTasks();
        if (controller.isLoading.value) {
          return const widgets.LoadingWidget(message: 'جاري تحميل المهام...');
        }
        
        
        final tasks = controller.getFilteredTasks();
        if (tasks.isEmpty) {
          return const widgets.EmptyWidget(
            message: 'لا توجد مهام',
            icon: Icons.task,
          );
        }
        
        return RefreshIndicator(
          onRefresh:  controller.fetchTasks,
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return widgets.TaskCard(task: tasks[index]);
            },
          ),
        );
      }),
    );
  }

  // الزر العائم
  Widget? _floatingButton(){
    return controllers.Auth.userAuth().role == "coordinator"?
      FloatingActionButton(
        onPressed: () {
          Get.toNamed(routes.Names.TASKS_CREATE);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
    ): null;
  }
  
}