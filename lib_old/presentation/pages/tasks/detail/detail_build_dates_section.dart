part of 'detail_page.dart';

extension on DetailTask
{
  // قسم التواريخ
  List<Widget> _buildDatesSection() {
    return [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('التواريخ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildDateItem('تاريخ الإنشاء', task.createdAt),
              if (task.dueDate != null) ...[
                const SizedBox(height: 8),
                _buildDateItem('تاريخ الاستحقاق', task.dueDate!),
              ],
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ];
  }
}

 
  