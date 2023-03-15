import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/market_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class PriceListValidator {
  static String? validateMarket(Market? market) {
    if (market == null) {
      return tr(LocaleKeys.noti_select_market_city_is_required);
    }
    return null;
  }

  static String? validateUnitType(UnitType? unitType) {
    if (unitType == null) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  static String? validateDate(String? date, bool isAdmin) {
    if (isAdmin && date!.isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }
}
