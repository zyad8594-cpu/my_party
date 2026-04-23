part of 'detail_page.dart';

extension on DetailTask
{
  // عنصر تاريخ
  Widget _buildDateItem(String label, DateTime date) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(_formatDate(date)),
      ],
    );
  }
  
}