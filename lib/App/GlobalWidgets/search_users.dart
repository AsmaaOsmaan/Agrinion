// import 'package:agriunion/Features/Ads/Presentation/view_logic/ad_vl.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Resources/text_themes.dart';

// class SearchForUsers extends StatefulWidget {
//   const SearchForUsers({
//     Key? key,
//     required this.onTap,
//   }) : super(key: key);
//   final Function(String value) onTap;
//   @override
//   State<SearchForUsers> createState() => _SearchForUsersState();
// }

// class _SearchForUsersState extends State<SearchForUsers> {
//   @override
//   void initState() {
//     context.read<AdProvider>().getUsers();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AdProvider>(builder: (context, ad, child) {
//       return Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 style: getRegularStyle(),
//                 decoration: const InputDecoration(hintText: "إبحث عن المستخدم"),
//                 onChanged: (value) => ad.searchInUsers(value),
//               ),
//               ...List.generate(
//                   ad.searchUsers.length,
//                   (index) => GestureDetector(
//                         onTap: () {
//                           widget.onTap(ad.searchUsers[index].userName);
//                           Navigator.pop(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 ad.searchUsers[index].userName,
//                                 style: getRegularStyle(fontSize: 14),
//                               ),
//                               const Divider(thickness: 1.2),
//                             ],
//                           ),
//                         ),
//                       )),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
