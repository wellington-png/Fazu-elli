import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/models/deputado.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DeputadoService {
  static const String baseUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados';

  Future<List<Deputados>> getDeputados(
      {String? nome, String? partido, String? estado}) async {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final List<dynamic> deputadosJson = jsonDecode(response.body)['dados'];
      return Deputados.fromJsonList(deputadosJson);
    } else {
      throw Exception('Erro ao carregar deputados');
    }
  }

  Future<Deputado> getDeputadoById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final deputado = jsonDecode(response.body)['dados'];
      return Deputado.fromMap(deputado);
    } else {
      throw Exception('Erro ao carregar deputado');
    }
  }

  Future<List<Deputados>> getDeputadosByParams(
      {String? nome, String? partido, String? estado}) async {
    final Map<String, String> queryParams = {};
    if (nome != null) queryParams['nome'] = nome;
    if (partido != null) queryParams['siglaPartido'] = partido;
    if (estado != null) queryParams['siglaUf'] = estado;

    final Uri uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> deputadosJson = jsonDecode(response.body)['dados'];
      return Deputados.fromJsonList(deputadosJson);
    } else {
      throw Exception('Erro ao carregar deputados');
    }
  }
}
