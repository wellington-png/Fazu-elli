class Ocupacao {
  final String titulo;
  final String? entidade;
  final String? entidadeUF;
  final String? entidadePais;
  final int? anoInicio;
  final int? anoFim;

  Ocupacao({
    required this.titulo,
    this.entidade,
    this.entidadeUF,
    this.entidadePais,
    this.anoInicio,
    this.anoFim,
  });

  factory Ocupacao.fromJson(Map<String, dynamic> json) {
    return Ocupacao(
      titulo: json['titulo'],
      entidade: json['entidade'],
      entidadeUF: json['entidadeUF'],
      entidadePais: json['entidadePais'],
      anoInicio: json['anoInicio'],
      anoFim: json['anoFim'],
    );
  }

  static List<Ocupacao> fromJsonList(List<dynamic> json) {
    return json.map((e) => Ocupacao.fromJson(e)).toList();
  }
}