part of 'detail_page.dart';

extension on DetailTask
{
  // عنصر معين
  Widget _buildAssigneeItem(String name, String role) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(name[0], style: const TextStyle(color: Colors.white)),
      ),
      title: Text(name),
      subtitle: Text(role),
      trailing: const Icon(Icons.person, color: Colors.grey),
    );
  }
  
}