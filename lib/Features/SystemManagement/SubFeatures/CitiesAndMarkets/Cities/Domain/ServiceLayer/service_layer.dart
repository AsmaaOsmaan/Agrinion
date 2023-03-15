import 'package:agriunion/Features/SystemManagement/SubFeatures/CitiesAndMarkets/Cities/Data/Repositories/cities_repo_impl.dart';

import '../../../../../../../App/Errors/exceptions.dart';
import '../Entities/city_entity.dart';

abstract class ICitiesService {
  Future<List<Cities>> getCities();
  Future<Cities> addCity(Cities city);
  Future<Cities> editCity(Cities city);
  Future<void> deleteCity(int id);
}

class CitiesService implements ICitiesService {
  ICitiesRepository citiesRepo;
  CitiesService(this.citiesRepo);
  @override
  Future<List<Cities>> getCities() async {
    return await citiesRepo.getCities();
  }

  @override
  Future<Cities> addCity(Cities city) async {
    return await citiesRepo.addCity(city);
  }

  @override
  Future<Cities> editCity(Cities city) async {
    return await citiesRepo.editCity(city);
  }

  @override
  Future<void> deleteCity(int id) async {
    try {
      await citiesRepo.deleteCity(id);
    } on Exception {
      throw const BadEntitesException(
          message: "This Entity has associated data");
    }
  }
}
