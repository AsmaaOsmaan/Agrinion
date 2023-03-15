import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../App/Utilities/utils.dart';
import '../../Domain/Entites/news_model.dart';
import '../../Domain/ServiceLayer/news_service_layer.dart';

class NewsVL extends ChangeNotifier {
  final INewsServiceLayer newsServiceLayer;

  NewsVL(this.newsServiceLayer);

  List<NewsModel> newsList = [];

  createNews(NewsModel newsModel) async {
    NewsModel creatingNews;
    creatingNews = await newsServiceLayer.createNews(newsModel);
    newsList.add(creatingNews);

    notifyListeners();
  }

  void listAllNews() async {
    newsList = await newsServiceLayer.listAllNews();

    notifyListeners();
  }

  void homeListAllNews() async {
    newsList = await newsServiceLayer.homeListAllNews();

    notifyListeners();
  }

  Future<void> deleteNews(NewsModel news) async {
    await newsServiceLayer.deleteNews(news.id!);
    newsList.remove(news);
    notifyListeners();
  }

  Future<void> editNews(NewsModel news, int index) async {
    final editedNews = await newsServiceLayer.editNews(news);
    newsList[index] = editedNews;
    notifyListeners();
  }

  File? image;

  Future<void> getNewsImage() async {
    image = await Utils.getImage();
    notifyListeners();
  }

  bool createPublish = false;

  changeCreatePublish(bool? value) {
    createPublish = value!;
    notifyListeners();
  }

  bool editPublish = false;

  changeEditingPublish(bool? value) {
    editPublish = value!;
    notifyListeners();
  }
}
