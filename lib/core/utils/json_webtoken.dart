import 'package:auth_app/core/constants/keys.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtManager {
  final dynamic _data;
  late JWT _jwt;
  JwtManager(this._data) {
    _jwt = JWT(_data);
  }

  String signJwt() {
    int _expiredTime = 500;
    String _secretKey = Keys.secretKey; // dotenv.env['JWT_SECRET_KEY'] as String;
    String token = _jwt.sign(SecretKey(_secretKey),
        expiresIn: Duration(seconds: _expiredTime));
        
    return token;
  }
}
