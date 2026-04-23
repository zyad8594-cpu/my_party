

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات الحدث
class NotificationModel {
  final int notification_id;                    // المعرف الفريد للحدث
  final int user_id;               // معرف المستخدم المنشئ للحدث
  final int supplier_id;               // معرف المستخدم المنشئ للحدث
  final int task_id;
  final String? type;              // اسم الحدث
  final String title;      // وصف الحدث (اختياري)
  final String message;
  final DateTime created_at;       // وقت الإنشاء
  final DateTime updated_at;       // وقت الإنشاء

  NotificationModel({
    required this.notification_id,
    required this.user_id,
    required this.supplier_id,
    required this.task_id,
    this.type,
    required this.title,
    required this.message,
    DateTime? created_at,
    DateTime? updated_at
  }):this.created_at = created_at ?? DateTime.now(),
    this.updated_at = updated_at ?? DateTime.now();

  factory NotificationModel.fromJson( json) {
    return NotificationModel(
      notification_id: json['notification_id'] ?? 0,
      user_id: json['user_id'] ?? 0,
      supplier_id: json['supplier_id'] ?? 0,
      task_id: json['task_id'] ?? 0,
      type: json['type'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_id': notification_id,
      'user_id': user_id,
      'supplier_id': supplier_id,
      'task_id': task_id,
      'type': type,
      'title': title,
      'message': message,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  NotificationModel copyWith({
    int? notification_id,
    int? user_id,
    int? supplier_id,
    int? task_id,
    String? type,
    String? title,
    String? message,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return NotificationModel(
      notification_id: notification_id ?? this.notification_id,
      user_id: user_id ?? this.user_id,
      supplier_id: supplier_id ?? this.supplier_id,
      task_id: task_id ?? this.task_id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}