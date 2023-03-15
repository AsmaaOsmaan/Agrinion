import 'package:agriunion/App/Errors/exceptions.dart';

import '../../Domain/Entities/linking_user_request_entity.dart';

class LinkingUserRequestMapper {
  static LinkingUserRequest fromJson(Map<String, dynamic> json) {
    try {
      return LinkingUserRequest(
        id: json['id'],
        status: json['status'],
        userName: json['user'] != null ? json['user']['name'] : null,
        userId: json['user'] != null ? json['user']['id'] : null,
        linkedUserName:
            json['linked_user'] != null ? json['linked_user']['name'] : null,
        linkedUserId:
            json['linked_user'] != null ? json['linked_user']['id'] : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
