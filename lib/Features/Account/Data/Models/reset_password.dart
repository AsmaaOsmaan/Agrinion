


class ResetPassword{
   final String? resetPasswordToken;
   final String? oldPassWord;
   final ResetPasswordError? errors;

   ResetPassword({
     this.resetPasswordToken,
     this.oldPassWord,
     this.errors,
});
}
class ResetPasswordError{
  String? error;
  ResetPasswordError({
    this.error
});
}