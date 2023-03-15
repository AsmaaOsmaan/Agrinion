import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalHelper<T> {
  BuildContext context;
  final List<T> data;
  String Function(T?)? itemAsString;
  ModalHelper(this.context, this.data, this.itemAsString);
  Future<String> showAppModal() async {
    String result = "";
    await showBarModalBottomSheet<T>(
      isDismissible: false,
      context: context,
      expand: false,
      bounce: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: AppCloseButton(),
              ),
              ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        result = itemAsString!(data[index]);
                        Navigator.of(context).pop();
                      },

                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemAsString!(data[index]),
                              style: getRegularStyle(fontSize: 14),
                            ),
                            //const Divider(thickness: 1.2),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );

    return Future.value(result);
  }
}

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: ColorManager.lightGrey,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close)),
    );
  }
}
