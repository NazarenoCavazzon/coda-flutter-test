import 'package:flutter/material.dart';
import 'package:test_coda/common/app_size.dart';

class CodaButton extends StatelessWidget {
  const CodaButton({
    super.key,
    this.onPressed,
    required this.padding,
    required this.width,
    required this.title,
  });
  final void Function()? onPressed;
  final EdgeInsets padding;
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        padding: padding,
        alignment: Alignment.center,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xff0D1111),
          borderRadius: BorderRadius.circular(
            AppSize(context).pixels(34),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize(context).pixels(14),
          ),
        ),
      ),
    );
  }
}
