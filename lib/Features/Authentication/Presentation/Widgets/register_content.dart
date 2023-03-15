part of 'auth_imports.dart';

class RegisterContent extends StatefulWidget {
  const RegisterContent({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> data = ['farmers', 'brokers', 'merchants', 'service providers'];
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVL>(builder: (context, vl, child) {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * .04),
              TextFormField(
                decoration: InputDecoration(
                    labelText: tr(LocaleKeys.phone),
                    labelStyle: getRegularStyle(fontColor: ColorManager.grey),
                    hintText: "55 - xxxx - xxx",
                    hintStyle: getSemiBoldStyle()),
                style: getBoldStyle(),
                controller: _phoneController,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: false),
                inputFormatters: nonDecimalInputFormatter,
                validator: (value) => Validator().validatePhone("0" + value!),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: getBoldStyle(),
                decoration: InputDecoration(hintText: tr(LocaleKeys.password)),
                validator: (value) => Validator().validateEmpty(value!),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordConController,
                style: getBoldStyle(),
                obscureText: true,
                decoration:
                    InputDecoration(hintText: tr(LocaleKeys.confirm_pass)),
                validator: (value) => Validator().validatePasswordConfirm(
                  value!,
                  pass: _passwordController.text,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * .1),
              BottomSheetTextField<String>(
                controller: _roleController,
                data: data,
                itemAsString: (value) => value!,
                hint: "تحديد نوع الحساب",
                value: "",
                onTap: () {},
                onItemSelected: (item) => _roleController.text = item,
                validator: (value) =>
                    Validator().validateEmpty(value.toString()),
              ),
              SizedBox(height: SizeConfig.screenHeight! * .1),
              CustomButtonAnimation(
                height: 40,
                width: SizeConfig.screenWidth! * .8,
                child: Text(
                  tr("signup"),
                  style: getBoldStyle(fontColor: Colors.white, size: 16),
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthVL>().register(
                          RegisterRequest(
                            phone: _phoneController.text,
                            password: _passwordController.text,
                            passwordConfirmation: _passwordController.text,
                            role: _roleController.text == data.last
                                ? 'service_providers'
                                : _roleController.text,
                          ),
                          context,
                        );
                  }
                },
                color: Colors.blue,
                borderRadius: 20,
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    });
  }
}
