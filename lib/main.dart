import 'package:deputados/domain/services/deputado_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

import 'domain/repositories/deputado_repository.dart';
import 'domain/stores/deputado_store.dart';
import 'package:deputados/screens/list_daputs_screen.dart';
import 'package:deputados/screens/details_daputs_screen.dart';
import 'utils/app_routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final deputadoRepository = DeputadoRepository(
      DeputadoService(),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DeputadoStore(deputadoRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        routes: {
          AppRoutes.home: (ctx) => const ListDeputados(),
          AppRoutes.detailsDeputados: (ctx) => const DeputadoPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
