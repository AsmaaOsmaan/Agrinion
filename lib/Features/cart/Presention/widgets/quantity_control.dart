import 'package:flutter/material.dart';

import '../../../../App/Resources/color_manager.dart';

class ControlAmountButtons extends StatelessWidget {
  const ControlAmountButtons._({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  const ControlAmountButtons.minus({
    Key? key,
    required Function onTap,
  }) : this._(
          icon: Icons.remove,
          onTap: onTap,
          key: key,
        );
  const ControlAmountButtons.plus({
    Key? key,
    required Function onTap,
  }) : this._(
          icon: Icons.add,
          onTap: onTap,
          key: key,
        );
  const ControlAmountButtons.delete({
    Key? key,
    required Function onTap,
  }) : this._(
          icon: Icons.delete,
          onTap: onTap,
          key: key,
        );

  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: icon == Icons.add
              ? ColorManager.black
              : icon == Icons.delete
                  ? ColorManager.error
                  : ColorManager.grey,
        ),
        child: Center(
          child: Icon(icon, color: ColorManager.lightGrey, size: 15),
        ),
      ),
    );
  }
}
