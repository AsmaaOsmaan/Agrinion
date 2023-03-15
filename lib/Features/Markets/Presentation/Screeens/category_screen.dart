import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
import 'package:agriunion/Features/Markets/Presentation/Widgets/search_bar.dart';
import 'package:agriunion/Features/SystemManagement/SubFeatures/CategoriesManagement/Categories/Domain/Entities/categories_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/flex_grid.dart';
import '../Widgets/sub_category_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  final Categories category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    context.read<AdsVL>().getSubCategories(widget.category);
    context.read<AdsVL>().getAdsByCategory(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdsVL>(builder: (context, vl, child) {
      return Scaffold(
          appBar: AppBar(title: Text(widget.category.name)),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SearchBar(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                ),
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vl.subCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SubCategoryWidget(
                        category: vl.subCategories[index],
                        index: index,
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: FlexGrid(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    category: widget.category,
                  ),
                )
              ],
            ),
          ));
    });
  }
}

class Mo3lnenList extends StatelessWidget {
  const Mo3lnenList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          title: Text(
            "اسم المستخدم",
            style: getBoldStyle(),
          ),
          subtitle: Text(
            "الرياض, المملكة العربية السعودية",
            style: getRegularStyle(fontSize: 12),
          ),
          trailing: ElevatedButton(
              onPressed: () => print,
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey,
              )),
              child: const Text("متابعة")),
        );
      },
    );
  }
}
