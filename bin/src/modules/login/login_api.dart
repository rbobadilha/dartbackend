import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../infra/security/security_service.dart';
import '../../utils/api.dart';
import '../../utils/functions.dart';
import '../usuarios/usuarios_model.dart';
import 'login_service.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;
  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = false,
  }) {
    Router router = Router();
    router.post('/auth', (Request req) async {
      String? body = await req.readAsString();
      if (body.isEmpty) return Response.badRequest();
      Usuario? usuario = Usuario.fromLogin(body);
      usuario = await _loginService.authenticate(usuario);
      if (usuario != null) {
        String token =
            await _securityService.generateJWT(usuario.id.toString());
        usuario.token = token;
        usuario.tokenDate = Functions.getDate(DateTime.now());
        return Response.ok(jsonEncode(usuario));
      }
      return Response(401);
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      securityRoute: securityRoute,
    );
  }
}
