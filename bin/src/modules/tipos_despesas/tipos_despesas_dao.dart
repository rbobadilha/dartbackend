import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import '../../infra/database/db_dao.dart';
import 'tipos_despesas_model.dart';

class TiposDespesasDAO implements DAO<TipoDespesa> {
  final DBConfig _dbConfig;
  TiposDespesasDAO(this._dbConfig);

  @override
  Future<bool> create(TipoDespesa tipoDespesa) async {
    String query =
        'INSERT INTO tipos_despesas (descricao, valorPrevisto) VALUES (:descricao, :valorPrevisto);';
    IResultSet result = await _dbConfig.execute(query, {
      'descricao': tipoDespesa.descricao,
      'valorPrevisto': tipoDespesa.valorPrevisto,
    });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    String query = 'DELETE FROM tipos_despesas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<TipoDespesa>> findAll() async {
    String query =
        'SELECT T.*, (SELECT SUM(valor) FROM despesas D WHERE D.tipoDespesaId = T.id) AS totalRealizado, ';
    query +=
        '(SELECT SUM(valor) FROM despesas D WHERE D.tipoDespesaId = T.id AND D.pago = 1) AS totalPago ';
    query += 'FROM tipos_despesas T ORDER BY T.descricao';
    IResultSet result = await _dbConfig.execute(query);
    List<TipoDespesa> tiposDespesas =
        result.rows.map((r) => TipoDespesa.fromMap(r.typedAssoc())).toList();
    for (TipoDespesa tipoDespesa in tiposDespesas) {
      tipoDespesa.percentRealizado = 0;
      if (tipoDespesa.valorPrevisto != null &&
          tipoDespesa.totalRealizado != null) {
        if (tipoDespesa.totalRealizado != 0) {
          if (tipoDespesa.valorPrevisto == 0) {
            tipoDespesa.percentRealizado = 0;
          } else {
            tipoDespesa.percentRealizado = (tipoDespesa.totalRealizado! * 100) /
                tipoDespesa.valorPrevisto!;
          }
        }
        // } else {
        //   tipoDespesa.percentRealizado = 0;
      }
      tipoDespesa.percentPago = 0;
      if (tipoDespesa.totalRealizado != null && tipoDespesa.totalPago != null) {
        if (tipoDespesa.totalPago != 0) {
          // if (tipoDespesa.valorPrevisto == 0) tipoDespesa.valorPrevisto = 0.001;
          tipoDespesa.percentPago =
              (tipoDespesa.totalPago! * 100) / tipoDespesa.totalRealizado!;
        }
        // } else {
        //   tipoDespesa.percentPago = 0;
      }
    }
    return tiposDespesas.cast<TipoDespesa>();
    // return result.rows
    //     .map((r) => TipoDespesa.fromMap(r.typedAssoc()))
    //     .toList()
    //     .cast<TipoDespesa>();
  }

  @override
  Future<TipoDespesa?> findOne(int id) async {
    final String query = 'SELECT * FROM tipos_despesas WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return (result.rows.isEmpty)
        ? null
        : TipoDespesa.fromMap(result.rows.first.typedAssoc());
  }

  @override
  Future<bool> update(TipoDespesa tipoDespesa) async {
    final String query =
        'UPDATE tipos_despesas SET descricao = :descricao, valorPrevisto = :valorPrevisto WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': tipoDespesa.id,
      'descricao': tipoDespesa.descricao,
      'valorPrevisto': tipoDespesa.valorPrevisto,
    });
    return result.affectedRows.toInt() > 0;
  }
}
