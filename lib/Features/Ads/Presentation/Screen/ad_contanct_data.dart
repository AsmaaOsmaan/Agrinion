import 'package:flutter/material.dart';

import '../../../../App/Resources/text_themes.dart';
import '../../Domain/Models/ad_model.dart';

class AdContactData extends StatelessWidget {
  const AdContactData({Key? key, required this.ad}) : super(key: key);
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ad.product.nameAr,
              style: getBoldStyle(),
            ),
          ],
        ),
      ],
    );
  }
}
