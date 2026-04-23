

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات الحدث
class EventModel {
  final int event_id;                    // المعرف الفريد للحدث
  final int client_id;               // معرف المستخدم المنشئ للحدث
  final int coordinator_id;               // معرف المستخدم المنشئ للحدث
  final String name_event;              // اسم الحدث
  final String? description;      // وصف الحدث (اختياري)
  final DateTime event_date;       // تاريخ البدء
  final String? location;
  final double? budget;
  final String status;
  final DateTime created_at;       // وقت الإنشاء
  final DateTime updated_at;       // وقت الإنشاء

  EventModel({
    required this.event_id,
    required this.client_id,
    required this.coordinator_id,
    required this.name_event,
    this.description,
    required this.event_date,
    this.location,
    this.budget,
    this.status = "not_started",
    DateTime? created_at,
    DateTime? updated_at
  }):this.created_at = created_at ?? DateTime.now(),
    this.updated_at = updated_at ?? DateTime.now();

  factory EventModel.fromJson( json) {
    return EventModel(
      event_id: json['event_id'] ?? 0,
      client_id: json['client_id'] ?? 0,
      coordinator_id: json['coordinator_id'] ?? 0,
      name_event: json['name_event'] ?? '',
      description: json['description'],
      event_date: DateTime.parse(json['start_date'] ?? DateTime.now().toString()),
      location: json['location'],
      budget: json['budget'],
      status: json['status'] ?? 'not_started',
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': event_id,
      'client_id': client_id,
      'coordinator_id': coordinator_id,
      'name_event': name_event,
      'description': description,
      'event_date': event_date.toIso8601String(), // تاريخ فقط بدون وقت
      'location': location,
      'budget': budget,
      'status': status,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  EventModel copyWith({
    int? event_id,
    int? client_id,
    int? coordinator_id,
    String? name_event,
    String? description,
    DateTime? event_date,
    String? location,
    double? budget,
    String? status,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return EventModel(
      event_id: event_id ?? this.event_id,
      client_id: client_id ?? this.client_id,
      coordinator_id: coordinator_id ?? this.coordinator_id,
      name_event: name_event ?? this.name_event,
      description: description ?? this.description,
      event_date: event_date ?? this.event_date,
      location: location ?? this.location,
      budget: budget ?? this.budget,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}