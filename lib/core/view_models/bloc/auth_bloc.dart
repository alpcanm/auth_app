import 'package:auth_app/core/models/user_model.dart';
import 'package:auth_app/core/repositories/auth_repository.dart';
import 'package:auth_app/core/utils/locator_get_it.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//part of bunun bir parçasıdır demekti
part 'auth_event.dart';//part ise onların ana parçalarının olduğu dosya içerisine yazılır. 
part 'auth_state.dart';// auth_state ve auth_event i aynı sayfada yazmak yerine part / part of ile ayırdık.
// Aslında üçü tek bir sayfa gibi hareket ediyorlar. Kod fazlalığından kurtulmak için böyle bir yöntem kullanılıyor.

class AuthBloc extends Bloc<AuthEvent, AuthState> {// AuthBloc u muzu Bloc sınıfından extend ediyoruz ve içerisine eventlerimizi ve statelerimizi bildiriyoruz.
  final AuthRepository _authRepository = getIt<AuthRepository>();//get_it yardımı ile bir kereye mahsus AuthRepositoryimizi oluşturuyoruz. 
  AuthBloc() : super(const AuthUnknown()) {// super içerisine oturumumuzun ilk durumu yazılıyor. Bizim projemizde bu "unknown" yani bilinmiyor.
    //kullanacağımız methodlar tetiklendiğinde çalışacak methodları parantez içerisine  yazıyoruz
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthLoginRequested>(_onAuthLogInRequested);
    on<AuthTryGetCurrentUser>(_tryGetCurrentUser);//AuthTryGetCurrentUser tetiklendiğinde _tryGetCurrentUser methodu çalışacaktır.
  }

  Future<void> _tryGetCurrentUser(  //ilk parametreye AuthEvent ten hangi method çalışacaksa onu yazıyoruz. 
      AuthTryGetCurrentUser event, Emitter<AuthState> emit) async { //İkinciye Emitter içinde abstarct state sınıfını.
    
     
    User? _user = await _authRepository.tryGetCurrentUser();//AuthRepository deki method çalıştırılır. 
    if (_user != null) {// Eğer bir user gelirse true
      emit(AuthAuthenticated(_user));//Emit methodu bildirme işlemini yapar. Burada AuthState ini değiştiriyor  
      //AuthAuthenticated yapyır ve AuthAuthenticated içerisien bir user almalıydı. AuthRepository den gelen user ı içine yerleştiriyoruz ve bildiriyoruz. EMİT ediyoruz.
    } else {
      emit(const AuthUnauthenticated());// Eğer AuthRepository den user null dömdüyse AuthUnauthenticated olarak bildiriyoruz. Ve Widget içerisinde ona göre işlem yapıyoruz.
    }
  }

  Future<void> _onAuthLogInRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    bool _result = await _authRepository.signIn(// AuthRepository de oturum açma işlemini yapıyoruz. Biliyorsunuz AuthRepo içinde oturum açıldığında token i ön belleğe atıyordu.
        mail: event.mail, password: event.password);

    if (_result) {// Eğer oturum açma işlemi true dönmüş ise token ön belleğe atılmıştır ve tek yapılması gereken o anki kullanıcıyı getirmektir.
      add(AuthTryGetCurrentUser());//add methodu ile bloc eventlerini tetikleyebiliyoruz.
      //Zaten token ön bellekte tek yapılması gereken sunucudan veriyi getiren methodun tetiklenmesi. O methodu da bu şekilde tetikliyoruz.
    } else {
      emit(const AuthUnauthenticated());// Eğer oturum açma işlemi başarısızsa state değişmiyor ve eski state yine emit ediliyor. 
      //Ancak ekranımız yenilenmiyor. işte burada equatable in ne işe yaradığını görüyoruz.
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.signOut();//AuthRepository deki signOut methodunu tetikliyor
    emit(const AuthUnauthenticated());// Hali hazırdaki AuthAuthenticated olan state i AuthUnauthenticated olarak değiştiryor Ve bildiriyor.
  }
}
