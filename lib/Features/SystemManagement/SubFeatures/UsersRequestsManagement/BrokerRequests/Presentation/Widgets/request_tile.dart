import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/app_route.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../../../App/Resources/color_manager.dart';
import '../../Domain/Entities/broker_to_market_requests_entity.dart';
import '../Screens/broker_request_details.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({
    Key? key,
    required this.request,
  }) : super(key: key);
  final BrokerToMarketRequest request;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => AppRoute().navigate(
        context: context,
        route: BrokerRequestDetails(requestId: request.id!),
      ),
      title: Text(request.market!.nameAr, style: getBoldStyle()),
      subtitle: Text(request.broker!.nameAr!),
      leading: CircleAvatar(
        radius: SizeConfig.defaultSize! * 2.5,
        backgroundColor: ColorManager.lightGrey,
        child: const Icon(Icons.person, color: ColorManager.black),
      ),
    );
  }
}
