part of 'detail_page.dart';

extension on DetailEvent
{
  // تبويب التفاصيل
  Widget _buildDetailsTab() {
    
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الإحصائيات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._buildShortStatistics(),
            // _buildStatsRow(),
          ],
        ),
      )
    ;
  }

  // بناء معلومات الحدث
  Widget _buildEventInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 4),
              Expanded(child: Text('يبدأ: ${_formatDate(event.startDate)}')),
            ],
          ),
          if (event.endDate != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Expanded(child: Text('ينتهي: ${_formatDate(event.endDate!)}')),
              ],
            ),
          ],
          if (event.description != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.description, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'الوصف: ${event.description!}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            )
          ],

          
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.watch_later, size: 16),
              const SizedBox(width: 4),
              Expanded(child: Text('تاريخ الإنشاء: ${_formatDate(event.createdAt)}')),
            ],
          ),
          
         
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.man, size: 16),
              const SizedBox(width: 4),
              Expanded(child: Text('منشئ الحدث: ${event.creatorName ?? 'غير معروف'}')),
            ],
          ),

          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.numbers, size: 16),
              const SizedBox(width: 4),
              Expanded(child: Text('معرف الحدث: ${event.id.toString()}')),
            ],
          ),
        ],
      ),
    );
  }

  // صف الإحصائيات
  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('المهام', taskController.tasks.where((task) => task.eventId == event.id).length.toString()),
        _buildStatItem('الأعضاء', controller.eventMembers.length.toString()),
        _buildStatItem('المكتمل', taskController.tasks
          .where((task) => task.eventId == event.id)
          .where((task) => task.status == "completed")
          .length.toString()
        ),
      ],
    );
  }
  
  // عنصر إحصائي
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
  
  // تنسيق التاريخ
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // بطاقة عدد المهام
  Widget _buildStatisticCard({
    IconData? icon,
    String title = '',
    String CON = '',
  })
  {
    const style = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    return Expanded(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(icon, size: 40, color: Colors.green),
                const SizedBox(height: 8),
                switch(CON)
                {
                  'Task' => Obx(() => Text('${taskController.tasks.length}', style: style)),
                  'Event' => Obx(() => Text('${controller.events.length}', style: style)),
                  'EventMember' => Obx(() => Text('${eventMemberController.eventMembers.length}', style: style)),
                  _ => Text('0', style: style)
                },
                Text(title),
              ],
            ),
          ),
        ),
      );
  }

  List<Widget> _buildShortStatistics()
  {
    return [
      GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2, // عدد الأعمدة
        crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
        mainAxisSpacing: 10, // المسافة الرأسية بين العناصر
        children: <Widget>[
          _buildStatisticCard(
            title: 'مهمة',
            icon: Icons.task,
            CON: 'Task'
          ),
          _buildStatisticCard(
            title: 'حدث',
            icon: Icons.task,
            CON: 'Event'
          ),
          _buildStatisticCard(
            title: 'عضو',
            icon: Icons.task,
            CON: 'EventMember'
          ),
        ],
      ),
      const SizedBox(height: 16),
    ];
  }







  // // تنسيق التاريخ والوقت
  // String _formatDateTime(DateTime date) {
  //   return '${_formatDate(date)} ${date.hour}:${date.minute}';
  // }
  
  // // عنصر تفصيلي
  // Widget _buildDetailItem(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: Row(
  //       children: [
  //         Text(
  //           '$label: ',
  //           style: const TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         Text(value),
  //       ],
  //     ),
  //   );
  // }
  
}