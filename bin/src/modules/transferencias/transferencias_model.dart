import '../../utils/functions.dart';

class Transferencia {
  int? id;
  String? descricao;
  DateTime? dat;
  int? contaIdDebito;
  String? contaNomeDebito;
  int? contaIdCredito;
  String? contaNomeCredito;
  double? valor;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  Transferencia();

  Transferencia.create(
    this.id,
    this.descricao,
    this.dat,
    this.contaIdDebito,
    this.contaNomeDebito,
    this.contaIdCredito,
    this.contaNomeCredito,
    this.valor,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory Transferencia.fromMap(Map<String, dynamic> map) {
    return Transferencia.create(
      map['id']?.toInt() ?? 0,
      map['descricao'] ?? '',
      DateTime.parse(map['dat']),
      map['contaIdDebito']?.toInt() ?? 0,
      map['contaNomeDebito'] ?? '',
      map['contaIdCredito']?.toInt() ?? 0,
      map['contaNomeCredito'] ?? '',
      map['valor'] ?? 0,
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory Transferencia.fromRequest(Map map) {
    return Transferencia()
      ..id = map['id']
      ..descricao = map['descricao']
      ..dat = Functions.stringToDateTime(date: map['dat'])
      ..contaIdDebito = map['contaIdDebito']
      ..contaIdCredito = map['contaIdCredito']
      ..valor = map['valor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'dat': (dat != null) ? Functions.getDate(dat!) : '',
      'contaIdDebito': contaIdDebito,
      'contaNomeDebito': contaNomeDebito,
      'contaIdCredito': contaIdCredito,
      'contaNomeCredito': contaNomeCredito,
      'valor': valor,
    };
  }

  @override
  String toString() {
    return 'Transferencia(id: $id, descricao: $descricao, dat: $dat, contaIdDebito: $contaIdDebito, contaNomeDebito: $contaNomeDebito, contaIdCredito: $contaIdCredito, contaNomeCredito: $contaNomeCredito, valor: $valor, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
