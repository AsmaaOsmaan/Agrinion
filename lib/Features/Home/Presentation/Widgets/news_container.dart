part of 'home_imports.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({
    required this.model,
    Key? key,
  }) : super(key: key);

  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute()
          .navigate(context: context, route: UserViewSpecificNewsScreen(model)),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.only(left: 10, bottom: 20),
        width: SizeConfig.screenWidth! * .8,
        height: SizeConfig.screenHeight! * .15,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1.2,
              color: Colors.grey.shade400,
            ),
            borderRadius: radius20),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                model.newImage!,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(Utils.dateFormat(model.createdAt!)),
                        SizedBox(
                          width: SizeConfig.screenHeight! * 0.015,
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                    Text(
                      model.titleAr!,
                      style: getBoldStyle(size: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.bodyAr!,
                      style: getMediumStyle(fontSize: 12),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
