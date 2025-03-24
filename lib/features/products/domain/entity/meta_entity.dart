class MetaEntity {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  MetaEntity({
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

  factory MetaEntity.fromMap(Map<String, dynamic> map) {
    return MetaEntity(
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      barcode: map['barcode'] as String,
      qrCode: map['qrCode'] as String,
    );
  }
}