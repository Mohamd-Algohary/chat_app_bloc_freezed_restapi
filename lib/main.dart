import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/app.dart';
import '/app/di.dart';
import '/presentation/login_page/cubit/login_cubit.dart';
import '/presentation/register_page/cubit/register_cubit.dart';
import 'data/network/network_info.dart';
import 'presentation/chat_page/cubit/chat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait({initAppModule()});
  instance<NetworkInfo>().internetConnectivity();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) => instance()),
        BlocProvider<RegisterCubit>(create: (context) => instance()),
        BlocProvider<ChatCubit>(create: (context) => instance()),
      ],
      child: MyApp(),
    ),
  );
}
