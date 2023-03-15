part of 'auth_imports.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVL>(
      builder: (context, auth, child) => Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                  labelText: tr(LocaleKeys.phone),
                  labelStyle: getRegularStyle(fontColor: ColorManager.grey),
                  hintText: "55 - xxxx - xxx",
                  suffixText: "|  +966  ",
                  suffixStyle: getBoldStyle(fontColor: ColorManager.grey),
                  hintStyle: getSemiBoldStyle()),
              style: getBoldStyle(),
              controller: _phoneController,
              keyboardType:
                  const TextInputType.numberWithOptions(signed: false),
              inputFormatters: [
                ...nonDecimalInputFormatter,
                LengthLimitingTextInputFormatter(9)
              ],
              validator: (value) => Validator().validatePhone("0" + value!),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: tr(LocaleKeys.password),
                labelStyle: getRegularStyle(fontColor: ColorManager.grey),
              ),
              controller: _passwordController,
              obscureText: true,
              style: getBoldStyle(),
              validator: (value) => Validator().validateEmpty(value!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      onChanged: (value) => setState(
                        () {
                          remember = !remember;
                          auth.rememberMe(remember);
                        },
                      ),
                    ),
                    Text(tr(LocaleKeys.rememberMe)),
                  ],
                ),
                TextButton(
                    onPressed: () => AppRoute().navigate(
                          context: context,
                          route: const ForgetPassword(),
                        ),
                    child: Text(tr(LocaleKeys.forgot_pass)))
              ],
            ),
            const Spacer(),
            CustomButtonAnimation(
              height: 40,
              width: SizeConfig.screenWidth! * .8,
              child: Text(
                tr(LocaleKeys.signin),
                style: getBoldStyle(fontColor: Colors.white, size: 16),
              ),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  auth.login(
                    LoginRequest(
                      phone: _phoneController.text,
                      password: _passwordController.text,
                    ),
                    context,
                  );
                }
              },
              color: Colors.blue,
              borderRadius: 20,
            ),
            const SizedBox(height: 15),
            Text(
              tr(LocaleKeys.byContinueYouAgree),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
