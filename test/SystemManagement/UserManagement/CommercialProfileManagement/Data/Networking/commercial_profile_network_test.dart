import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/DataSourse/user_managment_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../network_helper_mock.dart';

void main() {
  MockNetworkHelper helper = MockNetworkHelper();
  late UserManagementNetworking userManagementNetworking;
  var headers = {
    'Accept': 'application/json',
    'Content-Type': "application/json",
    'X-access-token':
        'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
  };
  setUp(
    () {
      userManagementNetworking = UserManagementNetworking(helper);
      dotenv.testLoad(fileInput: File('.env').readAsStringSync());
    },
  );
  group('get commercialProfile test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 35,
          "bio": "flutter",
          "profile_name": "asmaa",
          "commercial_register": 123,
          "tax_number": 123,
          "email": "asmaa@gmail.com",
          "creator": {"creator_id": 1}
        },
      ];
      when(helper.get(headers: headers, url: commercialProfileUrl))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await userManagementNetworking.getAllCommercialProfiles();

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(headers: headers, url: commercialProfileUrl))
          .thenThrow(const SocketException("HEllo"));
      try {
        await userManagementNetworking.getAllCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(headers: headers, url: commercialProfileUrl))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await userManagementNetworking.getAllCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(headers: headers, url: commercialProfileUrl))
          .thenThrow(const HttpException("HEllo"));
      try {
        await userManagementNetworking.getAllCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(headers: headers, url: commercialProfileUrl))
          .thenThrow(exception);
      try {
        await userManagementNetworking.getAllCommercialProfiles();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('get merchants commercialProfile test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 35,
          "bio": "flutter",
          "profile_name": "asmaa",
          "commercial_register": 123,
          "tax_number": 123,
          "email": "asmaa@gmail.com",
          "creator": {"creator_id": 1}
        },
      ];
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$merchantsCommercialProfileUrl'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo =
          await userManagementNetworking.getMerchantsCommercialProfiles();

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$merchantsCommercialProfileUrl'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await userManagementNetworking.getMerchantsCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$merchantsCommercialProfileUrl'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await userManagementNetworking.getMerchantsCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$merchantsCommercialProfileUrl'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await userManagementNetworking.getMerchantsCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$merchantsCommercialProfileUrl'))
          .thenThrow(exception);
      try {
        await userManagementNetworking.getMerchantsCommercialProfiles();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('get farmers commercialProfile test cases', () {
    test('Happy case scenario', () async {
      var response = [
        {
          "id": 35,
          "bio": "flutter",
          "profile_name": "asmaa",
          "commercial_register": 123,
          "tax_number": 123,
          "email": "asmaa@gmail.com",
          "creator": {"creator_id": 1}
        },
      ];
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$farmersCommercialProfileUrl'))
          .thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      var respo = await userManagementNetworking.getFarmersCommercialProfiles();

      expect(respo, response);
    });
    test('SocketException Bad case scenario', () async {
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$farmersCommercialProfileUrl'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await userManagementNetworking.getFarmersCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$farmersCommercialProfileUrl'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await userManagementNetworking.getFarmersCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$farmersCommercialProfileUrl'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await userManagementNetworking.getFarmersCommercialProfiles();
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.get(
              headers: headers,
              url: '$commercialProfileUrl/$farmersCommercialProfileUrl'))
          .thenThrow(exception);
      try {
        await userManagementNetworking.getFarmersCommercialProfiles();
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('post commercialProfile test cases', () {
    var functionBody = {
      "bio": "Profile bio",
      "profile_name": "mostafa",
      "email": "mostafa@gmail.com",
      "tax_number": "1223454",
      "commercial_register": "432432423434"
    };
    var response = {
      {
        "id": 37,
        "bio": "Profile bio",
        "profile_name": "mostafa",
        "commercial_register": "432432423434",
        "tax_number": "1223454",
        "email": "mostafa@gmail.com",
        "creator": {"creator_id": 1}
      }
    };

    var mockBody = {
      "farmer_commercial_profile": {
        "bio": "Profile bio", //OPTIONAL
        "profile_name": "mostafa", //OPTIONAL
        "email": "mostafa@gmail.com", //OPTIONAL
        "tax_number": "1223454", //OPTIONAL
        "commercial_register": "432432423434" //OPTIONAL
      }
    };

    test('Happy case scenario', () async {
      when(helper.post(
        headers: headers,
        url: commercialProfileUrl,
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        Response res = Response(
          requestOptions: RequestOptions(path: NetworkHelper.apiBaseUrl!),
          data: response,
        );
        res.data = response;
        return Future.value(res);
      }));
      expect(
        await userManagementNetworking.addCommercialProfile(
            functionBody, 'farmers'),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: commercialProfileUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await userManagementNetworking.addCommercialProfile(
            functionBody, 'farmers');
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: commercialProfileUrl, body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await userManagementNetworking.addCommercialProfile(
            functionBody, 'farmers');
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.post(
              headers: headers, url: commercialProfileUrl, body: mockBody))
          .thenThrow(const HttpException("HEllo"));
      try {
        await userManagementNetworking.addCommercialProfile(
            functionBody, 'farmers');
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.post(
              headers: headers, url: commercialProfileUrl, body: mockBody))
          .thenThrow(exception);
      try {
        await userManagementNetworking.addCommercialProfile(
            functionBody, 'farmers');
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
  group('patch commercialProfile test cases', () {
    var functionBody = {
      "bio": "Profile bio",
      "profile_name": "mostafa",
      "email": "mostafa@gmail.com",
      "tax_number": "1223454",
      "commercial_register": "432432423434"
    };
    var response = {
      // 'commercial_profile':
      {
        "id": 37,
        "bio": "Profile bio",
        "profile_name": "mostafa",
        "commercial_register": "432432423434",
        "tax_number": "1223454",
        "email": "mostafa@gmail.com",
        "creator": {"creator_id": 1}
      }
    };

    var mockBody = {
      "commercial_profile": {
        "bio": "Profile bio", //OPTIONAL
        "profile_name": "mostafa", //OPTIONAL
        "email": "mostafa@gmail.com", //OPTIONAL
        "tax_number": "1223454", //OPTIONAL
        "commercial_register": "432432423434" //OPTIONAL
      }
    };
    test('Happy case scenario', () async {
      when(helper.patch(
        headers: headers,
        url: '$commercialProfileUrl/1',
        body: mockBody,
      )).thenAnswer(((realInvocation) {
        return Future.value(
          response,
        );
      }));
      expect(
        await userManagementNetworking.editCommercialProfile(functionBody, 1),
        response,
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.patch(
              headers: headers, url: commercialProfileUrl, body: mockBody))
          .thenThrow(const SocketException("HEllo"));
      try {
        await userManagementNetworking.editCommercialProfile(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.patch(
              headers: headers, url: '$commercialProfileUrl/1', body: mockBody))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await userManagementNetworking.editCommercialProfile(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.patch(
              headers: headers, url: '$commercialProfileUrl/1', body: mockBody))
          .thenThrow(const HttpException("Hello"));
      try {
        await userManagementNetworking.editCommercialProfile(functionBody, 1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.patch(
              headers: headers, url: '$commercialProfileUrl/1', body: mockBody))
          .thenThrow(exception);
      try {
        await userManagementNetworking.editCommercialProfile(functionBody, 1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });

  group('delete commercialProfile test cases', () {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-access-token':
          'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1fQ.kMbh0VzqufYqJM05hF7wZADGu1zfZbfXKxINNAYfx-g'
    };
    test('Happy case scenario', () async {
      when(helper.delete(
              headers: headers2, url: commercialProfileUrl + '/' + '1'))
          .thenAnswer(((realInvocation) {
        return Future.value();
      }));
      expect(
        await userManagementNetworking.deleteCommercialProfile(1),
        isA(),
      );
    });
    test('SocketException Bad case scenario', () async {
      when(helper.delete(
              headers: headers, url: commercialProfileUrl + '/' + '1'))
          .thenThrow(const SocketException("HEllo"));
      try {
        await userManagementNetworking.deleteCommercialProfile(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('TimeoutException Bad case scenario', () async {
      when(helper.delete(
              headers: headers, url: commercialProfileUrl + '/' + '1'))
          .thenThrow(TimeoutException("HEllo"));
      try {
        await userManagementNetworking.deleteCommercialProfile(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('HttpException Bad case scenario', () async {
      when(helper.delete(
              headers: headers, url: commercialProfileUrl + '/' + '1'))
          .thenThrow(const HttpException("HEllo"));
      try {
        await userManagementNetworking.deleteCommercialProfile(1);
      } catch (e) {
        expect(
          e,
          ConnectivityException,
        );
      }
    });
    test('UnChaughtException Bad case scenario', () async {
      var exception = Exception();
      when(helper.delete(
              headers: headers, url: commercialProfileUrl + '/' + '1'))
          .thenThrow(exception);
      try {
        await userManagementNetworking.deleteCommercialProfile(1);
      } catch (e) {
        expect(
          e,
          exception,
        );
      }
    });
  });
}
