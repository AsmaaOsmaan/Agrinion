import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Data/DataSourse/unit_types_network.dart';

import '../../Domain/Entities/unit_types_entity.dart';
import '../../Domain/Entities/unit_types_mapper.dart';

abstract class IUnitTypeRepository {
  Future<List<UnitType>> getUnitType();
  Future<UnitType> addUnitType(UnitType model);
  Future<UnitType> editUnitType(UnitType model);
  Future<void> deleteUnitType(int id);
}

class UnitTypeRepository implements IUnitTypeRepository {
  final IUnitTypesNetworking _unitTypeNetwork;
  UnitTypeRepository(this._unitTypeNetwork);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<UnitType> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => UnitTypeMapper.fromJson(e)).toList();
  }

  UnitType convertToModel(Map<String, dynamic> jsonResponse) {
    return UnitTypeMapper.fromJson(jsonResponse);
  }

  @override
  Future<List<UnitType>> getUnitType() async {
    final response = await _unitTypeNetwork.getUnitTypes();
    final jsonResponse = convertToListJson(response);
    final unitTypes = convertToListModel(jsonResponse);
    return unitTypes;
  }

  @override
  Future<UnitType> addUnitType(UnitType model) async {
    final response =
        await _unitTypeNetwork.addUnitType(UnitTypeMapper.toJson(model));
    final jsonResponse = convertToJson(response);
    final unitType = convertToModel(jsonResponse);
    return unitType;
  }

  @override
  Future<UnitType> editUnitType(UnitType model) async {
    final response = await _unitTypeNetwork.editUnitType(
        UnitTypeMapper.toJson(model), model.id!);
    final jsonResponse = convertToJson(response);
    final unitType = convertToModel(jsonResponse);
    return unitType;
  }

  @override
  Future<void> deleteUnitType(int id) async {
    await _unitTypeNetwork.deleteUnitType(id);
  }
}
