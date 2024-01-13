import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/network/dio_factory.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/api.dart';
import '../data/network/api2.dart';
import '/data/network/network_info.dart';
import '/data/repository_impl/repo_impl.dart';
import '/domain/repository/repository.dart';
import '/domain/usecase/get_message_usecase.dart';
import '/domain/usecase/login_usecase.dart';
import '/domain/usecase/register_usecase.dart';
import '/presentation/chat_page/cubit/chat_cubit.dart';
import '/presentation/register_page/cubit/register_cubit.dart';
import '../domain/usecase/send_message_usecase.dart';
import '../presentation/login_page/cubit/login_cubit.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => prefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfo());

  var dio = await DioFactory().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance
      .registerLazySingleton<AppServiceClient2>(() => AppServiceClient2(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance(), instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(() => LoginUsecase(instance()));
    instance.registerFactory<LoginCubit>(() => LoginCubit(instance()));
  }
}

void initRegisterdModule() {
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance
        .registerFactory<RegisterUsecase>(() => RegisterUsecase(instance()));
    instance.registerFactory<RegisterCubit>(() => RegisterCubit(instance()));
  }
}

void initChatModule() {
  if (!GetIt.I.isRegistered<GetMessageUSecase>() &&
      !GetIt.I.isRegistered<GetMessageUSecase>()) {
    instance.registerFactory<GetMessageUSecase>(
        () => GetMessageUSecase(instance()));
    instance.registerFactory<SendMessageUSecase>(
        () => SendMessageUSecase(instance()));
    instance
        .registerFactory<ChatCubit>(() => ChatCubit(instance(), instance()));
  }
}
