import 'dart:io';

import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/translations.g.dart';
import '../GlobalWidgets/adaptive_picker.dart';
import '../GlobalWidgets/loading_dialog.dart';

class Utils {
  static void launchURL({required String url}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://" + url;
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      LoadingDialog.showSimpleToast("من فضلك تآكد من الرابط");
    }
  }

  static String getDate({DateTime? time}) {
    if (time == null) {
      return DateTime.now().toString().split(" ").first;
    } else {
      return time.toString().split(" ").first;
    }
  }

  static void launchWhatsApp(phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    var _whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
    if (await canLaunchUrl(Uri.parse(_whatsAppUrl))) {
      await launchUrl(Uri.parse(_whatsAppUrl));
    } else {
      throw 'حدث خطأ ما';
    }
  }

  static void launchYoutube({required String url}) async {
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static void callPhone({phone}) async {
    await launchUrl(Uri.parse("tel:$phone"));
  }

  static void sendMail(mail) async {
    await launchUrl(Uri.parse("mailto:$mail"));
  }

  static Future<File?> getImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.media);

    if (result != null) {
      List<File> files = result.paths.map((path) => File("$path")).toList();
      return files.first;
    } else {
      return null;
    }
  }

  static Future<List<File>> getImages() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);

    if (result != null) {
      List<File> files = result.paths.map((path) => File("$path")).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File?> getVideo() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.video);

    if (result != null) {
      List<File> files = result.paths.map((path) => File("$path")).toList();
      return files.first;
    } else {
      return null;
    }
  }

  static void copToClipboard(
      {required String text, required GlobalKey<ScaffoldState> scaffold}) {
    if (text.trim().isEmpty) {
      LoadingDialog.showSimpleToast("لا يوجد بيانات للنسخ");
      return;
    } else {
      Clipboard.setData(ClipboardData(text: text)).then((value) {
        LoadingDialog.showSimpleToast("تم النسخ بنجاح");
      });
    }
  }

  static String convertDigitsToLatin(String s) {
    var sb = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        //Arabic digits
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }

  static String dateformatedHeader(DateTime theDate) {
    DateTime date = DateTime.parse(theDate.toString());
    var f = DateFormat("MMM d, yyyy");
    return f.format(date.toLocal());
  }

  static String priceFormat(String price) {
    return NumberFormat("#,##0", "en_US").format(double.parse(price));
  }

  static String dateFormat(String date) {
    return DateFormat('MMM d, y').format(DateTime.parse(date).toLocal());
  }

  static String slashFormat(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String dashFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat('hh:mm a').format(DateTime.now());
  }

  static String capitalizeFirstChar(String? txt) {
    return txt != null ? txt.replaceFirst(txt[0], txt[0].toUpperCase()) : "";
  }

  static String substring(String text) {
    return text.substring(0, text.length - 1);
  }

  static List<Map<String, dynamic>> convertToListJson(response) {
    return List<Map<String, dynamic>>.from(response);
  }

  static Map<String, dynamic> convertToJson(response) {
    return Map<String, dynamic>.from(response);
  }

  static String singularizingTheString(String string) {
    if (string.endsWith('s')) {
      return substring(string);
    } else {
      return string;
    }
  }

  static String calculateTheTime(String createdAt) {
    var duration = DateTime.parse(createdAt);
    Duration diff = DateTime.now().difference(duration);

    if (diff.inSeconds < 60) {
      return "${tr(LocaleKeys.ago)} ${tr('fewSeconds')}";
    }
    if (diff.inMinutes < 60) {
      return "${tr(LocaleKeys.ago)} ${diff.inMinutes.toString()} ${tr(LocaleKeys.minute_ago)}";
    }
    if (diff.inHours < 24) {
      return "${tr(LocaleKeys.ago)} ${diff.inHours.toString()} ${tr(LocaleKeys.hours_ago)}";
    }
    return "${tr(LocaleKeys.ago)} ${diff.inDays.toString()} ${tr("day")}";
  }

  static Color getColorBasedOnStatus(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return ColorManager.black;
    }
  }

  static void pickDate(
      BuildContext context, String title, TextEditingController co) {
    AdaptivePicker.datePicker(
      context: context,
      onConfirm: (value) {
        co.text = dashFormat(value!);
      },
      title: title,
      initial: DateTime.now(),
      minDate: DateTime(2016),
    );
  }
}
