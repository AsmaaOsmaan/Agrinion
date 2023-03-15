import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/notification_data_mapper.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/notification_mapper.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/notification_payload_mapper.dart';
import 'package:agriunion/Features/Notification/Data/Mapper/pagination_data_mapper.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/notification_payload_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/pagination_data_model.dart';
import 'package:agriunion/Features/PricesList/Data/Mappers/price_item_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Notification fromjson test cases', () {
    Map<String, dynamic> json = {
      "notifications": [
        {
          "id": 1,
          "message": "message",
          "notifiable_type": "type",
          "notifiable_id": 1,
          'read?': true,
          'user_id': 1
        }
      ],
      "pagination_data": {
        "current_page": 1,
        "total_pages": 1,
        "total_count": 1
      },
    };
    NotificationModel response = NotificationModel(
      notificationDataModel: [
        NotificationDataModel(
          id: 1,
          message: "message",
          notifiableId: 1,
          notifiableType: 'type',
          read: true,
          userId: 1,
        )
      ],
      paginationDataModel: PaginationDataModel(
        currentPage: 1,
        totalCount: 1,
        totalPages: 1,
      ),
    );
    test('fromJson takes json returns object of Notification', () {
      var fromJson = NotificationMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        NotificationMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });

  group('Notification Data fromjson test cases', () {
    Map<String, dynamic> json = {
      "id": 1,
      "message": "message",
      "notifiable_type": "type",
      "notifiable_id": 1,
      'read?': true,
      'user_id': 1
    };
    NotificationDataModel response = NotificationDataModel(
      id: 1,
      message: "message",
      notifiableId: 1,
      notifiableType: 'type',
      read: true,
      userId: 1,
    );
    test('fromJson takes json returns object of Notification data', () {
      var fromJson = NotificationDataMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        NotificationDataMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('pagination data fromjson test cases', () {
    Map<String, dynamic> json = {
      "current_page": 1,
      "total_pages": 1,
      "total_count": 1
    };
    PaginationDataModel response = PaginationDataModel(
      currentPage: 1,
      totalCount: 1,
      totalPages: 1,
    );
    test('fromJson takes json returns object of pagination model', () {
      var fromJson = PaginationDataMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        PaginationDataMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
  group('Notification fromjson test cases', () {
    Map<String, dynamic> json = {
      "redirect_object": 'object',
      "redirect_object_id": 1,
      "notifiable_creator": 'creator'
    };
    NotificationPayload response = NotificationPayload(
        notifiableCreator: 'creator',
        redirectObject: 'object',
        redirectObjectId: 1);
    test('fromJson takes json returns object of payload model', () {
      var fromJson = NotificationPayloadMapper.fromJson(json);
      expect(fromJson, response);
    });
    test('fromJson takes wrong json throws exception', () {
      try {
        PriceItemMapper.fromJson({});
      } catch (e) {
        expect(e.runtimeType, UnSupportedJsonFormat);
      }
    });
  });
}
