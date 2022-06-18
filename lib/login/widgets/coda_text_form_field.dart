import 'package:flutter/material.dart';

class CodaTextFormField extends StatelessWidget {
  const CodaTextFormField({
    super.key,
    this.obscureText,
    this.onChanged,
    required this.validator,
    required this.hintText,
    required this.controller,
  });
  final String? Function(String? value, BuildContext context) validator;
  final bool? obscureText;
  final void Function()? onChanged;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (String? value) {
        return validator.call(value, context);
      },
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        filled: false,
        suffixIcon: obscureText != null
            ? IconButton(
                onPressed: onChanged,
                icon: Icon(
                  obscureText!
                      ? Icons.visibility_off_outlined
                      : Icons.visibility,
                  color: const Color(0xffA7A8A9),
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xff161B14),
        ),
      ),
    );
  }
}
