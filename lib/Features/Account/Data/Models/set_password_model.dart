


class SetPasswordModel{


String? newPassword;
String? passwordConfirmation;
String? passwordVerificationOtp;
String? msg;
SetPasswordErrors? errors;

SetPasswordModel({
  this.msg,
  this.newPassword,
  this.passwordConfirmation,
  this.errors,
  this.passwordVerificationOtp
});





}
class SetPasswordErrors{
  String? passwordConfirmation;
  SetPasswordErrors({
    this.passwordConfirmation,
});
}