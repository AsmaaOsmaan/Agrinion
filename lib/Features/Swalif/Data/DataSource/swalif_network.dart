import 'dart:async';
import 'dart:io';

import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/App/Network/network_routes.dart';
import 'package:dio/dio.dart';

abstract class ISwalifNetworking {
  Future<dynamic> addSwalifPost(Map<String, dynamic> body);
  Future<dynamic> getAllSwalifPosts(String postType);
  Future<dynamic> showSwalifPost(int postId);
  Future<dynamic> deleteSwalifPost(int postId);
  Future updateSwalifPost(Map<String, dynamic> body, int postId);
  Future<dynamic> likeSwalifPost(int postId);
  Future<dynamic> disLikeSwalifPost(int postId);
  Future<dynamic> likeComment(int postId);
  Future<dynamic> disLikeComment(int postId);
  Future<dynamic> getAllCommentsOnParticularPost(int postId);
  Future<dynamic> createComment(Map<String, dynamic> body, int postId);
  Future updateComment(Map<String, dynamic> body, int postId, int commentId);
  Future<dynamic> deleteComment(int postId, int commentId);
}

class SwalifNetworking implements ISwalifNetworking {
  SwalifNetworking(this.networking);
  final NetworkHelper networking;
  Map<String, String> headers() => {
        'Accept': 'application/json',
        'Content-Type': "application/json",
        'X-access-token': getToken(),
      };

  @override
  Future<dynamic> addSwalifPost(Map<String, dynamic> body) async {
    try {
      final response = await networking.post(
        url: swalifUrl,
        headers: headers(),
        body: body,
      );

      var data = response.data;
      return data['post'];
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
  Future<dynamic> getAllSwalifPosts(String postType) async {
    try {
      final response = await networking.get(
        url: swalifUrl + '?posts=$postType',
        headers: headers(),
      );
      var data = response.data;
      return data['posts'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> showSwalifPost(int postId) async {
    try {
      final response = await networking.get(
        url: '$swalifUrl/$postId',
        headers: headers(),
      );
      var data = response.data;
      return data['post'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> deleteSwalifPost(int postId) async {
    try {
      final response = await networking.delete(
        url: swalifUrl + "/$postId",
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

  @override
  Future updateSwalifPost(Map<String, dynamic> body, int postId) async {
    try {
      final response = await networking.patch(
          url: '$swalifUrl/$postId', headers: headers(), body: body);
      return response.data['post'];
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> likeSwalifPost(int postId) async {
    Map<String, dynamic> body = {};
    try {
      var response = await networking.post(
          url: '$swalifUrl/$postId/$likesUrl', body: body, headers: headers());

      return response.data;
    } catch (e) {
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
  Future<dynamic> disLikeSwalifPost(int postId) async {
    try {
      final response = await networking.delete(
        url: '$swalifUrl/$postId/$likesUrl',
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

  @override
  Future<dynamic> likeComment(int commentId) async {
    Map<String, dynamic> body = {};
    try {
      var response = await networking.post(
          url: '$commentsUrl/$commentId/$likesUrl',
          body: body,
          headers: headers());

      return response.data;
    } catch (e) {
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
  Future<dynamic> disLikeComment(int commentId) async {
    try {
      final response = await networking.delete(
        url: '$commentsUrl/$commentId/$likesUrl',
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

  @override
  Future<dynamic> getAllCommentsOnParticularPost(int postId) async {
    try {
      final response = await networking.get(
        url: '$swalifUrl/$postId/$commentsUrl',
        headers: headers(),
      );
      var data = response.data;
      return data['comments'];
    } on Exception catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> createComment(Map<String, dynamic> body, int postId) async {
    try {
      final response = await networking.post(
        url: '$swalifUrl/$postId/$commentsUrl',
        headers: headers(),
        body: body,
      );

      var data = response.data;
      return data["comment"];
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
  Future updateComment(
      Map<String, dynamic> body, int postId, int commentId) async {
    try {
      final response = await networking.patch(
          url: '$swalifUrl/$postId/$commentsUrl/$commentId',
          headers: headers(),
          body: body);
      return response.data['comment'];
    } catch (e) {
      if (e is TimeoutException || e is SocketException || e is HttpException) {
        throw ConnectivityException;
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> deleteComment(int postId, int commentId) async {
    try {
      final response = await networking.delete(
        url: '$swalifUrl/$postId/$commentsUrl/$commentId',
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
