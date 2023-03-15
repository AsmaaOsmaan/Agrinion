import 'package:easy_localization/easy_localization.dart';

class PriceItemValidation {
  static String? validateNumbers(String? value) {
    if (value!.isEmpty || double.parse(value) <= 0) {
      return tr("invalidValue");
    }
    return null;
  }

  static String? validatePricing(String? minPrice, String maxPrice) {
    validateNumbers(maxPrice);
    if (double.parse(maxPrice) <= double.parse(minPrice!)) {
      return tr("invalidMaxValue");
    }
    return null;
  }
}
