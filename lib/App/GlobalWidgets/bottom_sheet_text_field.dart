import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:agriunion/App/Resources/text_themes.dart';
import 'package:flutter/material.dart';

import 'modal_helper.dart';

class BottomSheetTextField<T> extends StatelessWidget {
  const BottomSheetTextField({
    Key? key,
    required TextEditingController controller,
    required this.data,
    this.validator,
    this.hint,
    this.onTap,
    this.onItemSelected,
    this.itemAsString,
    this.enabled = true,
    this.value = "",
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final List<T> data;
  final String? hint;
  final Function? onTap;
  final bool? enabled;
  final Function(T value)? onItemSelected;
  final String? value;
  final String? Function(String?)? validator;
  final String Function(T?)? itemAsString;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      keyboardType: TextInputType.number,
      controller: _controller,
      readOnly: true,
      style: getBoldStyle(),
      onTap: () async {
        await onTap!();

        _controller.text =
            await ModalHelper(context, data, itemAsString).showAppModal();

        _controller.text == ""
            ? _controller.text = value!
            : _controller.text = _controller.text;
        // onItemSelected!(_controller.text);
      },
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
        fillColor: ColorManager.white,
        filled: true,
      ),
    );
  }
}
