import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/cities_mapper.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Domain/Entities/city_entity.dart';

import '../DataSourse/cities_network.dart';

abstract class ICitiesRepository {
  Future<List<Cities>> getCities();
  Future<Cities> addCity(Cities model);
  Future<Cities> editCity(Cities model);
  Future<void> deleteCity(int id);
}

class CitiesRepository implements ICitiesRepository {
  final ICitiesNetworking citiesNetwork;
  CitiesRepository(this.citiesNetwork);

  List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  List<Cities> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => CitiesMapper.fromJson(e)).toList();
  }

  Cities convertToModel(Map<String, dynamic> jsonResponse) {
    return CitiesMapper.fromJson(jsonResponse);
  }

  @override
  Future<List<Cities>> getCities() async {
    final response = await citiesNetwork.getCities();
    final jsonResponse = convertToListJson(response);
    final cities = convertToListModel(jsonResponse);
    return cities;
  }

  @override
  Future<Cities> addCity(Cities model) async {
    final response = await citiesNetwork.addCity(CitiesMapper.toJson(model));
    final jsonResponse = convertToJson(response);
    final city = convertToModel(jsonResponse);
    return city;
  }

  @override
  Future<Cities> editCity(Cities model) async {
    final response =
        await citiesNetwork.editCity(CitiesMapper.toJson(model), model.id!);
    final jsonResponse = convertToJson(response);
    final city = convertToModel(jsonResponse);
    return city;
  }

  @override
  Future<void> deleteCity(int id) async {
    await citiesNetwork.deleteCity(id);
  }
}
