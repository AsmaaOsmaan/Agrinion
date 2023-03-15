import 'package:flutter/material.dart';

import '../../../../App/Utilities/app_route.dart';
import '../Screens/store_screen.dart';
import 'store_item.dart';

class StoreListItem extends StatelessWidget {
  const StoreListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute().navigate(
        context: context,
        route: const StoreScreen(),
      ),
      child: const StoreItem(),
    );
  }
}
