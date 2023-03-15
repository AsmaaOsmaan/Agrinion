import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/grouped_conversation.dart';

import '../../Domain/Entities/conversation_entity.dart';

class GroupedConversationMapper {
  static GroupedConversation fromJson(Map<String, dynamic> json) {
    try {
      return GroupedConversation(
        conversations: json['conversations'],
        managerName: json['name'],
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static List<GroupedConversation> convertToGrouped(
      Map<String?, List<Conversation>> grouped) {
    List<GroupedConversation> conversations = [];
    final _data = <String, dynamic>{};
    grouped.forEach((key, value) {
      _data['name'] = key;
      _data['conversations'] = value;
      conversations.add(fromJson(_data));
    });
    return conversations;
  }
}
