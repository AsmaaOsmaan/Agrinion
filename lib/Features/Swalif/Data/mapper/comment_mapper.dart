import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';

import '../../../Orders/Data/Mappers/create_order_mapper.dart';

class CommentMapper {
  static CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel(
        commentId: json['id'],
        content: json['body'],
        creator: json['creator'] != null
            ? CreatorMapper.fromJson(json['creator'])
            : null,
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        liked: json['liked?'],
        likesCount: json['likes_count'],
        commentsCount: json['comments_count']);
  }

  static Map<String, dynamic> toJson(CommentModel commentModel) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = commentModel.content;

    return {"comment": data};
  }
}
