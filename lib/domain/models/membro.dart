class Membro {
  final int id;
  final String uri;
  final String nome;
  final String siglaPartido;
  final String uriPartido;
  final String siglaUf;
  final int idLegislatura;
  final String urlFoto;
  final String email;
  final String titulo;
  final int codTitulo;
  final DateTime? dataInicio;
  final DateTime? dataFim;

  Membro({
    required this.id,
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    required this.email,
    required this.titulo,
    required this.codTitulo,
    this.dataInicio,
    this.dataFim,
  });

  factory Membro.fromJson(Map<String, dynamic> json) {
    return Membro(
      id: json['id'],
      uri: json['uri'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      uriPartido: json['uriPartido'],
      siglaUf: json['siglaUf'],
      idLegislatura: json['idLegislatura'],
      urlFoto: json['urlFoto'],
      email: json['email'],
      titulo: json['titulo'],
      codTitulo: json['codTitulo'],
      dataInicio: json['dataInicio'] != null
          ? DateTime.parse(json['dataInicio'])
          : null,
      dataFim: json['dataFim'] != null ? DateTime.parse(json['dataFim']) : null,
    );
  }

  static List<Membro> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Membro.fromJson(json)).toList();
  }
}
