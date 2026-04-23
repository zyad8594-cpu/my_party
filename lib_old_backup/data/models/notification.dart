class NotificationModel {
  final int id;
  final int? userId;
  final int? supplierId;
  final int taskId;
  final String? type;
  final String title;
  final String message;
  final String createdAt;

  NotificationModel({
    required this.id,
    this.userId,
    this.supplierId,
    required this.taskId,
    this.type,
    required this.title,
    required this.message,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['notification_id'] ?? json['id'] ?? 0,
      userId: json['user_id'],
      supplierId: json['supplier_id'],
      taskId: json['task_id'] ?? 0,
      type: json['type'],
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}