import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Validator {
  String? noValidate() {
    return null;
  }

  String? validateEmpty(String value, {String? message}) {
    if (value.trim().isEmpty) {
      return message ?? "برجاء ملئ الحقل";
    }
    return null;
  }

  String? validateTaxRate(String value) {
    if (value.isNotEmpty && double.parse(value) <= 0) {
      return tr(LocaleKeys.please_enter_correct_tax_rate);
    }
    return null;
  }

  String? validatePassword(String value, {String? message}) {
    if (value.trim().isEmpty) {
      return message ?? "برجاء ملئ الحقل";
    } else if (value.length < 6) {
      return message ?? "ادخل الباسوورد بشكل صحيح";
    }
    return null;
  }

  String? validateEmail(String value, {String? message}) {
    if (value.trim().isEmpty) {
      return message ?? "برجاء ملئ الحقل";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return message ?? "ادخل البريد الإلكتروني بشكل صحيح";
    }
    return null;
  }

  String? validatePhone(String value, {String? message}) {
    if (value.trim().isEmpty) {
      return message ?? "برجاء ملئ الحقل";
    } else if (!RegExp(r'(^(05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)')
        .hasMatch(value)) {
      return message ?? "ادخل رقم الهاتف بشكل صحيح";
    }
    return null;
  }

  String? validatePasswordConfirm(String value,
      {required String pass, String? message}) {
    if (value.trim().isEmpty) {
      return message ?? "برجاء ملئ الحقل";
    } else if (value != pass) {
      return message ?? "برجاء التأكد من تطابق كلمة المرور";
    }
    return null;
  }
}

extension ValidatorDrop<DataType> on DataType {
  String? validateDropDown(BuildContext context, {String? message}) {
    if (this == null) {
      return message ?? "برجاء ملئ الحقل";
    }
    return null;
  }
}
