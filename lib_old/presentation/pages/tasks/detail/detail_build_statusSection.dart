part of 'detail_page.dart';

extension on DetailTask{

  // قسم حالة المهمة
  List<Widget> _buildStatusSection() {
    Color statusColor;
    String statusText;
    
    switch (task.status) {
      case 'completed':
        statusColor = Colors.green;
        statusText = 'مكتملة';
        break;
      case 'in_progress':
        statusColor = Colors.orange;
        statusText = 'قيد التنفيذ';
        break;
      default: // pending.0.0.0
        statusColor = Colors.red;
        statusText = 'معلقة';
    }
    
    return [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.circle, color: statusColor, size: 16),
              const SizedBox(width: 8),
              const Text('الحالة:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
              const Spacer(),
              Chip(
                label: Text(statusText),
                backgroundColor: statusColor.withOpacity(0.1),
                labelStyle: TextStyle(color: statusColor),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ];
  }
}