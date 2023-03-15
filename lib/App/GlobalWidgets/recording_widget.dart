import 'package:flutter/material.dart';

import '../Resources/color_manager.dart';

class RecordingWidget extends StatefulWidget {
  const RecordingWidget({Key? key}) : super(key: key);

  @override
  _RecordingWidgetState createState() => _RecordingWidgetState();
}

class _RecordingWidgetState extends State<RecordingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _positionAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _positionAnimation =
        Tween<double>(begin: .2, end: .23).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      if (_positionAnimation.isCompleted) {
        _controller.reverse();
      } else if (_positionAnimation.isDismissed) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        padding: EdgeInsets.all((_positionAnimation.value * 100) - 15),
        decoration: const BoxDecoration(
          color: ColorManager.favRed,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.stop,
          color: ColorManager.white,
        ),
      ),
    );
  }
}
