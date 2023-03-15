// import 'package:agriunion/App/GlobalWidgets/bottom_sheet_helper.dart';
// import 'package:agriunion/App/GlobalWidgets/favorite_icon.dart';
// import 'package:agriunion/App/Resources/assets_manager.dart';
// import 'package:agriunion/App/Resources/color_manager.dart';
// import 'package:agriunion/App/Resources/text_themes.dart';
// import 'package:agriunion/App/Utilities/size_config.dart';
// import 'package:agriunion/App/constants/values.dart';
// import 'package:agriunion/Features/Offers/Presentation/Widgets/make_offers.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import '../../Domain/Models/ad_model.dart';
// import 'ad_contanct_data.dart';
// import 'ad_data.dart';

// class AdScreen extends StatelessWidget {
//   const AdScreen({
//     Key? key,
//     required this.ad,
//   }) : super(key: key);
//   final AdModel ad;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("تفاصيل المنتج"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     width: SizeConfig.screenWidth,
//                     height: SizeConfig.screenHeight! * .25,
//                     decoration: BoxDecoration(borderRadius: radius20),
//                     child: Image.network(ad.image!, fit: BoxFit.cover),
//                   ),
//                   Positioned(
//                     top: 0,
//                     child: Container(
//                       width: SizeConfig.screenWidth! * .85,
//                       height: SizeConfig.screenHeight! * .25,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.black.withOpacity(.7),
//                             Colors.transparent,
//                           ],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           stops: const [.0, .2],
//                         ),
//                         borderRadius: radius20,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(AppIcons.location, height: 18),
//                               Text(
//                                 "الرياض | سوق الرياض",
//                                 style: getRegularStyle(
//                                     fontColor: Colors.white, fontSize: 13),
//                               ),
//                               const Spacer(),
//                               CircleAvatar(
//                                 child: Image.asset(
//                                   AppIcons.linking,
//                                   color: ColorManager.black,
//                                   height: 25,
//                                 ),
//                                 backgroundColor: Colors.white70,
//                               ),
//                               const SizedBox(width: 10),
//                               const FavoriteIcon(size: 25),
//                             ],
//                           ),
//                           ElevatedButton.icon(
//                             onPressed: () {},
//                             icon: const Text("إبلاغ"),
//                             label: Image.asset(
//                               AppIcons.exclamationMark,
//                               height: 20,
//                             ),
//                             style: ElevatedButton.styleFrom(
//                                 primary: Colors.black54),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       top: SizeConfig.screenHeight! * .215,
//                       right: 20,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.grey.shade300,
//                         radius: 27,
//                         child: const Icon(
//                           Icons.person,
//                           color: ColorManager.black,
//                           size: 27,
//                         ),
//                       ))
//                 ],
//               ),
//               const SizedBox(height: 40),
//               AdContactData(ad: ad),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: const [
//                           Text("رقم السيارة"),
//                           SizedBox(width: 10),
//                           Text('15'),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   // const CircleAvatar(child: Icon(Icons.phone_rounded)),
//                   const SizedBox(width: 10),
//                   // const CircleAvatar(
//                   //   child: Icon(
//                   //     Icons.whatsapp_outlined,
//                   //     color: Colors.white,
//                   //   ),
//                   //   backgroundColor: Colors.green,
//                   // ),
//                 ],
//               ),
//               SizedBox(height: SizeConfig.screenHeight! * .01),
//               AdData(ad: ad),
//               ElevatedButton(
//                 onPressed: () => BottomSheetHelper(
//                   context: context,
//                   content: MakeOfferforAd(ad: ad),
//                 ).openFullSheet(),
//                 child: Text(
//                   tr("buy"),
//                   style: getBoldStyle(fontColor: Colors.white, size: 14),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
