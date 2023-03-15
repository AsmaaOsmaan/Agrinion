import 'package:agriunion/Features/Swalif/Data/mapper/comment_mapper.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/comment_model.dart';
import 'package:agriunion/Features/Swalif/Domain/Entites/swalif_post_model.dart';

import '../../../../App/Errors/exceptions.dart';
import '../../../Orders/Data/Mappers/create_order_mapper.dart';

class SwalifPostMapper {
  static SwalifPostModel fromJson(Map<String, dynamic> json) {
    List<CommentModel> comments = [];
    if (json['comments'] != null) {
      json['comments'].forEach((v) {
        comments.add(CommentMapper.fromJson(v));
      });
    }

    try {
      return SwalifPostModel(
          postId: json['id'],
          content: json['body'],
          creator: json['creator'] != null
              ? CreatorMapper.fromJson(json['creator'])
              : null,
          comment: comments,
          createdAt: json['created_at'],
          updatedAt: json['updated_at'],
          liked: json['liked?'],
          likesCount: json['likes_count'],
          commentsCount: json['comments_count']);
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(SwalifPostModel swalifPostModel) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = swalifPostModel.content;

    return {"post": data};
  }
}
