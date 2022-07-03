import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/parser_extension.dart';
import 'despesas_model.dart';
import 'despesas_service.dart';

class DespesasApi extends Api {
  final DespesasService _despesasService;
  DespesasApi(this._despesasService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    // router.get('/despesa', (Request req) async {
    //   String? id = req.url.queryParameters['id'];
    //   if (id == null) return Response.badRequest();

    //   Despesa? despesa = await _despesasService.findOne(id.toType(int));
    //   if (despesa == null) return Response.badRequest();

    //   return Response.ok(jsonEncode(despesa.toJson()));
    // });

    router.get('/despesas', (Request req) async {
      List<Despesa> despesas = await _despesasService.findAll();
      List<Map> despesasMap = despesas.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(despesasMap));
    });

    router.get('/despesas/total', (Request req) async {
      List<Map<String, dynamic>> despesas =
          await _despesasService.findAllTotal();
      // List<Map> despesasMap = despesas.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(despesas));
    });

    router.post('/despesas', (Request req) async {
      String? body = await req.readAsString();
      Despesa despesa = Despesa.fromRequest(jsonDecode(body));
      return (await _despesasService.save(despesa))
          ? Response.ok('Create successfull')
          : Response.internalServerError();
    });

    router.put('/despesas', (Request req) async {
      String body = await req.readAsString();
      Despesa despesa = Despesa.fromRequest(jsonDecode(body));
      if (await _despesasService.findOne(despesa.id!) == null) {
        return Response.badRequest();
      }
      return (await _despesasService
              .save(Despesa.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.delete('/despesas', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      if (await _despesasService.findOne(id.toType(int)) == null) {
        return Response.badRequest();
      }
      return (await _despesasService.delete(id.toType(int)))
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
