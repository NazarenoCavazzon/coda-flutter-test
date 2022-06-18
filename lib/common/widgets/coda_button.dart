import 'package:flutter/material.dart';
import 'package:test_coda/common/app_size.dart';

class CodaButton extends StatelessWidget {
  const CodaButton({
    super.key,
    this.onPressed,
    this.loading = false,
    required this.height,
    required this.width,
    required this.title,
  });
  final void Function()? onPressed;
  final double width;
  final double height;
  final String title;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xff0D1111),
          borderRadius: BorderRadius.circular(
            AppSize(context).pixels(34),
          ),
        ),
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
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
