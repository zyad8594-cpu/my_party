class Supplier {
  final int id;
  final int serviceId;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? notes;
  final String? createdAt;

  Supplier({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.notes,
    this.createdAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['supplier_id'] ?? json['id'] ?? 0,
      serviceId: json['service_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'],
      notes: json['notes'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'notes': notes,
    };
  }
}