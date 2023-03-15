import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/values.dart';
import '../../../Orders/Domain/Entities/create_order_model.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem(
      {Key? key, required this.conversation, required this.creator})
      : super(key: key);
  final Conversation conversation;
  final Creator? creator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(color: ColorManager.lightGrey),
        borderRadius: radius8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              creator != null
                  ? Text("${creator!.name}", style: getBoldStyle(size: 14))
                  : const SizedBox(),
              Text(
                Utils.calculateTheTime(conversation.createdAt!),
                style: getBoldStyle(
                  size: 12,
                  fontColor: ColorManager.grey,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("الكمية:"),
                    Text("السعر:"),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${conversation.lastOffer!.quantity}"),
                    Text("${conversation.lastOffer!.price}"),
                  ],
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "مقبول",
                      style: getBoldStyle(
                        fontColor: Colors.green,
                        size: 14,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: ColorManager.error,
                        minimumSize: const Size(60, 20)),
                    child: Text(
                      "رفض",
                      style: getBoldStyle(fontColor: Colors.white, size: 14),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
