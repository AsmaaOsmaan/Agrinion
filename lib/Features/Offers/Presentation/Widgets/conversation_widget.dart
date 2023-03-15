import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Utilities/size_config.dart';
import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/app_route.dart';
import '../../../../App/constants/distances.dart';
import '../../../../App/constants/values.dart';
import '../../../../generated/translations.g.dart';
import '../Screens/negotitaion_screen.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget({
    Key? key,
    required this.conversation,
    required this.index,
    required this.additionContent,
  }) : super(key: key);

  final Conversation conversation;
  final int index;
  final Widget additionContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoute().navigate(
          context: context,
          route: NegotiationScreen(
            conversationId: conversation.id!,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(paddingDistance),
        margin: const EdgeInsets.only(bottom: paddingDistance),
        decoration: BoxDecoration(
          borderRadius: radius8,
          border: Border.all(color: ColorManager.lightGrey),
          color: ColorManager.lightGrey1,
        ),
        child: Column(
          children: [
            Row(children: [
              conversation.image == null
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: radius8,
                      child: Image.network(
                        conversation.image!,
                        fit: BoxFit.cover,
                        width: SizeConfig.screenWidth! * .15,
                        height: SizeConfig.screenHeight! * .12,
                      ),
                    ),
              const SizedBox(width: paddingDistance),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      conversation.ad!.product.nameAr,
                      style: getBoldStyle(),
                    ),
                    Text(
                      '${conversation.status}',
                      style: getBoldStyle(
                        size: 14,
                        fontColor:
                            Utils.getColorBasedOnStatus(conversation.status!),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${tr(LocaleKeys.quantity)} : ${conversation.lastOffer?.quantity!.toInt()}',
                        ),
                        const SizedBox(width: paddingDistance),
                        Text(
                            '${tr(LocaleKeys.price)} : ${conversation.lastOffer?.price}'),
                      ],
                    ),
                    additionContent
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
