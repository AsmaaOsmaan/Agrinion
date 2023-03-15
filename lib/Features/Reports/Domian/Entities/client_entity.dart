import 'package:equatable/equatable.dart';

class Client extends Equatable {
  final int? id;
  final String? profileName;
  final String? secondaryProfileName;

  const Client({this.id, this.profileName, this.secondaryProfileName});

  @override
  List<Object?> get props => [id, profileName, secondaryProfileName];
}
