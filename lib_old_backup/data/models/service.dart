class Service {
  final int id;
  final String serviceName;
  final String? description;
  final String? createdAt;

  Service({
    required this.id,
    required this.serviceName,
    this.description,
    this.createdAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['service_id'] ?? json['id'] ?? 0,
      serviceName: json['service_name'] ?? '',
      description: json['description'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_name': serviceName,
      'description': description,
    };
  }
}