import 'financeiro_dao.dart';

class FinanceiroService {
  final FinanceiroDAO _financeiroDAO;
  FinanceiroService(this._financeiroDAO);

  Future<Map<String, dynamic>> findAll() async =>
      await _financeiroDAO.findAll();

  Future<Map<String, dynamic>> findAllFilter(
      DateTime dataInicial, DateTime dataFinal) async {
    return await _financeiroDAO.findAllFilter(dataInicial, dataFinal);
  }
}
