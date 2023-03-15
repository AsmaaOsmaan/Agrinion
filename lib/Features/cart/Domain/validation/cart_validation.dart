import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class CartValidator {
  static String? _validate(String? value, String msg) {
    if (value == null || value.isEmpty || double.parse(value) == 0.0) {
      return msg;
    }
    return null;
  }

  static String? validateQty(String? value) {
    return _validate(value, tr(LocaleKeys.invalidQty));
  }

  static String? validatePrice(String? value) {
    return _validate(value, tr("invalidPrice"));
  }
}
