class UnitTypeError {
  String? nameAr;
  String? nameEn;
  UnitTypeError({this.nameAr, this.nameEn});
  factory UnitTypeError.fromJson(Map<String, dynamic> json) {
    return UnitTypeError(
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
      other is UnitTypeError &&
          runtimeType == other.runtimeType &&
          nameEn == other.nameEn &&
          nameAr == other.nameAr;

  @override
  int get hashCode => nameAr.hashCode;
}
