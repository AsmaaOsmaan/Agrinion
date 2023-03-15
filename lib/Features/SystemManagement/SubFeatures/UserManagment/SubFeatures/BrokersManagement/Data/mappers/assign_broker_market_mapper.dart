import 'package:agriunion/App/Errors/exceptions.dart';

import '../../Domain/Entities/assign_broker_market_entity.dart';

class AssignBrokerToMarketMapper {
  static AssignBrokerToMarketModel fromJson(Map<String, dynamic> json) {
    try {
      return AssignBrokerToMarketModel(
        brokerId: json['broker_id'],
        marketId: json['market_id'],
        id: json['id'],
        status: json['status'],
        errorMsg:
            json['errors'] == null ? null : json['errors']['broker_id'][0],
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(AssignBrokerToMarketModel model) {
    final Map<String, dynamic> data = <String, dynamic>{};
    model.brokerId != null ? data['broker_id'] = model.brokerId : '';
    data['market_id'] = model.marketId;

    return {"request": data};
  }
}
