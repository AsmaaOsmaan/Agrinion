import 'dart:io';

import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final String? bodyAr;
  final String? bodyEn;
  final bool? published;
  final File? image;
  final String? newImage;
  final String? createdAt;

  const NewsModel({
    this.id,
    this.titleAr,
    this.titleEn,
    this.bodyAr,
    this.bodyEn,
    this.published,
    this.image,
    this.newImage,
    this.createdAt,
  });
  @override
  List<Object?> get props => [id, titleAr, titleEn, bodyAr, bodyEn, newImage];
}
