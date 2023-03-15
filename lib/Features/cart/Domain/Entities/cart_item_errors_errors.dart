class CartItemsError {
  String? creator;
  String? authError;
  String? quantityError;
  CartItemsError({this.creator, this.authError, this.quantityError});
  factory CartItemsError.fromJson(Map<String, dynamic> json) {
    return CartItemsError(
      creator: json['errors']['creator_id'] != null
          ? json['errors']['creator_id'][0]
          : null,
      authError: json['errors']['auth_error'],
      quantityError: json['errors']['offers.quantity'] != null
          ? json['errors']['offers.quantity'][0]
          : null,
    );
  }
}
