import 'package:auth_app/core/constants/navigation_consts.dart';
import 'package:auth_app/core/navigation/auth_guard.dart';
import 'package:auth_app/view/pages/home_page.dart';
import 'package:auth_app/view/pages/login_page.dart';
import 'package:auth_app/view/pages/not_login_page.dart';
import 'package:auth_app/view/pages/profile_page.dart';
import 'package:auth_app/view/pages/register_page.dart';
import 'package:auth_app/view/pages/splash_page.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, path: RouteConsts.INIT),
    AutoRoute(page: LoginPage, path: RouteConsts.LOGIN_PAGE),
    AutoRoute(page: HomePage, path: RouteConsts.HOME_PAGE, guards: [AuthGuard]),
    AutoRoute(
        page: ProfilePage, path: RouteConsts.PROFILE_PAGE, guards: [AuthGuard]),
    AutoRoute(page: NotLoginPage, path: RouteConsts.NOT_LOGIN_PAGE),
    AutoRoute(page: RegisterPage, path: RouteConsts.REGISTER_PAGE),
  ],
)
class $AppRouter {}
