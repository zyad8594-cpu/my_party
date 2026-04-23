import 'package:equatable/equatable.dart';

class ServiceRequest extends Equatable {
  final int id;
  final int supplierId;
  final String supplierName;
  final String serviceName;
  final String? description;
  final String status;
  final bool isDeleted;
  final String? createdAt;
  final String? supplierEmail;
  final String? supplierPhone;
  final String? supplierAddress;
  final String? supplierImg;

  const ServiceRequest({
    required this.id,
    required this.supplierId,
    required this.supplierName,
    required this.serviceName,
    this.description,
    required this.status,
    required this.isDeleted,
    this.createdAt,
    this.supplierEmail,
    this.supplierPhone,
    this.supplierAddress,
    this.supplierImg,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'] ?? 0,
      supplierId: json['supplier_id'] ?? 0,
      supplierName: json['supplier_name'] ?? 'غير معروف',
      serviceName: json['service_name'] ?? '',
      description: json['description'],
      status: json['status'] ?? 'PENDING',
      isDeleted: json['is_deleted'] ?? false,
      createdAt: json['created_at'],
      supplierEmail: json['supplier_email'],
      supplierPhone: json['supplier_phone'],
      supplierAddress: json['supplier_address'],
      supplierImg: json['supplier_img'],
    );
  }

  ServiceRequest copyWith({
    int? id,
    int? supplierId,
    String? supplierName,
    String? serviceName,
    String? description,
    String? status,
    bool? isDeleted,
    String? createdAt,
    String? supplierEmail,
    String? supplierPhone,
    String? supplierAddress,
    String? supplierImg,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      supplierEmail: supplierEmail ?? this.supplierEmail,
      supplierPhone: supplierPhone ?? this.supplierPhone,
      supplierAddress: supplierAddress ?? this.supplierAddress,
      supplierImg: supplierImg ?? this.supplierImg,
    );
  }

  @override
  List<Object?> get props => [
        id,
        supplierId,
        supplierName,
        serviceName,
        description,
        status,
        createdAt,
        supplierEmail,
        supplierPhone,
        supplierAddress,
        supplierImg,
      ];
}
