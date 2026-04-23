

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات الحدث
class ServiceModel {
  final int service_id;
  final String service_name;              // اسم الحدث
  final String? description;
  final DateTime created_at;       // وقت الإنشاء
  final DateTime updated_at;       // وقت الإنشاء

  ServiceModel({
    required this.service_id,
    required this.service_name,
    this.description,
    DateTime? created_at,
    DateTime? updated_at
  }):this.created_at = created_at ?? DateTime.now(),
    this.updated_at = updated_at ?? DateTime.now();

  factory ServiceModel.fromJson( json) {
    return ServiceModel(
      service_id: json['service_id'] ?? 0,
      service_name: json['service_name'] ?? '',
      description: json['description'],
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': service_id,
      'service_name': service_name,
      'description': description,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  ServiceModel copyWith({
    int? service_id,
    String? service_name,
    String? description,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return ServiceModel(
      service_id: service_id ?? this.service_id,
      service_name: service_name ?? this.service_name,
      description: description ?? this.description,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}