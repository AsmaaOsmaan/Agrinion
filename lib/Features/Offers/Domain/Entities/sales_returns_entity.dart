import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';

class SalesReturn {
  int? id;
  int? quantity;
  Conversation? conversation;
  int? conversationId;
  Creator? creator;
  bool? invoiceGenerated;
  int? invoiceId;
  String? createdAt;
  SalesReturn(
      {this.creator,
      this.conversation,
      this.id,
      this.quantity,
      this.conversationId,
      this.invoiceGenerated,
      this.invoiceId,
      this.createdAt});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesReturn &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          conversation == other.conversation &&
          quantity == other.quantity &&
          conversationId == other.conversationId &&
          invoiceGenerated == other.invoiceGenerated &&
          invoiceId == other.invoiceId &&
          createdAt == other.createdAt &&
          creator == other.creator;

  @override
  int get hashCode => id.hashCode;
}
