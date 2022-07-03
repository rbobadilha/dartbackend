import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import 'configuracoes_model.dart';

class ConfiguracoesDAO {
  final DBConfig _dbConfig;
  ConfiguracoesDAO(this._dbConfig);

  Future<bool> create(Configuracao configuracao) async {
    String query =
        'INSERT INTO configuracoes (constArea, constValorPrevistoM2, constUsarValorPrevisto) VALUES (:constArea, :constValorPrevistoM2, :constUsarValorPrevisto);';
    IResultSet result = await _dbConfig.execute(query, {
      'constArea': configuracao.constArea,
      'constValorPrevistoM2': configuracao.constValorPrevistoM2,
      'constUsarValorPrevisto': configuracao.constUsarValorPrevisto,
    });
    return result.affectedRows.toInt() > 0;
  }

  Future<List<Configuracao>> findAll() async {
    String query = 'SELECT * FROM configuracoes;';
    IResultSet result = await _dbConfig.execute(query);
    return result.rows
        .map((r) => Configuracao.fromMap(r.typedAssoc()))
        .toList()
        .cast<Configuracao>();
  }

  Future<bool> update(Configuracao configuracao) async {
    final String query =
        'UPDATE configuracoes SET constArea = :constArea, constValorPrevistoM2 = :constValorPrevistoM2, constUsarValorPrevisto = :constUsarValorPrevisto;';
    IResultSet result = await _dbConfig.execute(query, {
      'constArea': configuracao.constArea,
      'constValorPrevistoM2': configuracao.constValorPrevistoM2,
      'constUsarValorPrevisto': configuracao.constUsarValorPrevisto,
    });
    return result.affectedRows.toInt() > 0;
  }
}
