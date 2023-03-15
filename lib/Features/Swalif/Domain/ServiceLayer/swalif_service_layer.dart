import 'package:agriunion/Features/Swalif/Data/Repositories/swalif_repo.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';

abstract class ISwalifServiceLayer {
  Future<SwalifPostModel> addSwalifPostModel(SwalifPostModel swalifPostModel);
  Future<List<SwalifPostModel>> getAllSwalifPosts();
  Future<List<SwalifPostModel>> getMySwalifPosts();
  Future<SwalifPostModel> showSwalifPost(int postId);
  Future<void> deleteSwalifPost(int postId);
  Future<void> likePost(int postId);
  Future<void> dislikePost(int postId);
  Future<void> likeComment(int commentId);
  Future<void> dislikeComment(int commentId);
  Future<SwalifPostModel> updateSwalifPost(SwalifPostModel model, int postId);
  Future<List<CommentModel>> getAllCommentsOnParticularPost(int postId);
  Future<CommentModel> createComment(CommentModel commentModel, int postId);
  Future<void> deleteComment(int postId, int commentId);
  Future<CommentModel> updateComment(
      CommentModel model, int postId, int commentId);
}

class SwalifServiceLayer implements ISwalifServiceLayer {
  ISwalifRepository swalifRepo;

  SwalifServiceLayer(this.swalifRepo);

  @override
  Future<SwalifPostModel> addSwalifPostModel(
      SwalifPostModel swalifPostModel) async {
    return await swalifRepo.addSwalifPost(swalifPostModel);
  }

  @override
  Future<List<SwalifPostModel>> getAllSwalifPosts() async {
    return await swalifRepo.getAllPosts();
  }

  @override
  Future<List<SwalifPostModel>> getMySwalifPosts() async {
    return await swalifRepo.getMyPosts();
  }

  @override
  Future<SwalifPostModel> showSwalifPost(int postId) async {
    return await swalifRepo.showSwalifPost(postId);
  }

  @override
  Future<void> deleteSwalifPost(int postId) async {
    await swalifRepo.deleteSwalifPost(postId);
  }

  @override
  Future<SwalifPostModel> updateSwalifPost(
      SwalifPostModel model, int postId) async {
    return await swalifRepo.updateSwalifPost(model, postId);
  }

  @override
  Future<void> likePost(int postId) async {
    await swalifRepo.likePost(postId);
  }

  @override
  Future<void> dislikePost(int postId) async {
    await swalifRepo.dislikePost(postId);
  }

  @override
  Future<void> likeComment(int commentId) async {
    return await swalifRepo.likeComment(commentId);
  }

  @override
  Future<void> dislikeComment(int commentId) async {
    await swalifRepo.dislikeComment(commentId);
  }

  @override
  Future<List<CommentModel>> getAllCommentsOnParticularPost(int postId) async {
    return await swalifRepo.getAllCommentsOnParticularPost(postId);
  }

  @override
  Future<CommentModel> createComment(
      CommentModel commentModel, int postId) async {
    return await swalifRepo.createComment(commentModel, postId);
  }

  @override
  Future<void> deleteComment(int postId, int commentId) async {
    await swalifRepo.deleteComment(postId, commentId);
  }

  @override
  Future<CommentModel> updateComment(
      CommentModel model, int postId, int commentId) async {
    return await swalifRepo.updateComment(model, postId, commentId);
  }
}
