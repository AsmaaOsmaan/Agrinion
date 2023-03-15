// import 'package:flutter/material.dart';

// import '../../../../App/GlobalWidgets/recording_widget.dart';
// import '../../../../App/Utilities/recorder.dart';

// class RecordViewCard extends StatefulWidget {
//   final VoiceRecordBloc voiceRecordBloc;
//   final void Function() onCancelTap;
//   // final void Function() playFunction;
//   const RecordViewCard({
//     Key? key,
//     required this.voiceRecordBloc,
//     required this.onCancelTap,
//     // required this.playFunction,
//   }) : super(key: key);
//   @override
//   _RecordViewCardState createState() => _RecordViewCardState();
// }

// class _RecordViewCardState extends State<RecordViewCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         StreamBuilder<String>(
//             initialData: "00:00:00",
//             stream: widget.voiceRecordBloc.recorderTxtStream,
//             builder: (context, snapshot) {
//               return Text(snapshot.data!);
//             }),
//         const SizedBox(width: 10),
//         InkWell(
//             onTap: () {
//               setState(() {
//                 widget.voiceRecordBloc.stopRecording();
//               });
//             },
//             child: const RecordingWidget()),
//       ],
//     );
//   }
// }
