import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/validator.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/App/constants/values.dart';
import 'package:agriunion/Features/Account/Presentation/Widgets/change_address_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../App/Utilities/app_route.dart';
import '../../../Home/Presentation/Screens/home_screen.dart';
import '../../Data/Models/profile_model.dart';
import '../ViewLogic/users_vl.dart';
import '../Widgets/profile_pic_box.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profileNameController = TextEditingController();
  final TextEditingController _secondryNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commercialNoController = TextEditingController();
  final TextEditingController _taxNoController = TextEditingController();
  final TextEditingController _taxRateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController neighbourhood = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  late String phone;
  @override
  void initState() {
    _phoneController.text = phoneNumberView();
    context.read<UsersVL>().getUserProfile();
    super.initState();
  }

  String phoneNumberView() {
    if (CachHelper.getData(key: kPhone).toString().startsWith('+')) {
      phone = CachHelper.getData(key: kPhone).toString().substring(4);
    } else {
      phone = CachHelper.getData(key: kPhone);
    }
    return phone;
  }

  initProfile(Profile? profile) {
    _nameController.text = profile?.name ?? "";
    _taxNoController.text = profile?.taxNumber ?? "";
    _emailController.text = profile?.email ?? "";
    _descriptionController.text = profile?.bio ?? "";
    _profileNameController.text = profile?.profileName ?? "";
    _secondryNameController.text = profile?.secondaryName ?? "";
    _commercialNoController.text = profile?.commercialRegister ?? "";
    _taxRateController.text =
        profile?.taxRate == null ? '' : (profile?.taxRate).toString();
    city.text = profile!.city!;
    neighbourhood.text = profile.neighbourhood!;
    street.text = profile.street!;
    postalCode.text = profile.postalCode!;
  }

  @override
  void deactivate() {
    context.read<UsersVL>().avatar = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              AppRoute().navigateAndRemove(
                context: context,
                route: const HomeScreen(),
              );
            }
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Consumer<UsersVL>(builder: (context, vl, child) {
        initProfile(vl.profile);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ChangeProfilePicture(profileImage: vl.profile?.avatar),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                              hintText: tr(LocaleKeys.description)),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: tr(LocaleKeys.username)),
                              validator: (value) =>
                                  Validator().validateEmpty(value!),
                            )),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _phoneController,
                                enabled: false,
                                decoration: InputDecoration(
                                    hintText: tr(LocaleKeys.phone_number)),
                                validator: (value) =>
                                    Validator().validatePhone(value!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) =>
                              Validator().validateEmpty(value!),
                          controller: _profileNameController,
                          decoration:
                              InputDecoration(hintText: tr('commercialName')),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _secondryNameController,
                          decoration: InputDecoration(
                              hintText: tr(LocaleKeys.secondary_name)),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration:
                              InputDecoration(hintText: tr(LocaleKeys.email)),
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
                        TextFormField(
                            validator: (value) =>
                                Validator().validateTaxRate(value!),
                            controller: _taxRateController,
                            decoration: InputDecoration(
                                hintText: tr(LocaleKeys.tax_rate)),
                            keyboardType: decimalKeyboardType,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.]')),
                              LengthLimitingTextInputFormatter(2)
                            ]),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Flexible(
                                child: TextFormField(
                              controller: _commercialNoController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: tr(LocaleKeys.commercial_reg_no)),
                            )),
                            const SizedBox(width: 10),
                            Flexible(
                              child: TextFormField(
                                controller: _taxNoController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: tr(LocaleKeys.tax_number)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await context.read<UsersVL>().updateUserProfile(
                            Profile(
                                bio: _descriptionController.text,
                                commercialRegister:
                                    _commercialNoController.text,
                                email: _emailController.text,
                                name: _nameController.text,
                                profileName: _profileNameController.text,
                                secondaryName: _secondryNameController.text,
                                address: _addressController.text,
                                neighbourhood: neighbourhood.text,
                                city: city.text,
                                postalCode: postalCode.text,
                                street: street.text,
                                taxNumber: _taxNoController.text,
                                uploadedImage: vl.avatar,
                                taxRate:
                                    double.tryParse(_taxRateController.text)),
                          );
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        AppRoute().navigateAndRemove(
                            context: context, route: const HomeScreen());
                      }
                    }
                  },
                  child: Text(tr(LocaleKeys.save)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
