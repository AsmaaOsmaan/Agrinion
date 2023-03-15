import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_model.dart';
import 'package:agriunion/Features/Notification/Domain/ServiceLayer/notification_service_layer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../generated/translations.g.dart';
import 'notification_factory.dart';

class NotificationVL extends ChangeNotifier {
  final INotificationServiceLayer notificationServiceLayer;
  NotificationVL(this.notificationServiceLayer);
  bool isLoadMore = false;
  int currentPage = 1;
  int totalPages = 1;
  bool reachedLast = false;
  List<NotificationDataModel> notifications = [];
  NotificationModel? notificationModel;

  Future<void> getNotification() async {
    notificationModel =
        await notificationServiceLayer.getAllNotification(currentPage);
    notifications.addAll(notificationModel!.notificationDataModel);
    notifyListeners();
  }

  void managePagination() async {
    totalPages = notificationModel!.paginationDataModel!.totalPages!;
    totalPages != currentPage ? currentPage++ : reachedLast = true;
    if (currentPage <= totalPages && reachedLast == false) {
      isLoadMore = true;
      notifyListeners();
      await getNotification();
      reachedLast = notifications.length ==
          notificationModel!.paginationDataModel!.totalCount;
      isLoadMore = false;
      notifyListeners();
    }
  }

  void restValues() {
    currentPage = 1;
    totalPages = 1;
    notifications = [];
    reachedLast = false;
  }

  readNotification(int notificationId, int index,
      NotificationDataModel notificationModel, BuildContext context) async {
    try {
      await notificationServiceLayer.readNotification(notificationId);
      notifications[index].read = true;
      manageNavigation(notificationModel, context);
      notifyListeners();
    } catch (e) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
    }
  }

  void manageNavigation(
      NotificationDataModel notificationModel, BuildContext context) {
    NotificationFactory factory = NotificationFactory();
    var notification =
        factory.initializationObject(notificationModel.notifiableType!);
    notification.navigateToNotificationDetails(context, notificationModel);
  }
}
