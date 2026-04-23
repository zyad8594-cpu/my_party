part of 'detail_page.dart';

extension on DetailTask
{
  // قسم الإجراءات
  List<Widget> _buildActionsSection() {
    return controllers.Auth.userAuth().role == "coordinator"? [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('الإجراءات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (task.status != 'completed') ...[
                _buildActionButton('بدء التنفيذ', Icons.play_arrow, Colors.orange, () 
                {
                  _changeTaskStatus(task, 'in_progress');
                }),
                const SizedBox(height: 8),
              ],
              if (task.status == 'in_progress') ...[
                _buildActionButton('إكمال المهمة', Icons.check, Colors.green, () 
                {
                  _changeTaskStatus(task, 'completed');
                }),
                const SizedBox(height: 8),
              ],
              _buildActionButton('إعادة فتح', Icons.refresh, Colors.blue, () {
                _changeTaskStatus(task, 'pending');
              }),
            ],
          ),
        ),
      )
    ] : [];
  }
  
}