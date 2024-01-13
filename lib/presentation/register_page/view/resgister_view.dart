import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '/domain/model/model.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/values_manger.dart';
import '../../resources/assets_manger.dart';
import '/presentation/register_page/cubit/register_cubit.dart';
import '../../common/custom_button.dart';
import '../../common/custom_text_field.dart';
import '../../resources/routes_manager.dart';
import '/presentation/resources/colors_manager.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  String? email, password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (ctx, state) {
        state.whenOrNull(
          loading: () {
            isLoading = true;
          },
          errror: (err) {
            isLoading = false;
            ScaffoldMessenger.of(ctx)
                .showSnackBar(SnackBar(content: Text(err)));
          },
          success: () {
            Navigator.pushReplacementNamed(ctx, Routes.loginRoute,
                arguments: email);
          },
        );
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: ColorManager.primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
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
                      Text(
                        StringsManager.scholarChat,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s75,
                  ),
                  Row(
                    children: [
                      Text(
                        StringsManager.registerC,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
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
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: StringsManager.password,
                  ),
                  const SizedBox(
                    height: AppSize.s20,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await BlocProvider.of<RegisterCubit>(context)
                            .register(RegisterRequest(email!, password!));
                      } else {}
                    },
                    text: StringsManager.registerC,
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringsManager.haveAcc,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          StringsManager.login,
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
      ),
    );
  }
}
