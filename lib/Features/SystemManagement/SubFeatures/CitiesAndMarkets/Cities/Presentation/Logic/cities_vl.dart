import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/ServiceLayer/service_layer.dart';
import 'package:flutter/material.dart';

import '../../../../../../../App/Utilities/api_handler.dart';

class CitiesVL extends ChangeNotifier {
  final ICitiesService _citiesService;
  CitiesVL(this._citiesService);
  List<Cities> cities = [];
  bool isLoading = false;
  getCities() async {
    isLoading = true;
    cities = await _citiesService.getCities();
    isLoading = false;
    notifyListeners();
  }

  Cities? addingCity;
  addCity() async {
    addingCity = await _citiesService.addCity(addingCity!);
    notifyListeners();
  }

  manageAddingCity(BuildContext context) async {
    await addCity();
    if (addingCity!.errors == null) {
      cities.add(addingCity!);
      Navigator.pop(context);
    }
  }

  editCity(Cities city, int index) async {
    Cities editedCity = await _citiesService.editCity(city);
    cities[index] = editedCity;

    notifyListeners();
  }

  Future<void> deleteCity(Cities city) async {
    try {
      await _citiesService.deleteCity(city.id!);
      cities.remove(city);
    } on Exception catch (e) {
      APIHandler.handleExceptions(e);
    }

    notifyListeners();
  }
}
