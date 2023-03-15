import 'package:agriunion/App/Resources/assets_manager.dart';
import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:flutter/material.dart';

class OnBoardingModel {
  final String icon;
  final String title;
  final String subtitle;
  final Color color;

  OnBoardingModel(this.icon, this.title, this.subtitle, this.color);
}

List<OnBoardingModel> onBoardingScreens = [
  OnBoardingModel(
    AppIcons.wholesale,
    "أسواق الجملة",
    "نحن أول منصة إلكترونية في مجال التسويق الزراعي,\n نلبي جميع احتياجات تجار الجملة والتجزئة والأسواق \n الزراعية بجميع انحاء المملكة",
    ColorManager.primary,
  ),
  OnBoardingModel(
    AppIcons.retialManagement,
    "الفاتورة الإلكترونية",
    "اصدر فاتورتك بإدارة أعمالك بكل دقة وسهولة, مع مخزونك الإلكتروني",
    ColorManager.lightPrimary,
  ),
  OnBoardingModel(
    AppIcons.pricesList,
    "قائمة الأسعار",
    "يمكن مشاهدة قائمة الأسعار اليومية من خلال البحث عن المدينة والسوق والمنتج",
    ColorManager.green,
  ),
  OnBoardingModel(
    AppIcons.swaleef,
    "سواليف",
    "خدمة تساعدك في التواصل مع الآخرين و الاستفادة من خبرات وعرض المنتجاب والمزيد",
    ColorManager.secondary,
  ),
  OnBoardingModel(
    AppIcons.stories,
    "قصص",
    "يمكن عرض منتجاتك من خلال القصص بكل سهولة والتسويق لها والمزيد",
    ColorManager.yellow,
  ),
];
