import '../../utils/generic_service.dart';

import 'contas_dao.dart';
import 'contas_model.dart';

class ContasService implements GenericService<Conta> {
  final ContasDAO _contasDAO;
  ContasService(this._contasDAO);

  @override
  Future<bool> delete(int id) async => await _contasDAO.delete(id);

  @override
  Future<List<Conta>> findAll() async => await _contasDAO.findAll();

  @override
  Future<Conta?> findOne(int id) async {
    return await _contasDAO.findOne(id);
  }

  @override
  Future<bool> save(Conta conta) async {
    if (conta.id == null) {
      return await _contasDAO.create(conta);
    } else {
      return await _contasDAO.update(conta);
    }
  }
}
