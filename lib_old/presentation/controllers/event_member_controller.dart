import 'package:get/get.dart';
import '../../data/data.dart' as EventMmRpMd show EventMemberRepository, EventMemberModel;

class EventMember extends GetxController 
{
  final EventMmRpMd.EventMemberRepository _eventMemberRepository = EventMmRpMd.EventMemberRepository();

  // حالات التحميل
  final isLoading = false.obs;
  final isJoining = false.obs;
  final isLeaving = false.obs;
  final isChangingRole = false.obs;

  // البيانات
  final errorMessage = ''.obs;
  final eventMembers = <EventMmRpMd.EventMemberModel>[].obs;
  final userEvents = <EventMmRpMd.EventMemberModel>[].obs;
  final membershipStatus = Rx<EventMmRpMd.EventMemberModel?>(null);
  final lastActionResult = Rx<dynamic>(null);


  // الانضمام إلى حدث
  Future<bool> joinEvent(int eventId) async {
    isJoining.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      final result = await _eventMemberRepository.joinEvent(eventId);
      lastActionResult.value = result;
      isJoining.value = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isJoining.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // مغادرة حدث
  Future<bool> leaveEvent(int eventId) async {
    isLeaving.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      final result = await _eventMemberRepository.leaveEvent(eventId);
      lastActionResult.value  = {'success': result};
      isLeaving.value = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLeaving.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // جلب أعضاء حدث معين
  Future<void> fetchEventMembers(int eventId) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      eventMembers.value = await _eventMemberRepository.getEventMembers(eventId)?? [];
      isLoading.value = false;
      // notifyListeners();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      Get.snackbar('title', 'message');
    }
  }

  // جلب أحداث مستخدم معين
  Future<void> fetchUserEvents(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      userEvents.value = await _eventMemberRepository.getUserEvents(userId)?? [];
      isLoading.value = false;
      // notifyListeners();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
    }
  }

  // تغيير دور العضو
  Future<bool> changeMemberRole(int eventId, int userId, String role) async {
    isChangingRole.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      final result = await _eventMemberRepository.changeMemberRole(eventId, userId, role);
      lastActionResult.value  = result;
      isChangingRole.value = false;
      
      // تحديث قائمة الأعضاء إذا كانت محملة
      if (eventMembers.isNotEmpty) {
        final index = eventMembers.indexWhere((member) => 
          member.userId == userId || member.id == userId);
        if (index != -1) {
          eventMembers[index] = eventMembers[index].copyWith(role: role);
        }
      }
      
      // notifyListeners();
      return true;
    } catch (e) {
      isChangingRole.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // إزالة عضو من حدث
  Future<bool> removeMember(int eventId, int userId) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      final result = await _eventMemberRepository.removeMember(eventId, userId);
      lastActionResult.value  = {'success': result};
      
      // إزالة العضو من القائمة إذا كانت محملة
      if (eventMembers.isNotEmpty) {
        eventMembers.removeWhere((member) => 
          member.userId == userId || member.id == userId);
      }
      
      isLoading.value = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // إضافة عضو إلى حدث (بواسطة المنسق)
  Future<bool> addMember(int eventId, int userId, {String role = 'member'}) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      final result = await _eventMemberRepository.addMember(eventId, userId, role: role);
      lastActionResult.value  = result;
      isLoading.value = false;
      // notifyListeners();
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
      return false;
    }
  }

  // التحقق من عضوية المستخدم في حدث
  Future<void> checkMembership(int eventId) async {
    isLoading.value = true;
    errorMessage.value = '';
    // notifyListeners();

    try {
      membershipStatus.value = await _eventMemberRepository.checkMembership(eventId);
      isLoading.value = false;
      // notifyListeners();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      // notifyListeners();
    }
  }

  // تنظيف الأخطاء
  void clearError() {
    errorMessage.value = '';
    // notifyListeners();
  }

  // إعادة تعيين البيانات
  void reset() {
    eventMembers.value = [];
    userEvents.value = [];
    membershipStatus.value = null;
    lastActionResult.value  = null;
    errorMessage.value = '';
    isLoading.value = false;
    isJoining.value = false;
    isLeaving.value = false;
    isChangingRole.value = false;
    // notifyListeners();
  }

  // تحديث بيانات عضو معين
  void updateMember(int userId, Map<String, dynamic> newData) {
    final index = eventMembers.indexWhere((member) => 
      member.userId == userId || member.id == userId);
    
    if (index != -1) {
      // eventMembers[index] = eventMembers[index].copyWith(EventMemberModel.fromJson(newData));
      // eventMembers[index] = {...eventMembers[index], ...newData};
      // notifyListeners();
    }
  }
}