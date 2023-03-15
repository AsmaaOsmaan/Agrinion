import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';

import '../../../../App/Errors/exceptions.dart';

class CreateOrderMapper {
  static CreateOrderModel fromJson(Map<String, dynamic> json) {
    try {
      return CreateOrderModel(
        commercialProfileId: json['commercial_profile_id'],
        orderId: json['id'],
        creator: json['creator'] != null
            ? CreatorMapper.fromJson(json['creator'])
            : null,
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, commercial_profile_id: 1, creator: {id: 1, name: , type: }} , but found this : $json");
    }
  }

  static Map<String, dynamic> toJson(CreateOrderModel model) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commercial_profile_id'] = model.commercialProfileId;
    return {"order": data};
  }
}

class CreatorMapper {
  static Creator fromJson(Map<String, dynamic> json) {
    try {
      return Creator(
        id: json['id'],
        name: json['name'],
        type: json['type'],
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, name: , type: } , but found this : $json");
    }
  }
}
