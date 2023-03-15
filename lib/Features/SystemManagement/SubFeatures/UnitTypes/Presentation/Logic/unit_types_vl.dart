import 'package:agriunion/Features/SystemManagement/SubFeatures/UnitTypes/Domain/Entities/unit_types_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../App/Utilities/api_handler.dart';
import '../../Domain/ServiceLayer/service_layer.dart';

class UnitTypesVL extends ChangeNotifier {
  final IUnitTypesService _unitTypesService;
  UnitTypesVL(this._unitTypesService);

  List<UnitType> unitTypes = [];
  bool isLoading = false;
  getUnitTypes() async {
    isLoading = true;
    unitTypes = await _unitTypesService.getUnitTypes();
    isLoading = false;
    notifyListeners();
  }

  UnitType? addingUnitType;
  addUntiType() async {
    addingUnitType = await _unitTypesService.addUnitType(addingUnitType!);

    notifyListeners();
  }

  manageAddingProduct(BuildContext context) async {
    await addUntiType();
    if (addingUnitType!.error == null) {
      unitTypes.add(addingUnitType!);
      Navigator.pop(context);
    }
  }

  editUnitType(UnitType unit, int index) async {
    final editedUnitTypes = await _unitTypesService.editUnitType(unit);
    unitTypes[index] = editedUnitTypes;
    notifyListeners();
  }

  deleteUnitType(UnitType unitType) async {
    try {
      await _unitTypesService.deleteUnitType(unitType.id!);
      unitTypes.remove(unitType);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }
    notifyListeners();
  }
}
