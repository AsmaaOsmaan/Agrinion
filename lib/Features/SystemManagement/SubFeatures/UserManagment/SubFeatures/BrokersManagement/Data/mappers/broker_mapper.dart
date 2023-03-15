import 'package:agriunion/App/Errors/exceptions.dart';

import '../../Domain/Entities/broker_entity.dart';

class BrokersMapper {
  static Broker fromJson(Map<String, dynamic> json) {
    try {
      return Broker(
        id: json['id'],
        type: json['type'],
        nameAr: json['name']??"",
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Broker fromRequestJson(Map<String, dynamic> json) {
    try {
      return Broker(
        id: json['id'],
        nameAr: json['name']??"",
        nameEn: json['name_en'],
        type: json['type'],
        mobile: json['mobile'],
        confirmed: json['confirmed'],
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(Broker broker) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = broker.nameAr;
    data['name_en'] = broker.nameEn;
    data['type'] = broker.type;
    data['mobile'] = broker.mobile;
    data['confirmed'] = broker.confirmed;

    return data;
  }
}
