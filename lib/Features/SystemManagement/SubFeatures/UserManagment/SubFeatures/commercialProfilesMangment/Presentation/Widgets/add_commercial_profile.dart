import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Account/Presentation/Widgets/change_address_widget.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Logic/user_managment_vl.dart';
import 'package:agriunion/Features/cart/Presention/ViewLogic/my_ads_cart_vl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../App/GlobalWidgets/bottom_sheet_text_field.dart';
import '../../../../../../../../generated/translations.g.dart';

class AddCommercialProfileSheet extends StatefulWidget {
  final bool? fromCart;
  const AddCommercialProfileSheet({Key? key, this.fromCart}) : super(key: key);

  @override
  State<AddCommercialProfileSheet> createState() =>
      _AddCommercialProfileSheetState();
}

class _AddCommercialProfileSheetState extends State<AddCommercialProfileSheet> {
  final TextEditingController bio = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController secondaryName = TextEditingController();
  final TextEditingController taxNumber = TextEditingController();
  final TextEditingController commercialRegister = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController neighbourhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<String> data = ['farmers', 'brokers', 'merchants'];
  @override
  void initState() {
    if (widget.fromCart != null) {
      _roleController.text = data.last;
    }
    super.initState();
  }

  @override
  void dispose() {
    bio.dispose();
    name.dispose();
    taxNumber.dispose();
    commercialRegister.dispose();
    email.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.name_ar),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return Validator().validateEmpty(value!);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: secondaryName,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.secondary_name),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: bio,
                decoration:
                    InputDecoration(hintText: tr(LocaleKeys.description)),
              ),
              const SizedBox(height: 10),
              ChangeAddressWidget(
                address: _addressController,
                city: city,
                neighbourhood: neighbourhood,
                postalCode: postalCode,
                street: street,
              ),
              const SizedBox(height: 10),
              BottomSheetTextField<String>(
                enabled: widget.fromCart != null ? false : true,
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
              const SizedBox(height: 10),
              TextFormField(
                controller: taxNumber,
                inputFormatters: nonDecimalInputFormatter,
                decoration:
                    InputDecoration(hintText: tr(LocaleKeys.tax_number)),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: commercialRegister,
                inputFormatters: nonDecimalInputFormatter,
                decoration:
                    InputDecoration(hintText: tr(LocaleKeys.commercial_reg_no)),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                decoration: InputDecoration(
                  hintText: tr(LocaleKeys.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isNotEmpty &&
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return tr("emailValidationError");
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              AppButton(
                title: tr(LocaleKeys.adding),
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    CommercialProfileModel commercialModel =
                        CommercialProfileModel(
                      bio: bio.text,
                      address: address.text,
                      commercialRegister: commercialRegister.text,
                      profileName: name.text,
                      secondaryName: secondaryName.text,
                      taxNumber: taxNumber.text,
                      type: _roleController.text,
                      email: email.text,
                      city: city.text,
                      street: street.text,
                      postalCode: postalCode.text,
                      neighbourhood: neighbourhood.text,
                    );

                    widget.fromCart != null
                        ? await context
                            .read<MyAdsCartVL>()
                            .addCommercialProfile(commercialModel)
                        : await context
                            .read<UserManagementVL>()
                            .addCommercialProfile(commercialModel);

                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
