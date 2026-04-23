
part of 'services.dart';

// خدمة الأحداث للتعامل مع API الأحداث
class EventService 
{
  // جلب جميع الأحداث
  static Future<List<models.EventModel>?> index() async 
  {
    try 
    {
      final response = await ApiService.get('events');
      
      if (response['success'] == true) 
      {
        
        final List<dynamic> eventsJson = response['data'];
        return eventsJson.map((json) => models.EventModel.fromJson(json)).toList();
      } 
      else 
      {
        throw Exception('Failed to fetch events: ${response["message"]}');
      }
    } catch (e) 
    {
      throw Exception('Get events service error: $e');
    }
  }

  // جلب حدث بواسطة ID
  static Future<models.EventModel?> show(int id) async {
    try {
      final response = await ApiService.get('events/$id');
      
      if (response['success'] == true) {
        return models.EventModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to fetch event: ${response["message"]}');
      }
    } catch (e) {
      throw Exception('Get event by id service error: $e');
    }
  }
  
  // إنشاء حدث جديد
  static Future<models.EventModel?> create(models.EventModel event) async {
    try {
      var data = {
        'name': event.name_event,
        if(event.description != null) 'description': event.description,
        'start_date': event.event_date.toIso8601String(), // تاريخ فقط بدون وقت
        if(event.location != null)'location': event.location,
      };
      final response = await ApiService.post('events', data);
      
      if (response['success'] == true) 
      {
        return models.EventModel.fromJson(response['data']);
      } 
      else 
      {
        throw ['Failed to create event: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), "Create event service error"];
    }
  }
  
  // تحديث حدث
  static Future<models.EventModel?> update(models.EventModel event) async {
    try {
       var data = {
        'name': event.name_event,
        if(event.description != null) 'description': event.description,
        'start_date': event.event_date.toIso8601String(), // تاريخ فقط بدون وقت
        if(event.location != null)'location': event.location,
      };
      final response = await ApiService.put('events/${event.event_date}', data);
      
      if (response['success'] == true) {
        return models.EventModel.fromJson(response['data']);
      } 
      else 
      {
        throw ['Failed to update event: ${response["message"]}'];
      }
    } 
    catch (e) 
    {
      throw [...(e as List<String>), 'Update event service error'];
    }
  }
  
  // حذف حدث
  static Future<bool> delete(int id) async {
    try {
      final response = await ApiService.delete('events/$id');
      
      if (response['success'] == true) 
      {
        return true;
      } 
      else 
      {
        throw ['Failed to delete event: ${response["message"]}'];
      }
    } catch (e) 
    {
      throw [...(e as List<String>), "Delete event service error"];
    }
  }
  
}