import 'package:agriunion/Features/Notification/Domain/Entites/notification_payload_model.dart';

class NotificationDataModel {
  int? id;
  int? userId;
  String? message;
  String? responseMsg;
  bool? read;
  String? createdAt;
  String? readAt;
  String? notifiableType;
  int? notifiableId;
  String? notificationHandler;
  NotificationPayload? notificationPayload;
  NotificationDataModel({
    this.userId,
    this.id,
    this.createdAt,
    this.read,
    this.message,
    this.readAt,
    this.responseMsg,
    this.notifiableId,
    this.notifiableType,
    this.notificationHandler,
    this.notificationPayload,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDataModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          message == other.message &&
          notifiableId == other.notifiableId &&
          notifiableType == other.notifiableType &&
          read == other.read;

  @override
  int get hashCode => id.hashCode;
}
