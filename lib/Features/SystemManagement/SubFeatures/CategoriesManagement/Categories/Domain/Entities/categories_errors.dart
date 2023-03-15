class CategoriesError {
  String? nameAr;
  String? nameEn;
  CategoriesError({this.nameAr, this.nameEn});
  factory CategoriesError.fromJson(Map<String, dynamic> json) {
    return CategoriesError(
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
      other is CategoriesError &&
          runtimeType == other.runtimeType &&
          nameEn == other.nameEn &&
          nameAr == other.nameAr;

  @override
  int get hashCode => nameAr.hashCode;
}
