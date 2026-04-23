

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات المهمة
class ClientModel {
  final int client_id;                    // المعرف الفريد للمهمة
  final String full_name;              // معرف الحدث المرتبط
  final String phone_number;             // عنوان المهمة
  final String? email;      // وصف المهمة
  final String? address;            // حالة المهمة
  final DateTime created_at;        // تاريخ الاستحقاق
  final DateTime? updated_at;

  ClientModel({
    required this.client_id,
    required this.full_name,
    required this.phone_number,
    this.email,
    this.address,
    DateTime? created_at,
    this.updated_at
  }):this.created_at = created_at ?? DateTime.now();

  factory ClientModel.fromJson(json) {
    return ClientModel(
      client_id: json['client_id'] ?? 0,
      full_name: json['full_name'] ?? 0,
      phone_number: json['phone_number'],
      email: json['email'],
      address: json['address'],
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? '')
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'full_name': full_name,
      'phone_number': phone_number,
      'email': email,
      'address': address,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at?.toIso8601String()
    };
  }

  ClientModel copyWith({
    int? client_id,
    String? full_name,
    String? phone_number,
    String? email,
    String? address,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return ClientModel(
      client_id: client_id ?? this.client_id,
      full_name: full_name ?? this.full_name,
      phone_number: phone_number ?? this.phone_number,
      email: email ?? this.email,
      address: address ?? this.address,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at
    );
  }
}