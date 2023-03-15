// import 'dart:math';

// import 'package:flutter/material.dart';

// import '../../../../App/Utilities/recorder.dart';

// class PlayViewCard extends StatefulWidget {
//   final VoiceRecordBloc voiceRecordBloc;
//   final void Function() onDeleteTap;
//   const PlayViewCard(
//       {Key? key, required this.voiceRecordBloc, required this.onDeleteTap})
//       : super(key: key);
//   @override
//   _PlayViewCardState createState() => _PlayViewCardState();
// }

// class _PlayViewCardState extends State<PlayViewCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         SizedBox(
//           width: 200,
//           child: Card(
//             child: Row(
//               children: <Widget>[
//                 StreamBuilder<bool>(
//                   stream: widget.voiceRecordBloc.isPlayingStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return InkWell(
//                         onTap: () {
//                           if (widget.voiceRecordBloc.playerModule!.isStopped) {
//                             widget.voiceRecordBloc.startPlayer();
//                           } else {
//                             if (widget
//                                 .voiceRecordBloc.playerModule!.isPlaying) {
//                               widget.voiceRecordBloc.pausePlayer();
//                             } else {
//                               widget.voiceRecordBloc.resumePlayer();
//                             }
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: !snapshot.data!
//                               ? const Icon(
//                                   Icons.play_arrow,
//                                   color: Colors.blue,
//                                 )
//                               : const Icon(Icons.pause, color: Colors.grey),
//                         ),
//                       );
//                     }
//                     return Container();
//                   },
//                 ),
//                 Expanded(
//                   child: StreamBuilder<MapEntry<double, double>>(
//                     stream: widget.voiceRecordBloc.sliderPositionStream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return SizedBox(
//                           height: 30.0,
//                           child: Slider(
//                             value:
//                                 min(snapshot.data!.key, snapshot.data!.value),
//                             min: 0.0,
//                             max: snapshot.data!.value,
//                             onChanged: !widget
//                                     .voiceRecordBloc.playerModule!.isStopped
//                                 ? (double value) async {
//                                     await widget.voiceRecordBloc.playerModule!
//                                         .seekToPlayer(Duration(
//                                             milliseconds: value.toInt()));
//                                   }
//                                 : null,
//                             divisions: snapshot.data!.value == 0.0
//                                 ? 1
//                                 : snapshot.data!.value.toInt(),
//                           ),
//                         );
//                       }
//                       return Container();
//                     },
//                   ),
//                 ),
//                 StreamBuilder<String>(
//                     stream: widget.voiceRecordBloc.playerTxtStream,
//                     initialData: "",
//                     builder: (context, snapshot) {
//                       return Text(
//                         snapshot.data ?? "",
//                       );
//                     }),
//                 const SizedBox(
//                   width: 5,
//                 )
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(width: 5),
//         InkWell(
//           onTap: widget.onDeleteTap,
//           child: Container(
//             padding: const EdgeInsets.all(1),
//             decoration: BoxDecoration(
//               color: Colors.black.withAlpha(150),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.close,
//               // size: 40,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
