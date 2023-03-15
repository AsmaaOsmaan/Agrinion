import 'package:agriunion/Features/Offers/Data/Mappers/conversation_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/sales_returns_entity.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../Orders/Data/Mappers/create_order_mapper.dart';

class SalesReturnMapper {
  static SalesReturn fromJson(Map<String, dynamic> json) {
    try {
      return SalesReturn(
        creator: json['creator'] != null
            ? CreatorMapper.fromJson(json['creator'])
            : null,
        id: json['id'],
        quantity: json['quantity'],
        conversation:json['conversation']!=null? ConversationMapper.fromJson(json['conversation']):null,
        conversationId: json['conversation_id'],
        invoiceGenerated: json['invoice_generated'],
        invoiceId: json['invoice_id'],
        createdAt: json['created_at'],
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, invoice_generated: true, created_at: , invoice_id: 1, conversation_id: 1, creator: {id: 1, name: , type: }, quantity: 1, conversation: {Conversation}} , but found this : $json");
    }
  }

  static Map<String, dynamic> toJson(SalesReturn salesReturn) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = salesReturn.quantity;
    data['conversation_id'] = salesReturn.conversationId;

    return {"sales_returns": data};
  }
}
