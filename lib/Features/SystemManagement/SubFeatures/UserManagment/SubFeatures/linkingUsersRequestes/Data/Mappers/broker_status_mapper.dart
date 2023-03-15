import 'package:agriunion/Features/SystemManagement/SubFeatures/UserManagment/SubFeatures/linkingUsersRequestes/Domain/Entities/broker_status_model.dart';

class BrokerStatusMapper{

  static BrokerStatusModel fromJson(Map<String, dynamic> json) {
    return BrokerStatusModel(
       id:  json['id'],
      type:json['type'] ,
      phone:json['mobile'] ,
      hasParent: json['has_parent'],
      parent: json['parent']
    );
  }
}