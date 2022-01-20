import 'package:auth_app/core/navigation/auth_guard.dart';
import 'package:auth_app/core/navigation/navigation_manager.gr.dart';
import 'package:auth_app/core/repositories/init_repository.dart';
import 'package:auth_app/core/utils/locator_get_it.dart';
import 'package:auth_app/core/view_models/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  setupGetIt();
  await getIt<InitRepository>().getFirebaseApiKey();
  runApp(BlocProvider(
    create: (context) => AuthBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter(authGuard: AuthGuard());
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        initialRoutes: [const SplashRoute()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
