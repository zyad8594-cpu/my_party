part of 'detail_page.dart';

extension on DetailTask
{
  // قسم الوصف
  List<Widget> _buildDescriptionSection() {
    return task.description != null?
    [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                task.description!,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ] : [];
  }
  
}