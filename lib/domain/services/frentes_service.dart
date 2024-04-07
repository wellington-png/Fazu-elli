import 'package:deputados/domain/models/frente.dart';
import 'package:deputados/domain/models/membro.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FrentesService {
  static const String baseUrl =
      'https://dadosabertos.camara.leg.br/api/v2/frentes';

  Future<List<Frente>> getFrentes() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final List<dynamic> frentesJson = jsonDecode(response.body)['dados'];
      return Frente.fromJsonList(frentesJson);
    } else {
      throw Exception('Erro ao carregar frentes');
    }
  }

  Future<Frente> getFrenteById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final frente = jsonDecode(response.body)['dados'];
      return Frente.fromJson(frente);
    } else {
      throw Exception('Erro ao carregar frente');
    }
  }

  Future<List<Membro>> getMembrosByFrenteId(int frenteId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/$frenteId/membros'), headers: {
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final List<dynamic> membrosJson = jsonDecode(response.body)['dados'];
      return Membro.fromJsonList(membrosJson);
    } else {
      throw Exception('Erro ao carregar membros da frente');
    }
  }
}
