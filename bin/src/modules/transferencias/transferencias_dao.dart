import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import '../../infra/database/db_dao.dart';
import 'transferencias_model.dart';

class TransferenciasDAO implements DAO<Transferencia> {
  final DBConfig _dbConfig;
  TransferenciasDAO(this._dbConfig);

  @override
  Future<bool> create(Transferencia transferencia) async {
    return await insert(transferencia);
  }

  Future<bool> insert(Transferencia transferencia) async {
    String query =
        'INSERT INTO transferencias (descricao, dat, contaIdDebito, contaIdCredito, valor) VALUES ';
    query += '(:descricao, :dat, :contaIdDebito, :contaIdCredito, :valor);';
    IResultSet result = await _dbConfig.execute(query, {
      'descricao': transferencia.descricao,
      'dat': transferencia.dat,
      'contaIdDebito': transferencia.contaIdDebito,
      'contaIdCredito': transferencia.contaIdCredito,
      'valor': transferencia.valor,
    });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    String query = 'DELETE FROM transferencias WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<Transferencia>> findAll() async {
    String query =
        'SELECT T.id, T.descricao, T.dat, T.valor, T.contaIdDebito, CD.nome AS contaNomeDebito, ';
    query +=
        'T.dtCriacao, T.dtAtualizacao, T.contaIdCredito, CC.nome AS contaNomeCredito ';
    query +=
        'FROM transferencias T LEFT JOIN contas CD ON T.contaIdDebito = CD.id ';
    query +=
        'LEFT JOIN contas CC ON T.contaIdCredito = CC.id ORDER BY T.dat DESC';
    IResultSet result = await _dbConfig.execute(query);
    return result.rows
        .map((r) => Transferencia.fromMap(r.typedAssoc()))
        .toList()
        .cast<Transferencia>();
  }

  @override
  Future<Transferencia?> findOne(int id) async {
    final String query = 'SELECT * FROM transferencias WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return (result.rows.isEmpty)
        ? null
        : Transferencia.fromMap(result.rows.first.typedAssoc());
  }

  @override
  Future<bool> update(Transferencia transferencia) async {
    String query =
        'UPDATE transferencias SET descricao = :descricao, dat = :dat, contaIdDebito = :contaIdDebito, ';
    query += 'contaIdCredito = :contaIdCredito, valor = :valor WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': transferencia.id,
      'descricao': transferencia.descricao,
      'dat': transferencia.dat,
      'contaIdDebito': transferencia.contaIdDebito,
      'contaIdCredito': transferencia.contaIdCredito,
      'valor': transferencia.valor,
    });
    return result.affectedRows.toInt() > 0;
  }
}
