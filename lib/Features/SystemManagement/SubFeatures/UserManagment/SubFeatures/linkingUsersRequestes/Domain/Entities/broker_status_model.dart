class BrokerStatusModel {
  final int id;
  final String phone;
  final String type;
  final bool? parent;
  final bool? hasParent;

  const BrokerStatusModel({
    required this.id,
    required this.phone,
    required this.type,
    this.hasParent,
    this.parent,
  });
}
