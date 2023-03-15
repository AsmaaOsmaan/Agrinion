import '../../../../App/Utilities/utils.dart';
import '../../Domain/Entites/news_model.dart';
import '../DataSource/news_networking.dart';
import '../Mapper/news_mapper.dart';

abstract class INewsRepository {
  Future<NewsModel> createNews(NewsModel model);

  Future<List<NewsModel>> listAllNews();

  Future<List<NewsModel>> homeListAllNews();

  Future<NewsModel> showSpecificNews(int newsId);

  Future<void> deleteNews(int newsId);

  Future<NewsModel> editNews(NewsModel model);
}

class NewsRepository implements INewsRepository {
  INewsNetworking newsNetworking;

  NewsRepository(this.newsNetworking);

  Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  NewsModel convertToModel(Map<String, dynamic> jsonResponse) {
    return NewsMapper.fromJson(jsonResponse);
  }

  List<NewsModel> convertToListModel(List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => NewsMapper.fromJson(e)).toList();
  }

  @override
  Future<NewsModel> createNews(NewsModel model) async {
    final response = await newsNetworking.createNews(NewsMapper.toJson(model));
    final jsonResponse = convertToJson(response);
    final news = convertToModel(jsonResponse);
    return news;
  }

  @override
  Future<List<NewsModel>> listAllNews() async {
    final response = await newsNetworking.listAllNews();
    final jsonResponse = Utils.convertToListJson(response);
    final allNews = convertToListModel(jsonResponse);
    return allNews;
  }

  @override
  Future<List<NewsModel>> homeListAllNews() async {
    final response = await newsNetworking.homeListAllNews();
    final jsonResponse = Utils.convertToListJson(response);
    final allNews = convertToListModel(jsonResponse);
    return allNews;
  }

  @override
  Future<NewsModel> showSpecificNews(int newsId) async {
    final response = await newsNetworking.showSpecificNews(newsId);
    final jsonResponse = Utils.convertToJson(response);
    final news = convertToModel(jsonResponse);
    return news;
  }

  @override
  Future<void> deleteNews(int newsId) async {
    await newsNetworking.deleteNews(newsId);
  }

  @override
  Future<NewsModel> editNews(NewsModel model) async {
    final response =
        await newsNetworking.editNews(NewsMapper.toJson(model), model.id!);
    final jsonResponse = convertToJson(response);
    final news = convertToModel(jsonResponse);
    return news;
  }
}
