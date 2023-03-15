import 'package:agriunion/Features/Notification/Data/Mapper/notification_data_mapper.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/pagination_data_mapper.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_model.dart';

import '../../../../App/Errors/exceptions.dart';

class NotificationMapper {
  static NotificationModel fromJson(Map<String, dynamic> json) {
    List<NotificationDataModel> notifications = [];
    if (json['notifications'] != null) {
      json['notifications'].forEach((v) {
        notifications.add(NotificationDataMapper.fromJson(v));
      });
    }
    try {
      return NotificationModel(
        notificationDataModel: notifications,
        paginationDataModel: json['pagination_data'] != null
            ? PaginationDataMapper.fromJson(json['pagination_data'])
            : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
