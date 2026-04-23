import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/data.dart' as EventRpMd show EventService, EventModel;

// Controller لإدارة الأحداث
class Event extends GetxController 
{
  
  var isLoading = false.obs;                                    // حالة تحميل الأحداث
  var events = <EventRpMd.EventModel>[].obs;                              // قائمة الأحداث (قابلة للملاحظة)
  var listEvents = <EventRpMd.EventModel>[].obs;   
  var eventMembers = <Map<String, dynamic>>[].obs;
  var selectedEvent = Rxn<EventRpMd.EventModel>();                        // الحدث المحدد (يمكن أن يكون null)
  var startDate = Rx<DateTime>(DateTime.now());
  var endDate = Rx<DateTime?>(null);   
  var filedSerch = ''.obs;   
  var filterSerch = 'all'.obs;
  
  Future<void> updateFilter({String? filter, int? userId, bool onRefresh = false}) async
  {
    if(onRefresh) await fetchEvents();
    filterSerch.value = filter ?? filterSerch.value;
    var value = filedSerch.value;
    switch (filterSerch.value) 
    {
      case 'my_events':
          listEvents.value = events.value
            .where((event) => (event.userId == userId))
            .where((event)=> (
                value.isNotEmpty && 
                (event.name.contains(value) || event.description!.contains(value))
              ) || value.isEmpty
            )
            .toList();

      break;
      case 'upcoming':
        // عرض الأحداث القادمة
        listEvents.value = events.value
            .where((event) => gtDate(event.startDate, DateTime.now()))
            .where((event)=> (
                value.isNotEmpty && 
                (event.name.contains(value) || event.description!.contains(value))
              ) || value.isEmpty
            )
            .toList();
      break;
      case 'past':
        // عرض الأحداث الماضية
        listEvents.value = events.value
            .where((event) => ltDate(event.startDate, DateTime.now()))
            .where((event)=> (
                value.isNotEmpty && 
                (event.name.contains(value) || event.description!.contains(value))
              ) || value.isEmpty
            )
            .toList();
      break;
      default:
        // عرض جميع الأحداث
        listEvents.value = events.value
            .where((event)=> (
                value.isNotEmpty && 
                (event.name.contains(value) || event.description!.contains(value))
              ) || value.isEmpty
              )
            .toList();
            
      break;
    }
  }
  
  void updateStartDate(DateTime date) => startDate.value = date;
  void updateEndDate(DateTime date) => endDate.value = date;
  // اختيار تاريخ البدء
  Future<void> selectStartDate(BuildContext context) async 
  {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    
    if (picked != null && picked != startDate.value) 
    {
      // استخدام GetBuilder لإعادة بناء الواجهة بدلاً من setState
      startDate.value = picked;
      // إذا كان تاريخ الانتهاء قبل تاريخ البدء، نضبطه على تاريخ البدء
      if (endDate.value != null && endDate.value!.isBefore(picked)) 
      {
        endDate.value = picked;
      }
      // إعادة بناء الواجهة
    }
  }
  
   // اختيار تاريخ الانتهاء
  Future<void> selectEndDate(BuildContext context) async 
  {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value ?? startDate.value,
      firstDate: startDate.value,
      lastDate: DateTime(2100),
    );
    
    if (picked != null) 
    {
      updateEndDate(picked);
    }
  }
  
  
  // جلب جميع الأحداث
  Future<void> fetchEvents() async 
  {
    if(isLoading.value == false)
    {
      try 
      {
        isLoading.value = true;                                   // بدء التحميل
        final eventsList = await EventRpMd.EventService.index();    // جلب الأحداث من API
        events.assignAll(eventsList ?? []);                       // تعيين القائمة الجديدة
        isLoading.value = false;                                  // إيقاف التحميل

        // if (eventsList != null) 
        // {
        //   events.assignAll(eventsList);                           // تعيين القائمة الجديدة
        // }
        
        
      } 
      catch (e) 
      {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to fetch events: ');      // عرض خطأ
      }
    }
  }


  // Future<void> fetchEventMmbers(int eventId) async 
  // {
  //   try 
  //   {
  //     isLoading.value = true;                                   // بدء التحميل
      
  //     final eventsList = await _eventRepository.getEventMmbers(eventId);    // جلب الأحداث من API
      
  //     if (eventsList != null) 
  //     {
  //       eventMembers.assignAll(eventsList);                           // تعيين القائمة الجديدة
  //     }
      
  //     isLoading.value = false;                                  // إيقاف التحميل
  //   } 
  //   catch (e) 
  //   {
  //     isLoading.value = false;
  //     Get.snackbar('خطاء', [...(e as List<String>), 'Failed to fetch events'].join('\n'));      // عرض خطأ
  //   }
  // }
  

  Future<void> fetchUserEvents(int id) async 
  {
    try 
    {
      isLoading.value = true;                                   // بدء التحميل
      
      final eventsList = await EventRpMd.EventService.index();    // جلب الأحداث من API
      
      if (eventsList != null) 
      {
        events.assignAll(eventsList);                           // تعيين القائمة الجديدة
      }
      
      isLoading.value = false;                                  // إيقاف التحميل
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch events: ');      // عرض خطأ
    }
  }
  
  // جلب حدث محدد بواسطة ID
  Future<void> fetchEventById(int id) async 
  {
    try 
    {
      isLoading.value = true;
      
      final event = await EventRpMd.EventService.show(id);    // جلب الحدث من API
      
      if (event != null) 
      {
        selectedEvent.value = event;                            // تعيين الحدث المحدد
      }
      
      isLoading.value = false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch event: $e');
    }
  }

  // إنشاء حدث جديد
  Future<bool> createEvent(EventRpMd.EventModel event) async 
  {
    try 
    {
      isLoading.value = true;
      
      final newEvent = await EventRpMd.EventService.create(event); // إرسال الحدث الجديد
      
      if (newEvent != null) 
      {
        events.add(newEvent);                                   // إضافة الحدث للقائمة
        isLoading.value = false;
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('خطاء', [...(e as List<String>), 'Failed to create event'].join('\n'));
      return false;
    }
  }

  // تحديث حدث موجود
  Future<bool> updateEvent(EventRpMd.EventModel event) async 
  {
    try 
    {
      isLoading.value = true;
      
      final updatedEvent = await EventRpMd.EventService.update(event); // تحديث الحدث
      
      if (updatedEvent != null) 
      {
        // تحديث الحدث في القائمة
        final index = events.indexWhere((e) => e.id == event.id);
        if (index != -1) 
        {
          events[index] = updatedEvent;                         // استبدال الحدث المحدث
        }
        isLoading.value = false;
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('خطاء', [...(e as List<String>), 'Failed to update event'].join('\n'));
      return false;
    }
  }

  // حذف حدث
  Future<bool> deleteEvent(int id) async 
  {
    try 
    {
      isLoading.value = true;
      
      final success = await EventRpMd.EventService.delete(id);   // حذف الحدث
      
      if (success) 
      {
        Get.snackbar('نجاح', 'تم الحذف بنجاح');
        events.removeWhere((event) => event.id == id);          // إزالة الحدث من القائمة
        isLoading.value = false;
        return true;
      }
      
      isLoading.value = false;
      return false;
    } 
    catch (e) 
    {
      isLoading.value = false;
      Get.snackbar('خطاء', [...(e as List<String>), "Failed to delete event"].join('\n'));
      return false;
    }
  }
}