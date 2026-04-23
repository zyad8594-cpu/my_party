part of 'profile_page.dart';

// صفحة الملف الشخصي
class IndexProfile extends GetView<controllers.Auth> 
{
  final eventController = Get.find<controllers.Event>();
  final taskController = Get.find<controllers.Task>();
  final userController = Get.find<controllers.User>();

  IndexProfile({super.key});
  // auth/change-password
  //        actions: authController.currentUser.value!.role == "coordinator"?[
  // ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth((){
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: ()=>Get.toNamed(routes.Names.PROFILE_UPDATE),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      drawer: widgets.Drawer(selectedIndex: 1),
      body: Obx(() 
      {
        // final user = controller.currentUser.value;
        // if (user == null) {
        //   return const Center(child: Text('يجب تسجيل الدخول'));
        // }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // صورة الملف الشخصي
              _buildProfileHeader(controllers.Auth.userAuth()),
              const SizedBox(height: 24),
              
              // المعلومات الشخصية
              _buildPersonalInfo(controllers.Auth.userAuth()),
              const SizedBox(height: 24),
              
              // الإحصائيات
              _buildStatsSection(),
              const SizedBox(height: 24),
              
              // الإجراءات
              _buildActionsSection(),
            ],
          ),
        );
      }),
    );
  });

  // رأس الملف الشخصي
  Widget _buildProfileHeader(models.UserModel user) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Text(
              user.name[0].toUpperCase(),
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(
              user.role == 'coordinator' ? 'منسق' : 'عضو',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: user.role == 'coordinator' ? Colors.orange : Colors.blue,
          ),
        ],
      ),
    );
  }

  // المعلومات الشخصية
  Widget _buildPersonalInfo(models.UserModel user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'المعلومات الشخصية',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoItem('الاسم الكامل', user.name),
            _buildInfoItem('البريد الإلكتروني', user.email),
            _buildInfoItem('الدور', user.role == 'coordinator' ? 'منسق' : 'عضو'),
            _buildInfoItem('تاريخ الإنشاء', _formatDate(user.createdAt)),
          ],
        ),
      ),
    );
  }

  // عنصر معلومات
  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  // قسم الإحصائيات
  Widget _buildStatsSection()
  {
    eventController.fetchEvents();
    taskController.fetchTasks();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الإحصائيات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 _buildStatItem('الأحداث', eventController.events.length),
                 _buildStatItem('المهام', taskController.tasks.length),
                 _buildStatItem(
                    'المكتمل', 
                    taskController.tasks
                      .where((task)=> (task.userId == controllers.Auth.userAuth().id && task.status == "completed")).length
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // عنصر إحصائي
  Widget _buildStatItem(String label, [int value = 0])
  {
    return Column(
      children: [
        Text(
            '$value',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        
        Text(label),
      ],
    );
  }

  // قسم الإجراءات
  Widget _buildActionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الإجراءات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildActionButton('تغيير كلمة المرور', Icons.lock, () {
              Get.toNamed(routes.Names.PROFILE_CHANGE_PASSWORD);
            }),
            _buildActionButton('تسجيل الخروج', Icons.logout, () {
              controllers.Auth.logout();
            }),
          ],
        ),
      ),
    );
  }

  // زر إجراء
  Widget _buildActionButton(String text, IconData icon, VoidCallback onPressed) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onPressed,
    );
  }

  // تعديل الملف الشخصي
  // void _editProfile() {
  //   Get.defaultDialog(
  //     title: 'تعديل الملف الشخصي',
  //     content: const Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Text('هذه الخاصية قيد التطوير'),
  //     ),
  //     textConfirm: 'حسناً',
  //     onConfirm: () => Get.back(),
  //   );
  // }

  // // تغيير كلمة المرور
  // void _changePassword() {
    
  //   Get.defaultDialog(
  //     title: 'تغيير كلمة المرور',
  //     content: const Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Text('هذه الخاصية قيد التطوير'),
  //     ),
  //     textConfirm: 'حسناً',
  //     onConfirm: () => Get.back(),
  //   );
  // }

  // تنسيق التاريخ
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}