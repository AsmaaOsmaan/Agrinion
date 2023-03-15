import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../App/Utilities/size_config.dart';

class NewsImage extends StatelessWidget {
  const NewsImage._({
    Key? key,
    this.imageFile,
    required this.isFile,
    this.imageUrl,
  }) : super(key: key);

  const NewsImage.file({
    Key? key,
    required File image,
  }) : this._(imageFile: image, isFile: true, key: key);

  const NewsImage.url({
    Key? key,
    required String image,
  }) : this._(imageUrl: image, isFile: false, key: key);

  final File? imageFile;
  final bool isFile;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return isFile
        ? Image.file(
            imageFile!,
            fit: BoxFit.cover,
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight! * .11,
          )
        : Image.network(
            imageUrl!,
            fit: BoxFit.cover,
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight! * .11,
          );
  }
}
