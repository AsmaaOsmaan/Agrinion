import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/Utilities/utils.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';
import '../../../Offers/Presentation/Screens/conversations_screen.dart';
import '../../Domain/Entities/order_entity.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    Key? key,
    required this.order,
    required this.index,
  }) : super(key: key);
  final Order order;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoute().navigate(
        context: context,
        route: OrderConversations(orderId: order.id!),
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: paddingDistance),
        padding: const EdgeInsets.symmetric(
          horizontal: paddingDistance,
          vertical: paddingDistance * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: radius8,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              blurStyle: BlurStyle.outer,
              offset: Offset(2, 6),
              color: ColorManager.grey,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${tr(LocaleKeys.request_number)} ${order.referenceNumber}",
                    style: getBoldStyle()),
                Text(
                  Utils.dateFormat(order.createdAt!),
                  style: getRegularStyle(fontColor: ColorManager.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
