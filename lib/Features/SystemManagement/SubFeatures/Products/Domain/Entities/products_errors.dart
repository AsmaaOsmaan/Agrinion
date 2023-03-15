class ProductsError {
  String? nameAr;
  String? nameEn;
  ProductsError({this.nameAr, this.nameEn});
  factory ProductsError.fromJson(Map<String, dynamic> json) {
    return ProductsError(
      nameAr: json['errors']['name_ar'] != null
          ? json['errors']['name_ar'][0]
          : null,
      nameEn: json['errors']['name_en'] != null
          ? json['errors']['name_en'][0]
          : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsError &&
          runtimeType == other.runtimeType &&
          nameAr == other.nameAr &&
          nameEn == other.nameEn;

  @override
  int get hashCode => nameAr.hashCode;
}
