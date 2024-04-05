class Deputados {
  final int id;
  final String uri;
  final String nome;
  final String siglaPartido;
  final String uriPartido;
  final String siglaUf;
  final int idLegislatura;
  final String urlFoto;
  final String email;

  Deputados({
    required this.id,
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    required this.email,
  });

  factory Deputados.fromJson(Map<String, dynamic> json) {
    return Deputados(
      id: json['id'] as int,
      uri: json['uri'] as String,
      nome: json['nome'] as String,
      siglaPartido: json['siglaPartido'] as String,
      uriPartido: json['uriPartido'] as String,
      siglaUf: json['siglaUf'] as String,
      idLegislatura: json['idLegislatura'] as int,
      urlFoto: json['urlFoto'] as String,
      email: json['email'] as String,
    );
  }

  static List<Deputados> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Deputados.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uri': uri,
      'nome': nome,
      'siglaPartido': siglaPartido,
      'uriPartido': uriPartido,
      'siglaUf': siglaUf,
      'idLegislatura': idLegislatura,
      'urlFoto': urlFoto,
      'email': email,
    };
  }
}
