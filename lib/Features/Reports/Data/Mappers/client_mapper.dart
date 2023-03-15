import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/client_entity.dart';

class ClientMapper {
  static Client fromJson(Map<String, dynamic> json) {
    try {
      return Client(
        id: json["id"],
        profileName: json["profile_name"],
        secondaryProfileName: json["secondary_profile_name"],
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
