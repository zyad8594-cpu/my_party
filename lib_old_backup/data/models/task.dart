class Task {
  final int id;
  final int eventId;
  final String assignmentType; // SUPPLIER or USER
  final int? assignedUserId;
  final int? assignedSupplierId;
  final String typeTask;
  final String? description;
  final double? cost;
  final String status; // PENDING, IN_PROGRESS, UNDER_REVIEW, COMPLETED, CANCELLED
  final String? notes;
  final String? urlImage;
  final String? dateStart;
  final String? dateDue;
  final String? reminderType;
  final int? reminderValue;
  final String? reminderUnit;
  final String? dateCompletion;
  final String? createdAt;
  String? eventName;
  String? userName;
  String? supplierName;

  Task({
    required this.id,
    required this.eventId,
    required this.assignmentType,
    this.assignedUserId,
    this.assignedSupplierId,
    required this.typeTask,
    this.description,
    this.cost,
    required this.status,
    this.notes,
    this.urlImage,
    this.dateStart,
    this.dateDue,
    this.reminderType,
    this.reminderValue,
    this.reminderUnit,
    this.dateCompletion,
    this.createdAt,
    this.eventName,
    this.userName,
    this.supplierName,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['task_id'] ?? json['id'] ?? 0,
      eventId: json['event_id'] ?? 0,
      assignmentType: json['assignment_type'] ?? 'USER',
      assignedUserId: json['assigned_user_id'],
      assignedSupplierId: json['assigned_supplier_id'],
      typeTask: json['type_task'] ?? '',
      description: json['description'],
      cost: json['cost']?.toDouble(),
      status: json['status'] ?? 'PENDING',
      notes: json['notes'],
      urlImage: json['url_image'],
      dateStart: json['date_start'],
      dateDue: json['date_due'],
      reminderType: json['reminder_type'],
      reminderValue: json['reminder_value'],
      reminderUnit: json['reminder_unit'],
      dateCompletion: json['date_completion'],
      createdAt: json['created_at'],
      eventName: json['event_name'],
      userName: json['user_name'],
      supplierName: json['supplier_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'assignment_type': assignmentType,
      'assigned_user_id': assignedUserId,
      'assigned_supplier_id': assignedSupplierId,
      'type_task': typeTask,
      'description': description,
      'cost': cost,
      'status': status,
      'notes': notes,
      'url_image': urlImage,
      'date_start': dateStart,
      'date_due': dateDue,
      'reminder_type': reminderType,
      'reminder_value': reminderValue,
      'reminder_unit': reminderUnit,
    };
  }
}