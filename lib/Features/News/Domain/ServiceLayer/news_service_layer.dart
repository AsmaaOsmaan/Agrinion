import '../../Data/Repositories/news_repo.dart';
import '../Entites/news_model.dart';

abstract class INewsServiceLayer {
  Future<NewsModel> createNews(NewsModel model);

  Future<List<NewsModel>> listAllNews();

  Future<List<NewsModel>> homeListAllNews();

  Future<NewsModel> showSpecificNews(int newsId);

  Future<void> deleteNews(int newsId);

  Future<NewsModel> editNews(NewsModel model);
}

class NewsServiceLayer implements INewsServiceLayer {
  INewsRepository newsRepo;

  NewsServiceLayer(this.newsRepo);

  @override
  Future<List<NewsModel>> listAllNews() async {
    return await newsRepo.listAllNews();
  }

  @override
  Future<List<NewsModel>> homeListAllNews() async {
    return await newsRepo.homeListAllNews();
  }

  @override
  Future<NewsModel> createNews(NewsModel newsModel) async {
    return await newsRepo.createNews(newsModel);
  }

  @override
  Future<NewsModel> showSpecificNews(int newsId) async {
    return await newsRepo.showSpecificNews(newsId);
  }

  @override
  Future<void> deleteNews(int newsId) async {
    await newsRepo.deleteNews(newsId);
  }

  @override
  Future<NewsModel> editNews(NewsModel model) async {
    return await newsRepo.editNews(model);
  }
}
