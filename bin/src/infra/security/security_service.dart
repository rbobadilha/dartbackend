import 'package:shelf/shelf.dart';

import '../../utils/env.dart';
import 'security_service_def.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityService implements SecurityServiceDef<JWT> {
  // SecurityService() {
  //   print('Objeto criado ${DateTime.now()}');
  // }

  @override
  Future<String> generateJWT(String userId) async {
    JWT jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userId': userId,
      'roles': ['admin', 'user']
    });

    String key = await Env.get(key: 'jwt_key');
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    try {
      String key = await Env.get(key: 'jwt_key');
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (error) {
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers['Authorization'];
        JWT? jwt;
        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        Request request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(
        requestHandler: (Request req) {
          if (req.context['jwt'] == null) {
            return Response.forbidden('Acesso não autorizado!');
          }
          return null;
        },
      );
}
