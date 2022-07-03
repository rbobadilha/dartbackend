import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import '../../infra/database/db_dao.dart';
import 'contas_model.dart';

class ContasDAO implements DAO<Conta> {
  final DBConfig _dbConfig;
  ContasDAO(this._dbConfig);

  @override
  Future<bool> create(Conta conta) async {
    return await insert(conta);
  }

  Future<bool> insert(Conta conta) async {
    String query = 'INSERT INTO contas (nome) VALUES (:nome);';
    IResultSet result = await _dbConfig.execute(query, {'nome': conta.nome});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    String query = 'DELETE FROM contas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<Conta>> findAll() async {
    // String query = 'SELECT * FROM contas ORDER BY nome;';
    String query =
        'SELECT S.id, S.nome, (IF(S.creditosR IS NULL,0,S.creditosR) + IF(S.creditosT IS NULL,0,S.creditosT)) AS creditos, ';

    query +=
        '(IF(S.debitosD IS NULL,0,S.debitosD) + IF(S.debitosT IS NULL,0,S.debitosT)) AS debitos, ';
    query += 'S.dtCriacao, S.dtAtualizacao FROM (SELECT C.*, ';
    query += '(SELECT SUM(R.valor) FROM receitas R ';
    query +=
        'WHERE C.id = R.contaId AND R.recebido = 1 GROUP BY R.contaId) AS creditosR, ';
    query += '(SELECT SUM(T.valor) FROM transferencias T ';
    query +=
        'WHERE C.id = T.contaIdCredito GROUP BY T.contaIdCredito) AS creditosT, ';
    query += '(SELECT SUM(D.valor) FROM despesas D ';
    query +=
        'WHERE C.id = D.contaId AND D.pago = 1 GROUP BY D.contaId) AS debitosD, ';
    query += '(SELECT SUM(T.valor) FROM transferencias T ';
    query +=
        'WHERE C.id = T.contaIdDebito GROUP BY T.contaIdDebito) AS debitosT FROM contas C) S';
    IResultSet result = await _dbConfig.execute(query);
    // List<Map<String, dynamic>> dados =
    //     result.rows.map((r) => r.typedAssoc()).toList();
    return result.rows
        .map((r) => Conta.fromMap(r.typedAssoc()))
        .toList()
        .cast<Conta>();
  }

  @override
  Future<Conta?> findOne(int id) async {
    final String query = 'SELECT * FROM contas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return (result.rows.isEmpty)
        ? null
        : Conta.fromMap(result.rows.first.typedAssoc());
  }

  @override
  Future<bool> update(Conta conta) async {
    String query = 'UPDATE contas SET nome = :nome WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': conta.id,
      'nome': conta.nome,
    });
    return result.affectedRows.toInt() > 0;
  }
}
