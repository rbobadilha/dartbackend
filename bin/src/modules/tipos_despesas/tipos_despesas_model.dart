class TipoDespesa {
  int? id;
  String? descricao;
  double? valorPrevisto;
  double? totalRealizado;
  double? percentRealizado;
  double? totalPago;
  double? percentPago;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  TipoDespesa();

  TipoDespesa.create(
    this.id,
    this.descricao,
    this.valorPrevisto,
    this.totalRealizado,
    this.percentRealizado,
    this.totalPago,
    this.percentPago,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory TipoDespesa.fromMap(Map<String, dynamic> map) {
    return TipoDespesa.create(
      map['id']?.toInt() ?? 0,
      map['descricao'] ?? '',
      map['valorPrevisto'] ?? 0,
      map['totalRealizado'] ?? 0,
      map['percentRealizado'] ?? 0,
      map['totalPago'] ?? 0,
      map['percentPago'] ?? 0,
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory TipoDespesa.fromRequest(Map map) {
    return TipoDespesa()
      ..id = map['id']
      ..descricao = map['descricao']
      ..valorPrevisto = map['valorPrevisto'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valorPrevisto': valorPrevisto,
      'totalRealizado': totalRealizado,
      'percentRealizado': percentRealizado,
      'totalPago': totalPago,
      'percentPago': percentPago,
    };
  }

  @override
  String toString() {
    return 'TipoDespesa(id: $id, descricao: $descricao, valorPrevisto: $valorPrevisto, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
