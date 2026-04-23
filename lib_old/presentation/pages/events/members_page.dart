part of 'events_page.dart';

// صفحة إدارة أعضاء الحدث
class MembersEvent extends GetView<controllers.EventMember> 
{
  final models.EventModel event;
  final userController = Get.find<controllers.User>();
  // RxList  availableUsers = <models.UserModel>[].obs;

  MembersEvent({super.key, required this.event});

  

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth(() {
    controller.fetchEventMembers(event.id); // تحميل الأعضاء
    userController.all(); 
    // تحميل المستخدمين المتاحين
    //  availableUsers.value = userController.users.where(
    //   (models.UserModel user) => !controller.eventMembers.any((test)=> user.id == test.userId )
    //  ).toList();
     
    return Column(
      children: [
        // إحصائيات سريعة
        _buildStatsCard(),
        const SizedBox(height: 16),
        
        // علامات التبويب
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'أعضاء الحدث'),
                    Tab(text: 'إضافة أعضاء'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildMembersList(),    // قائمة الأعضاء الحاليين
                      FutureBuilder(
                        future:   userController.all(),
                        builder: (context, asyncSnapshot) {
                    
                          return _buildAddMembersTab(asyncSnapshot.data ?? []);
                        }
                      ), // تبويب إضافة أعضاء
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      
      ],
    );
  });

  // بطاقة الإحصائيات
  Widget _buildStatsCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('إجمالي الأعضاء', controller.eventMembers.length),
            _buildStatItem('المنسقين', 
              controller.eventMembers.where((m) => m.role == 'coordinator').length),
            _buildStatItem('الأعضاء', 
              controller.eventMembers.where((m) => m.role == 'member').length),
          ],
        ),
      ),
    );
  }

  // عنصر إحصائي
  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  // قائمة الأعضاء الحاليين
  Widget _buildMembersList() 
  {
    return Obx((){
      if(controller.isLeaving.value)
      {
        return widgets.LoadingWidget();
      }
      if (controller.eventMembers.isEmpty) {
        return const widgets.EmptyWidget(
          message: 'لا يوجد أعضاء في هذا الحدث',
          icon: Icons.people,
        );
      }

      return ListView.builder(
        itemCount: controller.eventMembers.length,
        itemBuilder: (context, index) {
          final member = controller.eventMembers[index];
          return _buildMemberItem(member);
        },
      );
    });
  }

  // عنصر العضو
  Widget _buildMemberItem(models.EventMemberModel member) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            member.name != null? member.name![0] : '', // الحرف الأول من الاسم
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(member.name ?? ''),
        subtitle: Text(member.email ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(
                member.role == 'coordinator' ? 'منسق' : 'عضو',
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: member.role == 'coordinator' 
                  ? Colors.orange.shade100 
                  : Colors.grey.shade100,
            ),
            const SizedBox(width: 8),
            if(controllers.Auth.userAuth().role == "coordinator") PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) => _handleMemberAction(value, member),
              itemBuilder: (context) => _buildMemberMenuItems(member),
            ),
          ],
        ),
      ),
    );
  }

  // تبويب إضافة أعضاء
  Widget _buildAddMembersTab(List<models.UserModel> availableUsers) 
  {
    
    if(userController.isLoading.value)
    {
      return widgets.LoadingWidget();
    }
    if (availableUsers.isEmpty) {
      return const widgets.EmptyWidget(
        message: 'لا يوجد مستخدمون متاحون للإضافة',
        icon: Icons.person_add,
      );
    }

    return ListView.builder(
      itemCount: availableUsers.length,
      itemBuilder: (context, index) {
        final user = availableUsers[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                user.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(user.name),
            subtitle: Text(user.role == 'coordinator' ? 'منسق' : 'عضو'),
            trailing: ElevatedButton(
              onPressed: () => _addMember(user),
              child: const Text('إضافة'),
            ),
          ),
        );
      },
    );
  }

  // بناء عناصر قائمة العضو
  List<PopupMenuItem<String>> _buildMemberMenuItems(models.EventMemberModel member) {
    final items = <PopupMenuItem<String>>[];
    
    items.add(const PopupMenuItem(value: 'change_role', child: Text('تغيير الدور')));
    items.add(const PopupMenuItem(value: 'remove', child: Text('إزالة من الحدث')));
    
    return items;
  }

  // معالجة إجراءات العضو
  void _handleMemberAction(String action, models.EventMemberModel member) {
    switch (action) {
      case 'change_role':
        _changeMemberRole(member);
        break;
      case 'remove':
        _removeMember(member);
        break;
    }
  }

  // تغيير دور العضو
  void _changeMemberRole(models.EventMemberModel member) {
    final newRole = member.role == 'coordinator' ? 'member' : 'coordinator';
    
    Get.defaultDialog(
      title: 'تغيير الدور',
      middleText: 'هل تريد تغيير دور ${member.name ?? ""} إلى ${newRole == 'coordinator' ? 'منسق' : 'عضو'}؟',
      textConfirm: 'تغيير',
      textCancel: 'إلغاء',
      onConfirm: () {
         controller.changeMemberRole(event.id, member.userId, member.role);
          
        Get.back();
        Get.snackbar('نجاح', 'تم تغيير الدور بنجاح');
      },
    );
  }

  // إزالة العضو من الحدث
  void _removeMember(models.EventMemberModel member) {
    Get.defaultDialog(
      title: 'إزالة العضو',
      middleText: 'هل تريد إزالة ${member.name ?? ''} من الحدث؟',
      textConfirm: 'إزالة',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      onConfirm: () {
        // setState(() {
          controller.removeMember(event.id, member.userId);
        // });
        Get.back();
        Get.snackbar('نجاح', 'تم إزالة العضو بنجاح');
      },
    );
  }

  // إضافة عضو جديد
  void _addMember(models.UserModel user) {
      try {
        controller.addMember(event.id, user.id);
        Get.snackbar('نجاح', 'تم إضافة ${user.name} إلى الحدث');
      } catch (e) {
         Get.snackbar('خطاء', "لم تتم الإضافة بنجاح");
      }
      
  }
}