class CreateOrderModel {
  int? commercialProfileId;
  int? orderId;
  Creator? creator;
  CreateOrderModel({this.commercialProfileId, this.creator, this.orderId});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateOrderModel &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          commercialProfileId == other.commercialProfileId &&
          creator == other.creator;

  @override
  int get hashCode => orderId.hashCode;
}

class Creator {
  int? id;
  String? name;
  String? type;
  Creator({this.id, this.name, this.type});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Creator &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => id.hashCode;
}
