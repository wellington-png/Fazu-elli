import 'package:deputados/domain/models/expense.dart';
import 'package:deputados/domain/services/expense_service.dart';

abstract class IExpenseRepository {
  Future<List<Expense>> getExpenses({required int id, List<int>? year, List<int>? month});
}

class ExpenseRepository implements IExpenseRepository {
  final ExpenseService _expenseService;

  ExpenseRepository(this._expenseService);

  @override
  Future<List<Expense>> getExpenses({required int id, List<int>? year, List<int>? month}) async {
    return _expenseService.getExpenses(id, year: year, month: month);
  }
}
