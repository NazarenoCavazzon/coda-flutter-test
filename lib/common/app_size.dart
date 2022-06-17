import 'package:flutter/material.dart';

/// Class used to normalize the sizes of components in the apps.
class AppSize {
  /// Creates an instance of [AppSize].
  const AppSize(this.context);

  /// The context of the widget.
  final BuildContext context;

  /// The amount of required to multiply the size to get a pixel.
  static const pixelRatio = 0.002545;

  /// Returns the size used to calculate the text size.
  double get size => MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width
      : MediaQuery.of(context).size.height;

  /// Returns the pixel ratio multiplied by the pixels given.
  double pixels(double pixels) => pixel * pixels;

  /// Returns a pixel for custom sizes
  double get pixel => size * pixelRatio;

  /// Returns xxx small size from 4 pixels.
  double get xxxSmall => 4 * pixel;

  /// Returns xx small size from 8 pixels.
  double get xxSmall => 8 * pixel;

  /// Returns x small size from 16 pixels.
  double get xSmall => 16 * pixel;

  /// Returns small size from 32 pixels.
  double get small => 32 * pixel;

  /// Returns medium size from 48 pixels.
  double get medium => 48 * pixel;

  /// Returns large size from 64 pixels.
  double get large => 64 * pixel;

  /// Returns x large size from 80 pixels.
  double get xLarge => 80 * pixel;

  /// Returns xx large size from 96 pixels.
  double get xxLarge => 96 * pixel;
}
