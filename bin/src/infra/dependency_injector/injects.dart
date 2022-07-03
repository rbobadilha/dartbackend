import '../../modules/configuracoes/configuracoes_api.dart';
import '../../modules/configuracoes/configuracoes_dao.dart';
import '../../modules/configuracoes/configuracoes_service.dart';
import '../../modules/contas/contas_api.dart';
import '../../modules/contas/contas_dao.dart';
import '../../modules/contas/contas_service.dart';
import '../../modules/transferencias/transferecnais_service.dart';
import '../../modules/transferencias/transferencias_api.dart';
import '../../modules/transferencias/transferencias_dao.dart';
import '../../modules/despesas/despesas_api.dart';
import '../../modules/despesas/despesas_dao.dart';
import '../../modules/despesas/despesas_service.dart';
import '../../modules/financeiro/financeiro_api.dart';
import '../../modules/financeiro/financeiro_dao.dart';
import '../../modules/financeiro/financeiro_service.dart';
import '../../modules/login/login_api.dart';
import '../../modules/login/login_service.dart';
import '../../modules/receitas/receitas_api.dart';
import '../../modules/receitas/receitas_dao.dart';
import '../../modules/receitas/receitas_service.dart';
import '../../modules/usuarios/usuarios_api.dart';
import '../../modules/usuarios/usuarios_dao.dart';
import '../../modules/usuarios/usuarios_service.dart';
import '../../modules/tipos_despesas/tipos_despesas_api.dart';
import '../../modules/tipos_despesas/tipos_despesas_dao.dart';
import '../../modules/tipos_despesas/tipos_despesas_service.dart';
import '../database/db_config.dart';
import '../database/db_connection.dart';
import '../database/db_migrations.dart';
import '../security/security_service.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    DependencyInjector di = DependencyInjector();

    di.register<DBConfig>(() => DBConnection());
    di.register<DBMigrations>(() => DBMigrations(di<DBConfig>()));
    di.register<SecurityService>(() => SecurityService());

    di.register<ConfiguracoesDAO>(() => ConfiguracoesDAO(di<DBConfig>()));
    di.register<ConfiguracoesService>(
        () => ConfiguracoesService(di<ConfiguracoesDAO>()));
    di.register<ConfiguracoesApi>(
        () => ConfiguracoesApi(di<ConfiguracoesService>()));

    di.register<UsuariosDAO>(() => UsuariosDAO(di<DBConfig>()));
    di.register<UsuariosService>(() => UsuariosService(di<UsuariosDAO>()));
    di.register<UsuariosApi>(() => UsuariosApi(di<UsuariosService>()));

    di.register<ContasDAO>(() => ContasDAO(di<DBConfig>()));
    di.register<ContasService>(() => ContasService(di<ContasDAO>()));
    di.register<ContasApi>(() => ContasApi(di<ContasService>()));

    di.register<TransferenciasDAO>(() => TransferenciasDAO(di<DBConfig>()));
    di.register<TransferenciasService>(
        () => TransferenciasService(di<TransferenciasDAO>()));
    di.register<TransferenciasApi>(
        () => TransferenciasApi(di<TransferenciasService>()));

    di.register<ReceitasDAO>(() => ReceitasDAO(di<DBConfig>()));
    di.register<ReceitasService>(() => ReceitasService(di<ReceitasDAO>()));
    di.register<ReceitasApi>(() => ReceitasApi(di<ReceitasService>()));

    di.register<TiposDespesasDAO>(() => TiposDespesasDAO(di<DBConfig>()));
    di.register<TiposDespesasService>(
        () => TiposDespesasService(di<TiposDespesasDAO>()));
    di.register<TiposDespesasApi>(
        () => TiposDespesasApi(di<TiposDespesasService>()));

    di.register<DespesasDAO>(() => DespesasDAO(di<DBConfig>()));
    di.register<DespesasService>(() => DespesasService(di<DespesasDAO>()));
    di.register<DespesasApi>(() => DespesasApi(di<DespesasService>()));

    di.register<FinanceiroDAO>(() => FinanceiroDAO(di<DBConfig>()));
    di.register<FinanceiroService>(
        () => FinanceiroService(di<FinanceiroDAO>()));
    di.register<FinanceiroApi>(() => FinanceiroApi(di<FinanceiroService>()));

    di.register<LoginService>(() => LoginService(di<UsuariosService>()));
    di.register<LoginApi>(
        () => LoginApi(di<SecurityService>(), di<LoginService>()));
    return di;
  }
}
