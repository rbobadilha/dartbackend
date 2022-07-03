import 'dart:convert';

class Usuario {
  int? id;
  String? nome;
  String? usuario;
  String? senha;
  int? nivel;
  bool? ativo;
  String? tema;
  String? token;
  String? tokenDate;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  Usuario();

  Usuario.create(
    this.id,
    this.nome,
    this.usuario,
    this.senha,
    this.nivel,
    this.ativo,
    this.tema,
    this.token,
    this.tokenDate,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario.create(
      map['id']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['usuario'] ?? '',
      map['senha'] ?? '',
      map['nivel']?.toInt() ?? 1,
      map['ativo'] == 1,
      map['tema'] ?? 'LBLue',
      map['token'] ?? '',
      map['tokenDate'],
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory Usuario.fromRequest(Map map) {
    return Usuario()
      ..id = map['id']
      ..nome = map['nome']
      ..usuario = map['usuario']
      ..senha = map['senha']
      ..nivel = map['nivel']
      ..ativo = map['ativo']
      ..tema = map['tema']
      ..tokenDate = map['tokenDate']
      ..token = map['token'];
  }

  factory Usuario.fromLogin(String body) {
    Map<String, dynamic> map = jsonDecode(body);
    return Usuario()
      ..usuario = map['usuario']
      ..senha = map['senha'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'usuario': usuario,
      'senha': senha,
      'nivel': nivel,
      'ativo': ativo,
      'tema': tema,
      'token': token,
      'tokenDate': tokenDate,
    };
  }

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome, usuario: $usuario, nivel: $nivel, ativo: $ativo, tema: $tema, tokenDate: $tokenDate, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
