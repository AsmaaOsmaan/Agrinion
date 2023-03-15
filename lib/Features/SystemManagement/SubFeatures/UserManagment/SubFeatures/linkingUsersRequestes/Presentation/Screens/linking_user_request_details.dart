import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/broker_status_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/linking_user_request_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/ViewLogic/linking_users_requests_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/Widgets/cancel_widget.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Presentation/Widgets/unlink_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../App/Utilities/cache_helper.dart';
import '../../../../../../../../App/constants/keys.dart';
import '../Widgets/approve_or_reject_request.dart';

class LinkingUserRequestDetails extends StatefulWidget {
  const LinkingUserRequestDetails({Key? key, required this.requestId})
      : super(key: key);

  final int? requestId;

  @override
  State<LinkingUserRequestDetails> createState() =>
      _LinkingUserRequestDetailsState();
}

class _LinkingUserRequestDetailsState extends State<LinkingUserRequestDetails> {
  int? id;

  @override
  void initState() {
    id = CachHelper.getData(key: kId);
    context
        .read<LinkingUsersRequestsVL>()
        .showLinkingUserRequest(widget.requestId!);
    context.read<LinkingUsersRequestsVL>().getBrokerStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LinkingUsersRequestsVL>(builder: (context, link, child) {
      return Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.details))),
        body: link.isLoading
            ? const LoadingView()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      link.linkingUserRequest!.linkedUserName!,
                      style: getBoldStyle(),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * .01),
                    Text(
                      '${tr(LocaleKeys.request_to_link)} ${link.linkingUserRequest!.userName}',
                      style: getBoldStyle(),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * .1),
                    checkStatusWidget(
                        link.linkingUserRequest!, link.brokerStatus!),
                  ],
                ),
              ),
      );
    });
  }

  Widget checkStatusWidget(
      LinkingUserRequest request, BrokerStatusModel broker) {
    if (request.status == 'pending') {
      if (broker.hasParent != true && request.linkedUserId != id) {
        return AcceptOrRefuseWidget(
          request: request,
        );
      } else {
        return CancelWidget(request: request);
      }
    } else if (request.status == 'approved') {
      return UnlinkWidget(request: request);
    } else if (request.status == 'canceled') {
      return Center(
          child: Text(
        tr(LocaleKeys.canceled),
        style: getBoldStyle(size: 20, fontColor: ColorManager.favRed),
      ));
    } else if (request.status == 'expired') {
      return Center(
          child: Text(
        tr(LocaleKeys.unlinked),
        style: getBoldStyle(size: 20, fontColor: ColorManager.favRed),
      ));
    } else {
      return Center(
          child: Text(
        tr(LocaleKeys.rejected),
        style: getBoldStyle(size: 20, fontColor: ColorManager.favRed),
      ));
    }
  }
}
