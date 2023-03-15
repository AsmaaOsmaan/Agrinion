class MarketsError {
  String? nameAr;
  String? nameEn;
  MarketsError({this.nameAr, this.nameEn});
  factory MarketsError.fromJson(Map<String, dynamic> json) {
    return MarketsError(
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
      other is MarketsError &&
          runtimeType == other.runtimeType &&
          nameAr == other.nameAr;

  @override
  int get hashCode => nameAr.hashCode;
}
