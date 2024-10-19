import 'package:flutter/material.dart';
import '../shared/strings.dart' as str;

abstract class Validator {
  bool isEmpty(var value);
  bool isNotEmpty(var value);
  bool isMatch(var value1, var value2, {bool ignoreCase = true});
  bool isNotMatch(var value1, var value2, {bool ignoreCase = true});
  bool isContain(var value1, var value2, {bool ignoreCase = true});
  bool isNotContain(var value1, var value2, {bool ignoreCase = true});
  String? validateField(var value, {String? errorMessage});
  String? validateEmail(var value);
  String? validatePassword(var value, {String? field, String? matchValue});
  String? string(var value);
}

final validator = CustomValidator.validator;

class CustomValidator implements Validator {
  static CustomValidator get validator => CustomValidator._();

  CustomValidator._();

  @override
  String? string(var value, {var orElse = '', bool lowercase = false}) {
    return isEmpty(value)
        ? orElse
        : value is TextEditingController
            ? lowercase
                ? value.text.toString().trim().toLowerCase()
                : value.text.toString().trim()
            : lowercase
                ? value.toString().trim().toLowerCase()
                : value.toString().trim();
  }

  @override
  bool isEmpty(var value) {
    return value == null
        ? true
        : value is String
            ? (value.trim().isEmpty)
            : value is bool
                ? (value)
                : value is TextEditingController
                    ? (value.text.isEmpty)
                    : value is List
                        ? (value.isEmpty)
                        : (value == null);
  }

  @override
  bool isNotEmpty(var value) {
    return !isEmpty(value);
  }

  @override
  bool isContain(var value1, var value2, {bool ignoreCase = true}) {
    return isEmpty(value1) || isEmpty(value2)
        ? false
        : value1 is List
            ? value1
                .map((item) => string(item, lowercase: ignoreCase))
                .toList()
                .contains(string(value2, lowercase: ignoreCase))
            : string(value1, lowercase: ignoreCase)!
                .contains(string(value2, lowercase: ignoreCase)!);
  }

  @override
  bool isNotContain(var value1, var value2, {bool ignoreCase = true}) {
    return !isContain(value1, value2, ignoreCase: ignoreCase);
  }

  @override
  bool isMatch(var value1, var value2, {bool ignoreCase = true}) {
    return isEmpty(value1) || isEmpty(value2)
        ? false
        : string(value1, lowercase: ignoreCase) ==
            string(value2, lowercase: ignoreCase);
  }

  @override
  bool isNotMatch(var value1, var value2, {bool ignoreCase = true}) {
    return !isMatch(value1, value2, ignoreCase: ignoreCase);
  }

  @override
  String? validateField(
    var value, {
    String? field,
    String? errorMessage,
    int? minLength,
    int? maxLength,
    String? valueSymbol,
    String? matchValue,
  }) {
    if (isEmpty(value)) {
      return errorMessage ?? str.string.of().emptyField('$field');
    } else if (minLength != null && value.length < minLength) {
      return str.string.of().inputMinLengthError('$field', minLength);
    } else if (maxLength != null && value.length > maxLength) {
      return str.string.of().inputMaxLengthError('$field', maxLength);
    } else if (matchValue != null && value != matchValue) {
      return str.string.of().fieldNotMatch('$field');
    }
    return null;
  }

  @override
  String? validateEmail(var value) {
    if (isEmpty(value)) {
      return str.string.of().emptyField(str.string.of().email);
    } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return str.string.of().notValidField(str.string.of().email);
    }
    return null;
  }

  @override
  String? validatePassword(var value, {String? field, String? matchValue}) {
    String? message = validateField(value,
        field: field ?? str.string.of().password, minLength: 6, maxLength: 40);
    if (message != null) {
      return message;
    } else if (matchValue != null && value != matchValue) {
      return str.string.of().fieldNotMatch(field ?? str.string.of().password);
    }
    return null;
  }
}