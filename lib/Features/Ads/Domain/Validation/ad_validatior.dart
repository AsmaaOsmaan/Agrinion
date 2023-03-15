import 'package:agriunion/Features/SystemManagement/SubFeatures/Products/Domain/Entities/products_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/translations.g.dart';
import '../../../SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';

class AdValidator {
  static String? validatePrice(String? value, bool negotiable) {
    bool isEmptyValue = value == null || value.isEmpty;
    bool isEqualToZero = double.tryParse(value!) == 0;
    if (!isEmptyValue && isEqualToZero) {
      return tr("invalidPrice");
    }
    if (!negotiable && isEmptyValue) {
      return tr(LocaleKeys.price_is_required);
    }
    return null;
  }

  static String? _validateNumbers(String? value, String msg) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.field_required);
    } else if (double.tryParse(value) == 0.0) {
      return msg;
    } else {
      return null;
    }
  }

  static String? validateQty(String? value) {
    return _validateNumbers(value, tr(LocaleKeys.invalidQty));
  }

  static String? validateWeight(String? value) {
    return _validateNumbers(value, tr(LocaleKeys.please_add_weight));
  }

  static String? validateUnitType(UnitType? value) {
    if (value == null) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  static String? carValidation(String value, CommercialProfileModel? farmer) {
    if (farmer != null && value.isEmpty) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }

  static String? validateProduct(Product? product) {
    if (product == null) {
      return tr(LocaleKeys.field_required);
    }
    return null;
  }
}
