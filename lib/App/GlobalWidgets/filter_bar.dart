import 'package:flutter/material.dart';

import '../Resources/text_themes.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    Key? key,
    this.trailing,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final Widget? trailing;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: getRegularStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.search),
            trailing == null
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 35,
                    color: Colors.black,
                  ),
          ],
        ),
      ),
    );
  }
}
