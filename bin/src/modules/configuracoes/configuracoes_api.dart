import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import 'configuracoes_model.dart';
import 'configuracoes_service.dart';

class ConfiguracoesApi extends Api {
  final ConfiguracoesService _configuracoesService;
  ConfiguracoesApi(this._configuracoesService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    router.get('/configuracoes', (Request req) async {
      List<Configuracao> configuracoes = await _configuracoesService.findAll();
      List<Map> configuracoesMap =
          configuracoes.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(configuracoesMap));
    });

    router.put('/configuracoes', (Request req) async {
      String body = await req.readAsString();
      return (await _configuracoesService
              .save(Configuracao.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      securityRoute: securityRoute,
    );
  }
}
