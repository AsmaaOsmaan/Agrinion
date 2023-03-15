import '../../../Orders/Domain/Entities/create_order_model.dart';
import 'cart_item_errors_errors.dart';

class CartItemEntity {
  String? productNameEn;
  String? productNameAr;
  int? id;
  double? quantity;
  double? price;
  String? note;
  String? status;
  int? commercialProfileId;
  int? adId;
  String? createdAt;
  Creator? creator;
  CartItemsError? errors;
  int? orderId;
  bool isDone;
  bool? isValid;
  String? image;
  int? minQty;
  bool? isSend;

  CartItemEntity(
      {this.productNameEn,
      this.productNameAr,
      this.id,
      this.adId,
      this.commercialProfileId,
      this.creator,
      this.errors,
      this.note,
      this.price,
      this.quantity,
      this.status,
      this.orderId,
      this.isDone = true,
      this.isValid,
      this.image,
      this.createdAt,
      this.minQty,
      this.isSend = false});
}
