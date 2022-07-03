import '../../utils/functions.dart';

class Despesa {
  int? id;
  String? descricao;
  int? tipoDespesaId;
  String? tipoDespesaDescricao;
  DateTime? dat;
  DateTime? vencimento;
  double? valor;
  bool? pago;
  int? contaId;
  String? contaDescricao;
  int? parcelas;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  Despesa();

  Despesa.create(
    this.id,
    this.descricao,
    this.tipoDespesaId,
    this.tipoDespesaDescricao,
    this.dat,
    this.vencimento,
    this.valor,
    this.pago,
    this.contaId,
    this.contaDescricao,
    this.parcelas,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory Despesa.fromMap(Map<String, dynamic> map) {
    return Despesa.create(
      map['id']?.toInt() ?? 0,
      map['descricao'] ?? '',
      map['tipoDespesaId']?.toInt() ?? 0,
      map['tipoDespesaDescricao'] ?? '',
      DateTime.parse(map['dat']),
      DateTime.parse(map['vencimento']),
      map['valor'] ?? 0,
      (map['pago'] != null) ? (map['pago'] == 1) : false,
      map['contaId']?.toInt() ?? 0,
      map['contaDescricao'] ?? '',
      map['parcelas'] ?? 1,
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory Despesa.fromRequest(Map map) {
    return Despesa()
      ..id = map['id']
      ..descricao = map['descricao']
      ..tipoDespesaId = map['tipoDespesaId']
      ..dat = Functions.stringToDateTime(date: map['dat'])
      ..vencimento = Functions.stringToDateTime(date: map['vencimento'])
      ..valor = map['valor']
      ..pago = map['pago']
      ..contaId = map['contaId']
      ..parcelas = map['parcelas'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'tipoDespesaId': tipoDespesaId,
      'tipoDespesaDescricao': tipoDespesaDescricao,
      'dat': (dat != null) ? Functions.getDate(dat!) : '',
      'vencimento': (vencimento != null) ? Functions.getDate(vencimento!) : '',
      'valor': valor,
      'pago': pago,
      'contaId': contaId,
      'contaDescricao': contaDescricao,
    };
  }

  @override
  String toString() {
    return 'Despesa(id: $id, descricao: $descricao, tipoDespesaId: $tipoDespesaId, tipoDespesaDescricao: $tipoDespesaDescricao, dat: $dat, vencimento: $vencimento, valor: $valor, pago: $pago, contaId: $contaId, contaDescricao: $contaDescricao, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
