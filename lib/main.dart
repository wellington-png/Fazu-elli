import 'package:deputados/domain/services/deputado_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/repositories/deputado_repository.dart';
import 'domain/stores/deputado_store.dart';
import 'routes/router.dart';

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
        home: const RoutesApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
