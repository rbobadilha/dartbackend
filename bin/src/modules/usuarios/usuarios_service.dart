import 'package:password_dart/password_dart.dart';

import '../../utils/generic_service.dart';

import 'usuarios_dao.dart';
import 'usuarios_model.dart';

class UsuariosService implements GenericService<Usuario> {
  final UsuariosDAO _usuariosDAO;
  UsuariosService(this._usuariosDAO);

  @override
  Future<List<Usuario>> findAll() async => await _usuariosDAO.findAll();

  @override
  Future<Usuario?> findOne(int id) async {
    return await _usuariosDAO.findOne(id);
  }

  Future<bool> create(Usuario usuario) async {
    try {
      String hash = Password.hash(usuario.senha!, PBKDF2());
      usuario.senha = hash;
      return await _usuariosDAO.create(usuario);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> update(Usuario usuario) async {
    try {
      if (usuario.senha!.isNotEmpty) {
        String hash = Password.hash(usuario.senha!, PBKDF2());
        usuario.senha = hash;
        return await _usuariosDAO.update(usuario, true);
      }
      return await _usuariosDAO.update(usuario);
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> delete(int id) async => await _usuariosDAO.delete(id);

  @override
  Future<bool> save(Usuario usuario) async {
    if (usuario.id == null) {
      String hash = Password.hash(usuario.senha!, PBKDF2());
      usuario.senha = hash;
      return await _usuariosDAO.create(usuario);
    } else {
      return await _usuariosDAO.update(usuario);
    }
  }

  Future<bool> updatePassword(Usuario usuario) async {
    String hash = Password.hash(usuario.senha!, PBKDF2());
    usuario.senha = hash;
    return await _usuariosDAO.updatePassword(usuario);
  }

  Future<bool> updateTheme(Usuario usuario) async {
    return await _usuariosDAO.updateTheme(usuario);
  }

  Future<Usuario?> findByUsuario(String usuario) async {
    return await _usuariosDAO.findByUsuario(usuario);
  }
}
