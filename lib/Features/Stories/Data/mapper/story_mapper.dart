import 'package:agriunion/App/Errors/exceptions.dart';
import 'package:agriunion/App/Network/network_helper.dart';
import 'package:agriunion/Features/Stories/Domain/Entites/story_model.dart';

import '../../../../App/Resources/color_manager.dart';

class StoryMapper {
  static StoryModel fromJson(Map<String, dynamic> json) {
    try {
      return StoryModel(
        storyId: json['id'],
        userId: json['user_id'],
        article: json['article'],
        storyType: json['story_type'],
        status: json['status'],
        multimedia: json['multimedia'] != null
            ? NetworkHelper.apiBaseUrl! + json['multimedia']
            : null,
        textContent: json['text_content'],
        textBackgroundColor: json['text_background_color'].toString().toColor(),
      );
    } catch (e) {
      throw UnSupportedJsonFormat(e.toString());
    }
  }

  static Map<String, dynamic> toJson(StoryModel storyModel) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text_content'] = storyModel.textContent;
    data['multimedia'] = storyModel.multimediaFile;
    data['story_type'] = storyModel.storyType;
    data['text_background_color'] = storyModel.textBackgroundColor?.toHex();

    return {"story": data};
  }
}
