import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SalesReportsValidator {
  static String? validatePhone(String value, {String? message}) {
    if (value != "" &&
        !RegExp(r'(^(05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)').hasMatch(value)) {
      return message ?? tr(LocaleKeys.noti_add_phone_number_is_required);
    }
    return null;
  }
}
