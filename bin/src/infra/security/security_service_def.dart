import 'package:shelf/shelf.dart';

abstract class SecurityServiceDef<Type> {
  Future<String> generateJWT(String userId);
  Future<Type?> validateJWT(String token);

  Middleware get verifyJwt;
  Middleware get authorization;
}
