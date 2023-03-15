import 'dart:io';

import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/Features/Account/Data/Models/profile_model.dart';
import 'package:agriunion/Features/Account/Data/Models/reset_password.dart';
import 'package:agriunion/Features/Account/Data/Models/set_password_model.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';
import '../../../../App/Utilities/utils.dart';
import '../../Domain/service_layer.dart';

class UsersVL extends ChangeNotifier {
  Profile? profile;
  late ResetPassword resetPassword;
  late SetPasswordModel setPasswordModelResponse;
  bool isLoading = false;
  final IProfileService _service;
  UsersVL(this._service);
  File? avatar;
  void getProfileImage() async {
    avatar = await Utils.getImage();
    notifyListeners();
  }

  Future<void> updateUserProfile(Profile profile) async {
    profile = await _service.updateProfile(profile);
    Profile.cachProfile(profile);
    notifyListeners();
  }

  Future<void> getUserProfile() async {
    profile = await _service.getProfile();
    Profile.cachProfile(profile!);
    notifyListeners();
  }

  Future<void> resetUserPassword(String oldPassword) async {
    changeLoadingStatues(true);
    resetPassword = await _service.resetPassword(oldPassword);
    changeLoadingStatues(false);
    notifyListeners();
  }

  Future<void> setNewPassword(
      SetPasswordModel setPasswordModel, BuildContext context) async {
    changeLoadingStatues(true);
    setPasswordModelResponse = await _service.setPassword(setPasswordModel);

    if (setPasswordModelResponse.errors != null) {
      LoadingDialog.showSimpleToast(
          setPasswordModelResponse.errors!.passwordConfirmation);
    } else {
      LoadingDialog.showSimpleToast(setPasswordModelResponse.msg);
      Navigator.pop(context);
      Navigator.pop(context);
    }

    changeLoadingStatues(false);

    notifyListeners();
  }

  changeLoadingStatues(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Widget getAvatar() {
    if (avatar != null) {
      return Image.file(
        avatar!,
        fit: BoxFit.cover,
        height: 50,
        width: SizeConfig.screenWidth,
      );
    }
    if (profile!.avatar != null) {
      return Image.network(
        profile!.avatar!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.camera_alt_outlined,
            color: ColorManager.grey,
            size: 28,
          ),
          const SizedBox(height: 10),
          Text(
            tr(LocaleKeys.changeProfilePic),
            style: getRegularStyle(
              fontSize: 16,
              fontColor: ColorManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}
