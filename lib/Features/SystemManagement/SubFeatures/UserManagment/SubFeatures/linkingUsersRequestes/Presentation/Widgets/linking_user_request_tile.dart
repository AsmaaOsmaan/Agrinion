import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../Domain/Entities/linking_user_request_entity.dart';
import '../Screens/linking_user_request_details.dart';

class LinkingUserRequestTile extends StatelessWidget {
  const LinkingUserRequestTile({
    Key? key,
    required this.request,
    required this.parent,
    required this.id,
    required this.hasParent,
  }) : super(key: key);
  final LinkingUserRequest request;
  final bool? parent;
  final bool? hasParent;
  final int? id;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => AppRoute().navigate(
        context: context,
        route: LinkingUserRequestDetails(requestId: request.id),
      ),
      title: request.linkedUserId != id
          ? Text(request.linkedUserName!, style: getBoldStyle())
          : Text(request.userName!, style: getBoldStyle()),
      leading: CircleAvatar(
        radius: SizeConfig.defaultSize! * 2.5,
        backgroundColor: ColorManager.lightGrey,
        child: const Icon(Icons.person, color: ColorManager.black),
      ),
    );
  }
}
