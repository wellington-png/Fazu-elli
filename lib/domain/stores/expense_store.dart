import 'package:flutter/material.dart';
import 'package:deputados/domain/models/expense.dart';
import 'package:deputados/domain/repositories/expense_repository.dart';

class ExpenseStore extends ChangeNotifier {
  final IExpenseRepository _expenseRepository;

  ExpenseStore(this._expenseRepository);
  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> getExpenses(
      {required int id, List<int>? year, List<int>? month}) async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _expenses = await _expenseRepository.getExpenses(
        id: id,
        year: year,
        month: month,
      );
    } catch (error) {
      _errorMessage = 'Erro ao carregar os gastos: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
