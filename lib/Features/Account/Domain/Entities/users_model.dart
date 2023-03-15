import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final int userId;
  final String userName;

  const Users({
    required this.userId,
    required this.userName,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'],
      userName: json['user_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    return data;
  }

  @override
  List<Object?> get props => [userId, userName];
}
