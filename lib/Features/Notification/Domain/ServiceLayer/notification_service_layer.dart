import 'package:agriunion/Features/Notification/Data/Repository/notification_repo.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_model.dart';

import '../Entites/firebase_session.dart';

abstract class INotificationServiceLayer {
  Future<NotificationModel> getAllNotification(int page);
  Future<void> readNotification(int notificationId);
  Future<void> sendFcmToken(FirebaseSession session);
}

class NotificationServiceLayer implements INotificationServiceLayer {
  INotificationRepo notificationRepo;
  NotificationServiceLayer(this.notificationRepo);

  @override
  Future<NotificationModel> getAllNotification(int page) async {
    return await notificationRepo.getAllNotifications(page);
  }

  @override
  Future<void> readNotification(int notificationId) async {
    await notificationRepo.readNotification(notificationId);
  }

  @override
  Future<void> sendFcmToken(FirebaseSession session) async {
    await notificationRepo.sendFcmToken(session);
  }
}
