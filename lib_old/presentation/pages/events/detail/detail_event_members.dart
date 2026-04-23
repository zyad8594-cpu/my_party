part of 'detail_page.dart';


extension on DetailEvent
{
 
  // تبويب الأعضاء
  Widget _buildMembersTab() 
  {
    return MembersEvent(event: event);
    // return EventMembersPage(event: event);
    // return Center(child: TextButton(onPressed: ()=> Get.toNamed(AppRoutes.EVENTS_MEMBERS, arguments: event), child: Text('members')),);
    // return FutureBuilder(
    //   future: eventMemberController.fetchEventMembers(event.id),
    //   builder: (context, snapshot) 
    //   {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const widgets.LoadingWidget(message: 'جاري تحميل الأعضاء...');
    //     }

    //     return Obx(() {
    //       final eventMembers = eventMemberController.eventMembers;
          
    //       if (eventMembers.isEmpty) {
    //         return const widgets.EmptyWidget(
    //           message: 'لا يوجد أعضاء لهذا الحدث',
    //           icon: Icons.task,
    //         );
    //       }

    //       return ListView.builder(
    //         itemCount: eventMembers.length,
    //         itemBuilder: (context, index) {
    //           return widgets.EventMemberCard(eventMember: eventMembers[index],);
    //         },
    //       );
    //     });
    //   },
    // );
  }
  
}
