import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/parser_extension.dart';
import 'receitas_model.dart';
import 'receitas_service.dart';

class ReceitasApi extends Api {
  final ReceitasService _receitasService;
  ReceitasApi(this._receitasService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    // router.get('/receita', (Request req) async {
    //   String? id = req.url.queryParameters['id'];
    //   if (id == null) return Response.badRequest();

    //   Receita? receita = await _receitasService.findOne(id.toType(int));
    //   if (receita == null) return Response.badRequest();

    //   return Response.ok(jsonEncode(receita.toJson()));
    // });

    router.get('/receitas', (Request req) async {
      List<Receita> receitas = await _receitasService.findAll();
      List<Map> receitasMap = receitas.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(receitasMap));
    });

    router.post('/receitas', (Request req) async {
      String? body = await req.readAsString();
      Receita receita = Receita.fromRequest(jsonDecode(body));
      return (await _receitasService.save(receita))
          ? Response.ok('Create successfull')
          : Response.internalServerError();
    });

    router.put('/receitas', (Request req) async {
      String body = await req.readAsString();
      Receita receita = Receita.fromRequest(jsonDecode(body));
      if (await _receitasService.findOne(receita.id!) == null) {
        return Response.badRequest();
      }
      return (await _receitasService
              .save(Receita.fromRequest(jsonDecode(body))))
          ? Response.ok('Update successfull')
          : Response.internalServerError();
    });

    router.delete('/receitas', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest();
      if (await _receitasService.findOne(id.toType(int)) == null) {
        return Response.badRequest();
      }
      return (await _receitasService.delete(id.toType(int)))
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
