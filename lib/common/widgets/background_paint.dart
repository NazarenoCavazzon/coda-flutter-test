import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackgroundPaint extends StatelessWidget {
  const BackgroundPaint({
    super.key,
    required this.svg,
    required this.alignment,
  });
  final String svg;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SvgPicture.asset(
        svg,
        color: const Color.fromARGB(255, 207, 230, 0),
      ),
    );
  }
}
