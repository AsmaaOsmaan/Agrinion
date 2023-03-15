import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Markets/Domain/Entities/markets_errors.dart';

class Market {
  int? id;
  String nameAr;
  String nameEn;
  MarketsError? errors;
  bool isSelected;

  Market({
    this.id,
    required this.nameAr,
    required this.nameEn,
    this.errors,
    this.isSelected = false,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Market &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameAr == other.nameAr;

  @override
  int get hashCode => id.hashCode;
}
