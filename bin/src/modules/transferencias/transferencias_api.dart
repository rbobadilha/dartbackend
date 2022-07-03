import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/parser_extension.dart';
import 'transferencias_model.dart';
import 'transferecnais_service.dart';

class TransferenciasApi extends Api {
  final TransferenciasService _transferenciasService;
  TransferenciasApi(this._transferenciasService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    router.get('/transferencias', (Request req) async {
      List<Transferencia> transferencias =
          await _transferenciasService.findAll();
      List<Map> transferenciasMap =
          transferencias.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(transferenciasMap));
    });

    router.post('/transferencias', (Request req) async {
      String? body = await req.readAsString();
      Transferencia transferencia = Transferencia.fromRequest(jsonDecode(body));
      return (await _transferenciasService.save(transferencia))
          ? Response.ok('Create successfull')
          : Response.internalServerError();
    });

    router.put('/transferencias', (Request req) async {
      String body = await req.readAsString();
      Transferencia transferencia = Transferencia.fromRequest(jsonDecode(body));
      if (await _transferenciasService.findOne(transferencia.id!) == null) {
        return Response.badRequest();
      }
      return (await _transferenciasService
              .save(Transferencia.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.delete('/transferencias', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      if (await _transferenciasService.findOne(id.toType(int)) == null) {
        return Response.badRequest();
      }
      return (await _transferenciasService.delete(id.toType(int)))
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
