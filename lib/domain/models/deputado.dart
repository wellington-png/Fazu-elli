class Deputado {
  final int id;
  final String nome;
  final String siglaPartido;
  final String imageURL;

  Deputado({
    required this.id,
    required this.nome,
    required this.siglaPartido,
    required this.imageURL,
  });

  factory Deputado.fromJson(Map<String, dynamic> json) {
    return Deputado(
      id: json['id'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      imageURL: json['urlFoto'], // Corrigido para 'urlFoto' de acordo com o JSON
    );
  }
}