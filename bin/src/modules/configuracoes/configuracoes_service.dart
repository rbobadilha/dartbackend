import 'configuracoes_dao.dart';
import 'configuracoes_model.dart';

class ConfiguracoesService {
  final ConfiguracoesDAO _configuracoesDAO;
  ConfiguracoesService(this._configuracoesDAO);

  Future<List<Configuracao>> findAll() async =>
      await _configuracoesDAO.findAll();

  Future<bool> save(Configuracao tipoDespesa) async {
    List<Configuracao> tiposDespesas = await _configuracoesDAO.findAll();
    if (tiposDespesas.isEmpty) {
      return await _configuracoesDAO.create(tipoDespesa);
    } else {
      return await _configuracoesDAO.update(tipoDespesa);
    }
  }
}
