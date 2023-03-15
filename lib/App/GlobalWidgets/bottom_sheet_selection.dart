import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/translations.g.dart';

class SelectionBottomSheet<T> extends StatelessWidget {
  const SelectionBottomSheet({
    Key? key,
    required this.itemAsString,
    required this.selectedItem,
    required this.onChange,
    required this.items,
    this.hintText,
    this.onClearFn,
    this.searchHintText,
    this.validator,
    this.filled = false,
    this.fillColor,
  }) : super(key: key);
  final String Function(T)? itemAsString;
  final T? selectedItem;
  final void Function(T?)? onChange;
  final List<T> items;
  final String? hintText;
  final Function()? onClearFn;
  final String? searchHintText;
  final String? Function(T?)? validator;
  final bool? filled;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          fillColor: fillColor,
          filled: filled,
        ),
      ),
      compareFn: (i, s) => i == s,
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      onChanged: onChange,
      popupProps: PopupProps.modalBottomSheet(
        isFilterOnline: true,
        showSelectedItems: true,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: searchHintText ?? tr(LocaleKeys.search),
          ),
        ),
        emptyBuilder: (co, t) => Center(
            child: Text(
          tr(LocaleKeys.no_data_found),
        )),
      ),
      items: items,
      validator: validator,
      clearButtonProps: ClearButtonProps(
        onPressed: onClearFn,
        isVisible: true,
      ),
    );
  }
}
