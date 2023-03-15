import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Payment/Domain/Entities/payment.dart';
import 'package:agriunion/Features/Payment/Presentation/ViewLogic/payment_vl.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key, required this.payment}) : super(key: key);
  final Payment payment;

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentVL>(builder: (context, vl, child) {
      return Container(
        padding: const EdgeInsets.all(paddingDistance),
        height: SizeConfig.screenHeight! * .10,
        margin: const EdgeInsets.only(bottom: paddingDistance),
        decoration: BoxDecoration(
          borderRadius: radius8,
          border: Border.all(color: ColorManager.lightGrey),
          color: ColorManager.lightGrey1,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(' ${tr(LocaleKeys.payment_amount)}'),
                Text(
                  "${payment.paymentAmount!}",
                  style: getBoldStyle(
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(' ${tr(LocaleKeys.payment_date)}'),
              Text(
                Utils.dateFormat(payment.createdAt!),
                style: getBoldStyle(
                  size: 14,
                ),
              ),
            ],
          ),
        ]),
      );
    });
  }
}
