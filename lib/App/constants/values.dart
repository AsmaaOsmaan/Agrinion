import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Gradient
LinearGradient bottomUpLinearGradient = LinearGradient(
    colors: [
      Colors.black.withOpacity(.7),
      Colors.transparent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: const [.0, .2]);
LinearGradient upBottomLinearGradient = LinearGradient(
  colors: [
    Colors.black.withOpacity(.7),
    Colors.transparent,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [.0, .2],
);

// Radius
var radius20 = BorderRadius.circular(20);
var radius8 = BorderRadius.circular(8);

var nonDecimalInputFormatter = [
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  FilteringTextInputFormatter.deny(RegExp('[\\-|\\ ]')),
  FilteringTextInputFormatter.digitsOnly
];
var decimalInputFormatter = [
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
];
const decimalKeyboardType =
    TextInputType.numberWithOptions(signed: false, decimal: true);
