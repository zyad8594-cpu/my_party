part of 'widgets.dart';

// بطاقة عرض المهمة
class EventMemberCard extends StatelessWidget {
  final models.EventMemberModel eventMember;                                        // المهمة المعروضة
  // final controllers.Auth controller;
  const EventMemberCard({
    super.key, 
    // required this.controller,
    required this.eventMember
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.person),                            // أيقونة حسب الحالة
        title: Text(
          eventMember.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الصلاحية: ${eventMember.role}'),   // نص الحالة
            Text('البريد: ${eventMember.email}'),
            // if (eventMember.joinedAt != null)
              Text('تأريخ الإنضمام: ${eventMember.joinedAt}'),
          ],
        ),
        trailing: controllers.Auth.userAuth().role == "coordinator"? 
        PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value, eventMember),
            itemBuilder: (context) {
              final items = <PopupMenuItem<String>>[];
              //  final currentUser = controller.currentUser.value;
              final isOwner = controllers.Auth.userAuth().id == eventMember.userId;

              if (isOwner) 
              {
                items.add(const PopupMenuItem(value: 'edit', child: Text('تعديل')));
                items.add(const PopupMenuItem(value: 'delete', child: Text('حذف')));
              }

            // items.add(const PopupMenuItem(value: 'share', child: Text('مشاركة')));

            return items;
            },
        ) : null,
        
      ),
    );
  }

  // معالجة إجراءات القائمة
  void _handleMenuAction(String action, models.EventMemberModel event) {
    switch (action) {
      case 'edit':
        // _editEvent(event);
        break;
      case 'delete':
        // _deleteEvent(event);
        break;
    }
  }
}