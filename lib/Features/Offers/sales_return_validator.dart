import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SalesReturnValidator{




  String? validateCreateSalesReturn(String value, double quantity  ,{String? message}) {
    if (value.trim().isEmpty) {
      return message ??tr(LocaleKeys.please_enter_value);
    }
    else if (double.parse(value) > quantity) {
      return message ?? tr(LocaleKeys.value_greater_than_quantity);
    }
    else if (double.parse(value) == quantity) {
      return message ?? tr(LocaleKeys.value_equal_than_quantity);
    }
    return null;
  }
}