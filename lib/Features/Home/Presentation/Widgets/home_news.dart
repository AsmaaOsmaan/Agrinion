part of 'home_imports.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  void initState() {
    context.read<NewsVL>().homeListAllNews();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsVL>(builder: (context, newsVL, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("news"),
                style: getBoldStyle(size: 18),
              ),
              TextButton(
                onPressed: () {
                  AppRoute().navigate(
                      context: context, route: const UserListNewsScreen());
                },
                child: Text(
                  tr("show_more"),
                  style: getMediumStyle(fontSize: 14, fontColor: Colors.blue),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                  newsVL.newsList.take(3).length,
                  ((index) => NewsContainer(
                        model: newsVL.newsList[index],
                      ))),
            ),
          ),
        ],
      );
    });
  }
}
