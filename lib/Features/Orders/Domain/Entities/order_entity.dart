import 'create_order_model.dart';

class Order {
  int? id;
  Creator? creator;
  int? commercialProfileId;
  String? createdAt;
  String? referenceNumber;
  bool isDirectOder;

  Order({
    this.id,
    this.creator,
    this.commercialProfileId,
    this.createdAt,
    this.referenceNumber,
    this.isDirectOder = false,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          referenceNumber == other.referenceNumber &&
          isDirectOder == other.isDirectOder &&
          commercialProfileId == other.commercialProfileId &&
          creator == other.creator;

  @override
  int get hashCode => id.hashCode;
}
