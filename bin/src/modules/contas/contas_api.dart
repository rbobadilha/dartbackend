import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/parser_extension.dart';
import 'contas_model.dart';
import 'contas_service.dart';

class ContasApi extends Api {
  final ContasService _contasService;
  ContasApi(this._contasService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    router.get('/contas', (Request req) async {
      List<Conta> contas = await _contasService.findAll();
      List<Map> contasMap = contas.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(contasMap));
    });

    router.post('/contas', (Request req) async {
      String? body = await req.readAsString();
      Conta conta = Conta.fromRequest(jsonDecode(body));
      return (await _contasService.save(conta))
          ? Response.ok('Create successfull')
          : Response.internalServerError();
    });

    router.put('/contas', (Request req) async {
      String body = await req.readAsString();
      Conta conta = Conta.fromRequest(jsonDecode(body));
      if (await _contasService.findOne(conta.id!) == null) {
        return Response.badRequest();
      }
      return (await _contasService.save(Conta.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.delete('/contas', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      if (await _contasService.findOne(id.toType(int)) == null) {
        return Response.badRequest();
      }
      return (await _contasService.delete(id.toType(int)))
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
