import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../../utils/env.dart';
import '../usuarios/usuarios_model.dart';
import '../usuarios/usuarios_service.dart';

class LoginService {
  final UsuariosService _usuariosService;
  LoginService(this._usuariosService);

  Future<Usuario?> authenticate(Usuario usuario) async {
    try {
      Usuario? usuarioEncontrado =
          await _usuariosService.findByUsuario(usuario.usuario!);
      if (usuarioEncontrado == null) {
        String usuarioAdmin = await Env.get(key: 'usuario_admin');
        String usuarioSenha = await Env.get(key: 'usuario_senha');
        String usuarioTema = await Env.get(key: 'usuario_tema');
        if (usuario.usuario == usuarioAdmin && usuario.senha == usuarioSenha) {
          usuarioEncontrado = Usuario.create(
            0,
            'Administrador do sistema',
            usuarioAdmin,
            '',
            5,
            true,
            usuarioTema,
            '',
            '',
            DateTime.now(),
            DateTime.now(),
          );
          return usuarioEncontrado;
        }
        return null;
      }
      return (Password.verify(usuario.senha!, usuarioEncontrado.senha!))
          ? usuarioEncontrado
          : null;
    } catch (e) {
      log('[ERROR] -> Authenticate method fail ${usuario.usuario}');
      return null;
    }
  }
}
