import '../../Domain/Models/ad_favourit_model.dart';

class AdFavoriteMapper {
  static AdFavoriteModel fromJson(Map<String, dynamic> json) {
    return AdFavoriteModel(adId: json['ad_id'] ?? 1, msg: json['msg']);
  }

  static Map<String, dynamic> toJson(AdFavoriteModel addFavoriteModel) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ad_id'] = addFavoriteModel.adId;

    return {"favorite_ad": data};
  }
}
