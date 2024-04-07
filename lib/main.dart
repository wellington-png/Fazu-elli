import 'package:deputados/domain/repositories/deputado_repository.dart';
import 'package:deputados/domain/repositories/expense_repository.dart';
import 'package:deputados/domain/repositories/frentes_repository.dart';
import 'package:deputados/domain/services/deputado_service.dart';
import 'package:deputados/domain/services/expense_service.dart';
import 'package:deputados/domain/services/frentes_service.dart';
import 'package:deputados/domain/stores/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final deputadoRepository = DeputadoRepository(DeputadoService());
    final expenseRepository = ExpenseRepository(ExpenseService());
    final frentesRepository = FrentesRepository(FrentesService());

    return MultiProvider(
      providers: [
        ...AppProviders.getDeputadoProvider(deputadoRepository),
        ...AppProviders.getExpenseProvider(expenseRepository),
        ...AppProviders.getFrentesProvider(frentesRepository),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const RoutesApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
