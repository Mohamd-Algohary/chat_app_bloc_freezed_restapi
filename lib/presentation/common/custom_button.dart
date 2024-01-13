import 'package:flutter/material.dart';

import '../resources/colors_manager.dart';
import '../resources/values_manger.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  VoidCallback? onTap;
  String text;
  CustomButton({Key? key, this.onTap, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        width: double.infinity,
        height: AppSize.s60,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
