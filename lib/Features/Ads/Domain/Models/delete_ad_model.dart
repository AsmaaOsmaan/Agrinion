import 'package:agriunion/App/Errors/exceptions.dart';

class DeleteAdError {
  String? errorMsg;
  DeleteAdError({this.errorMsg});
  factory DeleteAdError.fromJson(Map<String, dynamic> json) {
    try {
      return DeleteAdError(errorMsg: json['errors']['auth_error']);
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
