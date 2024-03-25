import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+\.[a-zA-Z]");

String? emptyTextFieldValidator(value) {
  if (value.isEmpty) {
    return getemptyTextField();
  }
  return null;
}

String? emailValidator(value) {
  if (value.isEmpty) {
    return getEmail();
  }
  if (!emailValidatorRegExp.hasMatch(value)) {
    return getValidEmail();
  }
  return null;
}

String? passwordValidator(value) {
  if (value.isEmpty) {
    return getPassword();
  }
  if (value.length < 6) {
    return getValidPassword();
  }
  return null;
}

class Validators {
  static String? email;
  static String? validEmail;
  static String? password;
  static String? validPassword;
  static String? emptyTextField;
  void init(BuildContext context) {
    email = "enterEmail";
    validEmail = "enterValidEmail";
    password = "enterPassword";
    validPassword = "enterValidPassword";
    emptyTextField = "emptyTextField";
  }
}

String? getEmail() => Validators.email;
String? getValidEmail() => Validators.validEmail;
String? getPassword() => Validators.password;
String? getValidPassword() => Validators.validPassword;
String? getemptyTextField() => Validators.emptyTextField;
