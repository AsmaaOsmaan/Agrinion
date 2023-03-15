import 'package:agriunion/Features/Notification/Domain/Entites/notification_payload_model.dart';

import '../../../../App/Errors/exceptions.dart';

class NotificationPayloadMapper {
  static NotificationPayload fromJson(Map<String, dynamic> json) {
    try {
      return NotificationPayload(
          redirectObject: json['redirect_object'],
          redirectObjectId: json['redirect_object_id'],
          notifiableCreator: json['notifiable_creator']);
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
