part of 'index_page.dart';

extension on IndexHome
{
  // ترحيب بالمستخدم
  List<Widget> _buildUserWelcome()
  {
    return [
      Obx(() {
        return Text
        (
          'مرحباً، ${controllers.Auth.userAuth().name}!',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        );
      }),
      const SizedBox(height: 20),
    ];
  }

  // إحصائيات سريعة
  List<Widget> _buildShortStatistics()
  {
    return [
      Row(
        children: [
          // بطاقة عدد الأحداث
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>
                  [
                    const Icon(Icons.event, size: 40, color: Colors.blue),
                    const SizedBox(height: 8),
                    Obx((){
                        controller.fetchEvents();
                      return Text(
                          '${controller.events.length}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        );
                    }),
                    const Text('حدث'),
                  ],
                ),
              ),
            ),
          ),
          
          // بطاقة عدد المهام
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.task, size: 40, color: Colors.green),
                    const SizedBox(height: 8),
                    Obx((){ 
                      taskController.fetchTasks();
                      return Text(
                          '${taskController.tasks.length}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        );
                    }),
                    const Text('مهمة'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
      const SizedBox(height: 20),
    ];
  }

  // قسم الأحداث القريبة أو المهام العاجلة
  List<Widget> _buildTasksOrEventsSections(String routeName)
  {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            (routeName == routes.Names.EVENTS_INDEX)? 'أحداثي القادمة' : 'مهامي العاجلة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () 
            {
              switch(routeName)
              {
                case routes.Names.EVENTS_INDEX: 
                  controller.updateFilter(onRefresh: true);
                break;
              }
              Get.toNamed(routeName);
              
            },
            child: const Text('عرض الكل'),
          ),
        ],
      ),
    ];
  }

  // قائمة المهام أو الأحداث
  List<Widget>_buildTasksOrEventsList([bool tController = false])
  {
    return [
      Expanded(
        flex: 1,
        child: Obx(() {

            if ((tController && taskController.isLoading.value) || (!tController && controller.isLoading.value)) {
              return const Center(child: CircularProgressIndicator());
            }
          
            final tasksC = tController?
              taskController.tasks
                .where((task) => task.status != 'completed')
                .take(3).toList() 
              : null;
            final eventsC = (!tController)?
              controller.events.take(3).toList() : null; // أول 3 objects غير مكتملة
            
            if ((tasksC ?? eventsC)!.isEmpty) {
              return Center(child: Text(tController? 'لا توجد مهام عاجلة' : 'لا توجد أحداث'));
            }
          
            return ListView.builder(
              itemCount: (tasksC ?? eventsC)!.length,
              itemBuilder: (context, index) {
                return tController? 
                  widgets.TaskCard(task: tasksC![index])
                : widgets.EventCard(event: eventsC![index]);
              },
            );
        }),
      ),

      const SizedBox(height: 20),
    ];
  }


}