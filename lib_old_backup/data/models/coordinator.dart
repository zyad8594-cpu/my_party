class Coordinator {
  final int id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? createdAt;
  final String? updatedAt;

  Coordinator({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory Coordinator.fromJson(Map<String, dynamic> json) {
    return Coordinator(
      id: json['coordinator_id'] ?? json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}