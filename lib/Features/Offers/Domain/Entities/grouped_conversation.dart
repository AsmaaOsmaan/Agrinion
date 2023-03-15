import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';

class GroupedConversation {
  final String? managerName;
  final List<Conversation>? conversations;

  GroupedConversation({this.managerName, this.conversations});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupedConversation &&
          runtimeType == other.runtimeType &&
          managerName == other.managerName &&
          conversations == other.conversations;

  @override
  int get hashCode => managerName.hashCode;
}
