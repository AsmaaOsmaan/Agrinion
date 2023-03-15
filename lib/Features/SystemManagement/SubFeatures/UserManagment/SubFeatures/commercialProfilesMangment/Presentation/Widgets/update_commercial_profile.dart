import 'package:agriunion/App/GlobalWidgets/app_button.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/Features/Account/Presentation/Widgets/change_address_widget.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Presentation/Logic/user_managment_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCommercialProfileSheet extends StatefulWidget {
  const UpdateCommercialProfileSheet({
    Key? key,
    required this.commercialProfileModel,
    required this.index,
  }) : super(key: key);
  final CommercialProfileModel commercialProfileModel;
  final int index;

  @override
  State<UpdateCommercialProfileSheet> createState() =>
      _UpdateCommercialProfileSheetState();
}

class _UpdateCommercialProfileSheetState
    extends State<UpdateCommercialProfileSheet> {
  final TextEditingController bio = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController secondaryName = TextEditingController();
  final TextEditingController taxNumber = TextEditingController();
  final TextEditingController commercialRegister = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController neighbourhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    bio.text = widget.commercialProfileModel.bio!;
    address.text = widget.commercialProfileModel.address!;
    name.text = widget.commercialProfileModel.profileName!;
    secondaryName.text = widget.commercialProfileModel.secondaryName!;
    taxNumber.text = widget.commercialProfileModel.taxNumber!;
    commercialRegister.text = widget.commercialProfileModel.commercialRegister!;
    email.text = widget.commercialProfileModel.email!;
    city.text = widget.commercialProfileModel.city!;
    neighbourhood.text = widget.commercialProfileModel.neighbourhood!;
    street.text = widget.commercialProfileModel.street!;
    postalCode.text = widget.commercialProfileModel.postalCode!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(hintText: "الإسم"),
                validator: (value) => Validator().validateEmpty(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: secondaryName,
                decoration:
                    InputDecoration(hintText: tr(LocaleKeys.secondary_name)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: bio,
                decoration: const InputDecoration(hintText: "الوصف"),
              ),
              const SizedBox(height: 10),
              ChangeAddressWidget(
                  address: _addressController,
                  city: city,
                  neighbourhood: neighbourhood,
                  postalCode: postalCode,
                  street: street),
              const SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration:
                    const InputDecoration(hintText: "البريد الالكترونى"),
                validator: (value) => Validator().validateEmail(value!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: commercialRegister,
                decoration:
                    const InputDecoration(hintText: "رقم السجل التجارى"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: taxNumber,
                decoration: const InputDecoration(hintText: "الرقم الضريبى"),
              ),
              AppButton(
                title: "تعديل",
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    await context
                        .read<UserManagementVL>()
                        .editCommercialProfile(
                          CommercialProfileModel(
                              id: widget.commercialProfileModel.id,
                              profileName: name.text,
                              secondaryName: secondaryName.text,
                              bio: bio.text,
                              address: address.text,
                              city: city.text,
                              neighbourhood: neighbourhood.text,
                              postalCode: postalCode.text,
                              street: street.text,
                              commercialRegister: commercialRegister.text,
                              email: email.text,
                              taxNumber: taxNumber.text),
                          widget.index,
                        );
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
