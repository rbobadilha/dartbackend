import '../../utils/generic_service.dart';

import 'receitas_dao.dart';
import 'receitas_model.dart';

class ReceitasService implements GenericService<Receita> {
  final ReceitasDAO _receitasDAO;
  ReceitasService(this._receitasDAO);

  @override
  Future<bool> delete(int id) async => await _receitasDAO.delete(id);

  @override
  Future<List<Receita>> findAll() async => await _receitasDAO.findAll();

  @override
  Future<Receita?> findOne(int id) async {
    return await _receitasDAO.findOne(id);
  }

  @override
  Future<bool> save(Receita receita) async {
    if (receita.id == null) {
      return await _receitasDAO.create(receita);
    } else {
      return await _receitasDAO.update(receita);
    }
  }
}
