import 'package:agriunion/App/GlobalWidgets/loading_dialog.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';
import 'package:agriunion/Features/Swalif/Domain/ServiceLayer/swalif_service_layer.dart';
import 'package:agriunion/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SwalifVL extends ChangeNotifier {
  final ISwalifServiceLayer swalifServiceLayer;
  SwalifVL(this.swalifServiceLayer);
  List<SwalifPostModel> posts = [];
  List<CommentModel> comments = [];
  SwalifPostModel? postModel;
  bool loading = false;
  bool inShowPost = false;

  addSwalifPost(SwalifPostModel swalifPostModel, BuildContext context) async {
    try {
      LoadingDialog.showLoadingDialog();
      SwalifPostModel post =
          await swalifServiceLayer.addSwalifPostModel(swalifPostModel);
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(tr(LocaleKeys.post_added_successfully));
      posts.add(post);
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
      EasyLoading.dismiss();
    }
  }

  updateSwalifPost(
      SwalifPostModel swalifPostModel, int postId, BuildContext context) async {
    try {
      LoadingDialog.showLoadingDialog();
      final post =
          await swalifServiceLayer.updateSwalifPost(swalifPostModel, postId);
      posts[posts.indexWhere((element) => element.postId == postId)] = post;
      postModel = post;
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(tr(LocaleKeys.post_updated_successfully));
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
      EasyLoading.dismiss();
    }
  }

  updateInShowPostVal(bool val) {
    inShowPost = val;
  }

  void getAllSwalifPosts() async {
    loading = true;
    posts = await swalifServiceLayer.getAllSwalifPosts();
    loading = false;
    notifyListeners();
  }

  void getMySwalifPosts() async {
    loading = true;
    posts = await swalifServiceLayer.getMySwalifPosts();
    loading = false;
    notifyListeners();
  }

  Future<void> showSwalifPost(int postId) async {
    loading = true;
    postModel = await swalifServiceLayer.showSwalifPost(postId);
    comments = postModel!.comment!;
    loading = false;
    notifyListeners();
  }

  deletePost(SwalifPostModel swalifPostModel) async {
    LoadingDialog.showLoadingDialog();
    await swalifServiceLayer.deleteSwalifPost(swalifPostModel.postId!);
    EasyLoading.dismiss();
  }

  deletePostWithNavigation(
      SwalifPostModel swalifPostModel, BuildContext context) {
    deletePost(
      swalifPostModel,
    );
    Navigator.pop(context);
  }

  deletePostWithoutNavigation(SwalifPostModel swalifPostModel, index) {
    deletePost(swalifPostModel);
    posts.removeAt(index);
    notifyListeners();
  }

  deletePostWithNavigationAndRemoveFromList(
      SwalifPostModel swalifPostModel, BuildContext context, int index) {
    deletePost(swalifPostModel);
    posts.removeAt(index);
    Navigator.pop(context);
    notifyListeners();
  }

  createComment(CommentModel commentModel, SwalifPostModel post) async {
    try {
      LoadingDialog.showLoadingDialog();
      CommentModel comment =
          await swalifServiceLayer.createComment(commentModel, post.postId!);
      comments.add(comment);
      int commentsCount =
          posts[posts.indexWhere((element) => element.postId == post.postId!)]
              .commentsCount!;
      LoadingDialog.showSimpleToast(tr(LocaleKeys.comment_added_successfully));
      posts[posts.indexWhere((element) => element.postId == post.postId!)]
          .commentsCount = commentsCount + 1;
      postModel = post;
      postModel!.commentsCount = commentsCount + 1;
      notifyListeners();
      EasyLoading.dismiss();
    } catch (e) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
      EasyLoading.dismiss();
    }
  }

  Future<void> likePost(int postId) async {
    await swalifServiceLayer.likePost(postId);
    notifyListeners();
  }

  Future<void> disLikePost(int postId) async {
    await swalifServiceLayer.dislikePost(postId);
    notifyListeners();
  }

  managePostLikes(int postId, bool liked) {
    if (liked == false) {
      manageLikePost(postId, liked);
    } else {
      manageDisLikePost(postId, liked);
    }

    notifyListeners();
  }

  Future<void> likeComment(int commentId) async {
    await swalifServiceLayer.likeComment(commentId);
    notifyListeners();
  }

  Future<void> disLikeComment(int commentId) async {
    await swalifServiceLayer.dislikeComment(commentId);
    notifyListeners();
  }

  manageCommentsLikes(int commentId, bool liked, int index) {
    if (liked == false) {
      likeComment(commentId);
      comments[index].likesCount = comments[index].likesCount! + 1;
    } else {
      disLikeComment(commentId);
      comments[index].likesCount = comments[index].likesCount! - 1;
    }
    comments[index].liked = !liked;
    notifyListeners();
  }

  void getAllCommentsOnParticularPost(int postId) async {
    loading = true;
    comments = await swalifServiceLayer.getAllCommentsOnParticularPost(postId);
    loading = false;
    notifyListeners();
  }

  deleteComment(CommentModel commentModel, int postId, int commentId) async {
    LoadingDialog.showLoadingDialog();
    await swalifServiceLayer.deleteComment(postId, commentId);
    comments.remove(commentModel);
    postModel!.commentsCount = postModel!.commentsCount! - 1;
    EasyLoading.dismiss();
    LoadingDialog.showSimpleToast(tr(LocaleKeys.comment_deleted_successfully));
    notifyListeners();
  }

  updateComment(CommentModel commentModel, int postId, BuildContext context,
      int index, int commentId) async {
    try {
      LoadingDialog.showLoadingDialog();
      final comment = await swalifServiceLayer.updateComment(
          commentModel, postId, commentId);
      comments[index] = comment;
      EasyLoading.dismiss();
      LoadingDialog.showSimpleToast(
          tr(LocaleKeys.comment_updated_successfully));
      notifyListeners();
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      LoadingDialog.showSimpleToast(tr(LocaleKeys.something_error));
      EasyLoading.dismiss();
    }
  }

  increaseCountLikesInPosts(int postId, bool liked) {
    posts[posts.indexWhere((element) => element.postId == postId)].likesCount =
        posts[posts.indexWhere((element) => element.postId == postId)]
                .likesCount! +
            1;
  }

  decreaseCountLikesInPosts(int postId, bool liked) {
    posts[posts.indexWhere((element) => element.postId == postId)].likesCount =
        posts[posts.indexWhere((element) => element.postId == postId)]
                .likesCount! -
            1;
  }

  manageLikePost(int postId, bool liked) {
    likePost(postId);
    posts[posts.indexWhere((element) => element.postId == postId)].liked =
        !liked;
    increaseCountLikesInPosts(postId, liked);
    if (inShowPost) {
      postModel!.likesCount = postModel!.likesCount! + 1;
      postModel!.liked = !liked;
    }
  }

  manageDisLikePost(int postId, bool liked) {
    disLikePost(postId);
    posts[posts.indexWhere((element) => element.postId == postId)].liked =
        !liked;
    decreaseCountLikesInPosts(postId, liked);
    if (inShowPost) {
      postModel!.likesCount = postModel!.likesCount! - 1;
      postModel!.liked = !liked;
    }
  }
}
