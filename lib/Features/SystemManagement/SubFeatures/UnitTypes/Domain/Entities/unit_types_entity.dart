import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_error.dart';

class UnitType {
  int? id;
  String nameAr;
  String nameEn;
  UnitTypeError? error;

  UnitType({
    this.id,
    required this.nameAr,
    required this.nameEn,
    this.error,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameEn == other.nameEn &&
          nameAr == other.nameAr;

  @override
  int get hashCode => id.hashCode;
}
