import '../../utils/generic_service.dart';

import 'despesas_dao.dart';
import 'despesas_model.dart';

class DespesasService implements GenericService<Despesa> {
  final DespesasDAO _despesasDAO;
  DespesasService(this._despesasDAO);

  @override
  Future<bool> delete(int id) async => await _despesasDAO.delete(id);

  @override
  Future<List<Despesa>> findAll() async => await _despesasDAO.findAll();

  Future<List<Map<String, dynamic>>> findAllTotal() async =>
      await _despesasDAO.findAllTotal();

  @override
  Future<Despesa?> findOne(int id) async {
    return await _despesasDAO.findOne(id);
  }

  @override
  Future<bool> save(Despesa despesa) async {
    if (despesa.id == null) {
      return await _despesasDAO.create(despesa);
    } else {
      return await _despesasDAO.update(despesa);
    }
  }
}
