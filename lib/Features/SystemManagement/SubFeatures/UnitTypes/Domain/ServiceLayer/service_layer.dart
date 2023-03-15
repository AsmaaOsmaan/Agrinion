import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';

import '../../../../../../App/Errors/exceptions.dart';
import '../../Data/Repositories/unit_types_repo_impl.dart';

abstract class IUnitTypesService {
  Future<List<UnitType>> getUnitTypes();
  Future<UnitType> addUnitType(UnitType unitType);
  Future<UnitType> editUnitType(UnitType unitType);
  Future<void> deleteUnitType(int id);
}

class UnitTypesService implements IUnitTypesService {
  final IUnitTypeRepository unitTypesRepo;
  UnitTypesService(this.unitTypesRepo);
  @override
  Future<List<UnitType>> getUnitTypes() async {
    return await unitTypesRepo.getUnitType();
  }

  @override
  Future<UnitType> addUnitType(UnitType unitType) async {
    return await unitTypesRepo.addUnitType(unitType);
  }

  @override
  Future<UnitType> editUnitType(UnitType unitType) async {
    return await unitTypesRepo.editUnitType(unitType);
  }

  @override
  Future<void> deleteUnitType(int id) async {
    try {
      await unitTypesRepo.deleteUnitType(id);
    } on Exception {
      throw const BadEntitesException(message: "This Data has associated Ads");
    }
  }
}
