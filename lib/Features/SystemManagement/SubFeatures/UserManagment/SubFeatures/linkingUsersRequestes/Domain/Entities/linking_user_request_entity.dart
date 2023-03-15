class LinkingUserRequest {
  int? id;
  String? status;

  String? userName;
  int? userId;
  String? linkedUserName;
  int? linkedUserId;
  LinkingUserRequest({
    this.id,
    this.status,
    this.userId,
    this.userName,
    this.linkedUserId,
    this.linkedUserName,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkingUserRequest &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          status == other.status &&
          linkedUserId == other.linkedUserId &&
          linkedUserId == other.linkedUserId &&
          userName == other.userName &&
          userId == other.userId;

  @override
  int get hashCode => id.hashCode;
}
