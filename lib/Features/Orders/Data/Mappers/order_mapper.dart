import 'package:agriunion/App/Errors/exceptions.dart';

import '../../Domain/Entities/order_entity.dart';
import 'create_order_mapper.dart';

class OrderMapper {
  static Order fromJson(Map<String, dynamic> json) {
    try {
      return Order(
          id: json['id'],
          creator: json['creator'] != null
              ? CreatorMapper.fromJson(json['creator'])
              : null,
          commercialProfileId: json['commercial_profile_id'],
          createdAt: json['created_at'],
          isDirectOder: json['direct_order'],
          referenceNumber: json['reference_number']);
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, commercial_profile_id: 1, created_at: , reference_number: , direct_order: false, creator: {id: 1, name: , type: }}, but found this : $json");
    }
  }
}
