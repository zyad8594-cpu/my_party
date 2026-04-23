

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات المهمة
class TaskModel {
  final int task_id;
  final int event_id;
  final String assignment_type;
  final int? assigned_user_id;
  final int? assigned_supplier_id;
  final String type_task;
  final String? description;
  final double? cost;
  final String status;
  final String? notes;
  final String? url_image;
  final DateTime? date_start;
  final DateTime? date_due;
  final String? reminder_type;
  final int? reminder_value;
  final String? reminder_unit;
  final DateTime? date_completion;
  final DateTime created_at;
  final DateTime updated_at;

  TaskModel({
    required this.task_id,
    required this.event_id,
    required this.assignment_type,
    this.assigned_user_id,
    this.assigned_supplier_id,
    required this.type_task,
    this.description,
    this.cost,
    required this.status,
    this.notes,
    this.url_image,
    this.date_start,
    this.date_due,
    this.reminder_type,
    this.reminder_value,
    this.reminder_unit,
    this.date_completion,
    DateTime? created_at,
    DateTime? updated_at
    
  }): this.created_at = created_at ?? DateTime.now(),
      this.updated_at = updated_at ?? DateTime.now();

  factory TaskModel.fromJson(json) {
    return TaskModel(
      task_id: json['task_id'] ?? 0,
      event_id: json['event_id'] ?? 0,
      assignment_type: json['assignment_type'] ?? '',
      assigned_user_id: json['assigned_user_id'],
      assigned_supplier_id: json['assigned_supplier_id'],
      type_task: json['type_task'] ?? '',
      description: json['description'],
      cost: json['cost'],
      status: json['status'] ?? 'PENDING',
      notes: json['notes'],
      url_image: json['url_image'],
      date_start: DateTime.parse(json['date_start'] ?? ''),
      date_due: DateTime.parse(json['date_due'] ?? ''),
      reminder_type: json['reminder_type'],
      reminder_value: json['reminder_value'],
      reminder_unit: json['reminder_unit'],
      date_completion: DateTime.parse(json['date_completion'] ?? ''),
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? DateTime.now().toString())
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': task_id,
      'event_task_id': event_id,
      'assignment_type': assignment_type,
      'assigned_user_id': assigned_user_id,
      'assigned_supplier_id': assigned_supplier_id,
      'type_task': type_task,
      'description': description,
      'cost': cost,
      'status': status,
      'notes': notes,
      'url_image': url_image,
      'date_start': date_start?.toIso8601String(),
      'date_due': date_due?.toIso8601String(),
      'reminder_type': reminder_type,
      'reminder_value': reminder_value,
      'reminder_unit': reminder_unit,
      'date_completion': date_completion?.toIso8601String(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  TaskModel copyWith({
    int? task_id,
    int? event_id,
    String? assignment_type,
    int? assigned_user_id,
    int? assigned_supplier_id,
    String? type_task,
    String? description,
    double? cost,
    String? status,
    String? notes,
    String? url_image,
    DateTime? date_start,
    DateTime? date_due,
    String? reminder_type,
    int? reminder_value,
    String? reminder_unit,
    DateTime? created_at,
    DateTime? updated_at,
    DateTime? date_completion,
  }) {
    return TaskModel(
      task_id: task_id ?? this.task_id,
      event_id: event_id ?? this.event_id,
      assignment_type: assignment_type ?? this.assignment_type,
      assigned_user_id: assigned_user_id ?? this.assigned_user_id,
      assigned_supplier_id: assigned_supplier_id ?? this.assigned_supplier_id,
      type_task: type_task ?? this.type_task,
      description: description ?? this.description,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      url_image: url_image ?? this.url_image,
      date_start: date_start ?? this.date_start,
      date_due: date_due ?? this.date_due,
      reminder_type: reminder_type ?? this.reminder_type,
      reminder_value: reminder_value ?? this.reminder_value,
      reminder_unit: reminder_unit ?? this.reminder_unit,
      date_completion: date_completion ?? this.date_completion,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}