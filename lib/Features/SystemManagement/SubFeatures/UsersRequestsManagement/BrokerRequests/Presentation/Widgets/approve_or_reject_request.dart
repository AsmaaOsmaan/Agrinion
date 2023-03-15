import 'package:agriunion/Features/SystemManagement/SubFeatures/UsersRequestsManagement/BrokerRequests/Domain/Entities/rejection_reason_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../App/GlobalWidgets/app_text_button.dart';
import '../../../../../../../App/Resources/color_manager.dart';
import '../../../../../../../generated/translations.g.dart';
import '../../Domain/Entities/broker_to_market_requests_entity.dart';
import '../ViewLogic/brokers_to_market_requests_vl.dart';
import 'rejection_reason_dialog.dart';

class AcceptOrRefuseWidget extends StatelessWidget {
  const AcceptOrRefuseWidget({
    Key? key,
    required this.request,
  }) : super(key: key);

  final BrokerToMarketRequest request;

  @override
  Widget build(BuildContext context) {
    return  Consumer<BrokersToMarketRequestsVL>(builder: (context, vl, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppTextButton(
            text: tr(LocaleKeys.accept),
            color: ColorManager.green,
            onTap: () => context
                .read<BrokersToMarketRequestsVL>()
                .approveRequests(request),
          ),
          AppTextButton(
            text: tr(LocaleKeys.reject),
            color: ColorManager.favRed,
            onTap: ()async {
              var result = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) =>
                    const  RejectionReasonDialog());
              if (result['send'] != null &&
                  result['send'] == true) {
                context.read<BrokersToMarketRequestsVL>().rejectRequests(request,RejectionReasonModel(rejectionReason:  result['reason']));
              }
            },
          ),
        ],
      );
    }

    );
  }
}
