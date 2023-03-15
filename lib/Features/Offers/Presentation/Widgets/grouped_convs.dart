import 'package:flutter/material.dart';

import '../../../../App/Resources/text_themes.dart';
import '../../../../App/constants/distances.dart';
import '../../Domain/Entities/grouped_conversation.dart';
import 'conversation_widget.dart';

class GroupedConversationWidget extends StatelessWidget {
  const GroupedConversationWidget({
    Key? key,
    required this.gcs,
    required this.getAdditionContent,
  }) : super(key: key);

  final GroupedConversation gcs;
  final Widget getAdditionContent;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(gcs.managerName!, style: getBoldStyle()),
        const SizedBox(height: paddingDistance),
        ...List.generate(
          gcs.conversations!.length,
          (index) => ConversationWidget(
            conversation: gcs.conversations![index],
            index: index,
            additionContent: getAdditionContent,
          ),
        ),
      ],
    );
  }
}
