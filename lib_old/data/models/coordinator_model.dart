

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات المهمة
class CoordinatorModel {
  final int coordinator_id;                    // المعرف الفريد للمهمة
  final String full_name;              // معرف الحدث المرتبط
  final String email;      // وصف المهمة
  final String password;            // حالة المهمة
  final String? phone_number;             // عنوان المهمة
  final DateTime created_at;        // تاريخ الاستحقاق
  final DateTime updated_at;

  CoordinatorModel({
    required this.coordinator_id,
    required this.full_name,
    required this.email,
    required this.password,
    this.phone_number,
    DateTime? created_at,
    DateTime? updated_at
  }):this.created_at = created_at ?? DateTime.now(),
    this.updated_at = updated_at ?? DateTime.now();

  factory CoordinatorModel.fromJson(json) {
    return CoordinatorModel(
      coordinator_id: json['coordinator_id'] ?? 0,
      full_name: json['full_name'] ?? 0,
      email: json['email'],
      password: json['password'],
      phone_number: json['phone_number'],
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? '')
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinator_id': coordinator_id,
      'full_name': full_name,
      'email': email,
      'password': password,
      'phone_number': phone_number,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  CoordinatorModel copyWith({
    int? coordinator_id,
    String? full_name,
    String? email,
    String? password,
    String? phone_number,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return CoordinatorModel(
      coordinator_id: coordinator_id ?? this.coordinator_id,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone_number: phone_number ?? this.phone_number,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at
    );
  }

  Map<String, dynamic> toJsonE(
    bool defaults, {
    bool? coordinator_id,
    bool? full_name,
    bool? email,
    bool? password,
    bool? phone_number,
    bool? created_at,
    bool? updated_at,
  }) {
    coordinator_id = coordinator_id ?? defaults; 
    full_name = full_name ?? defaults; 
    email = email ?? defaults;
    password = password ?? defaults;
    phone_number = phone_number ?? defaults; 
    created_at = created_at ?? defaults;
    updated_at = updated_at ?? defaults;
    return {
      if(coordinator_id) 'coordinator_id': this.coordinator_id,
      if(full_name) 'full_name': this.full_name,
      if(email) 'email': this.email,
      if(password) 'password': this.password,
      if(phone_number) 'phone_number': this.phone_number,
      if(created_at) 'created_at': this.created_at.toIso8601String(),
      if(updated_at) 'updated_at': this.updated_at.toIso8601String()
    };
  }
}