import 'package:mysql_client/mysql_client.dart';

import '../../infra/database/db_config.dart';
import '../../infra/database/db_dao.dart';
import 'usuarios_model.dart';

class UsuariosDAO implements DAO<Usuario> {
  final DBConfig _dbConfig;
  UsuariosDAO(this._dbConfig);

  @override
  Future<bool> create(Usuario usuario) async {
    String query =
        'INSERT INTO usuarios (nome, usuario, senha, nivel, ativo) VALUES (:nome, :usuario, :senha, :nivel, :ativo);';
    IResultSet result = await _dbConfig.execute(query, {
      'nome': usuario.nome,
      'usuario': usuario.usuario,
      'senha': usuario.senha,
      'nivel': usuario.nivel,
      'ativo': (usuario.ativo!) ? 1 : 0
    });
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<bool> delete(int id) async {
    String query = 'DELETE FROM usuarios WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return result.affectedRows.toInt() > 0;
  }

  @override
  Future<List<Usuario>> findAll() async {
    String query = 'SELECT * FROM usuarios;';
    IResultSet result = await _dbConfig.execute(query);
    return result.rows
        .map((r) => Usuario.fromMap(r.typedAssoc()))
        .toList()
        .cast<Usuario>();
  }

  @override
  Future<Usuario?> findOne(int id) async {
    final String query = 'SELECT * FROM usuarios WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {'id': id});
    return (result.rows.isEmpty)
        ? null
        : Usuario.fromMap(result.rows.first.typedAssoc());
  }

  @override
  Future<bool> update(Usuario usuario, [withPassword = false]) async {
    String query = '';
    (withPassword)
        ? query =
            'UPDATE usuarios SET nome = :nome, usuario = :usuario, senha = :senha, nivel = :nivel, ativo = :ativo WHERE id = :id;'
        : query =
            'UPDATE usuarios SET nome = :nome, usuario = :usuario, nivel = :nivel, ativo = :ativo WHERE id = :id;';

    // Map<String, dynamic> params = (withPassword)
    //     ? {
    //         'id': usuario.id,
    //         'nome': usuario.nome,
    //         'usuario': usuario.usuario,
    //         'senha': usuario.senha,
    //         'ativo': (usuario.ativo!) ? 1 : 0
    //       }
    //     : {
    //         'id': usuario.id,
    //         'nome': usuario.nome,
    //         'usuario': usuario.usuario,
    //         'ativo': (usuario.ativo!) ? 1 : 0
    //       };

    IResultSet result = await _dbConfig.execute(query, {
      'id': usuario.id,
      'nome': usuario.nome,
      'usuario': usuario.usuario,
      'senha': usuario.senha,
      'nivel': usuario.nivel,
      'ativo': (usuario.ativo!) ? 1 : 0
    });
    return result.affectedRows.toInt() > 0;
  }

  Future<bool> updatePassword(Usuario usuario) async {
    final String query = 'UPDATE usuarios SET senha = :senha WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': usuario.id,
      'senha': usuario.senha,
    });
    return result.affectedRows.toInt() > 0;
  }

  Future<bool> updateTheme(Usuario usuario) async {
    final String query = 'UPDATE usuarios SET tema = :tema WHERE id = :id;';
    IResultSet result = await _dbConfig.execute(query, {
      'id': usuario.id,
      'tema': usuario.tema,
    });
    return result.affectedRows.toInt() > 0;
  }

  Future<Usuario?> findByUsuario(String usuario) async {
    final String query = 'SELECT * FROM usuarios WHERE usuario = :usuario';
    IResultSet result = await _dbConfig.execute(query, {'usuario': usuario});
    return (result.rows.isEmpty)
        ? null
        : Usuario.fromMap(result.rows.first.typedAssoc());
  }
}
