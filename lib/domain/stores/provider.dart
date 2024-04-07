import 'package:provider/provider.dart';
import 'package:deputados/domain/repositories/deputado_repository.dart';
import 'package:deputados/domain/repositories/expense_repository.dart';
import 'package:deputados/domain/repositories/frentes_repository.dart';
import 'package:deputados/domain/stores/deputado_store.dart';
import 'package:deputados/domain/stores/expense_store.dart';
import 'package:deputados/domain/stores/frentes_store.dart';

class AppProviders {
  static List<ChangeNotifierProvider<DeputadoStore>> getDeputadoProvider(
      DeputadoRepository deputadoRepository) {
    return [
      ChangeNotifierProvider<DeputadoStore>(
        create: (context) => DeputadoStore(deputadoRepository),
      ),
    ];
  }

  static List<ChangeNotifierProvider<ExpenseStore>> getExpenseProvider(
      ExpenseRepository expenseRepository) {
    return [
      ChangeNotifierProvider<ExpenseStore>(
        create: (context) => ExpenseStore(expenseRepository),
      ),
    ];
  }

  static List<ChangeNotifierProvider<FrentesStore>> getFrentesProvider(
      FrentesRepository frentesRepository) {
    return [
      ChangeNotifierProvider<FrentesStore>(
        create: (context) => FrentesStore(frentesRepository),
      ),
    ];
  }
}
