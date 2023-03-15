import 'package:agriunion/Features/Offers/Domain/Entities/offers_entity.dart';
import 'package:agriunion/Features/Orders/Data/Repositories/orders_repo.dart';
import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Data/Repositories/user_managment_repo_impl.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/commercialProfilesMangment/Domain/Entities/commercial_profile_entity.dart';

abstract class ICartService {
  Future<List<CommercialProfileModel>> getMerchantsCommercialProfiles();
  Future<CommercialProfileModel> addCommercialProfile(
      CommercialProfileModel commercialProfile);

  Future<CreateOrderModel> createOrderId(CreateOrderModel createOrderModel);
  Future<CreateOrderModel> createDirectOrderId(
      CreateOrderModel createOrderModel);
  Future<Offer> placeOrder(Offer offer, int id);
}

class CartService implements ICartService {
  IUserManagementRepository userManagementRepo;

  IOrdersRepository cartRepository;
  CartService(this.userManagementRepo, this.cartRepository);

  @override
  Future<List<CommercialProfileModel>> getMerchantsCommercialProfiles() async {
    return await userManagementRepo.getAllMerchantCommercialProfiles();
  }

  @override
  Future<CommercialProfileModel> addCommercialProfile(
      CommercialProfileModel commercialProfile) async {
    return await userManagementRepo.addCommercialProfile(commercialProfile);
  }

  @override
  Future<CreateOrderModel> createOrderId(
      CreateOrderModel createOrderModel) async {
    return await cartRepository.createOrderId(createOrderModel);
  }

  @override
  Future<CreateOrderModel> createDirectOrderId(
      CreateOrderModel createOrderModel) async {
    return await cartRepository.createDirectOrderId(createOrderModel);
  }

  @override
  Future<Offer> placeOrder(Offer offer, int id) async {
    return await cartRepository.placeOrder(offer, id);
  }
}
