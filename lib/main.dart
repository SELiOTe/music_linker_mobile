import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/provider/global_model.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/page/auth/country_list_page.dart';
import 'package:mlm/page/auth/reset_password.dart';
import 'package:mlm/page/auth/sign_up_page.dart';
import 'package:mlm/page/auth/trust_device_login_page.dart';
import 'package:mlm/page/auth/trustless_device_login_page.dart';
import 'package:mlm/page/home_page.dart';
import 'package:mlm/page/splash_page.dart';
import 'package:provider/provider.dart';

import 'model/api/auth/country_list.dart';

/// 应用入口
///
/// @author seliote
/// @version 2021-08-07

// GlobalKey 用于获取全局 Context
final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

/// 应用入口方法
void main() {
  // 应用全局 Provider
  runApp(ChangeNotifierProvider(
    create: (context) => GlobalModel(),
    child: App(),
  ));
}

/// 基 Widget
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: globalKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      onGenerateRoute: (routeSettings) => _generateRoute(routeSettings),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

/// 全局路由钩子
///
/// param routeSettings 路由配置
Route<dynamic> _generateRoute(RouteSettings routeSettings) {
  debugPrint("Generate route ${routeSettings.name}, "
      "arguments ${routeSettings.arguments}");
  switch (routeSettings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => SplashPage());
    case AUTH_PAGE:
      return MaterialPageRoute(builder: (context) => AuthPage());
    case COUNTRY_LIST_PAGE:
      return MaterialPageRoute(
          builder: (context) => CountryListPage(
              routeSettings.arguments as List<CountryListResp>));
    case HOME_PAGE:
      return MaterialPageRoute(builder: (context) => HomePage());
    case SIGN_UP_PAGE:
      return MaterialPageRoute(
          builder: (context) =>
              SignUpPage(routeSettings.arguments as AuthInfo));
    case TRUST_DEVICE_LOGIN_PAGE:
      return MaterialPageRoute(
          builder: (context) =>
              TrustDeviceLoginPage(routeSettings.arguments as AuthInfo));
    case TRUSTLESS_DEVICE_LOGIN_PAGE:
      return MaterialPageRoute(
          builder: (context) =>
              TrustlessDeviceLoginPage(routeSettings.arguments as AuthInfo));
    case RESET_PASSWORD_PAGE:
      return MaterialPageRoute(
          builder: (context) =>
              ResetPasswordPage(routeSettings.arguments as AuthInfo));
    default:
      throw "404 Page ${routeSettings.name} Not Found";
  }
}
