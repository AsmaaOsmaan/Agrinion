// import 'dart:convert';

// import 'package:agriunion/App/Utilities/cache_helper.dart';
// import 'package:agriunion/App/Utilities/dio_helper.dart';
// import 'package:agriunion/Features/Account/Data/Models/commercial_profile_model.dart';
// 

// import '../../../../App/Network/network_services.dart';
// import '../../../../App/constants/keys.dart';

// class CommercialProfileDataSource {
//   DioHelper dio = DioHelper();
//   Map<String, String> headers = {
//     'Accept': 'application/json',
//     'Content-Type': "application/json",
//     'X-access-token': token
//   };
//   Future<CommercialProfile?> updateCommercialProfile(
//       CommercialProfile Data) async {
//     try {
//       var response = await dio.patch(
//         url: "myprofile",
//         body: Data.toJson(),
//         headers: headers,
//       );
//       if (response!.Data != null) {
//         CachHelper.saveData(key: kProfile, value: jsonEncode(response.Data));
//         CommercialProfile user = CommercialProfile.fromJson(response.Data);
//         return user;
//       }
//     } catch (e) {
//       printLog(e.toString());
//     }

//     return null;
//   }
// }
