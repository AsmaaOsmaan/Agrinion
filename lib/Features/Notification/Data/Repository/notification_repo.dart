import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Notification/Data/DataSource/notification_network.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/firebase_session_mapper.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/notification_mapper.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/firebase_session.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_model.dart';

abstract class INotificationRepo {
  Future<NotificationModel> getAllNotifications(int page);
  Future<void> readNotification(int notificationId);
  Future<void> sendFcmToken(FirebaseSession session);
}

class NotificationRepo implements INotificationRepo {
  INotificationNetworking notificationNetworking;
  NotificationRepo(this.notificationNetworking);

  NotificationModel convertToModel(Map<String, dynamic> jsonResponse) {
    return NotificationMapper.fromJson(jsonResponse);
  }

  @override
  Future<NotificationModel> getAllNotifications(int page) async {
    final response = await notificationNetworking.getAllNotification(page);
    final jsonResponse = Utils.convertToJson(response);
    final notifications = convertToModel(jsonResponse);
    return notifications;
  }

  @override
  Future<void> readNotification(int notificationId) async {
    try {
      await notificationNetworking.readNotification(notificationId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendFcmToken(FirebaseSession session) async {
    try {
      await notificationNetworking
          .sendFcmToken(FirebaseSessionMapper.toJson(session));
    } catch (e) {
      rethrow;
    }
  }
}
