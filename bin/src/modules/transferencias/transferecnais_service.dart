import '../../utils/generic_service.dart';

import 'transferencias_dao.dart';
import 'transferencias_model.dart';

class TransferenciasService implements GenericService<Transferencia> {
  final TransferenciasDAO _transferenciasDAO;
  TransferenciasService(this._transferenciasDAO);

  @override
  Future<bool> delete(int id) async => await _transferenciasDAO.delete(id);

  @override
  Future<List<Transferencia>> findAll() async =>
      await _transferenciasDAO.findAll();

  @override
  Future<Transferencia?> findOne(int id) async {
    return await _transferenciasDAO.findOne(id);
  }

  @override
  Future<bool> save(Transferencia conta) async {
    if (conta.id == null) {
      return await _transferenciasDAO.create(conta);
    } else {
      return await _transferenciasDAO.update(conta);
    }
  }
}
