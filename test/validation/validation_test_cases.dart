import 'package:agriunion/App/Utilities/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validate empty', () {
    test(
      'success',
      () => expect(Validator().validateEmpty(""), "برجاء ملئ الحقل"),
    );
    test(
      'failure',
      () => expect(Validator().validateEmpty("helllo"), isA()),
    );
  });
  group('validate password', () {
    test(
      'empty',
      () => expect(Validator().validatePassword(""), "برجاء ملئ الحقل"),
    );
    test(
      'wrong',
      () => expect(
        Validator().validatePassword("12345"),
        "ادخل الباسوورد بشكل صحيح",
      ),
    );
    test(
      'success',
      () => expect(Validator().validatePassword("123456"), isA()),
    );
  });
  group('validate email', () {
    test(
      'empty',
      () => expect(Validator().validateEmail(""), "برجاء ملئ الحقل"),
    );
    test(
      'wrong',
      () => expect(
        Validator().validateEmail("mahmoud"),
        "ادخل البريد الإلكتروني بشكل صحيح",
      ),
    );
    test(
      'success',
      () => expect(
        Validator().validateEmail("mahmoud.hweedy@aictec.com"),
        isA(),
      ),
    );
  });
  group('validate phone', () {
    test(
      'empty',
      () => expect(Validator().validatePhone(""), "برجاء ملئ الحقل"),
    );
    test(
      'wrong',
      () => expect(
        Validator().validatePhone("52222222"),
        "ادخل رقم الهاتف بشكل صحيح",
      ),
    );
    test(
      'success',
      () => expect(
        Validator().validatePhone("0557777777"),
        isA(),
      ),
    );
  });
  group('validate password confirmation', () {
    test(
      'empty',
      () => expect(
          Validator().validatePasswordConfirm("", pass: ""), "برجاء ملئ الحقل"),
    );
    test(
      'wrong',
      () => expect(
        Validator().validatePasswordConfirm("123456", pass: "12345"),
        "برجاء التأكد من تطابق كلمة المرور",
      ),
    );
    test(
      'success',
      () => expect(
        Validator().validatePasswordConfirm("123456", pass: "123456"),
        isA(),
      ),
    );
  });
}
