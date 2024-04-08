class Historico {
  final int id;
  final String uri;
  final String nome;
  final String nomeEleitoral;
  final String siglaPartido;
  final String uriPartido;
  final String siglaUf;
  final int idLegislatura;
  final String? email;
  final String urlFoto;
  final String dataHora;
  final String situacao;
  final String condicaoEleitoral;
  final String descricaoStatus;

  Historico({
    required this.id,
    required this.uri,
    required this.nome,
    required this.nomeEleitoral,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    this.email,
    required this.urlFoto,
    required this.dataHora,
    required this.situacao,
    required this.condicaoEleitoral,
    required this.descricaoStatus,
  });

  factory Historico.fromJson(Map<String, dynamic> json) {
    return Historico(
      id: json['id'],
      uri: json['uri'],
      nome: json['nome'],
      nomeEleitoral: json['nomeEleitoral'],
      siglaPartido: json['siglaPartido'],
      uriPartido: json['uriPartido'],
      siglaUf: json['siglaUf'],
      idLegislatura: json['idLegislatura'],
      email: json['email'],
      urlFoto: json['urlFoto'],
      dataHora: json['dataHora'],
      situacao: json['situacao'],
      condicaoEleitoral: json['condicaoEleitoral'],
      descricaoStatus: json['descricaoStatus'],
    );
  }

  static List<Historico> fromJsonList(List<dynamic> json) {
    return json.map((e) => Historico.fromJson(e)).toList();
  }
}
