import 'package:flutter/material.dart';
import 'package:test_coda/l10n/l10n.dart';

String? validateEmail(String? value, BuildContext context) {
  final _value = value?.trim();

  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  if (_value == null || _value.isEmpty) {
    return context.l10n.emailEmpty;
  }
  if (!emailRegExp.hasMatch(_value)) {
    return context.l10n.emailInvalid;
  }
  return null;
}

String? validatePassword(String? password, BuildContext context) {
  if (password == null || password.isEmpty) {
    return context.l10n.emptyPassword;
  }
  if (password.length < 8) {
    return context.l10n.passwordTooShort;
  }
  return null;
}

String? emptyFieldValidator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return context.l10n.fieldEmpty;
  }
  return null;
}
