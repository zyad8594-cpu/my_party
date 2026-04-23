

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات الحدث
class SupplierModel {
  final int supplier_id;                    // المعرف الفريد للحدث
  final int service_id;               // معرف المستخدم المنشئ للحدث
  final String name;              // اسم الحدث
  final String email;      // وصف الحدث (اختياري)
  final String password;       // تاريخ البدء
  final String? phone;
  final String? address;
  final String? notes;
  final DateTime created_at;       // وقت الإنشاء
  final DateTime updated_at;       // وقت الإنشاء

  SupplierModel({
    required this.supplier_id,
    required this.service_id,
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.address,
    this.notes,
    DateTime? created_at,
    DateTime? updated_at
  }):this.created_at = created_at ?? DateTime.now(),
    this.updated_at = updated_at ?? DateTime.now();

  factory SupplierModel.fromJson( json) {
    return SupplierModel(
      supplier_id: json['supplier_id'] ?? 0,
      service_id: json['service_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
      notes: json['notes'] ?? 'not_started',
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'supplier_id': supplier_id,
      'service_id': service_id,
      'name': name,
      'email': email,
      'password': password, 
      'phone': phone,
      'address': address,
      'notes': notes,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  SupplierModel copyWith({
    int? supplier_id,
    int? service_id,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? address,
    String? notes,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return SupplierModel(
      supplier_id: supplier_id ?? this.supplier_id,
      service_id: service_id ?? this.service_id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}