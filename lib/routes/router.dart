import 'package:deputados/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:deputados/screens/list_daputs_screen.dart';
import 'package:deputados/screens/details_daputs_screen.dart';
import 'package:deputados/screens/frentes_screen.dart';

class RoutesApp extends StatelessWidget {
  const RoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deputy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/frentes',
      routes: {
        '/': (context) => const ListDeputados(),
        '/home': (context) => const HomeScreen(),
        '/deputadoDetalhes': (context) => const DeputadoPage(),
        '/frentes': (context) => const FrentesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details' && settings.arguments is int) {
          return MaterialPageRoute(
            builder: (context) => const ListDeputados(),
          );
        }
        return null;
      },
    );
  }
}
