

// ignore_for_file: non_constant_identifier_names

// نموذج بيانات الحدث
class IncomeModel {
  final int income_id;                    // المعرف الفريد للحدث
  final int event_id;               // معرف المستخدم المنشئ للحدث
  final double? amount;
  final String? payment_method;               // معرف المستخدم المنشئ للحدث
  final DateTime? payment_date;       // تاريخ البدء 
  final String? url_image;              // اسم الحدث
  final String? description;      // وصف الحدث (اختياري)
  final DateTime created_at;       // وقت الإنشاء
  final DateTime updated_at;       // وقت الإنشاء

  IncomeModel({
    required this.income_id,
    required this.event_id,
    required this.payment_method,
    this.payment_date,
    this.url_image,
    this.description,
    this.amount,
    DateTime? created_at,
    DateTime? updated_at
  }):this.created_at = created_at ?? DateTime.now(),
    this.updated_at = updated_at ?? DateTime.now();

  factory IncomeModel.fromJson( json) {
    return IncomeModel(
      income_id: json['income_id'] ?? 0,
      event_id: json['event_id'] ?? 0,
      payment_method: json['payment_method'] ?? '',
      payment_date: DateTime.parse(json['start_date'] ?? DateTime.now().toString()),
      url_image: json['url_image'] ?? '',
      description: json['description'],
      amount: json['amount'],
      created_at: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updated_at: DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'income_id': income_id,
      'event_id': event_id,
      'payment_method': payment_method,
      'payment_date': payment_date?.toIso8601String(), // تاريخ فقط بدون وقت
      'url_image': url_image,
      'description': description,
      'amount': amount,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }

  IncomeModel copyWith({
    int? income_id,
    int? event_id,
    String? payment_method,
    DateTime? payment_date,
    String? url_image,
    String? description,
    double? amount,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return IncomeModel(
      income_id: income_id ?? this.income_id,
      event_id: event_id ?? this.event_id,
      payment_method: payment_method ?? this.payment_method,
      payment_date: payment_date ?? this.payment_date,
      url_image: url_image ?? this.url_image,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}