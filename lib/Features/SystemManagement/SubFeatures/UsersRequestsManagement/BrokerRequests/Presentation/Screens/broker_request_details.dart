import 'package:agriunion/App/GlobalWidgets/loading_view.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/App/Utilities/cache_helper.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/constants/keys.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/ViewLogic/brokers_to_market_requests_vl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/Widgets/cancel_widget.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Presentation/Widgets/unlink_widget.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/Resources/color_manager.dart';
import '../../Domain/Entities/broker_to_market_requests_entity.dart';
import '../Widgets/approve_or_reject_request.dart';

class BrokerRequestDetails extends StatefulWidget {
  const BrokerRequestDetails({
    Key? key,
    required this.requestId,
  }) : super(key: key);
  final int requestId;

  @override
  State<BrokerRequestDetails> createState() => _BrokerRequestDetailsState();
}

class _BrokerRequestDetailsState extends State<BrokerRequestDetails> {
  String? userType;
  @override
  void initState() {
    super.initState();
    userType = CachHelper.getData(key: kType);
    context
        .read<BrokersToMarketRequestsVL>()
        .showSpecificBrokersMarketRequest(widget.requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tr(LocaleKeys.details))),
      body: Consumer<BrokersToMarketRequestsVL>(builder: (context, vl, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: vl.isLoading
              ? const LoadingView()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      vl.brokerToMarketRequest!.broker!.nameAr!,
                      style: getBoldStyle(),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * .01),
                    Text(
                      '${tr(LocaleKeys.requestToJoin)} ${vl.brokerToMarketRequest!.market!.nameAr}',
                      style: getBoldStyle(),
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * .1),
                    checkUserType(vl.brokerToMarketRequest!)
                  ],
                ),
        );
      }),
    );
  }

  Widget checkUserType(BrokerToMarketRequest request) {
    if (request.status == 'pending') {
      if (userType == 'Admin') {
        return AcceptOrRefuseWidget(request: request);
      } else {
        return CancelWidget(request: request);
      }
    } else if (request.status == 'approved') {
      return UnlinkWidget(request: request);
    } else if (request.status == 'rejected') {
      return Center(
          child: Text(
        tr(LocaleKeys.rejected),
        style: getBoldStyle(size: 20, fontColor: ColorManager.favRed),
      ));
    } else {
      return Center(
          child: Text(
        tr(LocaleKeys.canceled),
        style: getBoldStyle(size: 20, fontColor: ColorManager.favRed),
      ));
    }
  }
}
