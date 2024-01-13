import 'package:flutter/material.dart';

import '../resources/strings_manager.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  Function(String)? onChanged;
  String? hintText;
  bool? obscureText;
  CustomFormTextField(
      {Key? key, this.hintText, this.onChanged, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.trim().isEmpty) {
          return StringsManager.fieldRequired;
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
