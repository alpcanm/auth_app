part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  //State değişimlerinin aynı olup olmadığını kontrol edeceğimiz için equatable sınıfından extends ediyoruz
  const AuthState({
    this.status = AuthStatus.unknown, //Default status=unknown
    this.user, //default user = null
  });

  final AuthStatus status; //AuthStatus ün geldiği yer AuthRepository deki enum yapımız.
  final User? user; //User modeilimizden import ettik
  @override
  List<Object?> get props => [status, user];// Equatable ın kontrol ettiği veriler.
}

class AuthUnknown extends AuthState {// Üst sınıftan üretiliyor.(AuthState)
  const AuthUnknown() : super(status: AuthStatus.unknown);//Super methodu üst sınıfın constructer'ını çalıştırır. 
  //Yani burada üst sınıfa status:AuthStatusz.unknown gönderiyoruz.
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(User user)//Oturum açılmış durumda içeride bir kullanıcı olması lazım.
      : super(status: AuthStatus.authenticated, user: user);//O kullanıcıyı bu sınıf çağırıldığında içeriye atıyoruz. Ve AuthState'e gönderiyoruz.
}

class AuthUnauthenticated extends AuthState {//oturum kapatıldığında herhangi bir user girdimiz yok. O zaman defaul hali (null) oluyor.
  const AuthUnauthenticated() : super(status: AuthStatus.unauthenticated);//status olarakta unauthenticated e dönüştürüp üretildiği sınıfa gönderiyoruz.
}
