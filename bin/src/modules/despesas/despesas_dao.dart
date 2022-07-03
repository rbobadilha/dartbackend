import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import '../../infra/database/db_dao.dart';
import 'despesas_model.dart';

class DespesasDAO implements DAO<Despesa> {
  final DBConfig _dbConfig;
  DespesasDAO(this._dbConfig);

  @override
  Future<bool> create(Despesa despesa) async {
    if (despesa.parcelas! == 1) {
      return await insert(despesa);
    } else {
      String descricao = despesa.descricao!;
      DateTime dat = despesa.vencimento!;
      for (int index = 1; index < despesa.parcelas!; index++) {
        despesa.descricao = '$descricao $index/${despesa.parcelas}';
        despesa.vencimento = dat;
        if (!await insert(despesa)) return false;
        dat = DateTime(dat.year, dat.month + 1, dat.day);
      }
    }
    return true;
  }

  Future<bool> insert(Despesa despesa) async {
    String query =
        'INSERT INTO despesas (descricao, tipoDespesaId, dat, vencimento, valor, pago) VALUES (:descricao, :tipoDespesaId, :dat, :vencimento, :valor, :pago);';
    IResultSet result = await _dbConfig.execute(query, {
      'descricao': despesa.descricao,
      'tipoDespesaId': despesa.tipoDespesaId,
      'dat': despesa.dat,
      'vencimento': despesa.vencimento,
      'valor': despesa.valor,
      'recebido': (despesa.pago!) ? 1 : 0,
    });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    String query = 'DELETE FROM despesas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<Despesa>> findAll() async {
    String query =
        'SELECT D.*, TD.descricao AS tipoDespesaDescricao FROM despesas D ';
    query +=
        'LEFT JOIN tipos_despesas TD ON D.tipoDespesaId = TD.id ORDER BY D.dat DESC;';
    IResultSet result = await _dbConfig.execute(query);
    return result.rows
        .map((r) => Despesa.fromMap(r.typedAssoc()))
        .toList()
        .cast<Despesa>();
  }

  Future<List<Map<String, dynamic>>> findAllTotal() async {
    String query =
        'SELECT SUM(S.total) AS total, SUM(S.totalPago) AS totalPago, S.tipoDespesaDescricao, S.valorPrevisto ';
    query +=
        'FROM (SELECT SUM(D.valor) AS total, 0 AS totalPago, TD.descricao AS tipoDespesaDescricao, TD.valorPrevisto AS valorPrevisto ';
    query +=
        'FROM despesas D LEFT JOIN tipos_despesas TD ON D.tipoDespesaId = TD.id GROUP BY TD.descricao, TD.valorPrevisto ';
    query +=
        'UNION SELECT 0 AS total, SUM(D.valor) as totalPago, TD.descricao AS tipoDespesaDescricao, TD.valorPrevisto AS valorPrevisto ';
    query +=
        'FROM despesas D LEFT JOIN tipos_despesas TD ON D.tipoDespesaId = TD.id WHERE D.pago = 1 GROUP BY TD.descricao, TD.valorPrevisto ';
    query +=
        'UNION SELECT 0 AS total, 0 as totalPago, TD.descricao AS tipoDespesaDescricao, TD.valorPrevisto AS valorPrevisto ';
    query +=
        'FROM despesas D LEFT JOIN tipos_despesas TD ON D.tipoDespesaId = TD.id WHERE D.pago = 1 GROUP BY TD.descricao, TD.valorPrevisto) AS S ';
    query += 'GROUP BY S.tipoDespesaDescricao, S.valorPrevisto;';
    IResultSet result = await _dbConfig.execute(query);
    return result.rows.map((r) => r.typedAssoc()).toList();
    // String dados = jsonEncode(result.rows.map((r) => r.typedAssoc()));
    // return {'saldoInicial': saldoInicial, 'dados': dados};
    // return result.rows
    //     .map((r) => Despesa.fromMap(r.typedAssoc()))
    //     .toList()
    //     .cast<Despesa>();
  }

  @override
  Future<Despesa?> findOne(int id) async {
    final String query = 'SELECT * FROM despesas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return (result.rows.isEmpty)
        ? null
        : Despesa.fromMap(result.rows.first.typedAssoc());
  }

  @override
  Future<bool> update(Despesa despesa) async {
    String query =
        'UPDATE despesas SET descricao = :descricao, tipoDespesaId = :tipoDespesaId, ';
    query += 'dat = :dat, vencimento = :vencimento, valor = :valor, ';
    query += 'pago = :pago WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': despesa.id,
      'descricao': despesa.descricao,
      'tipoDespesaId': despesa.tipoDespesaId,
      'dat': despesa.dat,
      'vencimento': despesa.vencimento,
      'valor': despesa.valor,
      'pago': despesa.pago,
    });
    return result.affectedRows.toInt() > 0;
  }
}
