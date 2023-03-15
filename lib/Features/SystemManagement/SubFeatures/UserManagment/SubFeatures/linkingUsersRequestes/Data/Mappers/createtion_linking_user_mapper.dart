import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/creation_linking_user_model.dart';

class CreateLinkingUserMapper {
  static CreateLinkingUser fromJson(Map<String, dynamic> json) {
    return CreateLinkingUser(
      userId: json['user_id'],
    );
  }

  static Map<String, dynamic> toJson(CreateLinkingUser createLinkingUser) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = createLinkingUser.userId;

    return {"request": data};
  }
}
