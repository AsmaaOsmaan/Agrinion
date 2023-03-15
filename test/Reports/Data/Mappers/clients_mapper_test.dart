import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Reports/Data/Mappers/client_mapper.dart';
import 'package:agriunion/Features/Reports/Domian/Entities/client_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('clients fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "profile_name": "Profile name",
      "secondary_profile_name": "Secondary Profile Name",
    };
    Client response = const Client(
      id: 1,
      profileName: "Profile name",
      secondaryProfileName: "Secondary Profile Name",
    );
    test('fromJson takes json returns object of products', () {
      var fromJson = ClientMapper.fromJson(json);
      expect(fromJson, response);
    });

    test('fromJson takes wrong json throws exception', () {
      try {
        ClientMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
