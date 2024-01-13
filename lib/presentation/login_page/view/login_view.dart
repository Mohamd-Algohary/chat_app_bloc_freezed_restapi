import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../chat_page/cubit/chat_cubit.dart';
import '../../common/custom_button.dart';
import '../../common/custom_text_field.dart';
import '../../resources/assets_manger.dart';
import '../../resources/colors_manager.dart';
import '/domain/model/model.dart';
import '/presentation/login_page/cubit/login_cubit.dart';
import '/presentation/resources/routes_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manger.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  final AppPreferences _appPreferences = instance();
  bool isLoading = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        listener: (ctx, state) {
          state.whenOrNull(
            loading: () {
              isLoading = true;
            },
            success: (authData) {
              initChatModule();
              _appPreferences.setUserLoggedin(authData);
              BlocProvider.of<ChatCubit>(ctx).getMessages();
              Navigator.pushReplacementNamed(ctx, Routes.chatRoute,
                  arguments: email);
            },
            errror: (err) {
              ScaffoldMessenger.of(ctx)
                  .showSnackBar(SnackBar(content: Text(err)));
              isLoading = false;
            },
          );
        },
        child: _getContent(context));
  }

  Widget _getContent(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: AppSize.s75,
                ),
                Image.asset(
                  AssetsManager.logo,
                  height: AppSize.s100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringsManager.scholarChat,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s75,
                ),
                Row(
                  children: [
                    Text(StringsManager.login,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: StringsManager.email,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: StringsManager.password,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context)
                          .login(LoginRequest(email!, password!));
                    } else {}
                  },
                  text: StringsManager.login,
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAcc,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.registerRoute);
                      },
                      child: Text(
                        StringsManager.register,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
