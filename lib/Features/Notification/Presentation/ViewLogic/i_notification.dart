import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/Features/Offers/Presentation/Screens/negotitaion_screen.dart';
import 'package:agriunion/Features/Swalif/Presentation/Screens/comments_screen.dart';
import 'package:agriunion/Features/Swalif/Presentation/ViewLogic/swalif_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/Screens/linking_user_request_details.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/Screens/broker_request_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class INotification {
  void navigateToNotificationDetails(
      BuildContext context, NotificationDataModel notificationModel);
}

class BrokerMarketRequestNotification implements INotification {
  @override
  void navigateToNotificationDetails(
      BuildContext context, NotificationDataModel notificationModel) {
    AppRoute().navigate(
        context: context,
        route: BrokerRequestDetails(
          requestId: notificationModel.notificationPayload!.redirectObjectId!,
        ));
  }
}

class LinkingUserRequestNotification implements INotification {
  @override
  void navigateToNotificationDetails(
      BuildContext context, NotificationDataModel notificationModel) {
    AppRoute().navigate(
        context: context,
        route: LinkingUserRequestDetails(
          requestId: notificationModel.notificationPayload!.redirectObjectId!,
        ));
  }
}

class PostNotification implements INotification {
  @override
  void navigateToNotificationDetails(
      BuildContext context, NotificationDataModel notificationModel) {
    AppRoute().navigate(
        context: context,
        route: CommentsScreen(
          postId: notificationModel.notificationPayload!.redirectObjectId!,
          fromNotification: true,
        ));
    context.read<SwalifVL>().getAllSwalifPosts();
  }
}

class OfferNotification implements INotification {
  @override
  void navigateToNotificationDetails(
      BuildContext context, NotificationDataModel notificationModel) {
    AppRoute().navigate(
        context: context,
        route: NegotiationScreen(
          conversationId:
              notificationModel.notificationPayload!.redirectObjectId!,
        ));
  }
}

class UserSignUpNotification implements INotification {
  @override
  void navigateToNotificationDetails(
      BuildContext context, NotificationDataModel notificationModel) {}
}
