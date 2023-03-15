import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/notification_payload_mapper.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';

class NotificationDataMapper {
  static NotificationDataModel fromJson(Map<String, dynamic> json) {
    try {
      return NotificationDataModel(
        id: json['id'],
        message: json['message'],
        readAt: json['read_at'],
        createdAt: json['created_at'],
        read: json['read?'],
        userId: json['user_id'],
        responseMsg: json['msg'],
        notifiableId: json['notifiable_id'],
        notifiableType: json['notifiable_type'],
        notificationHandler: json['notification_handler'],
        notificationPayload: json['payload'] != null
            ? NotificationPayloadMapper.fromJson(json['payload'])
            : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
