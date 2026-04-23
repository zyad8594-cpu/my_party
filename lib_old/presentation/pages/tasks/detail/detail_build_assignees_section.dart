part of 'detail_page.dart';

extension on DetailTask
{
  // قسم المعينين
  List<Widget> _buildAssigneesSection() {
    return [
      FutureBuilder(
        future: controller.fetchTaskAssigns(task.id), 
        builder: (context, snapshot){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('المعينون', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...controller.taskAss
                      .map((userAss) =>  _buildAssigneeItem(userAss['name'], userAss['email']),),
                ],
              ),
            ),
          );
        }
      ),
      const SizedBox(height: 16),
    ];
  }
  
}