import 'package:agriunion/Features/Notification/Domain/Entites/firebase_session.dart';

class FirebaseSessionMapper {
  static Map<String, dynamic> toJson(FirebaseSession object) {
    var data = <String, dynamic>{};
    data['token'] = object.token;
    return {"firebase_session": data};
  }
}
