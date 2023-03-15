import 'package:agriunion/App/constants/strings.dart';

class ServerException implements Exception {
  ServerException({String message = serverErrorMessage});
}

class UnAuthorizeException implements Exception {
  String? message;
  UnAuthorizeException({this.message});
}

class BadEntitesException implements Exception {
  final String message;
  const BadEntitesException({required this.message});
}

class NotFoundException implements Exception {
  NotFoundException({String message = notFoundMessage});
}

class UnCaughtException implements Exception {
  UnCaughtException({String message = unCaughtMessage});
}

class ConnectivityException implements Exception {
  ConnectivityException({String message = noConnectionMessage});
}

class UnSupportedJsonFormat implements Exception {
  UnSupportedJsonFormat(String message);
}
