part of 'detail_page.dart';

extension on DetailTask
{
  PreferredSizeWidget _appBar()
  {
    return widgets.AppBar(
        title: 'تفاصيل المهمة',
        actions: controllers.Auth.userAuth().role == "coordinator"? [
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value, task),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('تعديل')),
              const PopupMenuItem(value: 'delete', child: Text('حذف')),
              // const PopupMenuItem(value: 'share', child: Text('مشاركة')),
            ],
          ),
        ]: [],
      );
  }
}