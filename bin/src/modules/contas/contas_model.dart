import '../../utils/functions.dart';

class Conta {
  int? id;
  String? nome;
  double? debitos;
  double? creditos;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  Conta();

  Conta.create(
    this.id,
    this.nome,
    this.debitos,
    this.creditos,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta.create(
      map['id']?.toInt() ?? 0,
      map['nome'] ?? '',
      map['debitos'] ?? 0,
      map['creditos'] ?? 0,
      // Functions.stringtoDouble(map['debitos']) ?? 0,
      // Functions.stringtoDouble(map['creditos']) ?? 0,
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory Conta.fromRequest(Map map) {
    return Conta()
      ..id = map['id']
      ..nome = map['nome'];
    // ..debitos = map['debitos']
    // ..creditos = map['creditos'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'debitos': debitos,
      'creditos': creditos,
    };
  }

  @override
  String toString() {
    return 'Conta(id: $id, nome: $nome, debitos: $debitos, creditos: $creditos, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
