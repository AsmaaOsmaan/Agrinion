import 'package:agriunion/Features/Offers/Data/Repositories/offers_repo.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/conversation_entity.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/grouped_conversation.dart';
import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:collection/collection.dart';

import '../../Data/Mappers/grouped_conv_mapper.dart';

abstract class IOffersService {
  Future<Offer> addOffer(Offer offer, int adId);
  Future<Conversation> showConversation(int convId);
  Future<void> acceptOffer(Offer offer);
  Future<void> rejectOffer(Offer offer);
  Future<List<Conversation>> getAcceptedConversations(int orderId);
  Future<List<Conversation>> getPeningConversations(int orderId);
  Future<List<Conversation>> getRejectedConversations(int orderId);
  Future<List<GroupedConversation>> getAcceptedGroupConversations(int orderId);
  Future<List<GroupedConversation>> getPeningGroupConversations(int orderId);
  Future<List<GroupedConversation>> getRejectedGroupConversations(int orderId);
}

class OffersService implements IOffersService {
  IOffersRepository offersRepo;
  OffersService(this.offersRepo);

  @override
  Future<Offer> addOffer(Offer offer, int convId) async {
    offer.valdiateQuantity();
    return await offersRepo.addOffer(offer, convId);
  }

  @override
  Future<Conversation> showConversation(int convId) async {
    var conversation = await offersRepo.showConversation(convId);
    return conversation;
  }

  @override
  Future<void> acceptOffer(Offer offer) async {
    try {
      await offersRepo.acceptOffer(offer);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> rejectOffer(Offer offer) async {
    try {
      await offersRepo.rejectOffer(offer);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<List<Conversation>> getAcceptedConversations(int adId) async {
    return await offersRepo.getAcceptedConversations(adId);
  }

  @override
  Future<List<Conversation>> getPeningConversations(int orderId) async {
    return await offersRepo.getPendingConversations(orderId);
  }

  @override
  Future<List<Conversation>> getRejectedConversations(int orderId) async {
    return await offersRepo.getRejectedConversations(orderId);
  }

  @override
  Future<List<GroupedConversation>> getAcceptedGroupConversations(
      int adId) async {
    final accepted = await offersRepo.getAcceptedConversations(adId);
    final grouped = accepted.groupListsBy((element) => element.managerName);
    return GroupedConversationMapper.convertToGrouped(grouped);
  }

  @override
  Future<List<GroupedConversation>> getPeningGroupConversations(
      int orderId) async {
    final pending = await offersRepo.getPendingConversations(orderId);
    final grouped = pending.groupListsBy((element) => element.managerName);
    return GroupedConversationMapper.convertToGrouped(grouped);
  }

  @override
  Future<List<GroupedConversation>> getRejectedGroupConversations(
      int orderId) async {
    final rejected = await offersRepo.getRejectedConversations(orderId);
    final grouped = rejected.groupListsBy((element) => element.managerName);
    return GroupedConversationMapper.convertToGrouped(grouped);
  }
}
