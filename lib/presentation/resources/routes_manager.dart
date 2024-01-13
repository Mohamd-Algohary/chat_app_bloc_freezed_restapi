import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../chat_page/view/chat_view.dart';
import '../login_page/view/login_view.dart';
import '../register_page/view/resgister_view.dart';
import 'strings_manager.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String chatRoute = "/main";
}

class RouteGenerator {
  final AppPreferences _appPreferences = instance();
  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        initRegisterdModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.chatRoute:
        initChatModule();
        return MaterialPageRoute(
            builder: (_) =>
                ChatView(args: settings.arguments ?? _appPreferences.email));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringsManager.noRouteFound),
        ),
        body: const Center(child: Text(StringsManager.noRouteFoundBody)),
      ),
    );
  }
}
