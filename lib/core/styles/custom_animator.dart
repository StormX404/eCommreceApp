import 'package:flutter/material.dart';

class CustomAddAddressAnimator extends FloatingActionButtonAnimator {
  @override
  Offset getOffset({required Offset begin, required Offset end, required double progress}) {
    // Adjust the offset path if you want a custom curve for the animation.
    return Offset.lerp(begin, end, Curves.easeOut.transform(progress))!;
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: parent, curve: Curves.easeOut),
    );
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: parent, curve: Curves.easeInOut),
    );
  }
}