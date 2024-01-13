import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/resources/values_manger.dart';
import '/presentation/resources/strings_manager.dart';
import '../../common/chat_buble.dart';
import '../../resources/assets_manger.dart';
import '../../resources/colors_manager.dart';
import '../../../domain/model/model.dart';
import '../cubit/chat_cubit.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  final Object? args;
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];
  ChatView({Key? key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = args as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorManager.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManager.logo,
              height: AppSize.s50,
            ),
            const Text(StringsManager.chat),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (cont, state) {
                state.whenOrNull(
                  success: (messages) {
                    messagesList = messages.reversed.toList();
                  },
                );
              },
              builder: (ctx, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(AppNumbers.n0,
                    duration: const Duration(milliseconds: AppNumbers.n500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: StringsManager.sendMessage,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  color: ColorManager.primaryColor,
                  onPressed: () {
                    BlocProvider.of<ChatCubit>(context)
                        .sendMessage(message: controller.text, email: email);
                    controller.clear();
                    _controller.animateTo(AppNumbers.n0,
                        duration: const Duration(milliseconds: AppNumbers.n500),
                        curve: Curves.easeIn);
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.primaryColor, width: AppSize.s1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
