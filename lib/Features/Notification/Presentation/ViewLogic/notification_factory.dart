import 'package:agriunion/Features/Notification/Presentation/ViewLogic/i_notification.dart';

class NotificationFactory {
  initializationObject(String type) {
    switch (type) {
      case 'LinkingUserRequest':
        return LinkingUserRequestNotification();
      case 'BrokersMarketRequest':
        return BrokerMarketRequestNotification();
      case 'Offer':
        return OfferNotification();
      case 'Like':
        return PostNotification();
      case 'Comment':
        return PostNotification();
      case 'User':
        return UserSignUpNotification();
    }
  }
}
