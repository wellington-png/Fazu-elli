import 'package:flutter/material.dart';
import 'package:deputados/widgets/list_widget.dart';
import 'package:deputados/domain/models/deputados.dart';
import 'package:deputados/domain/stores/deputado_store.dart';
import 'package:provider/provider.dart';


class ListDeputados extends StatefulWidget {
  const ListDeputados({super.key});

  @override
  State<ListDeputados> createState() => _ListDeputadosState();
}

class _ListDeputadosState extends State<ListDeputados>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deputadoStore = Provider.of<DeputadoStore>(context);
    final List<Deputados> listaDeputados = deputadoStore.deputados;

    return Scaffold(
      body: ListDepsWidget(
        listaDeputados: listaDeputados,
      ),
    );
  }
}
