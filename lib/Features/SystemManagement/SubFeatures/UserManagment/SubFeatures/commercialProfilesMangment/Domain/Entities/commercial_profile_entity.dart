import 'package:equatable/equatable.dart';

import '../../../../../../../Orders/Domain/Entities/create_order_model.dart';

class CommercialProfileModel extends Equatable {
  final int? id;
  final String? bio;
  final String? address;
  final String? profileName;
  final String? secondaryName;
  final String? email;
  final String? taxNumber;
  final String? commercialRegister;
  final Creator? creator;
  final String? type;
  final String? city;
  final String? neighbourhood;
  final String? postalCode;
  final String? street;

  const CommercialProfileModel(
      {this.bio,
      this.address,
      this.profileName,
      this.secondaryName,
      this.email,
      this.taxNumber,
      this.commercialRegister,
      this.creator,
      this.id,
      this.type,
      this.postalCode,
      this.neighbourhood,
      this.city,
      this.street});

  @override
  List<Object?> get props => [
        id,
        type,
        address,
        bio,
        neighbourhood,
        city,
        street,
        profileName,
        secondaryName,
        email,
        taxNumber,
        commercialRegister,
        postalCode,
        creator,
      ];
}

extension ValidateCommercialProfile on CommercialProfileModel {
  bool validate() {
    bool isValid = false;
    if (id == 0) {
      isValid = false;
    } else if (profileName == "") {
      isValid = false;
    } else if (email == "") {
      isValid = false;
    } else {
      isValid = true;
    }
    return isValid;
  }
}
