import 'dart:io';

import 'package:flutter/material.dart';

class StoryModel {
  int? userId;
  int? storyId;
  String? status;
  String? storyType;
  String? article;
  String? textContent;
  File? multimediaFile;
  String? multimedia;
  Color? textBackgroundColor;

  StoryModel(
      {this.userId,
      this.multimediaFile,
      this.status,
      this.storyId,
      this.article,
      this.storyType,
      this.textContent,
      this.multimedia,
      this.textBackgroundColor});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryModel &&
          runtimeType == other.runtimeType &&
          storyId == other.storyId &&
          userId == other.userId &&
          status == other.status &&
          storyType == other.storyType &&
          textContent == other.textContent;

  @override
  int get hashCode => storyId.hashCode;
}
