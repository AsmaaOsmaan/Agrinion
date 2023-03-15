// import 'package:agriunion/App/Errors/exceptions.dart';
// import 'package:agriunion/App/Errors/failure.dart';
// import 'package:agriunion/App/Utilities/network_info.dart';
// import 'package:dartz/dartz.dart';

// import '../../Domain/Entities/city_entity.dart';
// import '../../Domain/Repositories/city_repository.dart';
// import '../DataSource/cities_data_source.dart';

// class NewsRepositoryImpl implements CityRepository {
//   final CitiesDataSource dataSource;
//   final NetWorkInfo netWorkInfo;
//   const NewsRepositoryImpl(
//       {required this.dataSource, required this.netWorkInfo});

//   @override
//   Future<Either<Failure, List<City>>> getCities() async {
//     if (!await netWorkInfo.isConnected) {
//       return Left(InternetFailure());
//     }
//     try {
//       List<City> news = await dataSource.getCities();
//       return Right(news);
//     } on ServerException {
//       return left(ServerFailure());
//     }
//   }
// }
