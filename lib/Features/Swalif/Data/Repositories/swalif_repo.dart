import 'package:agriunion/App/Utilities/utils.dart';
import 'package:agriunion/Features/Swalif/Data/DataSource/swalif_network.dart';
import 'package:agriunion/Features/Swalif/Data/mapper/comment_mapper.dart';
import 'package:agriunion/Features/Swalif/Data/mapper/swalif_post_mapper.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';

abstract class ISwalifRepository {
  Future<SwalifPostModel> addSwalifPost(SwalifPostModel model);
  Future<SwalifPostModel> showSwalifPost(int postId);
  Future<void> deleteSwalifPost(int postId);
  Future<SwalifPostModel> updateSwalifPost(SwalifPostModel model, int postId);
  Future<void> likePost(int postId);
  Future<void> dislikePost(int postId);
  Future<void> likeComment(int commentId);
  Future<void> dislikeComment(int commentId);
  Future<List<SwalifPostModel>> getMyPosts();
  Future<List<SwalifPostModel>> getAllPosts();
  Future<List<SwalifPostModel>> getPostsByTypes(String postType);
  Future<List<CommentModel>> getAllCommentsOnParticularPost(int postId);
  Future<CommentModel> createComment(CommentModel model, int postId);
  Future<CommentModel> updateComment(
      CommentModel model, int postId, int commentId);
  Future<void> deleteComment(int postId, int commentId);
}

class SwalifRepository implements ISwalifRepository {
  ISwalifNetworking swalifNetworking;

  SwalifRepository(this.swalifNetworking);

  SwalifPostModel convertToModel(Map<String, dynamic> jsonResponse) {
    return SwalifPostMapper.fromJson(jsonResponse);
  }

  CommentModel convertToCommentModel(Map<String, dynamic> jsonResponse) {
    return CommentMapper.fromJson(jsonResponse);
  }

  List<CommentModel> convertToListCommentModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => CommentMapper.fromJson(e)).toList();
  }

  List<SwalifPostModel> convertToListModel(
      List<Map<String, dynamic>> jsonResponse) {
    return jsonResponse.map((e) => SwalifPostMapper.fromJson(e)).toList();
  }

  @override
  Future<SwalifPostModel> addSwalifPost(SwalifPostModel model) async {
    final response =
        await swalifNetworking.addSwalifPost(SwalifPostMapper.toJson(model));

    final jsonResponse = Utils.convertToJson(response);
    final swalifPost = convertToModel(jsonResponse);
    return swalifPost;
  }

  @override
  Future<List<SwalifPostModel>> getMyPosts() async {
    return await getPostsByTypes('my_posts');
  }

  @override
  Future<List<SwalifPostModel>> getAllPosts() async {
    return await getPostsByTypes('all');
  }

  @override
  Future<List<SwalifPostModel>> getPostsByTypes(String postType) async {
    final response = await swalifNetworking.getAllSwalifPosts(postType);
    final jsonResponse = Utils.convertToListJson(response);
    final posts = convertToListModel(jsonResponse);
    return posts;
  }

  @override
  Future<SwalifPostModel> showSwalifPost(int postId) async {
    final response = await swalifNetworking.showSwalifPost(postId);
    final jsonResponse = Utils.convertToJson(response);
    final post = convertToModel(jsonResponse);
    return post;
  }

  @override
  Future<void> deleteSwalifPost(int postId) async {
    await swalifNetworking.deleteSwalifPost(postId);
  }

  @override
  Future<SwalifPostModel> updateSwalifPost(
      SwalifPostModel model, int postId) async {
    try {
      final response = await swalifNetworking.updateSwalifPost(
          SwalifPostMapper.toJson(model), postId);
      final jsonResponse = Utils.convertToJson(response);
      final post = SwalifPostMapper.fromJson(jsonResponse);
      return post;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likePost(int postId) async {
    await swalifNetworking.likeSwalifPost(postId);
  }

  @override
  Future<void> dislikePost(int postId) async {
    await swalifNetworking.disLikeSwalifPost(postId);
  }

  @override
  Future<void> likeComment(int commentId) async {
    await swalifNetworking.likeComment(commentId);
  }

  @override
  Future<void> dislikeComment(int commentId) async {
    await swalifNetworking.disLikeComment(commentId);
  }

  @override
  Future<List<CommentModel>> getAllCommentsOnParticularPost(int postId) async {
    final response =
        await swalifNetworking.getAllCommentsOnParticularPost(postId);
    final jsonResponse = Utils.convertToListJson(response);
    final comments = convertToListCommentModel(jsonResponse);
    return comments;
  }

  @override
  Future<CommentModel> createComment(CommentModel model, int postId) async {
    final response = await swalifNetworking.createComment(
        CommentMapper.toJson(model), postId);

    final jsonResponse = Utils.convertToJson(response);
    final comment = convertToCommentModel(jsonResponse);
    return comment;
  }

  @override
  Future<CommentModel> updateComment(
      CommentModel model, int postId, int commentId) async {
    try {
      final response = await swalifNetworking.updateComment(
          CommentMapper.toJson(model), postId, commentId);
      final jsonResponse = Utils.convertToJson(response);
      final comment = CommentMapper.fromJson(jsonResponse);
      return comment;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(int postId, int commentId) async {
    await swalifNetworking.deleteComment(postId, commentId);
  }
}
