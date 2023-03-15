import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/BrokersManagement/Data/mappers/broker_market_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Data/Mappers/linking_user_request_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/linking_user_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('linking user fromJson test cases', () {
    Map<String, dynamic> json = {
      'id': 1,
      'status': 'pending',
      "user": {'id': 1, 'name': "اسم"},
      "linked_user": {'id': 1, 'name': "اسم"},
    };
    LinkingUserRequest response = LinkingUserRequest(
      id: 1,
      status: 'pending',
      userName: 'اسم',
      userId: 1,
      linkedUserName: 'اسم',
      linkedUserId: 1,
    );
    test('fromJson takes json returns object', () {
      var fromJson = LinkingUserRequestMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json without user object returns null values', () {
      json['user'] = null;
      LinkingUserRequest response = LinkingUserRequest(
        id: 1,
        status: 'pending',
        userName: null,
        userId: null,
        linkedUserName: 'اسم',
        linkedUserId: 1,
      );
      var fromJson = LinkingUserRequestMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes json without linked user object returns null values',
        () {
      json['linked_user'] = null;
      LinkingUserRequest response = LinkingUserRequest(
        id: 1,
        status: 'pending',
        userName: 'اسم',
        userId: 1,
        linkedUserName: null,
        linkedUserId: null,
      );
      var fromJson = LinkingUserRequestMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        BrokerMarketMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
