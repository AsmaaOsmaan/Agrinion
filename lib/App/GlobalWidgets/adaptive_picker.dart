import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../Resources/color_manager.dart';
import '../Resources/text_themes.dart';

class AdaptivePicker {
  static datePicker(
      {required BuildContext context,
      required Function(DateTime? date) onConfirm,
      required String title,
      DateTime? initial,
      DateTime? minDate}) async {
    if (Platform.isIOS) {
      _iosDatePicker(context, onConfirm, title,
          initial: initial, minDate: minDate);
    } else {
      _androidDatePicker(context, onConfirm,
          initial: initial, minDate: minDate);
    }
  }

  static _androidDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm,
      {DateTime? initial, DateTime? minDate}) {
    DatePicker.showDatePicker(context,
        currentTime: initial ?? DateTime.now(),
        locale: context.locale != const Locale('ar')
            ? LocaleType.ar
            : LocaleType.en,
        minTime: minDate ?? DateTime.now().add(const Duration(days: -1)),
        maxTime: DateTime(2050),
        theme: const DatePickerTheme(
          headerColor: ColorManager.primary,
          backgroundColor: Colors.white,
          doneStyle: TextStyle(color: Colors.white)
        )).then(onConfirm);
  }

  static _iosDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm, String title,
      {DateTime? initial, DateTime? minDate}) {
    _bottomSheet(
      context: context,
      child: cupertinoDatePicker(context, onConfirm, title,
          initial: initial, minDate: minDate),
    );
  }

  static Widget cupertinoDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm, String title,
      {DateTime? initial, DateTime? minDate}) {
    DateTime _date = DateTime.now();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getRegularStyle(),
              ),
              SizedBox(
                height: 20,
                child: ElevatedButton(
                  onPressed: () {
                    onConfirm(_date);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Done",
                    style: getMediumStyle(),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: CupertinoDatePicker(
            initialDateTime: initial ?? DateTime.now(),
            onDateTimeChanged: (date) {
              _date = date;
            },
            minimumDate:
                minDate ?? DateTime.now().add(const Duration(days: -1)),
            mode: CupertinoDatePickerMode.date,
          ),
        ),
      ],
    );
  }

  static timePicker(
      {required BuildContext context,
      required String title,
      required Function(DateTime? date) onConfirm}) async {
    if (Platform.isIOS) {
      _iosTimePicker(context, title, onConfirm);
    } else {
      _androidTimePicker(context, onConfirm);
    }
  }

  static _androidTimePicker(
      BuildContext context, Function(DateTime date) onConfirm) {
    var now = DateTime.now();
    DatePicker.showDatePicker(
      context,
      minTime: DateTime.now(),
    ).then((time) => onConfirm(
        DateTime(now.year, now.month, now.day, time!.hour, time.minute)));
  }

  static _iosTimePicker(
      BuildContext context, String title, Function(DateTime? date) onConfirm) {
    _bottomSheet(
      context: context,
      child: cupertinoTimePicker(context, title, onConfirm),
    );
  }

  static Widget cupertinoTimePicker(
      BuildContext context, String title, Function(DateTime? date) onConfirm) {
    DateTime _date = DateTime.now();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getRegularStyle(),
              ),
              SizedBox(
                height: 20,
                child: ElevatedButton(
                  onPressed: () {
                    onConfirm(_date);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Done",
                    style: getMediumStyle(),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0, primary: Colors.white),
                ),
              )
            ],
          ),
        ),
        SizedBox(
            height: 280,
            child: CupertinoDatePicker(
              onDateTimeChanged: (date) {
                _date = date;
              },
              mode: CupertinoDatePickerMode.time,
            )),
      ],
    );
  }

  static _bottomSheet({required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SizedBox(
        height: 320,
        child: child,
      ),
    );
  }
}
