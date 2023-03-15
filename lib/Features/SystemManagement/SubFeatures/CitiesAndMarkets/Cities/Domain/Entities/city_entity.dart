import 'cities_errors.dart';

class Cities {
  int? id;
  String nameAr;
  String nameEn;
  CitiesErrors? errors;
  bool isSelected;

  Cities({
    this.id,
    required this.nameAr,
    required this.nameEn,
    this.errors,
    this.isSelected = false,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cities &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameEn == other.nameEn &&
          nameAr == other.nameAr;

  @override
  int get hashCode => id.hashCode;
}
