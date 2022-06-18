import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

/// Personalized [Flushbar] widget. To cast use the .show() method.
class CodaSnackbar {
  /// Creates a [Flushbar] widget.
  const CodaSnackbar({
    required this.message,
    this.accentColor = const Color(0xff7C7C7E),
    this.backgroundColor = Colors.white,
    this.icon = Icons.info_outline,
    this.position = FlushbarPosition.TOP,
    this.duration = 3,
  });

  /// Creates a Success [Flushbar] widget.
  const CodaSnackbar.success({
    required this.message,
    this.accentColor = const Color(0xff66C109),
    this.backgroundColor = Colors.white,
    this.icon = Icons.check_circle_outline,
    this.position = FlushbarPosition.TOP,
    this.duration = 3,
  });

  /// Creates an Error [Flushbar] widget.
  const CodaSnackbar.error({
    required this.message,
    this.accentColor = const Color(0xffFC5D47),
    this.backgroundColor = Colors.white,
    this.icon = Icons.error_outline,
    this.position = FlushbarPosition.TOP,
    this.duration = 3,
  });

  /// The message to be displayed in the [Flushbar].
  final String message;

  /// The background color of the [Flushbar].
  final Color backgroundColor;

  /// The color of the accents in the [Flushbar].
  final Color accentColor;

  /// The icon to be displayed in the [Flushbar].
  final IconData icon;

  /// The position of the [Flushbar].
  final FlushbarPosition position;

  /// The duration of the [Flushbar] in Seconds.
  final int duration;

  /// Shows the [Flushbar] in the [BuildContext].
  void show(BuildContext context) {
    Flushbar<void>(
      flushbarPosition: position,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      backgroundColor: backgroundColor,
      borderColor: accentColor,
      shouldIconPulse: false,
      icon: Icon(
        icon,
        color: accentColor,
      ),
      borderWidth: 2,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.07,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      borderRadius: BorderRadius.circular(8),
      message: message,
      messageColor: Colors.black,
      duration: Duration(seconds: duration),
    ).show(context);
  }
}
