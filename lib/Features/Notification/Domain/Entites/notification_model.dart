import 'package:agriunion/Features/Notification/Domain/Entites/notification_data_model.dart';
import 'package:agriunion/Features/Notification/Domain/Entites/pagination_data_model.dart';
import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final List<NotificationDataModel> notificationDataModel;
  final PaginationDataModel? paginationDataModel;
  const NotificationModel(
      {this.paginationDataModel, required this.notificationDataModel});

  @override
  List<Object?> get props => [notificationDataModel, paginationDataModel];
}
