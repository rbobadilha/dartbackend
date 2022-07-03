import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../utils/api.dart';
import '../../utils/functions.dart';
import 'financeiro_service.dart';

class FinanceiroApi extends Api {
  final FinanceiroService _financeiroService;
  FinanceiroApi(this._financeiroService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    Router router = Router();

    router.get('/financeiro', (Request req) async {
      Map<String, dynamic> financeiro = await _financeiroService.findAll();
      return Response.ok(jsonEncode(financeiro));
    });

    router.get('/financeiro/filter', (Request req) async {
      String? dataInicialStr = req.url.queryParameters['dataInicial'];
      String? dataFinalStr = req.url.queryParameters['dataFinal'];
      if (dataInicialStr == null || dataFinalStr == null) {
        return Response.badRequest();
      }
      DateTime? dataInicial = Functions.stringToDateTime(date: dataInicialStr);
      DateTime? dataFinal = Functions.stringToDateTime(date: dataFinalStr);
      Map<String, dynamic> financeiro =
          await _financeiroService.findAllFilter(dataInicial!, dataFinal!);
      return Response.ok(jsonEncode(financeiro));
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      securityRoute: securityRoute,
    );
  }
}
