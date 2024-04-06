import 'package:deputados/domain/models/expense.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExpenseService {
  static const String baseUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados';

  Future<List<Expense>> getExpenses(int id,
      {List<int>? year, List<int>? month}) async {
    final Uri uri = Uri.parse('$baseUrl/$id/despesas')
        .replace(queryParameters: _buildQueryParameters(year, month));

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> expensesJson = jsonDecode(response.body)['dados'];
      return Expense.fromJsonList(expensesJson);
    } else {
      throw Exception('Erro ao carregar despesas');
    }
  }

  Map<String, dynamic>? _buildQueryParameters(
      List<int>? year, List<int>? month) {
    final Map<String, dynamic> params = {};

    if (year != null && year.isNotEmpty) {
      params['ano'] = year.map((e) => e.toString()).toList();
    }

    if (month != null && month.isNotEmpty) {
      params['mes'] = month.map((e) => e.toString()).toList();
    }

    return params.isNotEmpty ? params : null;
  }
}
