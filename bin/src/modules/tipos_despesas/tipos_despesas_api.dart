import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/parser_extension.dart';
import 'tipos_despesas_model.dart';
import 'tipos_despesas_service.dart';

class TiposDespesasApi extends Api {
  final TiposDespesasService _tiposDespesasService;
  TiposDespesasApi(this._tiposDespesasService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    // router.get('/tipo-despesa', (Request req) async {
    //   String? id = req.url.queryParameters['id'];
    //   if (id == null) return Response.badRequest();

    //   TipoDespesa? tipoDespesa =
    //       await _tiposDespesasService.findOne(id.toType(int));
    //   if (tipoDespesa == null) return Response.badRequest();

    //   return Response.ok(jsonEncode(tipoDespesa.toJson()));
    // });

    router.get('/tipos-despesas', (Request req) async {
      List<TipoDespesa> tiposDespesas = await _tiposDespesasService.findAll();
      List<Map> tiposDespesasMap =
          tiposDespesas.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(tiposDespesasMap));
    });

    router.post('/tipos-despesas', (Request req) async {
      String? body = await req.readAsString();
      TipoDespesa tipoDespesa = TipoDespesa.fromRequest(jsonDecode(body));
      return (await _tiposDespesasService.save(tipoDespesa))
          ? Response.ok('Create successfull')
          : Response.internalServerError();
    });

    router.put('/tipos-despesas', (Request req) async {
      String body = await req.readAsString();
      TipoDespesa tipoDespesa = TipoDespesa.fromRequest(jsonDecode(body));
      if (await _tiposDespesasService.findOne(tipoDespesa.id!) == null) {
        return Response.badRequest();
      }
      return (await _tiposDespesasService
              .save(TipoDespesa.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.delete('/tipos-despesas', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      if (await _tiposDespesasService.findOne(id.toType(int)) == null) {
        return Response.badRequest();
      }
      return (await _tiposDespesasService.delete(id.toType(int)))
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
