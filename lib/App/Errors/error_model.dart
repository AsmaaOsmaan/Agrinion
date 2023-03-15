import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ResponseError {
  String? errorMsg;
  ResponseError({this.errorMsg});
  ResponseError.fromJson(Map<String, dynamic> json) {
    errorMsg = json['error'] ?? tr(LocaleKeys.something_error);
  }
}
