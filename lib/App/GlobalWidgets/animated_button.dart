import 'package:agriunion/App/Resources/color_manager.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({Key? key}) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _visible = false;
  bool showPayButton = false;
  _changeOpacity() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 650),
      child: ElevatedButton(
        onPressed: _changeOpacity,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: ColorManager.primary,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(showPayButton ? 'Proceed to pay' : 'Checkout'),
      ),
    );
  }
}
