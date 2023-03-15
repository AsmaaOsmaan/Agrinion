import 'package:agriunion/Features/Offers/Data/Mappers/conversation_mapper.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';

import '../../../../App/Utilities/utils.dart';
import '../DataSourse/offers_network.dart';
import '../Mappers/offers_mapper.dart';

abstract class IOffersRepository {
  Future<Offer> addOffer(Offer model, int convId);
  Future<Conversation> showConversation(int convId);
  Future<List<Conversation>> getAcceptedConversations(int orderId);
  Future<List<Conversation>> getPendingConversations(int orderId);
  Future<List<Conversation>> getRejectedConversations(int orderId);
  Future acceptOffer(Offer offer);
  Future rejectOffer(Offer offer);
}

class OffersRepository implements IOffersRepository {
  IOffersNetworking offersNetwork;
  OffersRepository(this.offersNetwork);
  List<Conversation> conversations = [];
  Conversation convertToConversation(Map<String, dynamic> jsonResponse) {
    return ConversationMapper.fromJson(jsonResponse);
  }

  List<Conversation> convertToListConversation(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => ConversationMapper.fromJson(e)).toList();
  }

  Offer convertToModel(Map<String, dynamic> jsonResponse) {
    return OffersMapper.fromJson(jsonResponse);
  }

  @override
  Future<Offer> addOffer(Offer model, int convId) async {
    final response =
        await offersNetwork.addOffer(OffersMapper.toJson(model), convId);
    final jsonResponse = Utils.convertToJson(response);
    final offer = convertToModel(jsonResponse);
    return offer;
  }

  @override
  Future<Conversation> showConversation(int convId) async {
    final response = await offersNetwork.showConversations(convId);
    final jsonResponse = Utils.convertToJson(response);
    final conversation = convertToConversation(jsonResponse);
    return conversation;
  }

  @override
  Future<void> acceptOffer(Offer offer) async {
    try {
      await offersNetwork.acceptOffer(OffersMapper.toJson(offer), offer.id!);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future rejectOffer(Offer offer) async {
    try {
      await offersNetwork.rejectOffer(OffersMapper.toJson(offer), offer.id!);
    } on Exception {
      rethrow;
    }
  }

  Future<void> getConversationsByOrder(int orderId) async {
    final response = await offersNetwork.getConversationsByOrder(orderId);
    final jsonResponse = Utils.convertToListJson(response);
    conversations = convertToListConversation(jsonResponse);
  }

  @override
  Future<List<Conversation>> getAcceptedConversations(int orderId) async {
    await getConversationsByOrder(orderId);
    List<Conversation> accepted =
        conversations.where((element) => element.status == "approved").toList();
    return accepted;
  }

  @override
  Future<List<Conversation>> getPendingConversations(int orderId) async {
    await getConversationsByOrder(orderId);
    List<Conversation> pending =
        conversations.where((element) => element.status == "pending").toList();
    return pending;
  }

  @override
  Future<List<Conversation>> getRejectedConversations(int orderId) async {
    await getConversationsByOrder(orderId);
    List<Conversation> rejected =
        conversations.where((element) => element.status == "rejected").toList();
    return rejected;
  }
}
