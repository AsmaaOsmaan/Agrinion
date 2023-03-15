import 'package:flutter/material.dart';

import '../../../App/Resources/color_manager.dart';

class SystemManagementTile extends StatelessWidget {
  const SystemManagementTile({
    Key? key,
    required this.ontap,
    required this.title,
  }) : super(key: key);
 final  Function ontap;
 final  String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:()=>ontap()
      ,
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
        color: ColorManager.black,
      ),
    );
  }
}
