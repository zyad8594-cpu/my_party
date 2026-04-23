

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات الحدث
class RatingTaskModel {
  final int rating_id;                    // المعرف الفريد للحدث
  final int task_id;               // معرف المستخدم المنشئ للحدث
  final int coordinator_id;               // معرف المستخدم المنشئ للحدث
  final String value_rating;              // اسم الحدث
  final String? comment;
  final DateTime rated_at;       // وقت الإنشاء

  RatingTaskModel({
    required this.rating_id,
    required this.task_id,
    required this.coordinator_id,
    required this.value_rating,
    this.comment,
    DateTime? rated_at,
  }):this.rated_at = rated_at ?? DateTime.now();
  factory RatingTaskModel.fromJson( json) {
    return RatingTaskModel(
      rating_id: json['rating_id'] ?? 0,
      task_id: json['task_id'] ?? 0,
      coordinator_id: json['coordinator_id'] ?? 0,
      value_rating: json['value_rating'] ?? '',
      comment: json['comment'],
      rated_at: DateTime.parse(json['rated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating_id': rating_id,
      'task_id': task_id,
      'coordinator_id': coordinator_id,
      'value_rating': value_rating,
      'comment': comment,
      'rated_at': rated_at.toIso8601String(),
    };
  }

  RatingTaskModel copyWith({
    int? rating_id,
    int? task_id,
    int? coordinator_id,
    String? value_rating,
    String? comment,
    DateTime? rated_at,
  }) {
    return RatingTaskModel(
      rating_id: rating_id ?? this.rating_id,
      task_id: task_id ?? this.task_id,
      coordinator_id: coordinator_id ?? this.coordinator_id,
      value_rating: value_rating ?? this.value_rating,
      comment: comment ?? this.comment,
      rated_at: rated_at ?? this.rated_at,
    );
  }
}