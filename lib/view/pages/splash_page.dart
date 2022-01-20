import 'package:auth_app/core/navigation/navigation_manager.gr.dart';
import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/repositories/init_repository.dart';
import 'package:auth_app/core/utils/locator_get_it.dart';
import 'package:auth_app/core/view_models/bloc/auth_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {// Splas screen açıldığında ilk çalışacak fonksyion.
    super.initState();
    initFunction();
  }

  initFunction() async {
    List<Future> futures = [
      Hive.initFlutter(),//Hive init edilir.
      getIt<InitRepository>().tokenInit(),//Token init edilir.
    ];
    await Future.wait(futures);// Toplu Future işlemlerini paralel çalıştırmak için kullanılan bir method.
    BlocProvider.of<AuthBloc>(context).add(AuthTryGetCurrentUser());
    // Yapmamız gereken Future işlemleri yaptıktan sonra AuthBloc içerisindeki
    // AuthTryGetCurrentUser methodu tetiklenir ve o an ön bellekte aktif token var mı kontrol edilir.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        //Listener parametresindeki bölümün ne zaman tetikleneceğini söylüyoruz.
        //Önceki status ile şuanki status aynı olmadığında listener parametresine tetikler.
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.authenticated:
              context.router.replace(
                  const HomeRoute()); // Status durumu authenticated ise HomePage E gönderir.
              break;
            default:
              context.router.replace(
                  const LoginRoute()); // Status durumu unauthenticated ise LoginPage E gönderir.
              break;
          }
        },
        child: const Center(// küçük bir bekleme anında ekranda çizilecek görüntü.
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
