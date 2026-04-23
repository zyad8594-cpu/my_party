part of 'detail_page.dart';

extension on DetailEvent
{
  // تبويب المهام
  Widget _buildTasksTab() {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: taskController.fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const widgets.LoadingWidget(message: 'جاري تحميل المهcام...');
          }
      
          return Obx(() {
            final tasks = taskController.tasks.where((task) => task.eventId == event.id).toList();
            
            if (tasks.isEmpty) {
              return const widgets.EmptyWidget(
                message: 'لا توجد مهام لهذا الحدث',
                icon: Icons.task,
              );
            }
      
            return Column(
              children: [...List.generate(
              tasks.length,
              (index) {
                return widgets.TaskCard(task: tasks[index]);
              },
            )]);
          });
        },
      ),
    );
  }
  
}