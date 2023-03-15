import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/Mappers/commercial_profile_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('commercial profile fromJson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "address": "address",
      "bio": "bio",
      'type': 'broker',
      'profile_name': "name",
      "secondary_profile_name": "name"
    };
    CommercialProfileModel response = const CommercialProfileModel(
      id: 1,
      address: "address",
      bio: "bio",
      type: "broker",
      profileName: "name",
      secondaryName: "name",
      city: "",
      commercialRegister: "",
      email: "",
      neighbourhood: "",
      postalCode: "",
      street: "",
      taxNumber: "",
    );
    Map<String, dynamic> someEmptyDataJson = {
      "id": 1,
      "address": null,
      "bio": null,
      'type': null,
      'profile_name': null,
      "secondary_profile_name": null,
    };
    test('fromJson takes json returns commercial profile', () {
      var fromJson = CommercialProfileMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('when the received data is null; fromJson returns empty string', () {
      final fromJson = CommercialProfileMapper.fromJson(someEmptyDataJson);
      expect(fromJson.address, "");
      expect(fromJson.bio, "");
      expect(fromJson.secondaryName, "");
      expect(fromJson.profileName, "");
      expect(fromJson.type, "");
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        CommercialProfileMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('toJson function test cases', () {
    CommercialProfileModel model = const CommercialProfileModel(
      id: 1,
      address: "address",
      bio: "bio",
      type: "broker",
      profileName: "name",
      secondaryName: "name",
      email: '',
    );
    Map<String, dynamic> json = {
      'bio': 'address',
      'profile_name': 'name',
      'secondary_profile_name': 'name',
      'email': null,
      'type': 'broker',
      'tax_number': null,
      'commercial_register': null,
      'city': null,
      'area': null,
      'postal_code': null,
      'street': null
    };
    test('toJson takes Object and return Json', () {
      var fromJson = CommercialProfileMapper.toJson(model);
      expect(fromJson, json);
    });
  });
}
