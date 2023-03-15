import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';
import '../../../../App/Resources/text_themes.dart';
import '../../../../App/Utilities/size_config.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key? key,
    required this.photo,
    required this.date,
    required this.title,
    required this.topic,
    required this.id,
  }) : super(key: key);

  final String photo;
  final String date;
  final String title;
  final String topic;
  final int id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => AppRoute()
      //     .navigate(context: context, route: SingleNewScreen(index: id)),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: SizeConfig.screenHeight! * .35,
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Hero(
                tag: "$id",
                child: Image.asset(photo, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: getBoldStyle(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(date),
                            const SizedBox(width: 5),
                            const Icon(Icons.calendar_month_rounded),
                          ],
                        )
                      ],
                    ),
                    Text(
                      topic,
                      style: getMediumStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
