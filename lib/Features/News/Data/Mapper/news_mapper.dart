import '../../../../App/Errors/exceptions.dart';
import '../../../../App/Network/network_helper.dart';
import '../../Domain/Entites/news_model.dart';

class NewsMapper {
  static NewsModel fromJson(Map<String, dynamic> json) {
    try {
      return NewsModel(
        id: json['id'],
        titleAr: json['title_ar'],
        titleEn: json["title_en"],
        bodyAr: json["body_ar"],
        bodyEn: json["body_en"],
        published: json["published"],
        newImage: json["image"] != null
            ? NetworkHelper.apiBaseUrl! + json["image"]
            : null,
        createdAt: json["created_at"],
      );
    } on Exception catch (e) {
      throw UnSupportedJsonFormat(e.toString() +
          "expected this format:{id: 1, title_ar:'' , title_en: '', body_ar:'' , body_en:'' , published: true, image:'' } , but found this : $json");
    }
  }

  static Map<String, dynamic> toJson(NewsModel newsModel) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title_ar'] = newsModel.titleAr;
    data["title_en"] = newsModel.titleEn;
    data["body_ar"] = newsModel.bodyAr;
    data["body_en"] = newsModel.bodyEn;
    data["published"] = newsModel.published;
    data["image"] = newsModel.image;

    return {"news": data};
  }
}
