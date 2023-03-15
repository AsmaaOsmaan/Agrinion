class AuthError {
  String? mobile;

  AuthError({this.mobile});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthError &&
          runtimeType == other.runtimeType &&
          mobile == other.mobile;

  @override
  int get hashCode => mobile.hashCode;

  AuthError.fromJson(Map<String, dynamic> json) {
    mobile = json['errors'] != null ? json['errors']['mobile'][0] : null;
  }
  AuthError.fromForgetJson(Map<String, dynamic> json) {
    mobile = json['errors'];
  }
}
