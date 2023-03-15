import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

abstract class IStoryNetworking {
  Future<dynamic> addStory(Map<String, dynamic> body);

  Future<dynamic> getAllStories();

  Future<dynamic> getSpecificUserStories(int userId);

  Future<dynamic> deleteStory(int storyId);
}

class StoryNetworking implements IStoryNetworking {
  StoryNetworking(this.networking);

  final NetworkHelper networking;

  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> addStory(Map<String, dynamic> body) async {
    try {
      final response = await networking.postMedia(
        url: storyUrl,
        headers: headers(),
        body: body,
      );

      var data = response.data;

      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else if (e is DioError) {
        if (e.response!.statusCode == 422) {
          return e.response!.data;
        }
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getAllStories() async {
    try {
      final response = await networking.get(
        url: storyUrl,
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> getSpecificUserStories(int userId) async {
    try {
      final response = await networking.get(
        url: '$userStoriesUrl?user_id=$userId',
        headers: headers(),
      );
      var data = response.data;
      return data;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> deleteStory(int storyId) async {
    try {
      final response = await networking.delete(
        url: storyUrl + "/$storyId",
        headers: headers(),
      );
      return response;
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }
}
