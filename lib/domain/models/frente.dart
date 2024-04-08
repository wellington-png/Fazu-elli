class Frente {
  final int id;
  final String titulo;
  final String? uri;
  final int? idLegislatura;
  final String? telefone;
  final String? email;
  final String? keywords;
  final String? idSituacao;
  final String? situacao;
  final String? urlWebsite;
  final String? urlDocumento;
  final Map<String, dynamic>? coordenador;
  final String? selfPage;
  final String? lastPage;
  final String? nextPage;
  final String? firstPage;

  Frente({
    required this.titulo,
    required this.id,
    this.uri,
    this.idLegislatura,
    this.telefone,
    this.email,
    this.keywords,
    this.idSituacao,
    this.situacao,
    this.urlWebsite,
    this.urlDocumento,
    this.coordenador,
    this.selfPage,
    this.lastPage,
    this.nextPage,
    this.firstPage,
  });

  factory Frente.fromJson(Map<String, dynamic> json) {
    return Frente(
      id: json['id'],
      titulo: json['titulo'],
      uri: json['uri'],
      idLegislatura: json['idLegislatura'],
      telefone: json['telefone'],
      email: json['email'],
      keywords: json['keywords'],
      idSituacao: json['idSituacao'],
      situacao: json['situacao'],
      urlWebsite: json['urlWebsite'],
      urlDocumento: json['urlDocumento'],
      coordenador: json['coordenador'],
      selfPage: _extractLink(json['links'], 'self'),
      lastPage: _extractLink(json['links'], 'last'),
      nextPage: _extractLink(json['links'], 'next'),
      firstPage: _extractLink(json['links'], 'first'),
    );
  }

  static String? _extractLink(Map<String, dynamic>? links, String rel) {
    final link = links?[rel];
    return link != null ? link['href'] : null;
  }

  static List<Frente> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Frente.fromJson(json)).toList();
  }
}
