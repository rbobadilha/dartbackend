import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/parser_extension.dart';
import 'usuarios_model.dart';
import 'usuarios_service.dart';

class UsuariosApi extends Api {
  final UsuariosService _usuariosService;
  UsuariosApi(this._usuariosService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    // router.get('/usuario', (Request req) async {
    //   String? id = req.url.queryParameters['id'];
    //   if (id == null) return Response.badRequest();

    //   Usuario? usuario = await _usuariosService.findOne(id.toType(int));
    //   if (usuario == null) return Response.badRequest();

    //   return Response.ok(jsonEncode(usuario.toJson()));
    // });

    router.get('/usuarios', (Request req) async {
      List<Usuario> usuarios = await _usuariosService.findAll();
      List<Map> usuariosMap = usuarios.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(usuariosMap));
    });

    router.post('/usuarios', (Request req) async {
      String? body = await req.readAsString();
      Usuario usuario = Usuario.fromRequest(jsonDecode(body));
      return (await _usuariosService.create(usuario))
          ? Response.ok('Create successfull')
          : Response.internalServerError();
    });

    router.put('/usuarios', (Request req) async {
      String body = await req.readAsString();
      Usuario usuario = Usuario.fromRequest(jsonDecode(body));
      if (await _usuariosService.findOne(usuario.id!) == null) {
        return Response.badRequest();
      }
      return (await _usuariosService
              .update(Usuario.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.put('/usuarios/senha', (Request req) async {
      String body = await req.readAsString();
      Usuario usuario = Usuario.fromRequest(jsonDecode(body));
      if (await _usuariosService.findOne(usuario.id!) == null) {
        return Response.badRequest();
      }
      return (await _usuariosService
              .save(Usuario.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.put('/usuarios/tema', (Request req) async {
      String body = await req.readAsString();
      Usuario usuario = Usuario.fromRequest(jsonDecode(body));
      if (await _usuariosService.findOne(usuario.id!) == null) {
        return Response.badRequest();
      }
      return (await _usuariosService
              .updateTheme(Usuario.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.delete('/usuarios', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      if (await _usuariosService.findOne(id.toType(int)) == null) {
        return Response.badRequest();
      }
      return (await _usuariosService.delete(id.toType(int)))
          ? Response.ok('Delete successfull')
          : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      securityRoute: securityRoute,
    );
  }
}
