// import 'package:flutter/dart' as material;
part of 'widgets.dart';

class AppBar extends material.AppBar
{
  final bool showBackButton;
  final bool showUserInfo;
  AppBar({
    super.key,
    this.showBackButton = true,
    this.showUserInfo = false,
    String title = Consetents.Config.APP_NAME,
    super.automaticallyImplyLeading = true,
    List<Widget>? actions,
    super.flexibleSpace,
    super.bottom,
    super.elevation,
    super.scrolledUnderElevation,
    super.notificationPredicate = defaultScrollNotificationPredicate,
    super.shadowColor,
    super.surfaceTintColor,
    super.shape,
    super.backgroundColor = Colors.blue,
    super.foregroundColor = Colors.white,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.excludeHeaderSemantics = false,
    super.titleSpacing,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.toolbarHeight,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
    super.forceMaterialTransparency = false,
    super.useDefaultSemanticsOrder = true,
    super.clipBehavior,
    super.actionsPadding,
    super.animateColor = false,
  }): super(
    title: Text(title),
    centerTitle: true,
    leading: showBackButton ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ) : null,
    actions: [
    if (showUserInfo) _buildUserInfo(),
      ...?actions,
    ]
  );

   // معلومات المستخدم
  static Widget _buildUserInfo() {
    return GetBuilder<controllers.Auth>(
      builder: (authController) {
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Text(
                  controllers.Auth.userAuth().name[0],
                  style: const TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controllers.Auth.userAuth().name.split(' ').first,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }


}

// شريط بحث مخصص
class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
