import 'package:agriunion/App/GlobalWidgets/app_text_button.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/broker_to_market_requests_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/ViewLogic/brokers_to_market_requests_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnlinkWidget extends StatelessWidget {
  const UnlinkWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final BrokerToMarketRequest request;

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
              context.read<BrokersToMarketRequestsVL>().unLinkRequests(request),
        ),
      ],
    );
  }
}
