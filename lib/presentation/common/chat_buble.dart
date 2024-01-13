import 'package:flutter/material.dart';

import '/presentation/resources/values_manger.dart';
import '../../domain/model/model.dart';
import '../resources/colors_manager.dart';

class ChatBuble extends StatelessWidget {
  final Message message;
  const ChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
            left: AppPadding.p16,
            top: AppPadding.p32,
            bottom: AppPadding.p32,
            right: AppPadding.p32),
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m16, vertical: AppMargin.m8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.s32),
            topRight: Radius.circular(AppSize.s32),
            bottomRight: Radius.circular(AppSize.s32),
          ),
          color: ColorManager.primaryColor,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
            left: AppPadding.p16,
            top: AppPadding.p32,
            bottom: AppPadding.p32,
            right: AppPadding.p32),
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m16, vertical: AppMargin.m8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSize.s32),
            topRight: Radius.circular(AppSize.s32),
            bottomLeft: Radius.circular(AppSize.s32),
          ),
          color: ColorManager.lightTeal,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
