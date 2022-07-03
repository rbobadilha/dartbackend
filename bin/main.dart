import 'package:shelf/shelf.dart';

import 'src/infra/database/db_migrations.dart';
import 'src/infra/dependency_injector/injects.dart';
import 'src/infra/middleware/middleware_interception.dart';
import 'src/infra/servidor.dart';
import 'src/modules/configuracoes/configuracoes_api.dart';
import 'src/modules/contas/contas_api.dart';
import 'src/modules/transferencias/transferencias_api.dart';
import 'src/modules/despesas/despesas_api.dart';
import 'src/modules/financeiro/financeiro_api.dart';
import 'src/modules/receitas/receitas_api.dart';
import 'src/modules/usuarios/usuarios_api.dart';
import 'src/modules/tipos_despesas/tipos_despesas_api.dart';
import 'src/modules/login/login_api.dart';
import 'src/utils/env.dart';

void main() async {
  print('Starting server...');
  Env.fromFile('.env_gcp');
  // Env.fromFile('.env_local');

  final di = Injects.initialize();

  // Check Database
  await di.get<DBMigrations>().checkTables();

  var handlers = Cascade()
      .add(di.get<LoginApi>().getHandler(securityRoute: false))
      .add(di.get<ConfiguracoesApi>().getHandler(securityRoute: true))
      .add(di.get<UsuariosApi>().getHandler(securityRoute: true))
      .add(di.get<ContasApi>().getHandler(securityRoute: true))
      .add(di.get<TransferenciasApi>().getHandler(securityRoute: true))
      .add(di.get<ReceitasApi>().getHandler(securityRoute: true))
      .add(di.get<TiposDespesasApi>().getHandler(securityRoute: true))
      .add(di.get<DespesasApi>().getHandler(securityRoute: true))
      .add(di.get<FinanceiroApi>().getHandler(securityRoute: true))
      .handler;

  // Middlewares Globais
  var pipeline = Pipeline()
      .addMiddleware(MiddlewareInterception.log)
      .addMiddleware(MiddlewareInterception.contentTypeJson)
      .addMiddleware(MiddlewareInterception.cors)
      .addHandler(handlers);

  await Servidor.initialize(
    endereco: await Env.get<String>(key: 'servidor_endereco'),
    porta: await Env.get<int>(key: 'servidor_porta'),
    handler: pipeline,
  );
}
