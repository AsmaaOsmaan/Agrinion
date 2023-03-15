import 'package:agriunion/App/GlobalWidgets/app_text_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/linking_user_request_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnlinkWidget extends StatelessWidget {
  const UnlinkWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final LinkingUserRequest request;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AppTextButton(
          width: 100,
          text: tr(LocaleKeys.unlink),
          color: ColorManager.favRed,
          onTap: () =>
              context.read<LinkingUsersRequestsVL>().unLinkRequests(request),
        ),
      ],
    );
  }
}
