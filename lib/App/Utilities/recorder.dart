// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// 
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:uuid/uuid.dart';

// class VoiceRecordBloc {
//   BehaviorSubject<String>? _recorderTxtController;
//   get recorderTxtStream => _recorderTxtController!.stream;

//   BehaviorSubject<String>? _playerTxtController;
//   get playerTxtStream => _playerTxtController!.stream;

//   double? _sliderCurrentPosition = 0.0;
//   double? _maxDuration = 1.0;
//   BehaviorSubject<MapEntry<double, double>>? _sliderPositionController;
//   get sliderPositionStream => _sliderPositionController!.stream;

//   BehaviorSubject<bool>? _isPlayingController;
//   get isPlayingStream => _isPlayingController!.stream;

//   BehaviorSubject<bool>? _isThereRecordingController;
//   get isThereRecordingStream => _isThereRecordingController!.stream;

//   String? recordedPath;
//   bool recordIsStopped = false;
//   final Codec _codec = (kIsWeb) ? Codec.opusWebM : Codec.aacADTS;
//   FlutterSoundPlayer? playerModule;
//   FlutterSoundRecorder? recorderModule;

//   VoiceRecordBloc() {
//     _recorderTxtController = BehaviorSubject<String>.seeded('0:00:00');
//     _playerTxtController = BehaviorSubject<String>.seeded('0:00');
//     _sliderPositionController =
//         BehaviorSubject<MapEntry<double, double>>.seeded(
//             const MapEntry(0.0, 1.0));
//     _isPlayingController = BehaviorSubject<bool>.seeded(false);
//     _isThereRecordingController = BehaviorSubject<bool>.seeded(false);
//     init();
//   }

//   Future<void> init() async {
//     printLog("========= init =========");
//     if (!kIsWeb) {
//       var status = Permission.microphone.request();
//       status.then((stat) {
//         if (stat != PermissionStatus.granted) {
//           throw RecordingPermissionException(
//               'Microphone permission not granted');
//         }
//       });
//     }
//     recorderModule = FlutterSoundRecorder();
//     await recorderModule?.openAudioSession();
//     playerModule = FlutterSoundPlayer();
//     await playerModule?.openAudioSession();
//     await playerModule!
//         .setSubscriptionDuration(const Duration(milliseconds: 10));
//     await recorderModule!
//         .setSubscriptionDuration(const Duration(milliseconds: 10));
//     await initializeDateFormatting();
//   }

//   void startRecorder() async {
//     try {
//       recordIsStopped = false;
//       String recordPath = await tempFile(suffix: '.aac');
//       await recorderModule?.startRecorder(toFile: recordPath);
//       printLog('startRecorder');
//       recorderModule?.onProgress!.listen((e) {
//         var date = DateTime.fromMillisecondsSinceEpoch(
//             e.duration.inMilliseconds,
//             isUtc: true);
//         var txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
//         _recorderTxtController?.sink.add(txt.substring(0, 7));
//         if (date.minute == 1) {
//           stopRecording();
//         }
//       });
//       recordedPath = recordPath;
//       printLog("path:$recordedPath");
//     } catch (err) {
//       printLog('startRecorder error: $err');
//       await _stopRecorder();
//     }
//   }

//   Future<void> _stopRecorder() async {
//     await recorderModule?.stopRecorder();
//   }

//   void stopRecording() async {
//     _stopRecorder();
//     recordIsStopped = true;
//     _isThereRecordingController?.sink.add(true);
//   }

//   void cancelRecorder() async {
//     _stopRecorder();
//     recordedPath = "";
//     recordIsStopped = false;
//     _isThereRecordingController?.sink.add(false);
//   }

//   Future<bool> fileExists(String path) async {
//     return await File(path).exists();
//   }

//   Future<void> startPlayer() async {
//     try {
//       if (await fileExists(recordedPath!)) {
//         await playerModule?.startPlayer(
//           fromURI: recordedPath,
//           codec: _codec,
//           whenFinished: () {
//             stopPlayer();
//             printLog('Play finished');
//           },
//         );
//       }
//       _addListeners();
//       _isPlayingController?.sink.add(true);
//     } catch (err) {
//       printLog('error: $err');
//     }
//   }

//   void pausePlayer() {
//     playerModule?.pausePlayer();
//     _isPlayingController?.sink.add(false);
//   }

//   void resumePlayer() {
//     playerModule?.resumePlayer();
//     _isPlayingController?.sink.add(true);
//   }

//   Future<void> stopPlayer() async {
//     try {
//       await playerModule?.stopPlayer();
//       _sliderCurrentPosition = 0.0;
//       _sliderPositionController?.sink
//           .add(MapEntry(_sliderCurrentPosition!, _maxDuration!));
//       _isPlayingController?.sink.add(false);
//     } catch (err) {
//       printLog('error: $err');
//     }
//   }

//   void _addListeners() {
//     // cancelPlayerSubscriptions();
//     playerModule?.onProgress!.listen((e) {
//       _maxDuration = e.duration.inMilliseconds.toDouble();
//       if (_maxDuration! <= 0) _maxDuration = 0.0;

//       _sliderCurrentPosition =
//           min(e.position.inMilliseconds.toDouble(), _maxDuration!);
//       if (_sliderCurrentPosition! < 0.0) {
//         _sliderCurrentPosition = 0.0;
//       }
//       _sliderPositionController?.sink
//           .add(MapEntry(_sliderCurrentPosition!, _maxDuration!));
//       DateTime date = DateTime.fromMillisecondsSinceEpoch(
//           e.position.inMilliseconds,
//           isUtc: true);
//       String txt = DateFormat('m:ss', 'en_GB').format(date);
//       _playerTxtController?.sink.add(txt.substring(0, 4));
//     });
//   }

//   Future<void> releaseFlauto() async {
//     try {
//       await playerModule?.closeAudioSession();
//       await recorderModule?.closeAudioSession();
//     } catch (e) {
//       printLog('Released unsuccessful');
//       printLog(e);
//     }
//   }

//   /// Creates an path to a temporary file.
//   Future<String> tempFile({String? suffix}) async {
//     suffix ??= 'tmp';

//     if (!suffix.startsWith('.')) {
//       suffix = '.$suffix';
//     }
//     var uuid = const Uuid();
//     String path;
//     if (!kIsWeb) {
//       var tmpDir = await getTemporaryDirectory();
//       path = '${tmpDir.path}/${uuid.v4()}$suffix';
//     } else {
//       path = 'uuid.v4()}$suffix';
//     }
//     return path;
//   }

//   void dispose() {
//     _recorderTxtController?.close();
//     _playerTxtController?.close();
//     _sliderPositionController?.close();
//     _isPlayingController?.close();
//     _isThereRecordingController?.close();
//     releaseFlauto();
//   }
// }
