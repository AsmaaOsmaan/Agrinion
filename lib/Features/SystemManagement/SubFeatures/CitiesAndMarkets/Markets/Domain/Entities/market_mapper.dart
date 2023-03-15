import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/markets_errors.dart';

class MarketsMapper {
  static Market fromJson(Map<String, dynamic> json) {
    try {
      return Market(
        id: json['id'],
        nameAr: json['name_ar'],
        nameEn: json['name_en'],
        errors: json['errors'] != null ? MarketsError.fromJson(json) : null,
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(Market market) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_ar'] = market.nameAr;
    data['name_en'] = market.nameEn;

    return data;
  }
}
