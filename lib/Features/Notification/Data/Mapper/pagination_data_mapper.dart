import 'package:agriunion/Features/Notification/Domain/Entites/pagination_data_model.dart';

import '../../../../App/Errors/exceptions.dart';

class PaginationDataMapper {
  static PaginationDataModel fromJson(Map<String, dynamic> json) {
    try {
      return PaginationDataModel(
          currentPage: json['current_page'],
          totalCount: json['total_count'],
          totalPages: json['total_pages']);
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }
}
