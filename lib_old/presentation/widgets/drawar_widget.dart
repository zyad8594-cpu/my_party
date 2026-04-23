part of 'widgets.dart';

class Drawer extends StatelessWidget 
{
  final int selectedIndex;

  const Drawer({
    super.key,
    required this.selectedIndex,
    // required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return material.Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // رأس الدراور
            _buildHeader(context),
            // قائمة العناصر
            Expanded(
              child: _buildMenuItems(context),
            ),
            // تذييل الدراور
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // رأس الدراور مع معلومات المستخدم
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المستخدم
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150/007bff/ffffff?text=User'),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 15),
          // اسم المستخدم
          Text(
            controllers.Auth.userAuth().name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          // البريد الإلكتروني
          Text(
            controllers.Auth.userAuth().email,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // قائمة عناصر الدراور
  Widget _buildMenuItems(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // العنصر الرئيسي
        _buildListTile(
          icon: Icons.home,
          title: 'الصفحة الرئيسية',
          index: 0,
          routName: routes.Names.HOME_HOME
        ),
        _buildListTile(
          icon: Icons.person,
          title: 'الملف الشخصي',
          index: 1,
          routName: routes.Names.PROFILE_INDEX
        ),
        
        _buildListTile(
          icon: Icons.settings,
          title: 'الأحداث',
          index: 2,
          routName: routes.Names.EVENTS_INDEX
        ),
        _buildListTile(
          icon: Icons.notifications,
          title: 'المهام',
          index: 3,
          routName: routes.Names.TASKS_INDEX
        ),
      ],
    );
  }

  // عنصر في القائمة
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required int index,
    required String routName
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: selectedIndex == index ? Colors.blue[50] : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: selectedIndex == index ? Colors.blue[800] : Colors.grey[700],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selectedIndex == index ? Colors.blue[800] : Colors.grey[700],
            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: selectedIndex == index 
            ? Icon(Icons.check, color: Colors.blue[800], size: 16)
            : null,
        onTap: () => Get.toNamed(routName),
      ),
    );
  }

  // تذييل الدراور
  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: controllers.Auth.logout,
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'تسجيل الخروج',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          Text(
            'الإصدار 1.0.0',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}