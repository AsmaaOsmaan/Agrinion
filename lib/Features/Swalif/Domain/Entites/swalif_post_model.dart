import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';

class SwalifPostModel {
  Creator? creator;
  String? content;
  int? postId;
  String? createdAt;
  String? updatedAt;
  bool? liked;
  int? likesCount;
  int? commentsCount;

  List<CommentModel>? comment;
  SwalifPostModel(
      {this.postId,
      this.comment,
      this.content,
      this.creator,
      this.createdAt,
      this.updatedAt,
      this.liked,
      this.likesCount,
      this.commentsCount});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SwalifPostModel &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          content == other.content &&
          liked == other.liked &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount;

  @override
  int get hashCode => postId.hashCode;
}
