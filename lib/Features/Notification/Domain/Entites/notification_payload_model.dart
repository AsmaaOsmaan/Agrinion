class NotificationPayload {
  String? redirectObject;
  int? redirectObjectId;
  String? notifiableCreator;
  NotificationPayload(
      {this.redirectObject, this.redirectObjectId, this.notifiableCreator});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationPayload &&
          runtimeType == other.runtimeType &&
          redirectObjectId == other.redirectObjectId &&
          redirectObject == other.redirectObject &&
          notifiableCreator == other.notifiableCreator;

  @override
  int get hashCode => redirectObjectId.hashCode;
}
