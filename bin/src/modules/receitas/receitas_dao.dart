import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import '../../infra/database/db_dao.dart';
import 'receitas_model.dart';

class ReceitasDAO implements DAO<Receita> {
  final DBConfig _dbConfig;
  ReceitasDAO(this._dbConfig);

  @override
  Future<bool> create(Receita receita) async {
    if (receita.parcelas! == 1) {
      return await insert(receita);
    } else {
      String descricao = receita.descricao!;
      DateTime dat = receita.vencimento!;
      for (int index = 1; index < receita.parcelas!; index++) {
        receita.descricao = '$descricao $index/${receita.parcelas}';
        receita.vencimento = dat;
        if (!await insert(receita)) return false;
        dat = DateTime(dat.year, dat.month + 1, dat.day);
      }
    }
    return true;
  }

  Future<bool> insert(Receita receita) async {
    String query =
        'INSERT INTO receitas (descricao, dat, vencimento, valor, recebido) VALUES (:descricao, :dat, :vencimento, :valor, :recebido);';
    IResultSet result = await _dbConfig.execute(query, {
      'descricao': receita.descricao,
      'dat': receita.dat,
      'vencimento': receita.vencimento,
      'valor': receita.valor,
      'recebido': (receita.recebido!) ? 1 : 0,
    });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    String query = 'DELETE FROM receitas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<Receita>> findAll() async {
    String query = 'SELECT * FROM receitas ORDER BY vencimento;';
    IResultSet result = await _dbConfig.execute(query);
    return result.rows
        .map((r) => Receita.fromMap(r.typedAssoc()))
        .toList()
        .cast<Receita>();
  }

  @override
  Future<Receita?> findOne(int id) async {
    final String query = 'SELECT * FROM receitas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return (result.rows.isEmpty)
        ? null
        : Receita.fromMap(result.rows.first.typedAssoc());
  }

  @override
  Future<bool> update(Receita receita) async {
    String query = 'UPDATE receitas SET descricao = :descricao, ';
    query += 'dat = :dat, vencimento = :vencimento, valor = :valor, ';
    query += 'recebido = :recebido WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': receita.id,
      'descricao': receita.descricao,
      'dat': receita.dat,
      'vencimento': receita.vencimento,
      'valor': receita.valor,
      'recebido': receita.recebido,
    });
    return result.affectedRows.toInt() > 0;
  }
}
