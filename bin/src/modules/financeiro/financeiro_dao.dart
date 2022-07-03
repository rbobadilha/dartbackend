import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';

class FinanceiroDAO {
  final DBConfig _dbConfig;
  FinanceiroDAO(this._dbConfig);

  Future<Map<String, dynamic>> findAll() async {
    Map<String, dynamic> saldoInicial = {
      'creditoInicial': 0,
      'creditoInicialRecebido': 0,
      'debitoInicial': 0,
      'debitoInicialPago': 0
    };
    String query =
        'SELECT descricao, vencimento, valor AS valorCredito, 0 AS valorDebito, ';
    query +=
        'recebido AS pagoRecebido FROM receitas UNION SELECT descricao, vencimento, 0 AS valorCredito, ';
    query +=
        'valor AS valorDebito, pago AS pagoRecebido FROM despesas ORDER BY vencimento;';
    IResultSet result = await _dbConfig.execute(query);
    // result.rows.map((e) => print(e.typedAssoc()));
    List<Map<String, dynamic>> dados =
        result.rows.map((r) => r.typedAssoc()).toList();
    for (Map<String, dynamic> element in dados) {
      element['pagoRecebido'] = (element['pagoRecebido'] == 1 ? true : false);
    }
    return {'saldoInicial': saldoInicial, 'dados': dados};
  }

  Future<Map<String, dynamic>> findAllFilter(
      DateTime dataInicial, DateTime dataFinal) async {
    String query =
        'SELECT SUM(T.creditoInicial) AS creditoInicial, SUM(T.creditoInicialRecebido) AS creditoInicialRecebido, ';
    query +=
        'SUM(T.debitoInicial) AS debitoInicial, SUM(T.debitoInicialPago) AS debitoInicialPago FROM ';
    query += '(SELECT SUM(valor) AS creditoInicial, ';
    query +=
        'SUM(CASE WHEN recebido = 1 THEN valor ELSE 0 END) AS creditoInicialRecebido, ';
    query +=
        '0 AS debitoInicial, 0 AS debitoInicialPago FROM receitas WHERE vencimento < :dataInicial UNION ';
    query +=
        'SELECT 0 AS creditoInicial, 0 AS creditoInicialRecebido, SUM(valor) AS debitoInicial, ';
    query +=
        'SUM(CASE WHEN pago = 1 THEN valor ELSE 0 END) AS debitoInicialPago FROM despesas ';
    query += 'WHERE vencimento < :dataInicial) AS T;';
    IResultSet result = await _dbConfig
        .execute(query, {'dataInicial': dataInicial, 'dataFinal': dataFinal});
    Map<String, dynamic> saldoInicial = result.rows.first.typedAssoc();

    query =
        'SELECT descricao, vencimento, valor AS valorCredito, 0 AS valorDebito, recebido AS pagoRecebido ';
    query +=
        'FROM receitas WHERE vencimento >= :dataInicial AND vencimento <= :dataFinal UNION ';
    query +=
        'SELECT descricao, vencimento, 0 AS valorCredito, valor AS valorDebito, ';
    query +=
        'pago AS pagoRecebido FROM despesas WHERE vencimento >= :dataInicial AND ';
    query += 'vencimento <= :dataFinal ORDER BY vencimento';
    result = await _dbConfig
        .execute(query, {'dataInicial': dataInicial, 'dataFinal': dataFinal});
    List<Map<String, dynamic>> dadosMap =
        result.rows.map((r) => r.typedAssoc()).toList();
    for (Map<String, dynamic> element in dadosMap) {
      element['pagoRecebido'] = (element['pagoRecebido'] == 1) ? true : false;
    }
    return {'saldoInicial': saldoInicial, 'dados': dadosMap};
  }
}
