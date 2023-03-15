class Broker {
  int? id;
  String? nameAr;
  String? nameEn;
  String? type;
  String? mobile;
  bool? confirmed;

  Broker(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.type,
      this.mobile,
      this.confirmed});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Broker &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameAr == other.nameAr &&
          nameEn == other.nameEn;

  @override
  int get hashCode => id.hashCode;
}
