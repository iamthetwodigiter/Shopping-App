import 'package:shopping/features/products/domain/entity/meta_entity.dart';

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      barcode: map['barcode'] as String,
      qrCode: map['qrCode'] as String,
    );
  }

  MetaEntity toEntity() => MetaEntity(
        createdAt: createdAt,
        updatedAt: updatedAt,
        barcode: barcode,
        qrCode: qrCode,
      );
}
