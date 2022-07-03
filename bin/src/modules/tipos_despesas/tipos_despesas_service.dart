import '../../utils/generic_service.dart';

import 'tipos_despesas_dao.dart';
import 'tipos_despesas_model.dart';

class TiposDespesasService implements GenericService<TipoDespesa> {
  final TiposDespesasDAO _tiposDespesasDAO;
  TiposDespesasService(this._tiposDespesasDAO);

  @override
  Future<bool> delete(int id) async => await _tiposDespesasDAO.delete(id);

  @override
  Future<List<TipoDespesa>> findAll() async =>
      await _tiposDespesasDAO.findAll();

  @override
  Future<TipoDespesa?> findOne(int id) async {
    return await _tiposDespesasDAO.findOne(id);
  }

  @override
  Future<bool> save(TipoDespesa tipoDespesa) async {
    if (tipoDespesa.id == null) {
      return await _tiposDespesasDAO.create(tipoDespesa);
    } else {
      return await _tiposDespesasDAO.update(tipoDespesa);
    }
  }
}
