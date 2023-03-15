class UserRequest {
  final String phone;
  final String password;

  const UserRequest({
    required this.phone,
    required this.password,
  });
}

class LoginRequest extends UserRequest {
  const LoginRequest({
    required String phone,
    required String password,
  }) : super(
          phone: phone,
          password: password,
        );
}

class RegisterRequest extends UserRequest {
  final String role;
  final String passwordConfirmation;
  const RegisterRequest(
      {required String phone,
      required String password,
      required this.passwordConfirmation,
      required this.role})
      : super(
          phone: phone,
          password: password,
        );
}
