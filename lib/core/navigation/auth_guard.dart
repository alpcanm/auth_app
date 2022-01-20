import 'package:auth_app/core/navigation/navigation_manager.gr.dart';
import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/utils/locator_get_it.dart';
import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final AuthRepository _authRepository = getIt<AuthRepository>();
    bool _result =
        _authRepository.status == AuthStatus.authenticated ? true : false;
    if (_result) {
      resolver.next(true);
    } else {
      router.push(const NotLoginRoute());
    }
  }
}
