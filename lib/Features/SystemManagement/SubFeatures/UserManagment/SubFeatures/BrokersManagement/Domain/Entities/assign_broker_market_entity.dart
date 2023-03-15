class AssignBrokerToMarketModel {
  int? brokerId;
  int? marketId;
  int? id;
  String? status;
  String? errorMsg;
  AssignBrokerToMarketModel({
    this.brokerId,
    this.marketId,
    this.status,
    this.id,
    this.errorMsg,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignBrokerToMarketModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          brokerId == other.brokerId &&
          status == other.status &&
          marketId == other.marketId;

  @override
  int get hashCode => id.hashCode;
}
