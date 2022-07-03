class Configuracao {
  double? constArea;
  double? constValorPrevistoM2;
  bool? constUsarValorPrevisto;
  DateTime? dtCriacao;
  DateTime? dtAtualizacao;

  Configuracao();

  Configuracao.create(
    this.constArea,
    this.constValorPrevistoM2,
    this.constUsarValorPrevisto,
    this.dtCriacao,
    this.dtAtualizacao,
  );

  factory Configuracao.fromMap(Map<String, dynamic> map) {
    return Configuracao.create(
      map['constArea'] ?? 0,
      map['constValorPrevistoM2'] ?? 0,
      (map['constUsarValorPrevisto'] != null)
          ? (map['constUsarValorPrevisto'] == 1)
          : false,
      // (map['constArea'] != null) ? double.parse(map['constArea']) : 0,
      // (map['constValorPrevistoM2'] != null)
      //     ? double.parse(map['constValorPrevistoM2'])
      //     : 0,
      // (map['constUsarValorPrevisto'] != null)
      //     ? (map['constUsarValorPrevisto'] == 1)
      //     : false,
      DateTime.parse(map['dtCriacao']),
      DateTime.parse(map['dtAtualizacao']),
    );
  }

  factory Configuracao.fromRequest(Map map) {
    return Configuracao()
      ..constArea = map['constArea']
      ..constValorPrevistoM2 = map['constValorPrevistoM2']
      ..constUsarValorPrevisto = map['constUsarValorPrevisto'];
  }

  Map<String, dynamic> toJson() {
    return {
      'constArea': constArea,
      'constValorPrevistoM2': constValorPrevistoM2,
      'constUsarValorPrevisto': constUsarValorPrevisto,
    };
  }

  @override
  String toString() {
    return 'Configuracao(constArea: $constArea, constValorPrevistoM2: $constValorPrevistoM2, constUsarValorPrevisto: $constUsarValorPrevisto, dtCriacao: $dtCriacao, dtAtualizacao: $dtAtualizacao)';
  }
}
