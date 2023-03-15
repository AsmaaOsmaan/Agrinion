import 'package:agriunion/Features/Orders/Domain/Entities/create_order_model.dart';

class CommentModel {
  int? commentId;
  Creator? creator;
  String? content;
  bool? liked;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  int? commentsCount;
  CommentModel(
      {this.content,
      this.commentId,
      this.creator,
      this.createdAt,
      this.updatedAt,
      this.liked,
      this.likesCount,
      this.commentsCount});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModel &&
          runtimeType == other.runtimeType &&
          commentId == other.commentId &&
          content == other.content &&
          liked == other.liked &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount;

  @override
  int get hashCode => commentId.hashCode;
}
