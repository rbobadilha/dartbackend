import '../../utils/functions.dart';

class Receita {
  int? id;
  String? descricao;
  DateTime? dat;
  DateTime? vencimento;
  double? valor;
  bool? recebido;
  int? contaId;
  String? contaDescricao;
  int? parcelas;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  Receita();

  Receita.create(
    this.id,
    this.descricao,
    this.dat,
    this.vencimento,
    this.valor,
    this.recebido,
    this.contaId,
    this.contaDescricao,
    this.parcelas,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita.create(
      map['id']?.toInt() ?? 0,
      map['descricao'] ?? '',
      DateTime.parse(map['dat']),
      DateTime.parse(map['vencimento']),
      map['valor'] ?? 0,
      (map['recebido'] != null) ? (map['recebido'] == 1) : false,
      map['contaId']?.toInt() ?? 0,
      map['contaDescricao'] ?? '',
      map['parcelas']?.toInt() ?? 1,
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory Receita.fromRequest(Map map) {
    return Receita()
      ..id = map['id']
      ..descricao = map['descricao']
      ..dat = Functions.stringToDateTime(date: map['dat'])
      ..vencimento = Functions.stringToDateTime(date: map['vencimento'])
      ..valor = map['valor']
      ..recebido = map['recebido']
      ..contaId = map['contaId']
      ..parcelas = map['parcelas'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'dat': (dat != null) ? Functions.getDate(dat!) : '',
      'vencimento': (vencimento != null) ? Functions.getDate(vencimento!) : '',
      'valor': valor,
      'recebido': recebido,
      'contaId': contaId,
      'contaDescricao': contaDescricao,
      'parcelas': parcelas,
    };
  }

  @override
  String toString() {
    return 'Receita(id: $id, descricao: $descricao, dat: $dat, vencimento: $vencimento, valor: $valor, recebido: $recebido, contaId: $contaId, contaDescricao: $contaDescricao, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
