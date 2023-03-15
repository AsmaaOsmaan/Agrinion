import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentValidator {
  String? validatePayment(String value, double remainingTotal,
      {String? message}) {
    if (value.trim().isEmpty) {
      return message ?? tr(LocaleKeys.please_enter_value);
    } else if (double.parse(value) > remainingTotal) {
      return message ?? tr(LocaleKeys.value_greater_than_remaining);
    }
    return null;
  }
}
